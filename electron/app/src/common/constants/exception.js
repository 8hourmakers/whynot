const keyMaker = require('../utils/key-maker');


const exception = keyMaker('exception', {
    LOGIN_FAIL: 'LOGIN_FAIL',
    DUPLICATED_EMAIL: 'DUPLICATED_EMAIL',
    INVALID_USERNAME: 'INVALID_USERNAME',
    INVALID_EMAIL: 'INVALID_EMAIL',
    INVALID_PASSWORD: 'INVALID_PASSWORD',
    UNEXPECTED: 'UNEXPECTED'
});

module.exports = exception;
