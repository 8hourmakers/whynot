const { NgModule } = require('@angular/core');
const Modal = require('./modal.service');
const ModalContainerComponent = require('./modal-container.component');


class ModalModule {
}

ModalModule.annotations = [
    new NgModule({
        imports: [],
        declarations: [
            ModalContainerComponent
        ],
        providers: [
            Modal
        ],
        exports: [
            ModalContainerComponent
        ]
    })
];

module.exports = ModalModule;
