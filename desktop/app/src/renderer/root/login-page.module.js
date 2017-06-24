const { NgModule } = require('@angular/core');
const { BrowserModule } = require('@angular/platform-browser');
const { FormsModule } = require('@angular/forms');
const SharedModule = require('../shared/shared.module');
const AccountModule = require('../account/account.module');
const LoginPageComponent = require('./login-page.component');

class LoginPageModule { }

LoginPageModule.annotations = [
    new NgModule({
        imports: [
            BrowserModule,
            FormsModule,
            SharedModule,
            AccountModule,
        ],
        declarations: [
            LoginPageComponent,
        ],
        providers: [],
        bootstrap: [LoginPageComponent],
    }),
];

module.exports = LoginPageModule;
