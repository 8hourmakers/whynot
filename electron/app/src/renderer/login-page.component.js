const { Component, ChangeDetectorRef } = require('@angular/core');
const Modal = require('./core/modal/modal.service');
const RegisterMoalComponent = require('./account/register-modal/register-modal.component');
const exception = require('../common/constants/exception');
const ipcExtra = require('../common/utils/ipc-extra');


class LoginPageComponent {
    constructor(modal, changeDetectorRef) {
        this.modal = modal;
        this.changeDetectorRef = changeDetectorRef;

        this.loading = false;
        this.isErrorCaught = false;
        this.errorMessage = '';

        this.model = {
            email: '',
            password: ''
        };
    }

    async login(event) {
        event.preventDefault();
        this.loading = true;

        try {
            await ipcExtra.call('authManager.login', {
                email: this.model.email,
                password: this.model.password
            });
        } catch (err) {
            this.isErrorCaught = true;
            this.handleErrorMessage(err);
        } finally {
            this.loading = false;
            this.changeDetectorRef.detectChanges();
        }
    }

    handleErrorMessage(error) {
        switch (error) {
            case exception.INVALID_EMAIL:
                this.errorMessage = '유효하지 않은 이메일입니다.';
                break;
            case exception.LOGIN_FAIL:
                this.errorMessage = '이메일 또는 비밀번호가 일치하지 않습니다.';
                break;
            case exception.UNEXPECTED:
                this.errorMessage = '예기치 못한 에러가 발생하였습니다. 다시 시도해 주세요 :(';
                break;
            default: break;
        }
    }

    openRegisterPopup() {
        this.modal.open(RegisterMoalComponent);
    }
}

LoginPageComponent.annotations = [
    new Component({
        moduleId: module.id,
        selector: 'app-login-page',
        templateUrl: 'login-page.component.html',
        styleUrls: ['login-page.component.css']
    })
];

LoginPageComponent.parameters = [
    [Modal],
    [ChangeDetectorRef]
];

module.exports = LoginPageComponent;
