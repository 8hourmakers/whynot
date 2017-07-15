const IpcGateway = require('./ipc-gateway');
const exception = require('../common/constants/exception');
const validation = require('../common/constants/validation');
const http = require('../common/utils/http');


class AuthManager extends IpcGateway {
    constructor(application, storage) {
        super(application);

        this.storage = storage;

        this.user = null;
        this.token = null;
        this.authorized = false;

        this.handleEvents();
    }

    getUserToken() {
        return this.token;
    }

    authorize(userInfo, token) {
        this.user = {
            username: userInfo.username,
            email: userInfo.email
        };
        this.token = token;
        this.authorized = true;

        this.storage.saveItem('token', this.token);
        this.application.switchWindowTo('main');
    }

    unauthorize() {
        this.user = null;
        this.token = null;
        this.authorized = false;

        this.storage.removeItem('token');
        this.application.switchWindowTo('login');
    }

    async checkAuthorized() {
        const token = this.storage.getItem('token');

        if (!token) {
            this.unauthorize();
            return this.authorized;
        }

        try {
            const userInfo = await http.get('/users/auth/token/', {
                headers: { authorization: `token ${token}` }
            });

            this.authorize(userInfo, token);
        } catch (err) {
            this.unauthorize();
        }

        return this.authorized;
    }

    async login(email, password) {
        const loginResponse = await http.post('/users/auth/', {
            data: { email, password }
        });

        this.authorize(loginResponse, loginResponse.token);
    }

    async logout() {
        await http.delete('/users/auth/', {
            headers: { authorization: `token ${this.token}` }
        });

        this.unauthorize();
    }

    async register(userInfo) {
        return http.post('/users/', {
            data: {
                username: userInfo.username,
                email: userInfo.email,
                password: userInfo.password
            }
        });
    }

    handleEvents() {
        this.on('authManager.checkAuthorized', async (req, res) => {
            const isAuthorized = await this.checkAuthorized();
            res.resolve(isAuthorized);
        });

        this.on('authManager.login', async (req, res) => {
            const { email, password } = req.data;

            if (!validation.email.test(email)) {
                res.reject(exception.INVALID_EMAIL);
                return;
            }

            try {
                await this.login(email, password);
                res.resolve(this.user);
            } catch (err) {
                if (err.statusCode === 401) {
                    res.reject(exception.LOGIN_FAIL);
                } else {
                    res.reject(exception.UNEXPECTED);
                }
            }
        });

        this.on('authManager.logout', async (req, res) => {
            try {
                await this.logout();
                res.resolve();
            } catch (err) {
                res.reject(exception.UNEXPECTED);
            }
        });

        this.on('authManager.register', async (req, res) => {
            const { username, email, password } = req.data;

            if (!validation.username.test(username)) {
                res.reject(exception.INVALID_USERNAME);
                return;
            } else if (!validation.email.test(email)) {
                res.reject(exception.INVALID_EMAIL);
                return;
            } else if (!validation.password.test(password)) {
                res.reject(exception.INVALID_PASSWORD);
                return;
            }

            try {
                await this.register({ username, email, password });
                res.resolve();
            } catch (err) {
                if (err.statusCode === 400) {
                    res.reject(exception.DUPLICATED_EMAIL);
                } else {
                    res.reject(exception.UNEXPECTED);
                }
            }
        });
    }
}

module.exports = AuthManager;
