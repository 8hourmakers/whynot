const path = require('path');
const { omit } = require('lodash');
const fsHelpers = require('../common/utils/fs-helpers');


class Storage {
    constructor() {
        this.filename = path.resolve(appEnv.paths.userDataPath, 'storage.json');
        this.initialized = false;
        this.data = {};
    }

    async init() {
        if (!await fsHelpers.isPathExists(this.filename)) {
            await this.save();
        }

        const dataBuf = await fsHelpers.readFile(this.filename);

        this.data = JSON.parse(dataBuf.toString());
        this.initialized = true;

        console.log(this.filename, this.data);
    }

    getItem(name) {
        return this.data[name];
    }

    saveItem(name, value) {
        this.data[name] = value;
    }

    removeItem(name) {
        this.data = omit(this.data, [name]);
    }

    async save() {
        await fsHelpers.writeFile(this.filename, JSON.stringify(this.data));
    }
}

module.exports = Storage;
