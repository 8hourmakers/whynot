const { app } = require('electron');
const url = require('url');
const AuthManager = require('./auth-manager');
const Storage = require('./storage');
const Window = require('./window');


class Application {
    constructor() {
        this.initialzied = false;
        this.window = null;

        this.storage = new Storage();
        this.authManager = new AuthManager(this, this.storage);

        this.handleEvents();
    }

    handleEvents() {
        app.on('activate', (event, hasVisibleWindows) => {
            if (!hasVisibleWindows) {
                this.launch();
            }
        });

        app.on('window-all-closed', () => {
            if (process.platform in ['win32', 'linux']) {
                app.quit();
            }
        });

        app.on('before-quit', () => {
            this.storage.save();
        });
    }

    async init() {
        await this.storage.init();
        this.initialzied = true;
    }

    isWindowOpened() {
        return this.window !== null;
    }

    switchWindowTo(windowName) {
        if (this.isWindowOpened()) {
            this.window.close();
        }

        this.window = new Window(this);

        let templateUrl;
        let options;

        switch (windowName) {
            case 'main':
                templateUrl = url.format({
                    protocol: 'file',
                    pathname: appEnv.paths.resolve('statics', 'main.html'),
                    slashes: true
                });

                options = {
                    width: 360,
                    height: 600,
                    minWidth: 300,
                    minHeight: 480
                };
                break;

            case 'login':
                templateUrl = url.format({
                    protocol: 'file',
                    pathname: appEnv.paths.resolve('statics', 'login.html'),
                    slashes: true
                });

                options = {
                    width: 360,
                    height: 600,
                    minWidth: 300,
                    minHeight: 480
                };
                break;
            default: throw new Error();
        }

        this.window.open(templateUrl, options);
    }

    async launch() {
        const isAuthorized = await this.authManager.checkAuthorized();

        if (isAuthorized) {
            this.switchWindowTo('main');
        } else {
            this.switchWindowTo('login');
        }
    }

    emitOnCurrentWindow(channel, ...args) {
        if (this.isWindowOpened()) {
            this.window.emit(channel, ...args);
        }
    }
}

module.exports = Application;
