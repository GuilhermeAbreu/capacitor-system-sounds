import { CapacitorSystemSounds } from '@guilhermeabreudev&#x2F;capacitor-system-sounds';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    CapacitorSystemSounds.echo({ value: inputValue })
}
