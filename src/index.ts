import { registerPlugin } from '@capacitor/core';

import type { CapacitorSystemSoundsPlugin } from './definitions';

const CapacitorSystemSounds = registerPlugin<CapacitorSystemSoundsPlugin>('CapacitorSystemSounds', {
  web: () => import('./web').then((m) => new m.CapacitorSystemSoundsWeb()),
});

export * from './definitions';
export { CapacitorSystemSounds };
