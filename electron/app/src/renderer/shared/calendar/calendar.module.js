const { NgModule } = require('@angular/core');
const { CommonModule } = require('@angular/common');
const CalendarTable = require('./calendar-table.factory');


class CalendarModule {
}

CalendarModule.annotations = [
    new NgModule({
        imports: [
            CommonModule
        ],
        declarations: [],
        providers: [
            {
                provide: CalendarTable,
                useFactory() {
                    return (year, month) => new CalendarTable(year, month);
                },
                deps: []
            }
        ],
        exports: []
    })
];

module.exports = CalendarModule;
