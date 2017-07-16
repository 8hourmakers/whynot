const { Component, EventEmitter } = require('@angular/core');


class AddTodoModalComponent {
    constructor() {
        this.close$ = new EventEmitter();
        this.categories = [
            { name: '미용', imgSrc: 'beauty@2x.png' },
            { name: '금용', imgSrc: 'beauty@2x.png' },
            { name: '친목', imgSrc: 'beauty@2x.png' },
            { name: '운동', imgSrc: 'beauty@2x.png' },
            { name: '학업', imgSrc: 'beauty@2x.png' },
            { name: '건강', imgSrc: 'beauty@2x.png' },
            { name: '집안일', imgSrc: 'beauty@2x.png' }
        ];
        this.todoTitle = '';
    }

    clearInput() {
        this.todoTitle = '';
    }

    closeModal() {
        this.close$.emit();
    }
}

AddTodoModalComponent.annotations = [
    new Component({
        moduleId: module.id,
        selector: 'app-add-todo-modal',
        templateUrl: 'add-todo-modal.component.html',
        styleUrls: ['add-todo-modal.component.css']
    })
];

module.exports = AddTodoModalComponent;
