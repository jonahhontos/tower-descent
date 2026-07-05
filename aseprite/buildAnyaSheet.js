const { exec } = require('child_process');
const fs = require('fs');

fs.readFile('anya_anim_names.txt', 'utf8', (err, data) => {
    if (err) {
        console.error('Error reading file:', err);
        return;
    }

    let filesString = ''

    for (anim of data.split('\n')) {
        filesString += ` anya/${anim}_down.aseprite anya/${anim}_up.aseprite anya/${anim}_side.aseprite`
    }

    let commandString = `/Applications/Aseprite.app/Contents/MacOS/aseprite -b ${filesString} --sheet ../assets/sprites/anya.png`;
    console.log(commandString)

    exec(commandString, (error, stdout, stderr) => {
        if (error) console.error(error)
    });
});