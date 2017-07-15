const fs = require('fs');
const fse = require('fs-extra');
const promisify = require('./promisify');


async function readFile(filename) {
    const readFileAsync = promisify(fs.readFile);

    try {
        return readFileAsync(filename);
    } catch (err) {
        console.error(err);
        return '';
    }
}

async function readdir(pathname) {
    const readdirAsync = promisify(fs.readdir);

    try {
        return readdirAsync(pathname);
    } catch (err) {
        console.error(err);
        return [];
    }
}

async function writeFile(filename, data) {
    const writeFileAsync = promisify(fs.writeFile);

    try {
        console.log(filename, data);
        await writeFileAsync(filename, data);
    } catch (err) {
        console.error(err);
    }
}

async function isPathExists(pathname) {
    const accessAsync = promisify(fs.access);

    try {
        await accessAsync(pathname);
        return true;
    } catch (err) {
        return false;
    }
}

async function ensureDirectory(dirname) {
    await fse.ensureDir(dirname);
}


module.exports = {
    readFile,
    readdir,
    writeFile,
    isPathExists,
    ensureDirectory
};
