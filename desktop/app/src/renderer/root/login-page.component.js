const { ipcRenderer } = require('electron');
const { Component } = require('@angular/core');
const RegisterPopupComponent = require('../account/register-popup.component');
const Popup = require('../shared/popup');
const ipcHelper = require('../../common/utils/ipc-helper');

class LoginPageComponent {
    constructor(popup) {
        this.popup = popup;
    }

    async ngOnInit() {
        this.loading = true;
        this.error = false;

        this.id = '';
        this.password = '';

        const isAuthorized = await ipcHelper.call('auth:check-authorized');

        if (isAuthorized) {
            ipcRenderer.send('application:switch-window');
        } else {
            this.loading = false;
        }
    }

    async login() {
        this.loading = true;

        try {
            await ipcHelper.call('auth:login', this.id, this.password);
            ipcRenderer.send('application:switch-window');
        } catch (err) {
            this.error = true;
        } finally {
            this.loading = false;
        }
    }

    openRegisterPopup() {
        this.popup.open(RegisterPopupComponent);
    }
}

LoginPageComponent.annotations = [
    new Component({
        selector: 'app-login-page',
        template: `
            <div class="LoginPage">
                <input [(ngModel)]="id" type="text" />
                <input [(ngModel)]="password" type="password" />
                <button (click)="login()">로그인</button>
                <button (click)="openRegisterPopup()">회원가입</button>
                
                <app-popup-container></app-popup-container>
            </div>
        `,
        styles: [`
            .LoginPage { }
        `],
    }),
];

LoginPageComponent.parameters = [
    [Popup],
];

module.exports = LoginPageComponent;
