const { Component } = require('@angular/core');


class CalendarComponent {
}

CalendarComponent.annotations = [
    new Component({
        moduleId: module.id,
        selector: 'app-calendar',
        templateUrl: 'calendar.component.html',
        styleUrls: ['calendar.component.css']
    })
];

module.exports = CalendarComponent;
