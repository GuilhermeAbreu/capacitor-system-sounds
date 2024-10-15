export interface SystemSoundsPlugin {
  getSystemSounds(configSystemSound: {type: SystemSoundsType}): Promise<{ sounds: {title: string, uri: string}[] }>;
  salveSoundLocation(systemSound: {uri: string, name: string}): Promise<{ filePath: string }>;
}

export enum SystemSoundsType {
  RINGTONE = 1,    
  NOTIFICATION = 2,
  ALARM = 4,       
  ALL = 7 
}