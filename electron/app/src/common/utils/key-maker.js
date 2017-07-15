function keyMaker(namespace, obj) {
    const composed = {};
    const keys = Object.keys(obj);

    keys.forEach((key) => {
        composed[key] = `${namespace}:${key}`;
    });

    return composed;
}

module.exports = keyMaker;
