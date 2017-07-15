const { app } = require('electron');
const Application = require('./application');

let application = null;

function start() {
    appEnv.paths.setAppPaths(app);

    process.on('uncaughtException', (error) => {
        console.error('Uncaught Exception: ', error.toString());

        if (error.stack) {
            console.error(error.stack);
        }
    });

    app.once('ready', () => {
        application = new Application();

        application
            .init()
            .then(() => application.launch())
            .catch((err) => {
                console.error(err);
            });
    });
}

module.exports = start;
