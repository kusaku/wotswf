package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractView;

public class LoginPageMeta extends AbstractView {

    public var onLogin:Function;

    public var onRegister:Function;

    public var onRecovery:Function;

    public var onTextLinkClick:Function;

    public var onLoginBySocial:Function;

    public var onSetRememberPassword:Function;

    public var onExitFromAutoLogin:Function;

    public var doUpdate:Function;

    public var isToken:Function;

    public var resetToken:Function;

    public var onEscape:Function;

    public var isCSISUpdateOnRequest:Function;

    public var isPwdInvalid:Function;

    public var isLoginInvalid:Function;

    public var showLegal:Function;

    public var startListenCsisUpdate:Function;

    public var saveLastSelectedServer:Function;

    public var changeAccount:Function;

    public var switchBgMode:Function;

    public var setMute:Function;

    public var onVideoLoaded:Function;

    public var musicFadeOut:Function;

    public function LoginPageMeta() {
        super();
    }

    public function onLoginS(param1:String, param2:String, param3:String, param4:Boolean):void {
        App.utils.asserter.assertNotNull(this.onLogin, "onLogin" + Errors.CANT_NULL);
        this.onLogin(param1, param2, param3, param4);
    }

    public function onRegisterS(param1:String):void {
        App.utils.asserter.assertNotNull(this.onRegister, "onRegister" + Errors.CANT_NULL);
        this.onRegister(param1);
    }

    public function onRecoveryS():void {
        App.utils.asserter.assertNotNull(this.onRecovery, "onRecovery" + Errors.CANT_NULL);
        this.onRecovery();
    }

    public function onTextLinkClickS(param1:String):void {
        App.utils.asserter.assertNotNull(this.onTextLinkClick, "onTextLinkClick" + Errors.CANT_NULL);
        this.onTextLinkClick(param1);
    }

    public function onLoginBySocialS(param1:String, param2:String):void {
        App.utils.asserter.assertNotNull(this.onLoginBySocial, "onLoginBySocial" + Errors.CANT_NULL);
        this.onLoginBySocial(param1, param2);
    }

    public function onSetRememberPasswordS(param1:Boolean):void {
        App.utils.asserter.assertNotNull(this.onSetRememberPassword, "onSetRememberPassword" + Errors.CANT_NULL);
        this.onSetRememberPassword(param1);
    }

    public function onExitFromAutoLoginS():void {
        App.utils.asserter.assertNotNull(this.onExitFromAutoLogin, "onExitFromAutoLogin" + Errors.CANT_NULL);
        this.onExitFromAutoLogin();
    }

    public function doUpdateS():void {
        App.utils.asserter.assertNotNull(this.doUpdate, "doUpdate" + Errors.CANT_NULL);
        this.doUpdate();
    }

    public function isTokenS():Boolean {
        App.utils.asserter.assertNotNull(this.isToken, "isToken" + Errors.CANT_NULL);
        return this.isToken();
    }

    public function resetTokenS():void {
        App.utils.asserter.assertNotNull(this.resetToken, "resetToken" + Errors.CANT_NULL);
        this.resetToken();
    }

    public function onEscapeS():void {
        App.utils.asserter.assertNotNull(this.onEscape, "onEscape" + Errors.CANT_NULL);
        this.onEscape();
    }

    public function isCSISUpdateOnRequestS():Boolean {
        App.utils.asserter.assertNotNull(this.isCSISUpdateOnRequest, "isCSISUpdateOnRequest" + Errors.CANT_NULL);
        return this.isCSISUpdateOnRequest();
    }

    public function isPwdInvalidS(param1:String):Boolean {
        App.utils.asserter.assertNotNull(this.isPwdInvalid, "isPwdInvalid" + Errors.CANT_NULL);
        return this.isPwdInvalid(param1);
    }

    public function isLoginInvalidS(param1:String):Boolean {
        App.utils.asserter.assertNotNull(this.isLoginInvalid, "isLoginInvalid" + Errors.CANT_NULL);
        return this.isLoginInvalid(param1);
    }

    public function showLegalS():void {
        App.utils.asserter.assertNotNull(this.showLegal, "showLegal" + Errors.CANT_NULL);
        this.showLegal();
    }

    public function startListenCsisUpdateS(param1:Boolean):void {
        App.utils.asserter.assertNotNull(this.startListenCsisUpdate, "startListenCsisUpdate" + Errors.CANT_NULL);
        this.startListenCsisUpdate(param1);
    }

    public function saveLastSelectedServerS(param1:String):void {
        App.utils.asserter.assertNotNull(this.saveLastSelectedServer, "saveLastSelectedServer" + Errors.CANT_NULL);
        this.saveLastSelectedServer(param1);
    }

    public function changeAccountS():void {
        App.utils.asserter.assertNotNull(this.changeAccount, "changeAccount" + Errors.CANT_NULL);
        this.changeAccount();
    }

    public function switchBgModeS():void {
        App.utils.asserter.assertNotNull(this.switchBgMode, "switchBgMode" + Errors.CANT_NULL);
        this.switchBgMode();
    }

    public function setMuteS(param1:Boolean):void {
        App.utils.asserter.assertNotNull(this.setMute, "setMute" + Errors.CANT_NULL);
        this.setMute(param1);
    }

    public function onVideoLoadedS():void {
        App.utils.asserter.assertNotNull(this.onVideoLoaded, "onVideoLoaded" + Errors.CANT_NULL);
        this.onVideoLoaded();
    }

    public function musicFadeOutS():void {
        App.utils.asserter.assertNotNull(this.musicFadeOut, "musicFadeOut" + Errors.CANT_NULL);
        this.musicFadeOut();
    }
}
}
