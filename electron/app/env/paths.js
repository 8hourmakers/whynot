const path = require('path');

const projectRootPath = path.resolve(__dirname, '../../');
const appRootPath = path.resolve(projectRootPath, 'app/');

const paths = {
    projectRootPath,
    appRootPath,
    statics: path.resolve(appRootPath, 'statics/'),
    resolve(basePathname, ...pathnames) {
        const basePath = this[basePathname];
        return path.resolve(basePath, ...pathnames);
    },
    setAppPaths(app) {
        this.userDataPath = app.getPath('userData');
    }
};

module.exports = paths;
