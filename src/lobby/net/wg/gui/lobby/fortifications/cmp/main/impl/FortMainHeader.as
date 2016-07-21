package net.wg.gui.lobby.fortifications.cmp.main.impl {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.geom.Rectangle;
import flash.text.TextField;

import net.wg.gui.components.advanced.ToggleSoundButton;
import net.wg.gui.components.controls.BitmapFill;
import net.wg.gui.components.controls.IconTextButton;
import net.wg.gui.interfaces.IButtonIconLoader;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.fortifications.cmp.main.IFortHeaderClanInfo;
import net.wg.gui.lobby.fortifications.cmp.main.IMainHeader;
import net.wg.gui.lobby.fortifications.utils.IFortsControlsAligner;
import net.wg.gui.lobby.fortifications.utils.impl.FortsControlsAligner;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IUIComponentEx;

public class FortMainHeader extends UIComponentEx implements IMainHeader {

    private static const TRANSPORT_BTN_RIGHT_OFFSET:Number = 9;

    private static const DEPOT_QUANTITY_RIGHT_OFFSET:Number = TRANSPORT_BTN_RIGHT_OFFSET + 8;

    private static const SETTING_BTN_LEFT_OFFSET:Number = 17;

    private static const CLAN_LIST_GAP:int = 1;

    private static const STATS_GAP:int = 1;

    private static const CLAN_PROFILE_GAP:int = 2;

    private static const START_POSITION:int = 35;

    private static const INV_BTN_POSITIONS:String = "InvBtnPositions";

    public var headerBitmapFill:BitmapFill = null;

    private var _timeAlert:FortTimeAlertIcon = null;

    private var _tutorialArrowTransport:IUIComponentEx = null;

    private var _tutorialArrowDefense:IUIComponentEx = null;

    private var _title:TextField = null;

    private var _infoTF:TextField = null;

    private var _clanInfo:IFortHeaderClanInfo = null;

    private var _totalDepotQuantityText:TextField = null;

    private var _vignetteYellow:VignetteYellow = null;

    private var _statsBtn:IconTextButton = null;

    private var _clanListBtn:IconTextButton = null;

    private var _calendarBtn:IconTextButton = null;

    private var _settingBtn:IButtonIconLoader = null;

    private var _transportBtn:ToggleSoundButton = null;

    private var _clanProfileBtn:ISoundButtonEx = null;

    private var _helper:IFortsControlsAligner = null;

    public function FortMainHeader() {
        super();
        this._helper = FortsControlsAligner.instance;
        this._vignetteYellow.alpha = 0;
    }

    override protected function configUI():void {
        super.configUI();
        this._calendarBtn.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_CALENDAR;
        this._vignetteYellow.mouseEnabled = false;
        this._vignetteYellow.mouseChildren = false;
        mouseEnabled = false;
        this._settingBtn.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_SETTINGS;
        this._transportBtn.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_TRANSPORTING;
    }

    override protected function onDispose():void {
        this.headerBitmapFill.dispose();
        this.headerBitmapFill = null;
        this._clanInfo.dispose();
        this._clanInfo = null;
        this._statsBtn.dispose();
        this._statsBtn = null;
        this._clanListBtn.dispose();
        this._clanListBtn = null;
        this._clanProfileBtn.dispose();
        this._clanProfileBtn = null;
        this._calendarBtn.dispose();
        this._calendarBtn = null;
        this._settingBtn.dispose();
        this._settingBtn = null;
        this._vignetteYellow.dispose();
        this._vignetteYellow = null;
        this._transportBtn.dispose();
        this._transportBtn = null;
        this._totalDepotQuantityText = null;
        this._title = null;
        this._infoTF = null;
        this._tutorialArrowTransport.dispose();
        this._tutorialArrowTransport = null;
        App.utils.tweenAnimator.removeAnims(DisplayObject(this._tutorialArrowDefense));
        this._tutorialArrowDefense.dispose();
        this._tutorialArrowDefense = null;
        this._helper = null;
        this._timeAlert.dispose();
        this._timeAlert = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INV_BTN_POSITIONS)) {
            this.updateBtnPositions();
        }
    }

    public function getComponentForFocus():InteractiveObject {
        var _loc1_:InteractiveObject = null;
        if (this._clanProfileBtn.visible) {
            _loc1_ = InteractiveObject(this._clanProfileBtn);
        }
        else if (this._statsBtn.visible) {
            _loc1_ = this._statsBtn;
        }
        else if (this._clanListBtn.visible) {
            _loc1_ = this._clanListBtn;
        }
        else {
            _loc1_ = this;
        }
        return _loc1_;
    }

    public function updateControls():void {
        this._title.width = App.appWidth;
        this._infoTF.width = App.appWidth;
        this._helper.centerControl(this._vignetteYellow, false);
        this._helper.centerControl(this._clanInfo, true);
        this._helper.rightControl(this._transportBtn, TRANSPORT_BTN_RIGHT_OFFSET);
        this._tutorialArrowTransport.x = this._transportBtn.x + (this._transportBtn.width - this._tutorialArrowTransport.width >> 1);
        this._helper.rightControl(this._totalDepotQuantityText, DEPOT_QUANTITY_RIGHT_OFFSET + (!!this._transportBtn.visible ? this._transportBtn.width : 0));
        var _loc1_:Rectangle = this._clanInfo.getRect(this);
        this._settingBtn.x = _loc1_.x + _loc1_.width + SETTING_BTN_LEFT_OFFSET;
        this._tutorialArrowDefense.x = this._settingBtn.x + (this._settingBtn.width - this._tutorialArrowDefense.width >> 1);
        App.utils.commons.moveDsiplObjToEndOfText(this._timeAlert, this._infoTF);
        invalidate(INV_BTN_POSITIONS);
    }

    private function updateBtnPositions():void {
        var _loc1_:int = START_POSITION;
        if (this._clanProfileBtn.visible) {
            this._clanProfileBtn.x = _loc1_;
            _loc1_ = _loc1_ + (this._clanProfileBtn.width + CLAN_PROFILE_GAP);
        }
        if (this._statsBtn.visible) {
            this._statsBtn.x = _loc1_;
            _loc1_ = _loc1_ + (this._statsBtn.width + STATS_GAP);
        }
        if (this._clanListBtn.visible) {
            this._clanListBtn.x = _loc1_;
            _loc1_ = _loc1_ + (this._clanListBtn.width + CLAN_LIST_GAP);
        }
        if (this._calendarBtn.visible) {
            this._calendarBtn.x = _loc1_;
        }
    }

    public function get clanProfileBtn():ISoundButtonEx {
        return this._clanProfileBtn;
    }

    public function set clanProfileBtn(param1:ISoundButtonEx):void {
        this._clanProfileBtn = param1;
    }

    public function set widthFill(param1:Number):void {
        this.headerBitmapFill.widthFill = param1;
    }

    public function get heightFill():Number {
        return this.headerBitmapFill.heightFill;
    }

    public function get statsBtn():IconTextButton {
        return this._statsBtn;
    }

    public function set statsBtn(param1:IconTextButton):void {
        this._statsBtn = param1;
    }

    public function get clanListBtn():IconTextButton {
        return this._clanListBtn;
    }

    public function set clanListBtn(param1:IconTextButton):void {
        this._clanListBtn = param1;
    }

    public function get calendarBtn():IconTextButton {
        return this._calendarBtn;
    }

    public function set calendarBtn(param1:IconTextButton):void {
        this._calendarBtn = param1;
    }

    public function get transportBtn():ToggleSoundButton {
        return this._transportBtn;
    }

    public function set transportBtn(param1:ToggleSoundButton):void {
        this._transportBtn = param1;
    }

    public function get settingBtn():IButtonIconLoader {
        return this._settingBtn;
    }

    public function set settingBtn(param1:IButtonIconLoader):void {
        this._settingBtn = param1;
    }

    public function get vignetteYellow():VignetteYellow {
        return this._vignetteYellow;
    }

    public function set vignetteYellow(param1:VignetteYellow):void {
        this._vignetteYellow = param1;
    }

    public function get totalDepotQuantityText():TextField {
        return this._totalDepotQuantityText;
    }

    public function set totalDepotQuantityText(param1:TextField):void {
        this._totalDepotQuantityText = param1;
    }

    public function get clanInfo():IFortHeaderClanInfo {
        return this._clanInfo;
    }

    public function set clanInfo(param1:IFortHeaderClanInfo):void {
        this._clanInfo = param1;
    }

    public function get title():TextField {
        return this._title;
    }

    public function set title(param1:TextField):void {
        this._title = param1;
    }

    public function get infoTF():TextField {
        return this._infoTF;
    }

    public function set infoTF(param1:TextField):void {
        this._infoTF = param1;
    }

    public function get tutorialArrowTransport():IUIComponentEx {
        return this._tutorialArrowTransport;
    }

    public function set tutorialArrowTransport(param1:IUIComponentEx):void {
        this._tutorialArrowTransport = param1;
    }

    public function get tutorialArrowDefense():IUIComponentEx {
        return this._tutorialArrowDefense;
    }

    public function set tutorialArrowDefense(param1:IUIComponentEx):void {
        this._tutorialArrowDefense = param1;
    }

    public function get timeAlert():FortTimeAlertIcon {
        return this._timeAlert;
    }

    public function set timeAlert(param1:FortTimeAlertIcon):void {
        this._timeAlert = param1;
    }
}
}
