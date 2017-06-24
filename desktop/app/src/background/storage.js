const { app } = require('electron');
const { cloneDeep } = require('lodash');
const path = require('path');
const fse = require('fs-extra');

const dataPath = path.resolve(app.getPath('userData'), 'data.json');

class Storage {
    constructor() {
        this.data = {};
    }

    async initialize() {
        try {
            if (await fse.pathExists(dataPath)) {
                await fse.ensureFile(dataPath);
                await fse.writeJson(dataPath, {});
            }

            await this.load();
        } catch (err) {
            throw new Error(err);
        }
    }

    async load() {
        let data;

        try {
            data = await fse.readJson(dataPath);
        } catch (err) {
            data = {};
        }

        this.data = data;
    }

    async save() {
        try {
            await fse.writeJson(dataPath, this.data);
        } catch (err) {
            console.error(err);
        }
    }

    hasItem(name) {
        return name in this.data;
    }

    setItem(object) {
        Object.assign(this.data, object);
    }

    getItem(name) {
        if (this.hasItem(name)) {
            return cloneDeep(this.data[name]);
        }

        return null;
    }
}

module.exports = Storage;
