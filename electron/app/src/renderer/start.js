const { platformBrowserDynamic } = require('@angular/platform-browser-dynamic');
const LoginPageModule = require('./login-page.module');
const MainPageModule = require('./main-page.module');


async function start(targetModule) {
    try {
        const platform = platformBrowserDynamic();
        let bootstrapModule;

        switch (targetModule) {
            case 'login':
                bootstrapModule = LoginPageModule;
                break;
            case 'main':
                bootstrapModule = MainPageModule;
                break;
            default:
                break;
        }

        await platform.bootstrapModule(bootstrapModule);
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
}

module.exports = start;
