const ipcHelper = require('../common/utils/ipc-helper');
const netHelper = require('../common/utils/net-helper');

class AuthManager {
    constructor(application, storage) {
        this.application = application;
        this.storage = storage;

        this.isAuthorized = false;
        this.token = null;
        this.userInfo = null;

        this.handleEvents();
    }

    async checkAuthorized() {
        if (!this.storage.hasItem('token')) {
            return false;
        }

        const token = this.storage.getItem('token');

        try {
            const res = await netHelper.fetch('GET', '/users/auth/token/', {
                authorization: `token ${token}`,
            });
            const data = JSON.parse(res.data);

            this.userInfo = {
                username: data.username,
                email: data.email,
            };

            this.isAuthorized = true;
            this.token = token;

            return true;
        } catch (error) {
            return false;
        }
    }

    async login(id, password) {
        try {
            const res = await netHelper.fetch(
                'POST',
                '/users/auth/',
                { 'content-type': 'application/json' },
                { id, password }
            );
            const data = JSON.parse(res.data);

            this.token = data.token;
            this.userInfo = {
                username: data.username,
                email: data.email,
            };

            this.isAuthorized = true;

            this.storage.setItem('token', this.token);
            await this.storage.save();
        } catch (err) {
            console.error(err);
        }
    }

    async register(info) {
        try {
            const res = await netHelper.fetch(
                'POST',
                '/users/',
                { 'content-type': 'application/json' },
                info
            );
            const data = JSON.parse(res.data);

            this.token = data.token;
            this.userInfo = {
                username: data.username,
                email: data.email,
            };

            this.isAuthorized = true;
            this.storage.setItem('token', this.token);
            await this.storage.save();
        } catch (err) {
            console.error(err);
        }
    }

    handleEvents() {
        ipcHelper.on('auth:check-authorized', () => this.checkAuthorized());
        ipcHelper.on('auth:login', (id, password) => this.login(id, password));
        ipcHelper.on('auth:register', info => this.register(info));
    }
}

module.exports = AuthManager;
