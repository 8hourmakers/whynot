const { Component, EventEmitter } = require('@angular/core');


class CheckboxComponent {
    constructor() {
        this.toggle = new EventEmitter();
        this.checked = false;
    }

    ngOnInit() {
        if (this.initChecked) {
            this.checked = this.initChecked;
        }
    }

    toggleCheckbox() {
        this.toggle.emit(this.checked);
    }
}

CheckboxComponent.annotations = [
    new Component({
        moduleId: module.id,
        selector: 'app-checkbox',
        templateUrl: 'checkbox.component.html',
        styleUrls: ['checkbox.component.css'],
        inputs: ['initChecked'],
        outputs: ['toggle']
    })
];

module.exports = CheckboxComponent;
