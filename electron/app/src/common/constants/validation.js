/* eslint no-useless-escape:0 */

const validation = {
    username: /^[가-힣a-zA-Z0-9_]{2,10}$/,
    email: /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
    password: /^[a-zA-Z0-9$@*#()]{4,20}$/
};

module.exports = validation;
