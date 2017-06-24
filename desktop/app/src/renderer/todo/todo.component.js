const { Component } = require('@angular/core');

class TodoComponent {
    ngOnInit() {
        this.completed = false;
    }

    toggleCompletion(isChecked) {
        this.completed = isChecked;
    }
}

TodoComponent.annotations = [
    new Component({
        selector: 'app-todo',
        template: `
            <div [class.completed]="completed" class="Todo">
                <span class="Todo__content">비타민 챙겨먹기</span>
                <span class="Todo__checkbox">
                    <app-checkbox [initChecked]="false" (toggle)="toggleCompletion($event)"></app-checkbox>
                </span>
            </div>
        `,
        styles: [`
            .Todo {
                display: flex;
                width: 100%;
                align-items: center;
                justify-content: space-between;
                padding: 11px 11px 11px 22px;
                border-radius: 26px;
                background: linear-gradient(to right, #3fb4fb, #83d1dd);
                box-shadow: 0 2px 8px 0 rgba(0, 0, 0, .13);
            }

            .Todo__content {
                padding-right: 6px;
                font-size: 14px;
                color: #fff;
            }
            
            .Todo.completed {
                background: #fff;
                
            }
            
            .Todo.completed > .Todo__content {
                color: rgb(197, 197, 197);
            }
        `],
    }),
];

module.exports = TodoComponent;
