const { NgModule } = require('@angular/core');
const { CommonModule } = require('@angular/common');
const { FormsModule } = require('@angular/forms');
const CheckboxComponent = require('./checkbox.component');
const Popup = require('./popup');
const PopupContainerComponent = require('./popup-container.component');
const TodayDateComponent = require('./today-date.component');

class SharedModule { }

SharedModule.annotations = [
    new NgModule({
        imports: [
            CommonModule,
            FormsModule,
        ],
        declarations: [
            CheckboxComponent,
            PopupContainerComponent,
            TodayDateComponent,
        ],
        providers: [
            Popup,
        ],
        exports: [
            CheckboxComponent,
            PopupContainerComponent,
            TodayDateComponent,
        ],
    }),
];

module.exports = SharedModule;
