package dev.abreu.guilherme.sounds.system.capacitor;

import android.database.Cursor;
import android.media.RingtoneManager;
import android.net.Uri;
import android.util.Log;
import android.content.Context;
import android.content.ContentResolver;
import android.os.Environment;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.getcapacitor.JSArray;
import com.getcapacitor.JSObject;

@CapacitorPlugin(name = "SystemSounds")
public class SystemSoundsPlugin extends Plugin {

    @PluginMethod
    public void getSystemSounds(PluginCall call) {
        // Receber o tipo de som como parâmetro do JavaScript
        int ringtoneTypeInt = call.getInt("type", RingtoneManager.TYPE_NOTIFICATION); // Padrão para NOTIFICATION

        // Converte o valor numérico para um tipo correspondente
        SystemSoundType ringtoneType = SystemSoundType.fromInt(ringtoneTypeInt);

        if (ringtoneType == null) {
            call.reject("Invalid ringtone type");
            return;
        }

        try {
            // Inicializar a classe responsável por obter os sons
            SystemSounds systemSounds = new SystemSounds(getContext());

            // Obter os sons do sistema com base no tipo
            JSArray soundsArray = systemSounds.getSystemSounds(ringtoneType.getType());

            // Retornar a lista de sons para o frontend
            JSObject result = new JSObject();
            result.put("sounds", soundsArray);
            call.resolve(result);

        } catch (Exception e) {
            call.reject("Failed to retrieve system sounds", e);
        }
    }

    @PluginMethod
    public void saveSoundLocation(PluginCall call) {
        String uriString = call.getString("uri");
        String nameString = call.getString("name");

        if (uriString == null) {
            call.reject("Invalid URI");
            return;
        }

        if (nameString == null || nameString.isEmpty()) {
            call.reject("Invalid name: not provided");
            return;
        }

        Uri uri = Uri.parse(uriString);
        String filePath = UriUtils.saveSoundToAppMedia(getContext(), uri, nameString);

        if (filePath == null) {
            call.reject("Failed to save sound to app media directory");
            return;
        }

        JSObject result = new JSObject();
        result.put("filePath", filePath);
        call.resolve(result);
    }
}

enum SystemSoundType {
    RINGTONE(RingtoneManager.TYPE_RINGTONE),
    NOTIFICATION(RingtoneManager.TYPE_NOTIFICATION),
    ALARM(RingtoneManager.TYPE_ALARM),
    ALL(RingtoneManager.TYPE_ALL);

    private final int type;

    SystemSoundType(int type) {
        this.type = type;
    }

    public int getType() {
        return type;
    }

    public static SystemSoundType fromInt(int type) {
        for (SystemSoundType soundType : SystemSoundType.values()) {
            if (soundType.getType() == type) {
                return soundType;
            }
        }
        return null;
    }
}

class SystemSounds {
    private final Context context;

    public SystemSounds(Context context) {
        this.context = context;
    }

    public JSArray getSystemSounds(int type) {
        JSArray soundsArray = new JSArray();

        RingtoneManager ringtoneManager = new RingtoneManager(context);
        ringtoneManager.setType(type);

        Cursor cursor = ringtoneManager.getCursor();
        if (cursor != null && cursor.moveToFirst()) {
            do {
                String title = cursor.getString(RingtoneManager.TITLE_COLUMN_INDEX);
                Uri ringtoneUri = ringtoneManager.getRingtoneUri(cursor.getPosition());

                JSObject sound = new JSObject();
                sound.put("title", title);
                sound.put("uri", ringtoneUri.toString());

                soundsArray.put(sound);
            } while (cursor.moveToNext());

            cursor.close();
        }

        return soundsArray;
    }
}

class UriUtils {
    public static String saveSoundToAppMedia(Context context, Uri uri, String name) {
        try {
            ContentResolver contentResolver = context.getContentResolver();
            InputStream inputStream = contentResolver.openInputStream(uri);

            // Caminho para salvar o som na pasta media do aplicativo
            File mediaDir = new File(context.getExternalFilesDir(Environment.DIRECTORY_MUSIC), "media/notifications");
            if (!mediaDir.exists()) {
                mediaDir.mkdirs();
            }

            String fileName = name + ".mp3";
            File soundFile = new File(mediaDir, fileName);

            OutputStream outputStream = new FileOutputStream(soundFile);

            byte[] buffer = new byte[1024];
            int length;
            while ((length = inputStream.read(buffer)) > 0) {
                outputStream.write(buffer, 0, length);
            }

            outputStream.close();
            inputStream.close();

            return soundFile.getAbsolutePath();  // Retorna o caminho do arquivo salvo
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}
