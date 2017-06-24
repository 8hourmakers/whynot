const { EventEmitter, Injectable } = require('@angular/core');

class Popup {
    constructor() {
        this.popupOpen = new EventEmitter();
        this.popupClose = new EventEmitter();
    }

    open(Component, options = {}) {
        const data = {
            component: Component,
            inputs: options.inputs || {},
        };

        this.popupOpen.emit(data);
    }

    close() {
        this.popupClose.emit();
    }

    getPopupOpenEmitter() {
        return this.popupOpen;
    }

    getPopupCloseEmitter() {
        return this.popupClose;
    }
}

Popup.annotations = [
    new Injectable(),
];

module.exports = Popup;
