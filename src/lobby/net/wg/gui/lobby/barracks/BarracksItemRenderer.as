package net.wg.gui.lobby.barracks {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

import net.wg.data.Colors;
import net.wg.data.constants.ComponentState;
import net.wg.data.constants.SoundTypes;
import net.wg.data.constants.Values;
import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.components.controls.IconText;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.SoundListItemRenderer;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.gui.events.CrewEvent;

import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ListEvent;

public class BarracksItemRenderer extends SoundListItemRenderer {

    private static const INVALIDATE_PARAMS:String = "params";

    private static const INVALIDATE_IN_TANK:String = "inTank";

    private static const PATH_TANKMAN_ICONS_BARRACKS:String = "../maps/icons/tankmen/icons/barracks/";

    private static const PATH_TANKMAN_ICONS_SMALL:String = "../maps/icons/tankmen/ranks/small/";

    private static const SOUND_ID_BTN_DISSMISS:String = "btnDissmiss";

    private static const SOUND_ID_BTN_UPLOADED:String = "btnUnload";

    private static const PROPERTY_ACTION_PRICE_DATA:String = "actionPriceData";

    private static const TO_STRING_TEXT:String = "BarracksItemRenderer: ";

    private static const PREFIX_EMPTY:String = "empty_";

    private static const PREFIX_BUY:String = "buy_";

    private static const PREFIX_SELECTED:String = "selected_";

    private static const SELECTION_STATE_BARRACKS:String = "barracks";

    private static const SELECTION_STATE_TANK:String = "tank";

    private static const SELECTION_STATE_CURRENT_TANK:String = "current_tank";

    private static const PLUS:String = "+";

    private static const CHAR_LEFT_BRACES:String = "{";

    private static const CHAR_RIGHT_BRACES:String = "}";

    private static const CHAR_PERCENT:String = "%";

    private static const CHAR_COMMA:String = ",";

    private static const HTML_FONT_START:String = " <font color=\'";

    private static const HTML_FONT_END:String = "\'>";

    private static const HTML_FONT_TAG_CLOSE:String = "</font>";

    public var countField:TextField = null;

    public var btnDissmiss:SoundButtonEx;

    public var icon:UILoaderAlt;

    public var iconRole:UILoaderAlt;

    public var iconRank:UILoaderAlt;

    public var clickArea:Sprite = null;

    public var selection:MovieClip = null;

    public var emptyPlacesTF:TextField;

    public var levelSpecializationMain:TextField = null;

    public var tankmanName:TextField = null;

    public var rank:TextField = null;

    public var role:TextField = null;

    public var lockMsg:TextField = null;

    public var vehicleType:TextField = null;

    public var price:IconText = null;

    public var actionPrice:ActionPrice = null;

    public var descrField:TextField = null;

    private var _inTank:Boolean = false;

    private var _inCurrentTank:Boolean = false;

    private var _empty:Boolean = false;

    private var _buy:Boolean = false;

    private var _isMouseOver:Boolean = false;

    private var _actionPriceVo:ActionPriceVO = null;

    public function BarracksItemRenderer() {
        super();
        buttonMode = true;
        soundType = SoundTypes.BARRACKS_TANKMAN_SOUND_TYPE;
        this.btnDissmiss.soundType = SoundTypes.NORMAL_BTN;
    }

    override public function setData(param1:Object):void {
        if (!param1) {
            return;
        }
        this.btnDissmiss.focusTarget = this;
        data = param1;
        this.empty = param1.empty;
        this.buy = param1.buy;
        if (param1.iconFile && param1.iconFile != this.icon.source) {
            this.icon.source = PATH_TANKMAN_ICONS_BARRACKS + param1.iconFile;
        }
        if (param1.rankIconFile && param1.rankIconFile != this.iconRank.source) {
            this.iconRank.source = PATH_TANKMAN_ICONS_SMALL + param1.rankIconFile;
        }
        if (param1.roleIconFile && param1.roleIconFile != this.iconRole.source) {
            this.iconRole.source = param1.roleIconFile;
        }
        this.inCurrentTank = param1.inCurrentTank;
        if (!this.inCurrentTank) {
            this.inTank = param1.inTank;
        }
        this._actionPriceVo = data.hasOwnProperty(PROPERTY_ACTION_PRICE_DATA) && data.actionPriceData ? new ActionPriceVO(data.actionPriceData) : null;
        this.btnDissmiss.enabled = !(param1.locked || param1.vehicleBroken);
        this.btnDissmiss.label = MENU.BARRACKS_BTNDISSMISS;
        this.btnDissmiss.soundId = SOUND_ID_BTN_DISSMISS;
        if (this.isTankmanInTank()) {
            this.btnDissmiss.label = MENU.BARRACKS_BTNUNLOAD;
            this.btnDissmiss.soundId = SOUND_ID_BTN_UPLOADED;
            this.btnDissmiss.enabled = !param1.locked;
        }
        this.btnDissmiss.soundType = SoundTypes.NORMAL_BTN;
        this.btnDissmiss.validateNow();
        invalidate(INVALIDATE_PARAMS);
        validateNow();
    }

    override public function toString():String {
        return TO_STRING_TEXT + name;
    }

    override protected function onBeforeDispose():void {
        removeEventListener(ButtonEvent.CLICK, this.onButtonEventClickHandler, false);
        removeEventListener(MouseEvent.CLICK, this.onClickHandler, false);
        removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler);
        this.btnDissmiss.removeEventListener(ButtonEvent.CLICK, this.onBtnDissmissButtonEventClickHandler);
        this.btnDissmiss.removeEventListener(MouseEvent.ROLL_OVER, this.onBtnDissmissRollOverHandler, false);
        this.btnDissmiss.removeEventListener(MouseEvent.ROLL_OUT, this.onButtonDissmissRollOutHandler, false);
        this.btnDissmiss.removeEventListener(MouseEvent.CLICK, this.onButtonDissmissRollOutHandler, false);
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        this.btnDissmiss.focusTarget = null;
        if (this.icon) {
            this.icon.dispose();
            this.icon = null;
        }
        if (this.iconRole) {
            this.iconRole.dispose();
            this.iconRole = null;
        }
        if (this.iconRank) {
            this.iconRank.dispose();
            this.iconRank = null;
        }
        this.btnDissmiss.dispose();
        this.btnDissmiss = null;
        this.emptyPlacesTF = null;
        _data = null;
        this.countField = null;
        this.clickArea = null;
        this.selection = null;
        this.levelSpecializationMain = null;
        this.tankmanName = null;
        this.rank = null;
        this.role = null;
        this.lockMsg = null;
        this.vehicleType = null;
        if (this.price) {
            this.price.dispose();
            this.price = null;
        }
        if (this.actionPrice) {
            this.actionPrice.dispose();
            this.actionPrice = null;
        }
        if (this._actionPriceVo) {
            this._actionPriceVo.dispose();
            this._actionPriceVo = null;
        }
        this.descrField = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        tabChildren = false;
        this.btnDissmiss.focusTarget = this;
        this.btnDissmiss.addEventListener(ButtonEvent.CLICK, this.onBtnDissmissButtonEventClickHandler);
        this.icon.mouseEnabled = this.iconRole.mouseEnabled = this.iconRank.mouseEnabled = false;
        this.icon.mouseChildren = this.iconRole.mouseChildren = this.iconRank.mouseChildren = false;
        addEventListener(ButtonEvent.CLICK, this.onButtonEventClickHandler, false, 0, true);
        addEventListener(MouseEvent.CLICK, this.onClickHandler, false);
        addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        addEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler);
        this.btnDissmiss.addEventListener(MouseEvent.ROLL_OVER, this.onBtnDissmissRollOverHandler, false, 0, true);
        this.btnDissmiss.addEventListener(MouseEvent.ROLL_OUT, this.onButtonDissmissRollOutHandler, false, 0, true);
        this.btnDissmiss.addEventListener(MouseEvent.CLICK, this.onButtonDissmissRollOutHandler, false, 0, true);
        mouseChildren = true;
        this.clickArea.buttonMode = true;
    }

    override protected function getStatePrefixes():Vector.<String> {
        if (this._empty) {
            return Vector.<String>([PREFIX_EMPTY]);
        }
        if (this._buy) {
            return Vector.<String>([PREFIX_BUY]);
        }
        if (_selected) {
            return Vector.<String>([PREFIX_SELECTED, Values.EMPTY_STR]);
        }
        return Vector.<String>([Values.EMPTY_STR]);
    }

    override protected function draw():void {
        var _loc1_:String = null;
        var _loc2_:Point = null;
        var _loc3_:String = null;
        var _loc4_:String = null;
        super.draw();
        if (!_baseDisposed) {
            if (isInvalid(INVALIDATE_IN_TANK) && this.selection) {
                _loc1_ = SELECTION_STATE_BARRACKS;
                if (this._inTank) {
                    _loc1_ = SELECTION_STATE_TANK;
                }
                if (this._inCurrentTank) {
                    _loc1_ = SELECTION_STATE_CURRENT_TANK;
                }
                this.selection.gotoAndPlay(_loc1_);
            }
            if (isInvalid(INVALIDATE_PARAMS) && data) {
                _loc2_ = new Point(mouseX, mouseY);
                _loc2_ = localToGlobal(_loc2_);
                if (hitTestPoint(_loc2_.x, _loc2_.y, true) && this._isMouseOver) {
                    if (this.btnDissmiss.hitTestPoint(_loc2_.x, _loc2_.y, true) && !(this._buy || this.empty)) {
                        this.onBtnDissmissRollOverHandler(null);
                    }
                    else {
                        dispatchEvent(new ListEvent(ListEvent.ITEM_ROLL_OVER, true, true, -1, -1, -1, null, data));
                    }
                }
                this.countField.text = Values.EMPTY_STR;
                if (this._buy) {
                    if (this.price) {
                        this.price.textColor = !!data.enoughGold ? Number(IconText.BASE_COLOR) : Number(Colors.ERROR_COLOR);
                        this.price.text = App.utils.locale.gold(data.price);
                        this.price.visible = true;
                    }
                    if (this.actionPrice) {
                        if (this._actionPriceVo) {
                            this._actionPriceVo.forCredits = false;
                            this.actionPrice.textColorType = !!data.enoughGold ? ActionPrice.TEXT_COLOR_TYPE_ICON : ActionPrice.TEXT_COLOR_TYPE_ERROR;
                        }
                        this.actionPrice.setData(this._actionPriceVo);
                        this.actionPrice.setup(this);
                        if (this.price) {
                            this.price.visible = !this.actionPrice.visible;
                        }
                    }
                    this.countField.text = PLUS + data.count;
                    this.descrField.text = App.utils.locale.makeString(MENU.BARRACKS_BTNBUYBERTHDECS);
                    this.descrField.replaceText(this.descrField.text.indexOf(CHAR_LEFT_BRACES), this.descrField.text.indexOf(CHAR_RIGHT_BRACES) + 1, String(data.count));
                }
                if (this.empty) {
                    this.emptyPlacesTF.text = App.utils.locale.makeString(MENU.BARRACKS_BARRACKSRENDERER_PLACESCOUNT) + Values.SPACE_STR + data.freePlaces;
                }
                if (this.role) {
                    this.role.htmlText = data.role;
                }
                if (!(this._buy || this.empty)) {
                    _loc3_ = data.specializationLevel + CHAR_PERCENT;
                    _loc4_ = App.utils.locale.makeString(MENU.tankmen(data.tankType));
                    if (!data.isInSelfVehicleClass) {
                        this.levelSpecializationMain.htmlText = this.formatDebuffHtmlText(_loc3_);
                        this.role.htmlText = this.role.htmlText + (CHAR_COMMA + this.formatDebuffHtmlText(_loc4_ + Values.SPACE_STR + data.vehicleType));
                    }
                    else if (!data.isInSelfVehicleType) {
                        this.levelSpecializationMain.htmlText = this.formatDebuffHtmlText(_loc3_);
                        this.role.htmlText = this.role.htmlText + (CHAR_COMMA + _loc4_ + this.formatDebuffHtmlText(data.vehicleType));
                    }
                    else {
                        this.levelSpecializationMain.htmlText = _loc3_;
                        this.role.htmlText = this.role.htmlText + (CHAR_COMMA + Values.SPACE_STR + _loc4_ + Values.SPACE_STR + data.vehicleType);
                    }
                    this.tankmanName.text = data.firstname + Values.SPACE_STR + data.lastname;
                    this.rank.text = data.rank;
                    this.lockMsg.text = data.lockMessage;
                }
            }
        }
    }

    private function updateControlsState():void {
        var _loc1_:* = !(this._buy || this._empty);
        this.icon.visible = this.iconRank.visible = this.iconRole.visible = _loc1_;
        this.btnDissmiss.visible = _loc1_;
        if (this.buy) {
            soundType = SoundTypes.BARRACKS_BUY_SOUND_TYPE;
        }
        else if (this.empty) {
            soundType = SoundTypes.BARRACKS_EMPTY_SOUND_TYPE;
        }
        else {
            soundType = SoundTypes.BARRACKS_TANKMAN_SOUND_TYPE;
        }
    }

    override public function get enabled():Boolean {
        return super.enabled;
    }

    override public function set enabled(param1:Boolean):void {
        super.enabled = param1;
        mouseChildren = param1;
    }

    public function get inTank():Boolean {
        return this._inTank;
    }

    public function set inTank(param1:Boolean):void {
        if (this._inTank == param1) {
            return;
        }
        this._inTank = param1;
        invalidate(INVALIDATE_IN_TANK);
    }

    public function get inCurrentTank():Boolean {
        return this._inCurrentTank;
    }

    public function set inCurrentTank(param1:Boolean):void {
        if (this._inCurrentTank == param1) {
            return;
        }
        this._inCurrentTank = param1;
        invalidate(INVALIDATE_IN_TANK);
    }

    public function get buy():Boolean {
        return this._buy;
    }

    public function set buy(param1:Boolean):void {
        this._buy = param1;
        this.updateControlsState();
        setState(ComponentState.UP);
    }

    public function get empty():Boolean {
        return this._empty;
    }

    public function set empty(param1:Boolean):void {
        this._empty = param1;
        this.updateControlsState();
        setState(ComponentState.UP);
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        super.handleMouseRollOver(param1);
        this._isMouseOver = true;
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        super.handleMouseRollOut(param1);
        this._isMouseOver = false;
    }

    private function onBtnDissmissButtonEventClickHandler(param1:ButtonEvent):void {
        if (this.isTankmanInTank()) {
            dispatchEvent(new CrewEvent(CrewEvent.UNLOAD_TANKMAN, data));
        }
        else {
            dispatchEvent(new CrewEvent(CrewEvent.DISMISS_TANKMAN, data));
        }
    }

    private function onButtonEventClickHandler(param1:ButtonEvent):void {
        if (this.isDismissBtn(param1.target)) {
            return;
        }
        if (this._empty) {
            dispatchEvent(new CrewEvent(CrewEvent.SHOW_RECRUIT_WINDOW, null, true));
        }
        else if (this._buy) {
            dispatchEvent(new CrewEvent(CrewEvent.SHOW_BERTH_BUY_DIALOG));
        }
    }

    private function onBtnDissmissRollOverHandler(param1:MouseEvent):void {
        setState(ComponentState.OUT);
        if (this.isTankmanInTank()) {
            App.toolTipMgr.showComplex(TOOLTIPS.BARRACKS_TANKMEN_UNLOAD);
        }
        else {
            App.toolTipMgr.showComplex(TOOLTIPS.BARRACKS_TANKMEN_DISMISS);
        }
    }

    private function onButtonDissmissRollOutHandler(param1:MouseEvent = null):void {
        setState(ComponentState.OVER);
        App.toolTipMgr.hide();
        dispatchEvent(new ListEvent(ListEvent.ITEM_ROLL_OVER, true, true, -1, -1, -1, null, data));
    }

    private function onRollOverHandler(param1:MouseEvent):void {
        dispatchEvent(new ListEvent(ListEvent.ITEM_ROLL_OVER, true, true, -1, -1, -1, null, data));
    }

    private function onRollOutHandler(param1:MouseEvent):void {
        dispatchEvent(new ListEvent(ListEvent.ITEM_ROLL_OUT, true, true, -1, -1, -1, null, data));
    }

    private function onClickHandler(param1:MouseEvent):void {
        if (this.isDismissBtn(param1.target)) {
            return;
        }
        if (App.utils.commons.isRightButton(param1) && (!this._buy && !this._empty)) {
            dispatchEvent(new CrewEvent(CrewEvent.OPEN_PERSONAL_CASE, data, false, 0));
        }
    }

    private function formatDebuffHtmlText(param1:String):String {
        return HTML_FONT_START + Colors.ERROR_COLOR + HTML_FONT_END + param1 + HTML_FONT_TAG_CLOSE;
    }

    private function isTankmanInTank():Boolean {
        return this._inTank || this._inCurrentTank;
    }

    private function isDismissBtn(param1:Object):Boolean {
        return param1 == this.btnDissmiss;
    }
}
}
