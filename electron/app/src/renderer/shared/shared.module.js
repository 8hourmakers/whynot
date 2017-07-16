const { NgModule } = require('@angular/core');
const { CommonModule } = require('@angular/common');
const { FormsModule } = require('@angular/forms');
const CalendarModule = require('./calendar/calendar.module');
const CheckboxComponent = require('./checkbox/checkbox.component');


class SharedModule {
}

SharedModule.annotations = [
    new NgModule({
        imports: [
            CommonModule,
            FormsModule,
            CalendarModule
        ],
        declarations: [
            CheckboxComponent
        ],
        providers: [],
        exports: [
            CommonModule,
            FormsModule,
            CalendarModule,
            CheckboxComponent
        ]
    })
];

module.exports = SharedModule;
