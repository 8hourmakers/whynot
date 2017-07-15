const { Injectable } = require('@angular/core');
const { Subject } = require('rxjs/Subject');


const defaultModalOptions = {
    inputs: [],
    onClose: () => null
};

class Modal {
    constructor() {
        this.modalOpens$ = new Subject();
        this.modalCloses$ = new Subject();
    }

    open(component, options) {
        const concatOptions = Object.assign({}, defaultModalOptions, options);

        this.modalOpens$.next({
            component,
            options: concatOptions
        });
    }

    close() {
        this.modalCloses$.next();
    }
}

Modal.annotations = [
    new Injectable()
];

module.exports = Modal;