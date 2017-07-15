let ipcRenderer = null;

const ipcExtra = {
    getResponseChannel(channel) {
        return `ipc-extra-${channel}-response`;
    },

    call(channel, ...args) {
        if (!ipcRenderer) {
            ipcRenderer = require('electron').ipcRenderer;
        }

        const responseChannel = this.getResponseChannel(channel);

        return new Promise((resolve, reject) => {
            ipcRenderer.once(responseChannel, (event, err, result) => {
                if (err) reject(err);
                else resolve(result);
            });

            ipcRenderer.send(channel, ...args);
        });
    }
};

module.exports = ipcExtra;
