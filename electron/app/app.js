const env = require('./env');

global.appEnv = env;

const start = env.require('main/start');
start();
