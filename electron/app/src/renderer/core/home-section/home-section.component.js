const { Component } = require('@angular/core');
const Modal = require('../../core/modal/modal.service');
const AddTodoModalComponent = require('../../todo/add-todo-modal/add-todo-modal.component');


class HomeSectionComponent {
    constructor(modal) {
        this.modal = modal;
        this.today = new Date();
    }

    openAddTodoModal() {
        this.modal.open(AddTodoModalComponent);
    }
}

HomeSectionComponent.annotations = [
    new Component({
        moduleId: module.id,
        selector: 'app-home-section',
        templateUrl: 'home-section.component.html',
        styleUrls: ['home-section.component.css']
    })
];

HomeSectionComponent.parameters = [
    [Modal]
];

module.exports = HomeSectionComponent;
