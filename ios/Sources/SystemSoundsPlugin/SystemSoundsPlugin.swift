import Capacitor
import AVFoundation
import MediaPlayer

@objc(SystemSoundsPlugin)
public class SystemSoundsPlugin: CAPPlugin {
    
    @objc func getSystemSounds(_ call: CAPPluginCall) {
        let ringtoneTypeInt = call.getInt("type") ?? SystemSoundType.notification.rawValue

        guard let ringtoneType = SystemSoundType(rawValue: ringtoneTypeInt) else {
            call.reject("Invalid ringtone type")
            return
        }

        do {
            let systemSounds = SystemSounds()
            let soundsArray = systemSounds.getSystemSounds(ringtoneType: ringtoneType)
            
            var result = JSObject()
            result["sounds"] = soundsArray
            call.resolve(result)
        } catch {
            call.reject("Failed to retrieve system sounds", error)
        }
    }

    @objc func saveSoundLocation(_ call: CAPPluginCall) {
        guard let uriString = call.getString("uri"), let uri = URL(string: uriString) else {
            call.reject("Invalid URI")
            return
        }
        guard let nameString = call.getString("name"), !nameString.isEmpty else {
            call.reject("Invalid name: not provided")
            return
        }

        let filePath = UriUtils.saveSoundToAppMedia(uri: uri, name: nameString)

        if let filePath = filePath {
            var result = JSObject()
            result["filePath"] = filePath
            call.resolve(result)
        } else {
            call.reject("Failed to save sound to app media directory")
        }
    }
}

enum SystemSoundType: Int {
    case ringtone = 1
    case notification = 2
    case alarm = 3
    case all = 4
}

class SystemSounds {
    
    func getSystemSounds(ringtoneType: SystemSoundType) -> [JSObject] {
        var soundsArray = [JSObject]()
        
        let query = MPMediaQuery()
        switch ringtoneType {
        case .ringtone:
            query.addFilterPredicate(MPMediaPropertyPredicate(value: "Ringtone", forProperty: MPMediaItemPropertyMediaType))
        case .notification:
            query.addFilterPredicate(MPMediaPropertyPredicate(value: "Notification", forProperty: MPMediaItemPropertyMediaType))
        case .alarm:
            query.addFilterPredicate(MPMediaPropertyPredicate(value: "Alarm", forProperty: MPMediaItemPropertyMediaType))
        case .all:
            break
        }

        if let items = query.items {
            for item in items {
                var sound = JSObject()
                sound["title"] = item.title ?? "Unknown"
                if let assetURL = item.assetURL {
                    sound["uri"] = assetURL.absoluteString
                }
                soundsArray.append(sound)
            }
        }

        return soundsArray
    }
}

class UriUtils {
    static func saveSoundToAppMedia(uri: URL, name: String) -> String? {
        let fileManager = FileManager.default

        guard let mediaDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("media/notifications") else {
            return nil
        }

        do {
            if !fileManager.fileExists(atPath: mediaDir.path) {
                try fileManager.createDirectory(at: mediaDir, withIntermediateDirectories: true, attributes: nil)
            }

            let fileName = "\(name).mp3"
            let soundFile = mediaDir.appendingPathComponent(fileName)

            let data = try Data(contentsOf: uri)
            try data.write(to: soundFile)

            return soundFile.path
        } catch {
            print("Failed to save sound file: \(error)")
            return nil
        }
    }
}
