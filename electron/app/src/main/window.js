const { BrowserWindow } = require('electron');


class Window {
    constructor(application) {
        this.application = application;
        this.browserWindow = null;
    }

    open(templateUrl, options = {}) {
        this.browserWindow = new BrowserWindow(options);
        this.browserWindow.loadURL(templateUrl);
    }

    close() {
        this.browserWindow.close();
    }

    emit(channel, ...args) {
        this.browserWindow.webContents.send(channel, ...args);
    }
}

module.exports = Window;
