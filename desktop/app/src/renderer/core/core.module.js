const { NgModule } = require('@angular/core');
const { CommonModule } = require('@angular/common');
const SharedModule = require('../shared/shared.module');
const TodoModule = require('../todo/todo.module');
const HomeComponent = require('./home.component');
const NavComponent = require('./nav.component');

class CoreModule {

}

CoreModule.annotations = [
    new NgModule({
        imports: [
            CommonModule,
            SharedModule,
            TodoModule,
        ],
        declarations: [
            HomeComponent,
            NavComponent,
        ],
        exports: [
            HomeComponent,
            NavComponent,
        ],
    }),
];

module.exports = CoreModule;
