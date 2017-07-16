const { NgModule } = require('@angular/core');
const SharedModule = require('../shared/shared.module');
const TodoModule = require('../todo/todo.module');
const HomeSectionComponent = require('./home-section/home-section.component');
const ModalModule = require('./modal/modal.module');
const NavComponent = require('./nav/nav.component');


class CoreModule {
}

CoreModule.annotations = [
    new NgModule({
        imports: [
            SharedModule,
            TodoModule,
            ModalModule
        ],
        declarations: [
            HomeSectionComponent,
            NavComponent
        ],
        providers: [],
        exports: [
            HomeSectionComponent,
            ModalModule,
            NavComponent
        ]
    })
];

module.exports = CoreModule;
