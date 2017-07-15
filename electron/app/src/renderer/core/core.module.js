const { NgModule } = require('@angular/core');
const SharedModule = require('../shared/shared.module');
const ModalModule = require('./modal/modal.module');
const NavComponent = require('./nav/nav.component');


class CoreModule {
}

CoreModule.annotations = [
    new NgModule({
        imports: [
            SharedModule,
            ModalModule
        ],
        declarations: [
            NavComponent
        ],
        providers: [],
        exports: [
            ModalModule,
            NavComponent
        ]
    })
];

module.exports = CoreModule;
