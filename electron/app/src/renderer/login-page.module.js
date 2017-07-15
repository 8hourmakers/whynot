const { NgModule } = require('@angular/core');
const { BrowserModule } = require('@angular/platform-browser');
const CoreModule = require('./core/core.module');
const SharedModule = require('./shared/shared.module');
const AccountModule = require('./account/account.module');
const LoginPageComponent = require('./login-page.component');

class LoginPageModule {}

LoginPageModule.annotations = [
    new NgModule({
        imports: [
            BrowserModule,
            CoreModule,
            AccountModule,
            SharedModule
        ],
        declarations: [
            LoginPageComponent
        ],
        providers: [],
        bootstrap: [LoginPageComponent]
    })
];

module.exports = LoginPageModule;
