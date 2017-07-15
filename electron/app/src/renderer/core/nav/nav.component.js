const { Component, EventEmitter } = require('@angular/core');


class NavComponent {
    constructor() {
        this.tabs = [
            { id: 0, name: '홈', value: 'home-section' },
            { id: 1, name: '리스트', value: 'list-section' },
            { id: 2, name: '캘린더', value: 'calendar-section' }
        ];
        this.settingTab = { id: 3, name: '설정', value: 'setting-section' };
        this.selectSection = new EventEmitter();
    }

    ngOnInit() {
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
        moduleId: module.id,
        selector: 'app-nav',
        templateUrl: 'nav.component.html',
        styleUrls: ['nav.component.css'],
        outputs: ['selectSection'],
    }),
];

module.exports = NavComponent;
