const { NgModule } = require('@angular/core');
const { BrowserModule } = require('@angular/platform-browser');
const SharedModule = require('./shared/shared.module');
const MainPageComponent = require('./main-page.component');


class MainPageModule {}

MainPageModule.annotations = [
    new NgModule({
        imports: [
            BrowserModule,
            SharedModule
        ],
        declarations: [
            MainPageComponent
        ],
        providers: [],
        bootstrap: [MainPageComponent]
    })
];

module.exports = MainPageModule;
