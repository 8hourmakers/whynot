const { Component } = require('@angular/core');


class MainPageComponent {
}

MainPageComponent.annotations = [
    new Component({
        moduleId: module.id,
        selector: 'app-main-page',
        templateUrl: 'main-page.component.html',
        styleUrls: ['main-page.component.css']
    })
];

module.exports = MainPageComponent;
