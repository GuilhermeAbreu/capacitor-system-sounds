export interface CapacitorSystemSoundsPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
