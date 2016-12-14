package net.wg.gui.login.impl {
import fl.motion.easing.Cubic;

import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.ui.Keyboard;

import net.wg.data.Aliases;
import net.wg.data.ListDAAPIDataProvider;
import net.wg.data.constants.Linkages;
import net.wg.data.constants.LobbyMetrics;
import net.wg.gui.components.common.BaseLogoView;
import net.wg.gui.components.common.serverStats.ServerVO;
import net.wg.gui.components.common.video.PlayerStatus;
import net.wg.gui.components.common.video.SimpleVideoPlayer;
import net.wg.gui.components.common.video.VideoPlayerStatusEvent;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.events.UILoaderEvent;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.login.ILoginFormView;
import net.wg.gui.login.ISparksManager;
import net.wg.gui.login.impl.components.Copyright;
import net.wg.gui.login.impl.components.CopyrightEvent;
import net.wg.gui.login.impl.components.RssItemEvent;
import net.wg.gui.login.impl.components.RssNewsFeed;
import net.wg.gui.login.impl.ev.LoginEvent;
import net.wg.gui.login.impl.ev.LoginEventTextLink;
import net.wg.gui.login.impl.ev.LoginServerDDEvent;
import net.wg.gui.login.impl.views.LoginFormView;
import net.wg.gui.login.impl.views.SimpleForm;
import net.wg.gui.login.impl.vo.SimpleFormVo;
import net.wg.gui.login.impl.vo.SocialFormVo;
import net.wg.gui.login.impl.vo.SubmitDataVo;
import net.wg.infrastructure.base.meta.ILoginPageMeta;
import net.wg.infrastructure.base.meta.impl.LoginPageMeta;

import org.idmedia.as3commons.util.Map;

import scaleform.clik.constants.InputValue;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.InputEvent;
import scaleform.clik.interfaces.IDataProvider;
import scaleform.clik.motion.Tween;

public class LoginPage extends LoginPageMeta implements ILoginPageMeta {

    private static const SPARK_ZONE:Rectangle = new Rectangle(100, 0, -200, -100);

    private static const SPARK_QUANTITY:uint = 150;

    private static const VIEW_SIMPLE_FORM:String = "LoginFormUI";

    private static const VIEW_SOCIAL_FORM:String = "SocialFormUI";

    private static const INV_CSIS_LISTENING:String = "invCsisListening";

    private static const DELAY_ON_ESCAPE:Number = 50;

    private static const DELAY_ENABLE_INPUTS:Number = 200;

    private static const FREE_SPACE_FACTOR:Number = 0.6;

    private static const FREE_SPACE_BORDER_FACTOR:Number = 0.18;

    private static const WOT_LOGO_OFFSET_Y:Number = 123;

    private static const COPYRIGHT_OFFSET_Y:Number = 44;

    private static const BG_IMAGE_WIDTH:Number = 1920;

    private static const BG_IMAGE_HEIGHT:Number = 1200;

    private static const STAGE_RESIZED:String = "stageResized";

    private static const SOUND_BUTTON_OFFSET_X:int = 78;

    private static const MODE_BUTTON_OFFSET_X:int = 38;

    private static const MODE_BUTTON_OFFSET_Y:int = 20;

    private static const SHADOW_OFFSET_X:Number = 285;

    private static const SHADOW_OFFSET_Y:Number = 331;

    private static const VIDEO_ORIG_WIDTH:Number = 1920;

    private static const VIDEO_ORIG_HEIGHT:Number = 1080;

    private static const TWEEN_DURATION:int = 1500;

    private static const VIDEO_START_OFFSET:Number = 0.4;

    private static const VIDEO_END_OFFSET:Number = 0.1;

    public var bgImage:UILoaderAlt = null;

    public var videoPlayer:SimpleVideoPlayer;

    public var bgModeButton:ISoundButtonEx;

    public var soundButton:ISoundButtonEx;

    public var sparksMc:Sprite = null;

    public var blackScreen:Sprite = null;

    public var loginViewStack:LoginViewStack = null;

    public var version:TextField = null;

    public var wotLogo:BaseLogoView = null;

    public var shadowVideo:Sprite = null;

    public var shadowImage:Sprite = null;

    public var vignette:Sprite = null;

    public var bottomShadow:Sprite = null;

    public var copyright:Copyright = null;

    public var rssNewsFeed:RssNewsFeed = null;

    private var _currentView:ILoginFormView = null;

    private var _simpleFormDataVo:SimpleFormVo = null;

    private var _socialFormDataVo:SocialFormVo = null;

    private var _sparksManager:ISparksManager = null;

    private var _useWallpaper:Boolean = true;

    private var _keyMappings:Map = null;

    private var _focusInited:Boolean = false;

    private var _startListenCSIS:Boolean = false;

    private var _isInputEnabled:Boolean = true;

    private var _selectedServerIndex:Number = 0;

    private var _currentViewForm:String = "";

    private var _stageDimensions:Point;

    private var _isVideoLoaded:Boolean = false;

    private var _tween:Tween;

    private var _serversDataProvider:IDataProvider;

    public function LoginPage() {
        super();
        this._serversDataProvider = new ListDAAPIDataProvider(ServerVO);
    }

    override public function updateStage(param1:Number, param2:Number):void {
        this.updateContentPosition();
        if (this._sparksManager != null) {
            this._sparksManager.resetZone(this.getSparkZone());
        }
        if (!this._stageDimensions) {
            this._stageDimensions = new Point();
        }
        this._stageDimensions.x = param1;
        this._stageDimensions.y = param2;
        invalidate(STAGE_RESIZED);
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        this.initFocus();
    }

    override protected function allowHandleInput():Boolean {
        return false;
    }

    override protected function configUI():void {
        super.configUI();
        this.rssNewsFeed.addEventListener(RssItemEvent.ITEM_SIZE_INVALID, this.onRssNewsFeedItemSizeInvalidHandler);
        if (this.bgImage != null) {
            this.bgImage.addEventListener(UILoaderEvent.COMPLETE, this.onLoadingImageCompleteHandler, false, 0, true);
        }
        var _loc1_:String = App.globalVarsMgr.getLocaleOverrideS();
        if (_loc1_) {
            this.wotLogo.setLocale(_loc1_);
        }
        this.copyright.addEventListener(CopyrightEvent.TO_LEGAL, this.onCopyrightToLegalHandler);
        this.copyright.addEventListener(Event.CHANGE, this.onCopyrightChangeHandler);
        this.updateContentPosition();
        addEventListener(Event.ENTER_FRAME, this.onEnterFrameHandler);
        this.soundButton.addEventListener(ButtonEvent.CLICK, this.onSoundButtonClickHandler);
        this.bgModeButton.addEventListener(ButtonEvent.CLICK, this.onSwitchModeButtonClickHandler);
        this.loginViewStack.addEventListener(LoginEvent.TOKEN_RESET, this.onLoginViewStackTokenResetHandler);
        this.loginViewStack.addEventListener(LoginEvent.FOCUS_INIT, this.onLoginViewStackFocusInitHandler);
        this.loginViewStack.addEventListener(LoginEvent.ON_INPUT_CHANGE, this.onLoginViewStackOnInputChangeHandler);
        this.loginViewStack.addEventListener(LoginEvent.ON_REMEMBER_CHANGE, this.onLoginViewStackOnRememberChangeHandler);
        this.loginViewStack.addEventListener(LoginEvent.SUBMIT, this.onLoginViewStackSubmitHandler);
        this.loginViewStack.addEventListener(LoginEvent.ON_RECOVERY_LINK_CLICK, this.onLoginViewStackOnRecoveryLinkClickHandler);
        this.loginViewStack.addEventListener(LoginEvent.ON_REGISTER_LINK_CLICK, this.onLoginViewStackOnRegisterLinkClickHandler);
        this.loginViewStack.addEventListener(LoginEventTextLink.ON_TEXT_LINK_CLICK, this.onLoginViewStackOnTextLinkClickHandler);
        this.loginViewStack.addEventListener(LoginEvent.LOGIN_BY_SOCIAL, this.onLoginViewStackLoginBySocialHandler);
        this.loginViewStack.addEventListener(LoginServerDDEvent.ON_CHANGE_LISTEN_CSIS, this.onLoginViewStackOnChangeListenCsisHandler);
        this.loginViewStack.addEventListener(LoginServerDDEvent.ON_SERVER_CHANGE, this.onLoginViewStackOnServerChangeHandler);
        this.loginViewStack.addEventListener(LoginEvent.ON_CHANGE_ACCOUNT_CLICK, this.onLoginViewStackOnChangeAccountClickHandler);
        this.loginViewStack.addEventListener(LoginEvent.ON_SUBMIT_WITHOUT_TOKEN, this.onLoginViewStackOnSubmitWithoutTokenHandler);
        this.bgModeButton.focusable = false;
        this.soundButton.focusable = false;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INV_CSIS_LISTENING)) {
            startListenCsisUpdateS(this._startListenCSIS);
        }
        if (this._stageDimensions && isInvalid(STAGE_RESIZED)) {
            this.imitateNoBorderScaleMode(this._stageDimensions.x, this._stageDimensions.y);
        }
    }

    override protected function onPopulate():void {
        super.onPopulate();
        if (App.globalVarsMgr.isLoginLoadedAtFirstTimeS()) {
            RudimentarySwfOnLoginCheckingHelper.instance.checkRudimentarySwf();
        }
        registerFlashComponentS(this.rssNewsFeed, Aliases.RSS_NEWS_FEED);
        this._simpleFormDataVo = new SimpleFormVo();
        this._socialFormDataVo = new SocialFormVo();
        this._keyMappings = App.utils.data.createMap([Keyboard.ESCAPE, this.onEscapeKeyPress, Keyboard.ENTER, this.onEnterKeyPress]);
    }

    override protected function onDispose():void {
        removeEventListener(Event.ENTER_FRAME, this.onEnterFrameHandler);
        this.bgImage.removeEventListener(UILoaderEvent.COMPLETE, this.onLoadingImageCompleteHandler);
        this.bgImage.dispose();
        this.bgImage = null;
        this.bgModeButton.removeEventListener(ButtonEvent.CLICK, this.onSwitchModeButtonClickHandler);
        this.bgModeButton.dispose();
        this.bgModeButton = null;
        this.soundButton.removeEventListener(ButtonEvent.CLICK, this.onSoundButtonClickHandler);
        this.soundButton.dispose();
        this.soundButton = null;
        this.removeVideoPlayerEvents();
        this.videoPlayer.dispose();
        this.videoPlayer = null;
        this._stageDimensions = null;
        this.wotLogo.dispose();
        this.wotLogo = null;
        this.version = null;
        this.sparksMc = null;
        this.shadowVideo = null;
        this.shadowImage = null;
        this.bottomShadow = null;
        this.copyright.removeEventListener(CopyrightEvent.TO_LEGAL, this.onCopyrightToLegalHandler);
        this.copyright.removeEventListener(Event.CHANGE, this.onCopyrightChangeHandler);
        this.copyright.dispose();
        this.copyright = null;
        this.blackScreen = null;
        this.rssNewsFeed.removeEventListener(RssItemEvent.ITEM_SIZE_INVALID, this.onRssNewsFeedItemSizeInvalidHandler);
        this.rssNewsFeed = null;
        this.enableInputs(false);
        this._keyMappings.clear();
        this._keyMappings = null;
        this._currentView = null;
        this.vignette = null;
        this._serversDataProvider.cleanUp();
        this._serversDataProvider = null;
        App.utils.scheduler.cancelTask(onEscapeS);
        App.utils.scheduler.cancelTask(this.enableInputs);
        this.destroySparks();
        this.removeTween();
        this._simpleFormDataVo.dispose();
        this._simpleFormDataVo = null;
        this._socialFormDataVo.dispose();
        this._socialFormDataVo = null;
        this.loginViewStack.removeEventListener(LoginEvent.TOKEN_RESET, this.onLoginViewStackTokenResetHandler);
        this.loginViewStack.removeEventListener(LoginEvent.FOCUS_INIT, this.onLoginViewStackFocusInitHandler);
        this.loginViewStack.removeEventListener(LoginEvent.ON_INPUT_CHANGE, this.onLoginViewStackOnInputChangeHandler);
        this.loginViewStack.removeEventListener(LoginEvent.ON_REMEMBER_CHANGE, this.onLoginViewStackOnRememberChangeHandler);
        this.loginViewStack.removeEventListener(LoginEvent.SUBMIT, this.onLoginViewStackSubmitHandler);
        this.loginViewStack.removeEventListener(LoginEvent.ON_RECOVERY_LINK_CLICK, this.onLoginViewStackOnRecoveryLinkClickHandler);
        this.loginViewStack.removeEventListener(LoginEvent.ON_REGISTER_LINK_CLICK, this.onLoginViewStackOnRegisterLinkClickHandler);
        this.loginViewStack.removeEventListener(LoginEventTextLink.ON_TEXT_LINK_CLICK, this.onLoginViewStackOnTextLinkClickHandler);
        this.loginViewStack.removeEventListener(LoginEvent.LOGIN_BY_SOCIAL, this.onLoginViewStackLoginBySocialHandler);
        this.loginViewStack.removeEventListener(LoginServerDDEvent.ON_CHANGE_LISTEN_CSIS, this.onLoginViewStackOnChangeListenCsisHandler);
        this.loginViewStack.removeEventListener(LoginServerDDEvent.ON_SERVER_CHANGE, this.onLoginViewStackOnServerChangeHandler);
        this.loginViewStack.removeEventListener(LoginEvent.ON_CHANGE_ACCOUNT_CLICK, this.onLoginViewStackOnChangeAccountClickHandler);
        this.loginViewStack.removeEventListener(LoginEvent.ON_SUBMIT_WITHOUT_TOKEN, this.onLoginViewStackOnSubmitWithoutTokenHandler);
        this.loginViewStack.dispose();
        this.loginViewStack = null;
        super.onDispose();
    }

    public function as_doAutoLogin():void {
        this.submit();
    }

    public function as_enable(param1:Boolean):void {
        this.enableInputs(param1);
    }

    public function as_getServersDP():Object {
        return this._serversDataProvider;
    }

    public function as_pausePlayback():void {
        this.videoPlayer.pausePlayback();
    }

    public function as_resetPassword():void {
        this._simpleFormDataVo.pwd = "";
        this._simpleFormDataVo.invalidType = SimpleForm.INV_PASSWORD;
        this.invalidateForm();
    }

    public function as_resumePlayback():void {
        this.videoPlayer.resumePlayback();
    }

    public function as_setCapsLockState(param1:Boolean):void {
        this._simpleFormDataVo.capsLockState = param1;
        this._simpleFormDataVo.invalidType = SimpleForm.INV_CAPS_LOCK;
        this.invalidateForm();
    }

    public function as_setCopyright(param1:String, param2:String):void {
        this.copyright.updateLabel(param1, param2);
        this.updateContentPosition();
    }

    public function as_setDefaultValues(param1:String, param2:String, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean):void {
        this._simpleFormDataVo.loginName = param1;
        this._simpleFormDataVo.pwd = param2;
        this._simpleFormDataVo.memberMe = param3;
        this._simpleFormDataVo.memberMeVisible = param4;
        this._simpleFormDataVo.isIgrCredentialsReset = param5;
        this._simpleFormDataVo.showRecoveryLink = param6;
        this._simpleFormDataVo.invalidType = SimpleForm.INV_DEFAULT_DATA;
        this.invalidateForm();
    }

    public function as_setErrorMessage(param1:String, param2:int):void {
        this.setErrorMessage(param1, param2);
    }

    public function as_setKeyboardLang(param1:String):void {
        this._simpleFormDataVo.keyboardLang = param1;
        this._simpleFormDataVo.invalidType = SimpleForm.INV_KEYBOARD_LANG;
        this.invalidateForm();
    }

    public function as_setSelectedServerIndex(param1:int):void {
        this._selectedServerIndex = param1;
        if (this._currentView) {
            this._currentView.setSelectedServerIndex(this._selectedServerIndex);
        }
    }

    public function as_setVersion(param1:String):void {
        assertNotNull(param1);
        this.version.text = param1;
    }

    public function as_showLoginVideo(param1:String, param2:Number, param3:Boolean):void {
        if (!this.videoPlayer.hasEventListener(VideoPlayerStatusEvent.ERROR)) {
            this.videoPlayer.addEventListener(VideoPlayerStatusEvent.ERROR, this.onVideoPlayerErrorHandler);
            this.videoPlayer.addEventListener(VideoPlayerStatusEvent.STATUS_CHANGED, this.onVideoPlayerStatusChangedHandler);
        }
        this.videoPlayer.bufferTime = param2;
        if (this.videoPlayer.source != param1) {
            this.videoPlayer.source = param1;
            this._isVideoLoaded = false;
        }
        else {
            this.fadeInBg();
            this.videoPlayer.resumePlayback();
        }
        this.shadowImage.visible = false;
        this.shadowVideo.visible = true;
        this.videoPlayer.visible = true;
        this.vignette.visible = true;
        this.bgModeButton.selected = false;
        this.soundButton.selected = param3;
        this.destroySparks();
        this.updateButtonsTooltips();
    }

    override protected function showSimpleForm(param1:Boolean, param2:DataProvider):void {
        this._simpleFormDataVo.invalidType = LoginFormView.INV_ALL_DATA;
        this._simpleFormDataVo.isShowSocial = param1 && param2;
        if (this._simpleFormDataVo.isShowSocial) {
            this._simpleFormDataVo.socialList = param2;
        }
        this.changeView(VIEW_SIMPLE_FORM);
    }

    public function as_showSocialForm(param1:Boolean, param2:String, param3:String, param4:String):void {
        this._socialFormDataVo.invalidType = LoginFormView.INV_ALL_DATA;
        this._socialFormDataVo.haveToken = param1;
        this._socialFormDataVo.userName = param2;
        this._socialFormDataVo.icoPath = param3;
        this._socialFormDataVo.socialId = param4;
        this.changeView(VIEW_SOCIAL_FORM);
    }

    public function as_showWallpaper(param1:Boolean, param2:String, param3:Boolean, param4:Boolean):void {
        this.removeVideoPlayerEvents();
        this.shadowImage.visible = true;
        this.shadowVideo.visible = false;
        if (this.bgImage.source != param2) {
            this.bgImage.source = param2;
        }
        else {
            this.fadeInBg();
        }
        this._useWallpaper = param1;
        if (!this._useWallpaper) {
            this.bgImage.autoSize = true;
        }
        this.videoPlayer.visible = false;
        this.vignette.visible = false;
        this.soundButton.selected = param4;
        this.bgModeButton.selected = true;
        this.bgModeButton.visible = param3;
        this.createSparks();
        this.updateButtonsTooltips();
    }

    public function as_switchToAutoAndSubmit(param1:String):void {
        this._simpleFormDataVo.autoLoginKey = param1;
        this._simpleFormDataVo.invalidType = SimpleForm.INV_AUTO_LOGIN_KEY;
        this.invalidateForm();
    }

    private function removeVideoPlayerEvents():void {
        this.videoPlayer.removeEventListener(VideoPlayerStatusEvent.ERROR, this.onVideoPlayerErrorHandler);
        this.videoPlayer.removeEventListener(VideoPlayerStatusEvent.STATUS_CHANGED, this.onVideoPlayerStatusChangedHandler);
    }

    private function updateButtonsTooltips():void {
        this.bgModeButton.tooltip = !!this.bgModeButton.selected ? TOOLTIPS.LOGIN_BGMODEBUTTON_ON : TOOLTIPS.LOGIN_BGMODEBUTTON_OFF;
        this.soundButton.tooltip = !!this.soundButton.selected ? TOOLTIPS.LOGIN_SOUNDBUTTON_ON : TOOLTIPS.LOGIN_SOUNDBUTTON_OFF;
    }

    private function imitateNoBorderScaleMode(param1:Number, param2:Number):void {
        var _loc3_:Number = Math.max(param1 / VIDEO_ORIG_WIDTH, param2 / VIDEO_ORIG_HEIGHT);
        this.videoPlayer.video.width = VIDEO_ORIG_WIDTH * _loc3_ >> 0;
        this.videoPlayer.video.height = VIDEO_ORIG_HEIGHT * _loc3_ >> 0;
        this.videoPlayer.x = param1 - this.videoPlayer.video.width >> 1;
        this.videoPlayer.y = param2 - this.videoPlayer.video.height >> 1;
    }

    private function setErrorMessage(param1:String, param2:int):void {
        if (this._currentView != null) {
            this._currentView.setErrorMessage(param1, param2);
        }
        this.initFocus();
    }

    private function onEscapeKeyPress():void {
        this.enableInputs(false);
        App.utils.scheduler.scheduleTask(onEscapeS, DELAY_ON_ESCAPE);
        App.utils.scheduler.scheduleTask(this.enableInputs, DELAY_ENABLE_INPUTS, true);
    }

    private function onEnterKeyPress():void {
        this.submit();
    }

    private function updateContentPosition():void {
        this.loginViewStack.x = App.appWidth >> 1;
        this.loginViewStack.y = Math.round(App.appHeight * FREE_SPACE_FACTOR + (App.appHeight - LobbyMetrics.MIN_STAGE_HEIGHT) * FREE_SPACE_BORDER_FACTOR);
        this.wotLogo.x = this.loginViewStack.x;
        this.wotLogo.y = this.loginViewStack.y - WOT_LOGO_OFFSET_Y;
        this.shadowImage.x = this.loginViewStack.x - SHADOW_OFFSET_X;
        this.shadowImage.y = this.loginViewStack.y - SHADOW_OFFSET_Y;
        this.shadowVideo.x = this.loginViewStack.x;
        this.shadowVideo.y = this.loginViewStack.y;
        this.copyright.y = App.appHeight - COPYRIGHT_OFFSET_Y;
        this.updateCopyrightXPos();
        this.updateRssPositions();
        this.bgModeButton.x = App.appWidth - MODE_BUTTON_OFFSET_X;
        this.bgModeButton.y = MODE_BUTTON_OFFSET_Y;
        this.soundButton.x = App.appWidth - (!!this.bgModeButton.visible ? SOUND_BUTTON_OFFSET_X : MODE_BUTTON_OFFSET_X);
        this.soundButton.y = MODE_BUTTON_OFFSET_Y;
        this.vignette.width = App.appWidth;
        this.vignette.height = App.appHeight;
        this.blackScreen.width = App.appWidth;
        this.blackScreen.height = App.appHeight;
        this.bottomShadow.x = App.appWidth >> 1;
        this.bottomShadow.y = App.appHeight;
        this.updateWallpaperPosition();
        invalidateSize();
    }

    private function updateCopyrightXPos():void {
        this.copyright.x = this.loginViewStack.x - (this.copyright.getWidth() >> 1);
    }

    private function updateRssPositions():void {
        this.rssNewsFeed.x = App.appWidth - this.rssNewsFeed.actualWidth;
        this.rssNewsFeed.y = App.appHeight;
    }

    private function updateWallpaperPosition():void {
        var _loc1_:Number = NaN;
        var _loc2_:Number = NaN;
        var _loc3_:Number = NaN;
        if (this._useWallpaper) {
            if (this.bgImage) {
                _loc1_ = App.appWidth / BG_IMAGE_WIDTH;
                _loc2_ = App.appHeight / BG_IMAGE_HEIGHT;
                _loc3_ = 1;
                if (_loc1_ > _loc2_) {
                    _loc3_ = _loc2_;
                }
                else {
                    _loc3_ = _loc1_;
                }
                this.bgImage.scaleX = this.bgImage.scaleY = _loc3_;
                this.bgImage.x = App.appWidth - this.bgImage.width >> 1;
                this.bgImage.y = App.appHeight - this.bgImage.height >> 1;
            }
        }
        else {
            this.bgImage.scaleX = this.bgImage.scaleY = 1;
            this.bgImage.x = App.appWidth - this.bgImage.width >> 1;
            this.bgImage.y = App.appHeight - this.bgImage.height >> 1;
        }
    }

    private function submit():void {
        var _loc1_:SubmitDataVo = null;
        if (this._currentView != null) {
            _loc1_ = this.getSubmitData();
            this.setErrorMessage(MENU.LOGIN_STATUS_CONNECTING, ErrorStates.NONE);
            onLoginS(_loc1_.login, _loc1_.pwd, _loc1_.host, _loc1_.isSocial);
        }
    }

    private function enableInputs(param1:Boolean):void {
        this._isInputEnabled = param1;
        if (this._isInputEnabled) {
            addEventListener(InputEvent.INPUT, this.onInputHandler);
            this.initFocus();
        }
        else {
            removeEventListener(InputEvent.INPUT, this.onInputHandler);
        }
    }

    private function createSparks():void {
        if (this._sparksManager == null) {
            if (this.sparksMc == null) {
                this.sparksMc = new Sprite();
                this.sparksMc.mouseEnabled = false;
                this.sparksMc.mouseChildren = false;
                addChild(this.sparksMc);
            }
            this._sparksManager = ISparksManager(App.utils.classFactory.getObject(Linkages.SPARKS_MGR));
            this._sparksManager.zone = this.getSparkZone();
            this._sparksManager.scope = this.sparksMc;
            this._sparksManager.sparkQuantity = SPARK_QUANTITY;
            this._sparksManager.createSparks();
        }
    }

    private function destroySparks():void {
        if (this._sparksManager != null) {
            this._sparksManager.dispose();
            this._sparksManager = null;
        }
        if (this.sparksMc != null) {
            removeChild(this.sparksMc);
            this.sparksMc = null;
        }
    }

    private function getSparkZone():Rectangle {
        return new Rectangle(SPARK_ZONE.x, SPARK_ZONE.y, stage.width + SPARK_ZONE.right, stage.height + SPARK_ZONE.bottom);
    }

    private function initFocus():void {
        assertLifeCycle();
        if (!this._focusInited && this._currentView != null) {
            this._currentView.initFocus();
            this._focusInited = true;
        }
    }

    private function invalidateForm():void {
        if (this._currentView != null) {
            if (this._currentView is SimpleForm) {
                this._currentView.updateVo(this._simpleFormDataVo);
            }
            else {
                this._currentView.updateVo(this._socialFormDataVo);
            }
            this._currentView.setServersDP(this._serversDataProvider);
            this._currentView.setSelectedServerIndex(this._selectedServerIndex);
        }
    }

    private function changeView(param1:String):void {
        this._currentViewForm = param1;
        this.loginViewStack.show(param1);
        this._currentView = ILoginFormView(this.loginViewStack.currentView);
        this.invalidateForm();
    }

    private function getSubmitData():SubmitDataVo {
        if (this._currentView != null) {
            return this._currentView.getSubmitData();
        }
        return null;
    }

    private function onFadeInTweenFinished():void {
        this.bgModeButton.enabled = true;
    }

    private function onFadeOutTweenFinished():void {
        if (this.videoPlayer.status == PlayerStatus.PLAYING) {
            this.videoPlayer.pausePlayback();
        }
        switchBgModeS();
        this.updateContentPosition();
    }

    private function fadeInBg():void {
        this.removeTween();
        this._tween = new Tween(TWEEN_DURATION, this.blackScreen, {"alpha": 0}, {
            "paused": false,
            "ease": Cubic.easeOut,
            "onComplete": this.onFadeInTweenFinished
        });
    }

    private function removeTween():void {
        if (this._tween != null) {
            this._tween.dispose();
            this._tween = null;
        }
    }

    private function onInputHandler(param1:InputEvent):void {
        var _loc2_:Function = null;
        if (param1.handled || App.waiting && App.waiting.isOnStage) {
            return;
        }
        if (param1.details.value == InputValue.KEY_DOWN) {
            _loc2_ = this._keyMappings.get(param1.details.code);
            if (_loc2_ != null) {
                _loc2_();
                param1.handled = true;
            }
        }
    }

    private function onEnterFrameHandler(param1:Event):void {
        var _loc2_:Number = !!isNaN(this.videoPlayer.currentTime) ? Number(0) : Number(this.videoPlayer.currentTime);
        var _loc3_:Number = !!this.videoPlayer.metaData ? Number(this.videoPlayer.metaData.duration) : Number(0);
        if (_loc3_ > 0 && _loc2_ >= _loc3_ - VIDEO_END_OFFSET) {
            this.videoPlayer.seek(0);
        }
    }

    private function onVideoPlayerStatusChangedHandler(param1:Event):void {
        if (!this._isVideoLoaded && this.videoPlayer.status == PlayerStatus.PLAYING) {
            this._isVideoLoaded = true;
            onVideoLoadedS();
            this.videoPlayer.seek(VIDEO_START_OFFSET);
            this.fadeInBg();
        }
    }

    private function onSoundButtonClickHandler(param1:ButtonEvent):void {
        setMuteS(this.soundButton.selected);
        this.updateButtonsTooltips();
    }

    private function onSwitchModeButtonClickHandler(param1:Event):void {
        musicFadeOutS();
        this.bgModeButton.enabled = false;
        this.updateButtonsTooltips();
        this.removeTween();
        this._tween = new Tween(TWEEN_DURATION, this.blackScreen, {"alpha": 1}, {
            "paused": false,
            "ease": Cubic.easeOut,
            "onComplete": this.onFadeOutTweenFinished
        });
    }

    private function onVideoPlayerErrorHandler(param1:VideoPlayerStatusEvent):void {
        App.utils.asserter.assert(false, param1.errorCode + ": " + param1.toString());
    }

    private function onCopyrightToLegalHandler(param1:CopyrightEvent):void {
        showLegalS();
    }

    private function onRssNewsFeedItemSizeInvalidHandler(param1:RssItemEvent):void {
        this.updateRssPositions();
    }

    private function onLoginViewStackFocusInitHandler(param1:LoginEvent):void {
        if (param1.focusTarget != null) {
            setFocus(param1.focusTarget);
        }
    }

    private function onCopyrightChangeHandler(param1:Event):void {
        this.updateCopyrightXPos();
    }

    private function onLoginViewStackOnInputChangeHandler(param1:LoginEvent):void {
        var isToken:Boolean = false;
        var simpleForm:SimpleForm = null;
        var event:LoginEvent = param1;
        if (this._isInputEnabled) {
            isToken = isTokenS();
            try {
                onExitFromAutoLoginS();
                simpleForm = event.target as SimpleForm;
                if (simpleForm) {
                    simpleForm.updateInputForm(event.focusTarget, isToken);
                }
                return;
            }
            catch (e:Error) {
                DebugUtils.LOG_ERROR(e.message);
                return;
            }
        }
    }

    private function onLoginViewStackLoginBySocialHandler(param1:LoginEvent):void {
        var _loc2_:SubmitDataVo = this.getSubmitData();
        onLoginBySocialS(param1.socialId, _loc2_.host);
    }

    private function onLoginViewStackOnRememberChangeHandler(param1:LoginEvent):void {
        onSetRememberPasswordS(param1.isRemember);
    }

    private function onLoginViewStackOnRegisterLinkClickHandler(param1:LoginEvent):void {
        var _loc2_:SubmitDataVo = this.getSubmitData();
        onRegisterS(_loc2_.host);
    }

    private function onLoginViewStackOnTextLinkClickHandler(param1:LoginEventTextLink):void {
        onTextLinkClickS(param1.linkId);
    }

    private function onLoginViewStackOnRecoveryLinkClickHandler(param1:LoginEvent):void {
        onRecoveryS();
    }

    private function onLoginViewStackSubmitHandler(param1:LoginEvent):void {
        this.submit();
    }

    private function onLoginViewStackTokenResetHandler(param1:LoginEvent):void {
        resetTokenS();
    }

    private function onLoadingImageCompleteHandler(param1:UILoaderEvent):void {
        this.updateWallpaperPosition();
        this.removeTween();
        this.fadeInBg();
    }

    private function onLoginViewStackOnChangeListenCsisHandler(param1:LoginServerDDEvent):void {
        this._startListenCSIS = param1.isListenCSIS;
        invalidate(INV_CSIS_LISTENING);
    }

    private function onLoginViewStackOnServerChangeHandler(param1:LoginServerDDEvent):void {
        if (param1.serverVO) {
            saveLastSelectedServerS(param1.serverVO.data);
        }
        this._selectedServerIndex = param1.selectedIndex;
    }

    private function onLoginViewStackOnChangeAccountClickHandler(param1:LoginEvent):void {
        changeAccountS();
    }

    private function onLoginViewStackOnSubmitWithoutTokenHandler(param1:LoginEvent):void {
        var _loc2_:SubmitDataVo = this.getSubmitData();
        onLoginBySocialS(param1.socialId, _loc2_.host);
    }
}
}
