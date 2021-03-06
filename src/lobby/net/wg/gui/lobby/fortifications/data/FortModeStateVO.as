package net.wg.gui.lobby.fortifications.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class FortModeStateVO extends DAAPIDataClass {

    private var _mode:String = "";

    private var _yellowVignette:uint = 0;

    private var _clanInfo:uint = 0;

    private var _totalDepotQuantity:uint = 0;

    private var _stateTexts:FortModeStateStringsVO = null;

    private var _descrTextMove:uint = 0;

    private var _clanProfileBtn:uint = 0;

    private var _statsBtn:uint = 0;

    private var _clanListBtn:uint = 0;

    private var _calendarBtn:uint = 0;

    private var _settingBtn:uint = 0;

    private var _transportToggle:uint = 0;

    private var _footerBitmapFill:uint = 0;

    private var _ordersPanel:uint = 0;

    private var _orderSelector:uint = 0;

    private var _sortieBtn:uint = 0;

    private var _intelligenceButton:uint = 0;

    private var _leaveModeBtn:uint = 0;

    private var _tutorialArrow:uint = 0;

    private var _infoTF:uint = 0;

    private var _timeAlert:uint = 0;

    public function FortModeStateVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == "stateTexts") {
            this._stateTexts = new FortModeStateStringsVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        this._stateTexts.dispose();
        this._stateTexts = null;
        super.onDispose();
    }

    public function getCalendarBtn():FortModeElementProperty {
        return new FortModeElementProperty(this._calendarBtn);
    }

    public function getClanInfo():FortModeElementProperty {
        return new FortModeElementProperty(this._clanInfo);
    }

    public function getClanListBtn():FortModeElementProperty {
        return new FortModeElementProperty(this._clanListBtn);
    }

    public function getClanProfileBtn():FortModeElementProperty {
        return new FortModeElementProperty(this._clanProfileBtn);
    }

    public function getFooterBitmapFill():FortModeElementProperty {
        return new FortModeElementProperty(this._footerBitmapFill);
    }

    public function getInfoTF():FortModeElementProperty {
        return new FortModeElementProperty(this._infoTF);
    }

    public function getIntelligenceButton():FortModeElementProperty {
        return new FortModeElementProperty(this._intelligenceButton);
    }

    public function getLeaveModeBtn():FortModeElementProperty {
        return new FortModeElementProperty(this._leaveModeBtn);
    }

    public function getOrderSelector():FortModeElementProperty {
        return new FortModeElementProperty(this._orderSelector);
    }

    public function getOrdersPanel():FortModeElementProperty {
        return new FortModeElementProperty(this._ordersPanel);
    }

    public function getSettingBtn():FortModeElementProperty {
        return new FortModeElementProperty(this._settingBtn);
    }

    public function getSortieBtn():FortModeElementProperty {
        return new FortModeElementProperty(this._sortieBtn);
    }

    public function getStatsBtn():FortModeElementProperty {
        return new FortModeElementProperty(this._statsBtn);
    }

    public function getTimeAlert():FortModeElementProperty {
        return new FortModeElementProperty(this._timeAlert);
    }

    public function getTotalDepotQuantity():FortModeElementProperty {
        return new FortModeElementProperty(this._totalDepotQuantity);
    }

    public function getTransportToggle():FortModeElementProperty {
        return new FortModeElementProperty(this._transportToggle);
    }

    public function getTutorialArrow():FortModeElementProperty {
        return new FortModeElementProperty(this._tutorialArrow);
    }

    public function getYellowVignette():FortModeElementProperty {
        return new FortModeElementProperty(this._yellowVignette);
    }

    public function get statsBtn():uint {
        return this._statsBtn;
    }

    public function set statsBtn(param1:uint):void {
        this._statsBtn = param1;
    }

    public function get clanProfileBtn():uint {
        return this._clanProfileBtn;
    }

    public function set clanProfileBtn(param1:uint):void {
        this._clanProfileBtn = param1;
    }

    public function get clanListBtn():uint {
        return this._clanListBtn;
    }

    public function set clanListBtn(param1:uint):void {
        this._clanListBtn = param1;
    }

    public function get calendarBtn():uint {
        return this._calendarBtn;
    }

    public function set calendarBtn(param1:uint):void {
        this._calendarBtn = param1;
    }

    public function get settingBtn():uint {
        return this._settingBtn;
    }

    public function set settingBtn(param1:uint):void {
        this._settingBtn = param1;
    }

    public function get mode():String {
        return this._mode;
    }

    public function set mode(param1:String):void {
        this._mode = param1;
    }

    public function get yellowVignette():uint {
        return this._yellowVignette;
    }

    public function set yellowVignette(param1:uint):void {
        this._yellowVignette = param1;
    }

    public function get clanInfo():uint {
        return this._clanInfo;
    }

    public function set clanInfo(param1:uint):void {
        this._clanInfo = param1;
    }

    public function get totalDepotQuantity():uint {
        return this._totalDepotQuantity;
    }

    public function set totalDepotQuantity(param1:uint):void {
        this._totalDepotQuantity = param1;
    }

    public function get stateTexts():FortModeStateStringsVO {
        return this._stateTexts;
    }

    public function set stateTexts(param1:FortModeStateStringsVO):void {
        this._stateTexts = param1;
    }

    public function get footerBitmapFill():uint {
        return this._footerBitmapFill;
    }

    public function set footerBitmapFill(param1:uint):void {
        this._footerBitmapFill = param1;
    }

    public function get ordersPanel():uint {
        return this._ordersPanel;
    }

    public function set ordersPanel(param1:uint):void {
        this._ordersPanel = param1;
    }

    public function get orderSelector():uint {
        return this._orderSelector;
    }

    public function set orderSelector(param1:uint):void {
        this._orderSelector = param1;
    }

    public function get sortieBtn():uint {
        return this._sortieBtn;
    }

    public function set sortieBtn(param1:uint):void {
        this._sortieBtn = param1;
    }

    public function get intelligenceButton():uint {
        return this._intelligenceButton;
    }

    public function set intelligenceButton(param1:uint):void {
        this._intelligenceButton = param1;
    }

    public function get leaveModeBtn():uint {
        return this._leaveModeBtn;
    }

    public function set leaveModeBtn(param1:uint):void {
        this._leaveModeBtn = param1;
    }

    public function get descrTextMove():uint {
        return this._descrTextMove;
    }

    public function set descrTextMove(param1:uint):void {
        this._descrTextMove = param1;
    }

    public function get tutorialArrow():uint {
        return this._tutorialArrow;
    }

    public function set tutorialArrow(param1:uint):void {
        this._tutorialArrow = param1;
    }

    public function get transportToggle():uint {
        return this._transportToggle;
    }

    public function set transportToggle(param1:uint):void {
        this._transportToggle = param1;
    }

    public function get infoTF():uint {
        return this._infoTF;
    }

    public function set infoTF(param1:uint):void {
        this._infoTF = param1;
    }

    public function get timeAlert():uint {
        return this._timeAlert;
    }

    public function set timeAlert(param1:uint):void {
        this._timeAlert = param1;
    }
}
}
