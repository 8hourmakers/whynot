const { app, ipcMain } = require('electron');
const EventEmitter = require('events');
const AuthManager = require('./auth-manager');
const Storage = require('./storage');
const Window = require('./window');

class Application extends EventEmitter {
    constructor() {
        super();

        this.storage = new Storage();
        this.authManager = new AuthManager(this, this.storage);

        this.initialized = false;
        this.window = null;

        this.handleEvents();
    }

    async initialize() {
        try {
            await Promise.all([
                this.storage.initialize(),
            ]);
        } catch (err) {
            throw new Error(err);
        }
    }
    
    launch() {
        let window;

        if (this.authManager.isAuthorized) {
            // OPEN main page.
            window = new Window(this, 'main', {
                template: 'index',
                minWidth: 320,
                minHeight: 480,
                width: 480,
                height: 768,
            });
        } else {
            // OPEN login page.
            window = new Window(this, 'login', {
                template: 'login',
                minWidth: 300,
                minHeight: 480,
                width: 360,
                height: 600,
            });
        }

        this.addWindow(window);
    }
    
    handleEvents() {
        ipcMain.on('application:switch-window', () => {
            this.removeWindow();
            this.launch();
        });

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

        app.on('before-quit', async () => {
            try {
                await this.storage.save();
            } catch (err) {
                console.error(err);
            } finally {
                app.quit();
            }
        });
    }

    addWindow(window) {
        this.window = window;
        this.window.focus();
    }

    removeWindow(window = null) {
        if (window === null) {
            this.window.close();
        } else {
            this.window = null;
        }
    }
}

module.exports = Application;
