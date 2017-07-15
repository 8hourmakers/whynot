const { ipcMain } = require('electron');
const ipcExtra = require('../common/utils/ipc-extra');


class IpcGateway {
    constructor(application) {
        this.application = application;
    }

    on(channel, callback) {
        const request = {
            data: null,
            sender: null,
        };

        const response = {
            resolve: null,
            reject: null,
        };

        const responseChannel = ipcExtra.getResponseChannel(channel);

        ipcMain.on(channel, (event, data) => {
            request.data = data;
            request.sender = event.sender;

            response.resolve = function resolve(resolveData) {
                event.sender.send(responseChannel, null, resolveData);
            };

            response.reject = function reject(rejectData) {
                event.sender.send(responseChannel, rejectData, null);
            };

            callback(request, response);
        });
    }

    emit(channel, ...args) {
        this.application.emitOnCurrentWindow(channel, ...args);
    }
}

module.exports = IpcGateway;
