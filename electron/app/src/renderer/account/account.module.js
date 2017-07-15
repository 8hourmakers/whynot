const { NgModule } = require('@angular/core');
const CoreModule = require('../core/core.module');
const SharedModule = require('../shared/shared.module');
const RegisterModalComponent = require('./register-modal/register-modal.component');


class AccountModule {
}

AccountModule.annotations = [
    new NgModule({
        imports: [
            CoreModule,
            SharedModule
        ],
        declarations: [
            RegisterModalComponent
        ],
        entryComponents: [
            RegisterModalComponent
        ],
        providers: [],
        exports: [
            RegisterModalComponent
        ]
    })
];

module.exports = AccountModule;
