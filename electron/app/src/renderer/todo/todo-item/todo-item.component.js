const { Component } = require('@angular/core');


class TodoItemComponent {
    ngOnInit() {
        this.completed = false;
    }

    toggleCompletion(isChecked) {
        this.completed = isChecked;
    }
}

TodoItemComponent.annotations = [
    new Component({
        moduleId: module.id,
        selector: 'app-todo-item',
        templateUrl: 'todo-item.component.html',
        styleUrls: ['todo-item.component.css']
    })
];

module.exports = TodoItemComponent;
