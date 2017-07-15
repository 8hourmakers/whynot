const { NgModule } = require('@angular/core');
const { BrowserModule } = require('@angular/platform-browser');
const CoreModule = require('./core/core.module');
const SharedModule = require('./shared/shared.module');
const MainPageComponent = require('./main-page.component');


class MainPageModule {}

MainPageModule.annotations = [
    new NgModule({
        imports: [
            BrowserModule,
            CoreModule,
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
