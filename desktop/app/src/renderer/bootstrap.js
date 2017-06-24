const { platformBrowserDynamic } = require('@angular/platform-browser-dynamic');
const LoginPageModule = require('./root/login-page.module');
const MainPageModule = require('./root/main-page.module');

async function bootstrap(name) {
    try {
        const platform = platformBrowserDynamic();

        switch (name) {
            case 'main':
                await platform.bootstrapModule(MainPageModule);
                break;
            case 'login':
                await platform.bootstrapModule(LoginPageModule);
                break;
            default:
                return;
        }
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
}

module.exports = bootstrap;
