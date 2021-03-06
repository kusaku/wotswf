package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface ILoginPageMeta extends IEventDispatcher {

    function onLoginS(param1:String, param2:String, param3:String, param4:Boolean):void;

    function onRegisterS(param1:String):void;

    function onRecoveryS():void;

    function onTextLinkClickS(param1:String):void;

    function onLoginBySocialS(param1:String, param2:String):void;

    function onSetRememberPasswordS(param1:Boolean):void;

    function onExitFromAutoLoginS():void;

    function doUpdateS():void;

    function isTokenS():Boolean;

    function resetTokenS():void;

    function onEscapeS():void;

    function isCSISUpdateOnRequestS():Boolean;

    function isPwdInvalidS(param1:String):Boolean;

    function isLoginInvalidS(param1:String):Boolean;

    function showLegalS():void;

    function startListenCsisUpdateS(param1:Boolean):void;

    function saveLastSelectedServerS(param1:String):void;

    function changeAccountS():void;

    function switchBgModeS():void;

    function setMuteS(param1:Boolean):void;

    function onVideoLoadedS():void;

    function musicFadeOutS():void;

    function as_setDefaultValues(param1:String, param2:String, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean):void;

    function as_setErrorMessage(param1:String, param2:int):void;

    function as_setVersion(param1:String):void;

    function as_setCopyright(param1:String, param2:String):void;

    function as_showWallpaper(param1:Boolean, param2:String, param3:Boolean, param4:Boolean):void;

    function as_showLoginVideo(param1:String, param2:Number, param3:Boolean):void;

    function as_setCapsLockState(param1:Boolean):void;

    function as_pausePlayback():void;

    function as_resumePlayback():void;

    function as_setKeyboardLang(param1:String):void;

    function as_doAutoLogin():void;

    function as_enable(param1:Boolean):void;

    function as_switchToAutoAndSubmit(param1:String):void;

    function as_showSimpleForm(param1:Boolean, param2:Array):void;

    function as_showSocialForm(param1:Boolean, param2:String, param3:String, param4:String):void;

    function as_resetPassword():void;

    function as_getServersDP():Object;

    function as_setSelectedServerIndex(param1:int):void;
}
}
