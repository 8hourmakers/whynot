const { Component } = require('@angular/core');

class TodoListComponent {

}

TodoListComponent.annotations = [
    new Component({
        selector: 'app-todo-list',
        template: `
            <ul class="TodoList">
                <li class="TodoList__item">
                    <app-todo></app-todo>
                </li>

                <li class="TodoList__item">
                    <app-todo></app-todo>
                </li>

                <li class="TodoList__item">
                    <app-todo></app-todo>
                </li>
            </ul>
        `,
        styles: [`
            .TodoList {
                display: block;
                width: 100%;
                margin: 0;
                padding: 0 24px;
            }

            .TodoList__item {
                list-style: none;
                display: block;
                margin-bottom: 16px;
            }
        `],
    }),
];

module.exports = TodoListComponent;
