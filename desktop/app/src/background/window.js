const { BrowserWindow } = require('electron');
const path = require('path');
const url = require('url');

class Window {
    constructor(application, name, options) {
        this.application = application;

        this.name = name;
        this.browserWindow = null;

        const templateUrl = url.format({
            protocol: 'file',
            pathname: path.resolve(__dirname, `../../statics/${options.template}.html`),
            slashes: true,
        });

        this.browserWindow = new BrowserWindow(options);
        this.browserWindow.loadURL(templateUrl);

        this.application.addWindow(this);
        this.handleEvents();
    }

    handleEvents() {
        this.browserWindow.on('closed', () => {
            this.application.removeWindow(this);
        });
    }

    focus() {
        this.browserWindow.focus();
    }

    close() {
        this.browserWindow.close();
    }

    toggleDevTools() {
        this.browserWindow.toggleDevTools();
    }

    openDevTools() {
        this.browserWindow.openDevTools();
    }

    closeDevTools() {
        this.browserWindow.closeDevTools();
    }

    disableZoom() {
        this.browserWindow.webContents.setVisualZoomLevelLimits(1, 1);
    }

    getWindowContents() {
        return this.browserWindow.webContents;
    }
}

module.exports = Window;
