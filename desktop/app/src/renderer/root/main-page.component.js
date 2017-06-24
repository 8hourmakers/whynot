const { Component } = require('@angular/core');

class MainPageComponent {
    ngOnInit() {
        this.section = 'home-section';
    }

    changeSection(selection) {
        this.section = selection;
    }
}

MainPageComponent.annotations = [
    new Component({
        selector: 'app-main-page',
        template: `
            <div class="MainPage">
                <app-nav (selectSection)="changeSection($event)" class="MainPage__nav"></app-nav>
                <main [ngSwitch]="section" class="MainPage__content">
                    <app-home *ngSwitchCase="'home-section'"></app-home>
                </main>
                <button class="MainPage__addTodoBtn"></button>
            </div>
        `,
        styles: [`
            .MainPage { }
        `],
    }),
];

module.exports = MainPageComponent;
