const { Component, ChangeDetectorRef, EventEmitter } = require('@angular/core');
const { dialog } = require('electron').remote;
const ipcExtra = require('../../../common/utils/ipc-extra');
const exception = require('../../../common/constants/exception');


class RegisterModalComponent {
    constructor(changeDetectorRef) {
        this.changeDetectorRef = changeDetectorRef;

        this.close$ = new EventEmitter();
        this.isErrorCaught = false;
        this.errorMessage = '';
        this.model = {
            email: '',
            username: '',
            password: '',
            passwordConfirm: '',
        };
    }

    async registerNewAccount() {
        if (this.model.password !== this.model.passwordConfirm) {
            this.isErrorCaught = true;
            this.errorMessage = '비밀번호가 일치하지 않습니다.';
            return;
        }

        try {
            await ipcExtra.call('authManager.register', {
                username: this.model.username,
                email: this.model.email,
                password: this.model.password
            });

            dialog.showMessageBox({
                type: 'info',
                message: '회원 가입에 성공하였습니다 :)'
            }, () => {
                this.close();
            });
        } catch (err) {
            this.isErrorCaught = true;
            this.handleErrorMessage(err);
            this.changeDetectorRef.detectChanges();
        }
    }

    handleErrorMessage(error) {
        switch (error) {
            case exception.INVALID_EMAIL:
                this.errorMessage = '유효하지 않은 이메일입니다.';
                break;
            case exception.INVALID_USERNAME:
                this.errorMessage = '유효하지 않은 사용자 이름입니다.';
                break;
            case exception.INVALID_PASSWORD:
                this.errorMessage = '유효하지 않은 비밀번호입니다.';
                break;
            case exception.DUPLICATED_EMAIL:
                this.errorMessage = '중복된 이메일입니다. 다른 이메일을 사용해 주세요.';
                break;
            case exception.UNEXPECTED:
                this.errorMessage = '예기치 못한 에러가 발생하였습니다. 다시 시도해 주세요 :(';
                break;
            default: break;
        }
    }

    close() {
        this.close$.emit();
    }
}

RegisterModalComponent.annotations = [
    new Component({
        moduleId: module.id,
        selector: 'app-register-modal',
        templateUrl: 'register-modal.component.html',
        styleUrls: ['register-modal.component.css']
    })
];

RegisterModalComponent.parameters = [
    [ChangeDetectorRef]
];

module.exports = RegisterModalComponent;
