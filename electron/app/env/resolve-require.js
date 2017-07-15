const path = require('path');
const paths = require('./paths');

const NODE_ENV = process.env.NODE_ENV || 'development';
const basePath = NODE_ENV === 'production'
    ? path.resolve(paths.appRootPath, 'dist/')
    : path.resolve(paths.appRootPath, 'src/');

function resolveRequire(pathname) {
    const scriptPath = path.resolve(basePath, pathname);

    return require(scriptPath);
}

module.exports = resolveRequire;
