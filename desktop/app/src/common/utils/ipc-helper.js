/* eslint global-require:0 */
let ipcRenderer = null;
let ipcMain = null;

const getResponseChannel = channel => `ipc-helpers-${channel}-response`;

const ipcHelper = {
    on(channel, asyncCallback) {
        if (!ipcMain) {
            ipcMain = require('electron').ipcMain;
        }

        const responseChannel = getResponseChannel(channel);

        ipcMain.on(channel, (event, ...args) => {
            asyncCallback(...args)
                .then((result) => {
                    event.sender.send(responseChannel, result);
                });
        });
    },

    call(channel, ...args) {
        if (!ipcRenderer) {
            ipcRenderer = require('electron').ipcRenderer;
        }

        const responseChannel = getResponseChannel(channel);

        return new Promise((resolve) => {
            ipcRenderer.once(responseChannel, (event, result) => {
                resolve(result);
            });

            ipcRenderer.send(channel, ...args);
        });
    },

    listenTo(channel, callback) {
        if (!ipcMain) {
            ipcMain = require('electron').ipcMain;
        }

        const responseChannel = getResponseChannel(channel);
        let hasEventDriven = false;
        let hasEmitted = false;

        ipcMain.on(channel, (event, ...args) => {
            if (!hasEventDriven) {
                hasEventDriven = true;
            }

            if (hasEventDriven && hasEmitted) {
                const result = callback(event, ...args);
                event.sender.send(responseChannel, result);
            }
        });

        return {
            emit() {
                hasEmitted = true;
            },
        };
    },

    asyncListenTo(channel, asyncCallback) {
        if (!ipcMain) {
            ipcMain = require('electron').ipcMain;
        }

        const responseChannel = getResponseChannel(channel);
        let hasEventDriven = false;
        let hasEmitted = false;

        ipcMain.on(channel, async (event, ...args) => {
            if (!hasEventDriven) {
                hasEventDriven = true;
            }

            if (hasEventDriven && hasEmitted) {
                const result = await asyncCallback(event, ...args);
                event.sender.send(responseChannel, result);
            }
        });

        return {
            emit() {
                hasEmitted = true;
            },
        };
    },
};

module.exports = ipcHelper;
