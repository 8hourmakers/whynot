const { Component, EventEmitter } = require('@angular/core');
const ipcHelper = require('../../common/utils/ipc-helper');

class RegisterPopupComponent {
    constructor() {
        this.close = new EventEmitter();
    }

    ngOnInit() {
        this.model = {
            email: '',
            password: '',
            passwordConfirm: '',
        };
    }

    registerNewAccount() {
        ipcHelper
            .call('auth:register', this.model)
            .then((res) => {
                console.log(res);

                this.model.email = '';
                this.model.password = '';
                this.model.passwordConfirm = '';
            });
    }
}

RegisterPopupComponent.annotations = [
    new Component({
        selector: 'app-register-popup',
        template: `
            <div class="RegisterPopup">
                
                
                <form (ngSubmit)="registerNewAccount()" #registerForm="ngForm" class="RegisterPopup__form">
                    <h1>REGISTER</h1>
                    <section>
                        <label for="register-email">Email</label>
                        <input [(ngModel)]="model.email" id="registerEmail" name="email" required type="email" />
                    </section>
                    
                    <section>
                        <label for="register-pw">Password</label>
                        <input [(ngModel)]="model.password" id="registerPW" name="password" required type="password" />
                    </section>

                    <section>
                        <label for="register-pwConfirm">Password Confirm</label>
                        <input [(ngModel)]="model.passwordConfirm" id="registerPWConfirm" name="passwordConfirm" required type="password" />
                    </section>
                    
                    <button type="submit">CREATE ACCOUNT</button>
                </form>
            </div>
        `,
        styles: [`            
            .RegisterPopup {
                display: block;
                padding: 36px 0;
                width: 100%;
                height: 100%;
                background-color: rgb(131, 209, 221);
            }
            
            .RegisterPopup__form {
                padding-bottom: 30px;
                margin: 0 auto;
                max-width: 300px;
            }
            
            .RegisterPopup__form > h1 {
                display: block;
                margin: 0 0 24px 0;
                padding: 0;
                font-size: 24px;
                font-weight: 500;
                line-height: 24px;
                color: #fff;
            }
            
            .RegisterPopup__form > section {
                margin-bottom: 32px;
            }
            
            .RegisterPopup__form > section > label {
                display: block;
                height: 14px;
                margin-bottom: 4px;
                font-size: 14px;
                font-weight: 300;
                line-height: 14px;
                color: #fff;
            }

            .RegisterPopup__form > section > input {
                display: block;
                margin: 0;
                padding: 0;
                width: 100%;
                height: 32px;
                font-size: 18px;
                font-weight: 400;
                line-height: 31px;
                color: #fff;
                border: none;
                border-bottom: 1px solid #fff;
                outline: 0;
                background: transparent;
            }
            
            .RegisterPopup__form > button {
                display: block;
                padding: 0;
                margin: 61px auto 0 auto;
                width: 230px;
                height: 40px;
                font-size: 20px;
                font-weight: 500;
                line-height: 38px;
                color: #fff;
                background: transparent;
                border: 1px solid #fff;
                transition: all .2s ease;
                outline: 0;
                cursor: pointer;
            }

            .RegisterPopup__form > button:hover {
                background-color: #fff;
                color: rgb(131, 209, 221);
            }
        `],
    }),
];

module.exports = RegisterPopupComponent;
