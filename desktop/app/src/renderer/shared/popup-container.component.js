const {
    Component,
    ComponentFactoryResolver,
    ReflectiveInjector,
    ViewChild,
    ViewContainerRef,
} = require('@angular/core');
const Popup = require('./popup');

class PopupContainerComponent {
    constructor(componentFactoryResolver, popup) {
        this.componentFactoryResolver = componentFactoryResolver;
        this.popup = popup;
    }

    ngOnInit() {
        this.currentComponent = null;

        this.openSub = this.popup
            .getPopupOpenEmitter()
            .subscribe(componentData => this.openComponent(componentData));

        this.closeSub = this.popup
            .getPopupCloseEmitter()
            .subscribe(() => this.closeComponent());
    }

    ngOnDestroy() {
        this.openSub.unsubscribe();
        this.closeSub.unsubscribe();
    }

    isOpened() {
        return this.currentComponent !== null;
    }

    openComponent(data) {
        if (this.isOpened()) {
            this.closeComponent();
        }

        const injector = ReflectiveInjector
            .fromResolvedProviders([], this.popupHost.parentInjector);

        const factory = this.componentFactoryResolver
            .resolveComponentFactory(data.component);

        const component = factory.create(injector);

        // Bind inputs and close event emitter.
        Object
            .keys(data.inputs)
            .forEach((inputName) => {
                component.instance[inputName] = data.inputs[inputName];
            });

        component.instance.close.subscribe(() => this.closeComponent());

        this.popupHost.insert(component.hostView);
        this.currentComponent = component;
    }

    closeComponent() {
        this.currentComponent.destroy();
        this.currentComponent = null;
    }
}

PopupContainerComponent.annotations = [
    new Component({
        selector: 'app-popup-container',
        template: `
            <div [class.opened]="isOpened()" class="PopupContainer">
                <div #host class="PopupContainer__host"></div>
            </div>
        `,
        styles: [`            
            .PopupContainer {
                position: fixed;
                display: none;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                z-index: 50;
            }
            
            .PopupContainer.opened {
                display: block;
            }
        `],
        queries: {
            popupHost: new ViewChild('host', { read: ViewContainerRef }),
        },
    }),
];

PopupContainerComponent.parameters = [
    [ComponentFactoryResolver],
    [Popup],
];

module.exports = PopupContainerComponent;
