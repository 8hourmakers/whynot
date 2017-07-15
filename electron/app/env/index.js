const paths = require('./paths');
const resolveRequire = require('./resolve-require');

module.exports = {
    paths,
    require: resolveRequire
};
