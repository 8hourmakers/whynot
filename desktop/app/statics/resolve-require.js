/* eslint global-require:0, import/no-dynamic-require:0 */
const path = require('path');

const NODE_ENV = process.env.NODE_ENV || 'development';
const appRootPath = path.resolve(__dirname, '../');
const basePath = NODE_ENV === 'production'
    ? path.resolve(appRootPath, 'dist/')
    : path.resolve(appRootPath, 'src/');

function resolveRequire(pathname) {
    const scriptPath = path.resolve(basePath, pathname);

    return require(scriptPath);
}

module.exports = resolveRequire;
