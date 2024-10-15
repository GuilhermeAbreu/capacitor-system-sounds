# @guilhermeabreudev/capacitor-system-sounds

Listagem de sistema padrão do sistema

## Install

```bash
npm install @guilhermeabreudev/capacitor-system-sounds
npx cap sync
```

## API

<docgen-index>

* [`getSystemSounds(...)`](#getsystemsounds)
* [`salveSoundLocation(...)`](#salvesoundlocation)
* [Enums](#enums)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### getSystemSounds(...)

```typescript
getSystemSounds(configSystemSound: { type: SystemSoundsType; }) => Promise<{ sounds: { title: string; uri: string; }[]; }>
```

| Param                   | Type                                                                     |
| ----------------------- | ------------------------------------------------------------------------ |
| **`configSystemSound`** | <code>{ type: <a href="#systemsoundstype">SystemSoundsType</a>; }</code> |

**Returns:** <code>Promise&lt;{ sounds: { title: string; uri: string; }[]; }&gt;</code>

--------------------


### salveSoundLocation(...)

```typescript
salveSoundLocation(systemSound: { uri: string; name: string; }) => Promise<{ filePath: string; }>
```

| Param             | Type                                        |
| ----------------- | ------------------------------------------- |
| **`systemSound`** | <code>{ uri: string; name: string; }</code> |

**Returns:** <code>Promise&lt;{ filePath: string; }&gt;</code>

--------------------


### Enums


#### SystemSoundsType

| Members            | Value          |
| ------------------ | -------------- |
| **`RINGTONE`**     | <code>1</code> |
| **`NOTIFICATION`** | <code>2</code> |
| **`ALARM`**        | <code>4</code> |
| **`ALL`**          | <code>7</code> |

</docgen-api>
