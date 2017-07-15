const { NgModule } = require('@angular/core');
const SharedModule = require('../shared/shared.module');
const ModalModule = require('./modal/modal.module');


class CoreModule {
}

CoreModule.annotations = [
    new NgModule({
        imports: [
            SharedModule,
            ModalModule
        ],
        declarations: [],
        providers: [],
        exports: [
            ModalModule
        ]
    })
];

module.exports = CoreModule;
