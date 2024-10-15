import { WebPlugin } from '@capacitor/core';

import type { SystemSoundsPlugin } from './definitions';

export class SystemSoundsWeb extends WebPlugin implements SystemSoundsPlugin {
  getSystemSounds(): Promise<{ sounds: { title: string; uri: string; }[]; }> {
    throw new Error('Method not implemented web.');
  }
  salveSoundLocation(systemSound: { uri: string; }): Promise<{ filePath: string; }> {
    systemSound
    throw new Error('Method not implemented web.');
  }
}
