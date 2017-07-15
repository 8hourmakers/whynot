const {
    Component,
    ComponentFactoryResolver,
    ChangeDetectorRef,
    ReflectiveInjector,
    ViewChild,
    ViewContainerRef,
} = require('@angular/core');
const Modal = require('./modal.service');


class ModalContainerComponent {
    constructor(modal, componentFactoryResolver, changeDetectorRef) {
        this.modal = modal;
        this.componentFactoryResolver = componentFactoryResolver;
        this.changeDetectorRef = changeDetectorRef;

        this.onModalOpen = null;
        this.onModalClose = null;
        this.currentComponent = null;
        this.modalOpened = false;
    }

    ngOnInit() {
        this.onModalOpen = this.modal
            .modalOpens$
            .subscribe(data => this.openComponent(data.component, data.options));

        this.onModalClose = this.modal
            .modalCloses$
            .subscribe(() => this.closeComponent());
    }

    ngOnDestroy() {
        this.onModalOpen.unsubscribe();
        this.onModalClose.unsubscribe();
    }

    openComponent(component, options) {
        if (this.modalOpened) {
            this.closeComponent();
        }

        const injector = ReflectiveInjector
            .fromResolvedProviders([], this.modalHost.parentInjector);

        const factory = this.componentFactoryResolver
            .resolveComponentFactory(component);

        const componentRef = factory.create(injector);

        Object
            .keys(options.inputs)
            .forEach((inputName) => {
                componentRef.instance[inputName] = options.inputs[inputName];
            });

        componentRef.instance.close$.subscribe((value) => {
            options.onClose(value);
            this.closeComponent();
            this.changeDetectorRef.detectChanges();
        });

        this.modalHost.insert(componentRef.hostView);
        this.currentComponent = componentRef;
        this.modalOpened = true;
    }

    closeComponent() {
        this.currentComponent.destroy();
        this.currentComponent = null;
        this.modalOpened = false;
    }
}

ModalContainerComponent.annotations = [
    new Component({
        moduleId: module.id,
        selector: 'app-modal-container',
        templateUrl: 'modal-container.component.html',
        styleUrls: ['modal-container.component.css'],
        queries: {
            modalHost: new ViewChild('modalHost', { read: ViewContainerRef })
        }
    })
];

ModalContainerComponent.parameters = [
    [Modal],
    [ComponentFactoryResolver],
    [ChangeDetectorRef]
];

module.exports = ModalContainerComponent;
