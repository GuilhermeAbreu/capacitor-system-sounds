import { WebPlugin } from '@capacitor/core';

import type { CapacitorSystemSoundsPlugin } from './definitions';

export class CapacitorSystemSoundsWeb extends WebPlugin implements CapacitorSystemSoundsPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
