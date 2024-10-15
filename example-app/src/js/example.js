import { NativeAudio } from "@capacitor-community/native-audio";
import { SystemSounds } from '@guilhermeabreudev/capacitor-system-sounds';

function listSystemSounds(type) {
    // Limpar a lista antes de preencher
    const soundListElement = document.getElementById('soundList');
    soundListElement.innerHTML = '';

    // Chamar o plugin para pegar os sons do sistema
    SystemSounds.getSystemSounds({type: type}).then(result => {
        const sounds = result.sounds; // Array de sons recebidos

        // Iterar sobre a lista de sons e criar elementos HTML
        sounds.forEach(sound => {
            const listItem = document.createElement('li');

            // Criar o botão de tocar o som
            const button = document.createElement('button');
            const buttonSalve = document.createElement('button');
            const buttonStop = document.createElement('button');


            button.textContent = `Play ${sound.title}`;
            buttonSalve.textContent = `Salve ${sound.title}`;
            buttonStop.textContent = `Stop ${sound.title}`;

            button.addEventListener('click', () => play(sound.uri, sound.title)); // Associa o clique para tocar o som
            buttonSalve.addEventListener('click', () => download(sound.uri, sound.title)); // Associa o clique para tocar o som
            buttonStop.addEventListener('click', () => stopAudio(sound.title)); // Associa o clique para tocar o som

            // Adicionar título do som e botão à lista
            listItem.textContent = `${sound.title} - `;
            listItem.appendChild(button);
            listItem.appendChild(buttonSalve);
            listItem.appendChild(buttonStop);


            // Adicionar o item à lista HTML
            soundListElement.appendChild(listItem);
        });
    }).catch(error => {
        console.error('Error retrieving system sounds:', error);
    });
}

async function download(uri, title) {
    SystemSounds.salveSoundLocation({uri: uri, name: title}).then(() => {
        alert('salvo com sucesso');
    }).catch(error => {
        alert(error);
    });
}

async function stopAudio(title) {
    NativeAudio.stop({
        assetId: title
    });
}

async function play(uri, title) {
    NativeAudio.preload({
        assetId: title,
        assetPath: uri,
        audioChannelNum: 1,
        isUrl: false,
        volume: 100
    }).then(() => {
        NativeAudio.play({ assetId: title });
    }).catch(error => {
        NativeAudio.play({ assetId: title });
    });
}

// Expor a função globalmente
window.listSystemSounds = listSystemSounds;

listSystemSounds()