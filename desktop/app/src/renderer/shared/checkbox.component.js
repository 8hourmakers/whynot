const { Component, EventEmitter } = require('@angular/core');

class CheckboxComponent {
    constructor() {
        this.toggle = new EventEmitter();
    }

    ngOnInit() {
        this.checked = this.initChecked;
    }

    toggleCheckbox() {
        this.toggle.emit(this.checked);
    }
}

CheckboxComponent.annotations = [
    new Component({
        selector: 'app-checkbox',
        template: `
            <label class="Checkbox">
                <input [(ngModel)]="checked"
                       (change)="toggleCheckbox()"
                       type="checkbox" />
                <span class="Checkbox__indicator"></span>
            </label>
        `,
        styles: [`
            .Checkbox {
                position: relative;
                display: inline-flex;
                width: 30px;
                height: 30px;
            }
            
            .Checkbox > input {
                position: absolute;
                z-index: -999;
                opacity: 0;
            }
            
            .Checkbox__indicator {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: #fff;
                border-radius: 15px;
                box-shadow: 0 2px 8px 0 rgba(0, 0, 0, 0.13);
                cursor: pointer;
            }

            .Checkbox__indicator:after {
                display: none;
                position: absolute;
                top: 5px;
                left: 5px;
                width: 20px;
                height: 20px;
                content: " ";
                background-image: url(./images/checked.png);
                background-position: center;
                background-size: cover;
                background-repeat: no-repeat;
             }
            
            .Checkbox > input:checked ~ .Checkbox__indicator:after {
                  display: block;
            }
        `],
        inputs: ['initChecked'],
        outputs: ['toggle'],
    }),
];

module.exports = CheckboxComponent;
