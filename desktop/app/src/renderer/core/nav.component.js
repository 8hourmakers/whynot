const { Component, EventEmitter } = require('@angular/core');

class NavComponent {
    constructor() {
        this.selectSection = new EventEmitter();
    }

    ngOnInit() {
        this.tabs = [
            { id: 0, name: '홈', value: 'home-section' },
            { id: 1, name: '리스트', value: 'list-section' },
            { id: 2, name: '캘린더', value: 'calendar-section' },
        ];

        this.selectTab(this.tabs[0]);
    }

    isTabSelected(tab) {
        return this.currentSection === tab.value;
    }

    selectTab(tab) {
        this.currentSection = tab.value;
        this.selectSection.emit(this.currentSection);
    }
}

NavComponent.annotations = [
    new Component({
        selector: 'app-nav',
        template: `
            <nav class="Nav">
                <ul class="Nav__tab">
                    <li *ngFor="let tab of tabs" [ngClass]="{ 'active': isTabSelected(tab) }">
                        <a (click)="selectTab(tab)">{{tab.name}}</a>
                    </li>
                </ul>
            </nav>
        `,
        styles: [`
            .Nav {
                display: flex;
                align-items: stretch;
                justify-content: space-between;
                padding: 0 11px;
                height: 51px;
                border-bottom: 1px solid rgba(216, 216, 216, 1);
            }

            .Nav__tab {
                display: inline-flex;
                align-items: center;
                margin: 0;
                padding: 0;
                height: 100%;
            }

            .Nav__tab > li {
                list-style: none;
                padding: 7px 10px;
                color: #000;
            }

            .Nav__tab > li.active {
                color: rgba(63, 180, 251, 1);
            }

            .Nav__tab > li > a {
                display: inline-block;
                width: 100%;
                height: 100%;
                font-size: 18px;
                font-weight: 400;
                line-height: 36px;
                cursor: pointer;
            }

            .Nav__tab > li > a:hover {
                opacity: .85;
            }
        `],
        inputs: ['initSection'],
        outputs: ['selectSection'],
    }),
];

module.exports = NavComponent;
