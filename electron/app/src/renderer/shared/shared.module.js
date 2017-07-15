const { NgModule } = require('@angular/core');
const { CommonModule } = require('@angular/common');
const { FormsModule } = require('@angular/forms');


class SharedModule {
}

SharedModule.annotations = [
    new NgModule({
        imports: [
            CommonModule,
            FormsModule
        ],
        declarations: [],
        providers: [],
        exports: [
            CommonModule,
            FormsModule
        ]
    })
];

module.exports = SharedModule;
