package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.login.impl.vo.SocialIconVo;
import net.wg.infrastructure.base.AbstractView;
import net.wg.infrastructure.exceptions.AbstractException;

import scaleform.clik.data.DataProvider;

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

    private var _dataProviderSocialIconVo:DataProvider;

    public function LoginPageMeta() {
        super();
    }

    override protected function onDispose():void {
        var _loc1_:SocialIconVo = null;
        if (this._dataProviderSocialIconVo) {
            for each(_loc1_ in this._dataProviderSocialIconVo) {
                _loc1_.dispose();
            }
            this._dataProviderSocialIconVo.cleanUp();
            this._dataProviderSocialIconVo = null;
        }
        super.onDispose();
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

    public final function as_showSimpleForm(param1:Boolean, param2:Array):void {
        var _loc4_:uint = 0;
        var _loc5_:int = 0;
        var _loc6_:SocialIconVo = null;
        var _loc3_:DataProvider = this._dataProviderSocialIconVo;
        this._dataProviderSocialIconVo = new DataProvider();
        if (param2) {
            _loc4_ = param2.length;
            _loc5_ = 0;
            while (_loc5_ < _loc4_) {
                this._dataProviderSocialIconVo[_loc5_] = new SocialIconVo(param2[_loc5_]);
                _loc5_++;
            }
        }
        this.showSimpleForm(param1, this._dataProviderSocialIconVo);
        if (_loc3_) {
            for each(_loc6_ in _loc3_) {
                _loc6_.dispose();
            }
            _loc3_.cleanUp();
        }
    }

    protected function showSimpleForm(param1:Boolean, param2:DataProvider):void {
        var _loc3_:String = "as_showSimpleForm" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc3_);
        throw new AbstractException(_loc3_);
    }
}
}
