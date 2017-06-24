const { NgModule } = require('@angular/core');
const { CommonModule } = require('@angular/common');
const { FormsModule } = require('@angular/forms');
const SharedModule = require('../shared/shared.module');
const RegisterPopupComponent = require('./register-popup.component');

class AccountModule { }

AccountModule.annotations = [
    new NgModule({
        imports: [
            CommonModule,
            FormsModule,
            SharedModule,
        ],
        declarations: [
            RegisterPopupComponent,
        ],
        entryComponents: [
            RegisterPopupComponent,
        ],
        providers: [],
        exports: [
            RegisterPopupComponent,
        ],
    }),
];

module.exports = AccountModule;
