const request = require('request-promise');
const { cloneDeep } = require('lodash');


const http = {
    apiUrl: 'http://8hourmakers.com/whynot/api',
    defaultOptions: {
        headers: {
            accept: 'application/json',
            'content-type': 'application/json'
        }
    },

    setDefaultOption(name, value) {
        this.defaultOptions[name] = value;
    },

    parseProviderOptions(options) {
        const providerOptions = {};

        if (options.headers) {
            providerOptions.headers = cloneDeep(options.headers);
        }

        if (options.data) {
            providerOptions.body = cloneDeep(options.data);
            providerOptions.json = true;
        }

        return providerOptions;
    },

    async request(method, endpoint, options = {}) {
        const url = `${this.apiUrl}${endpoint}`;
        const concatOptions = Object.assign({}, this.defaultOptions, options);
        const providerOptions = this.parseProviderOptions(concatOptions);

        providerOptions.method = method;
        providerOptions.url = url;

        console.log(`${method}-${url}`);

        try {
            const res = await request(providerOptions);
            console.log(res);
            return res;
        } catch (err) {
            console.error(err.message);
            return Promise.reject(err);
        }
    },

    get(endpoint, options) {
        return this.request('GET', endpoint, options);
    },

    post(endpoint, options) {
        return this.request('POST', endpoint, options);
    },

    put(endpoint, options) {
        return this.request('PUT', endpoint, options);
    },

    delete(endpoint, options) {
        return this.request('DELETE', endpoint, options);
    }
};

module.exports = http;
