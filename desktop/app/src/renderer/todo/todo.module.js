const { NgModule } = require('@angular/core');
const { CommonModule } = require('@angular/common');
const SharedModule = require('../shared/shared.module');
const TodoComponent = require('./todo.component');
const TodoListComponent = require('./todo-list.component');

class TodoModule {

}

TodoModule.annotations = [
    new NgModule({
        imports: [
            CommonModule,
            SharedModule,
        ],
        declarations: [
            TodoComponent,
            TodoListComponent,
        ],
        exports: [
            TodoComponent,
            TodoListComponent,
        ],
    }),
];

module.exports = TodoModule;
