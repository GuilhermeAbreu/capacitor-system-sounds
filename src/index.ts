import { registerPlugin } from '@capacitor/core';

import type { SystemSoundsPlugin } from './definitions';

const SystemSounds = registerPlugin<SystemSoundsPlugin>('SystemSounds', {
  web: () => import('./web').then((m) => new m.SystemSoundsWeb()),
});

export * from './definitions';
export { SystemSounds };

