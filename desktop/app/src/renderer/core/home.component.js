const { Component } = require('@angular/core');

class HomeComponent {

}

HomeComponent.annotations = [
    new Component({
        selector: 'app-home',
        template: `
            <div class="Home">
                <app-today-date></app-today-date>
                <app-todo-list></app-todo-list>
            </div>
        `,
        styles: [`
            .Home { }
        `],
    }),
];

module.exports = HomeComponent;
