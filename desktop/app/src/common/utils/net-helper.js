const { net } = require('electron');
const { forEach } = require('lodash');

async function fetch(method, url, headers = {}, data = null) {
    return new Promise((resolve, reject) => {
        const request = net.request({
            method,
            url: `http://8hourmakers.com/whynot/api${url}`,
        });

        forEach(headers, (headerValue, headerName) => {
            request.setHeader(headerName, headerValue);
        });

        request.on('response', (res) => {
            let responseData = '';

            res.on('error', (err) => {
                reject(err);
            });

            res.on('data', (chunk) => {
                responseData += chunk.toString();
            });

            res.on('end', () => {
                const statusCode = res.statusCode;

                res.data = responseData;

                if (/2\d\d/.test(statusCode)) {
                    resolve(res);
                } else {
                    reject(res);
                }
            });
        });

        if (data !== null) {
            request.write(JSON.stringify(data), 'utf8');
        }

        request.end();
    });
}

module.exports = {
    fetch,
};
