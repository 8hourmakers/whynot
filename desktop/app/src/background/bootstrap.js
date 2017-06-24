const { app } = require('electron');
const Application = require('./application');

let application = null;

function start() {
    process.on('uncaughtException', (error) => {
        console.error('Uncaught Exception: ', error.toString());

        if (error.stack) {
            console.error(error.stack);
        }
    });

    app.once('ready', () => {
        application = new Application();
        application
            .initialize()
            .then(() => application.launch())
            .catch(err => console.error(err));
    });
}

module.exports = start;
