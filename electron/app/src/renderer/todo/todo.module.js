const { NgModule } = require('@angular/core');
const SharedModule = require('../shared/shared.module');
const AddTodoModalComponent = require('./add-todo-modal/add-todo-modal.component');
const TodoItemComponent = require('./todo-item/todo-item.component');


class TodoModule {
}

TodoModule.annotations = [
    new NgModule({
        imports: [
            SharedModule
        ],
        declarations: [
            AddTodoModalComponent,
            TodoItemComponent
        ],
        entryComponents: [
            AddTodoModalComponent
        ],
        providers: [],
        exports: [
            AddTodoModalComponent,
            TodoItemComponent
        ]
    })
];

module.exports = TodoModule;
