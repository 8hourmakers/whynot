const { Component } = require('@angular/core');

class TodayDateComponent {
    ngOnInit() {
        this.today = new Date();
    }
}

TodayDateComponent.annotations = [
    new Component({
        selector: 'app-today-date',
        template: `
            <div class="TodayDate">
                <div class="TodayDate__left">
                    <span class="TodayDate__date">{{today | date:'d'}}</span>
                    <div class="TodayDate__meta">
                        <label>{{today | date:'MMM'}}</label>
                        <label>{{today | date:'y'}}</label>
                    </div>
                </div>
                <span class="TodayDate__right">{{today | date:'EEEE'}}</span>
            </div>
        `,
        styles: [`
            .TodayDate {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin: 20px 0;
                padding: 11px 22px;
                width: 100%;
                height: 68px;
                color: rgba(71, 71, 71, 1);
            }

            .TodayDate__left {
                display: inline-flex;
            }

            .TodayDate__date {
                display: inline-block;
                font-size: 40px;
                line-height: 40px;
                margin-right: 6px;
            }
            
            .TodayDate__meta > label {
                display: block;
                font-size: 14px;
                line-height: 18px;
            }

            .TodayDate__right {
                font-size: 16px;
                line-height: 20px;
            }
        `],
    }),
];

module.exports = TodayDateComponent;
