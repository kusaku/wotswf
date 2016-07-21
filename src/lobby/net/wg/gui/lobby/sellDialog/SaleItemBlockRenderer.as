package net.wg.gui.lobby.sellDialog {
import flash.display.MovieClip;
import flash.events.MouseEvent;

import net.wg.data.VO.SellDialogElement;
import net.wg.data.constants.BaseTooltips;
import net.wg.data.constants.Currencies;
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.FITTING_TYPES;
import net.wg.data.managers.impl.TooltipProps;
import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.components.controls.AlertIco;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.IconText;
import net.wg.gui.components.controls.SoundButton;
import net.wg.gui.components.controls.TextFieldShort;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.gui.events.VehicleSellDialogEvent;
import net.wg.gui.interfaces.ISaleItemBlockRenderer;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.ListItemRenderer;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ListEvent;

public class SaleItemBlockRenderer extends ListItemRenderer implements ISaleItemBlockRenderer {

    private static const RIGHT_MARGIN:Number = 7;

    private static const ACTION_PRICE_LEFT_PADDING:Number = -5;

    private static const GOLD_COLOR:Number = 16763253;

    private static const CREDITS_COLOR:Number = 13556185;

    private static const DEFAULT_MONEY_TEXT:String = "0";

    private static const DASH:String = "-";

    private static const EMPTY_STR:String = "";

    private static const PLUS_STR:String = "+";

    public var tfShort:TextFieldShort = null;

    public var alertIcon:AlertIco = null;

    public var ddm:DropdownMenu = null;

    public var money:IconText = null;

    public var actionPrice:ActionPrice = null;

    public var clickArea:SoundButton = null;

    public var itemUnderline:MovieClip = null;

    private var _kind:String = "";

    private var _type:String = "";

    private var _toInventory:Boolean;

    private var _fromInventory:Boolean;

    private var _id:String = "";

    private var _isRemovable:Boolean;

    private var _moneyValue:Number = 0;

    private var _intCD:int = -1;

    private var _count:int = 1;

    private var _removePrice:Number = 0;

    private var _actionPriceDataVo:ActionPriceVO = null;

    private var _actionPriceRemoveVo:ActionPriceVO = null;

    private var _sellExternalData:Array = null;

    public function SaleItemBlockRenderer() {
        super();
    }

    override public function setData(param1:Object):void {
        this.data = param1;
        var _loc2_:SellDialogElement = SellDialogElement(param1);
        this._toInventory = _loc2_.toInventory;
        this._fromInventory = _loc2_.fromInventory;
        this._isRemovable = _loc2_.isRemovable;
        this._moneyValue = _loc2_.moneyValue;
        this._intCD = _loc2_.intCD;
        this._count = _loc2_.count;
        this._kind = _loc2_.kind;
        this._type = _loc2_.type;
        this._id = _loc2_.id;
        this._removePrice = _loc2_.removePrice;
        this._actionPriceRemoveVo = _loc2_.removeActionPriceVo;
        this._actionPriceDataVo = _loc2_.sellActionPriceVo;
        this._sellExternalData = _loc2_.sellExternalData;
        invalidateData();
    }

    override public function setSize(param1:Number, param2:Number):void {
        this.money.x = param1 - this.money.width - RIGHT_MARGIN;
        this.actionPrice.x = param1 + ACTION_PRICE_LEFT_PADDING;
        this.itemUnderline.width = param1;
    }

    override protected function onDispose():void {
        this.alertIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onAlertIconRollOverHandler, false);
        this.alertIcon.removeEventListener(MouseEvent.ROLL_OUT, this.onAlertIconRollOutHandler, false);
        this.alertIcon.dispose();
        this.alertIcon = null;
        this.clickArea.removeEventListener(MouseEvent.ROLL_OVER, handleMouseRollOver, false);
        this.clickArea.removeEventListener(MouseEvent.ROLL_OUT, handleMouseRollOut, false);
        this.clickArea.removeEventListener(MouseEvent.MOUSE_DOWN, handleMousePress, false);
        this.clickArea.removeEventListener(MouseEvent.CLICK, handleMouseRelease, false);
        this.clickArea.removeEventListener(MouseEvent.DOUBLE_CLICK, handleMouseRelease);
        this.clickArea.dispose();
        this.clickArea = null;
        if (this.ddm) {
            this.ddm.removeEventListener(ListEvent.INDEX_CHANGE, this.onChangeHandler);
            this.ddm.dispose();
            this.ddm = null;
        }
        this.tfShort.dispose();
        this.tfShort = null;
        this.money.dispose();
        this.money = null;
        this._actionPriceRemoveVo = null;
        this._actionPriceDataVo = null;
        this._sellExternalData = null;
        this.actionPrice.dispose();
        this.actionPrice = null;
        this.itemUnderline = null;
        super.onDispose();
    }

    override protected function configUI():void {
        this.buttonMode = false;
        this.money.textFieldYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
        this.actionPrice.textYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
        this.ddm.dataProvider = new DataProvider([{"label": DIALOGS.SELLCONFIRMATION_SUBMIT}, {"label": DIALOGS.VEHICLESELLDIALOG_UNLOAD}]);
        this.alertIcon.addEventListener(MouseEvent.ROLL_OVER, this.onAlertIconRollOverHandler, false, 0, true);
        this.alertIcon.addEventListener(MouseEvent.ROLL_OUT, this.onAlertIconRollOutHandler, false, 0, true);
        this.alertIcon.buttonMode = false;
        this.tfShort.buttonMode = false;
        if (this.clickArea) {
            this.clickArea.addEventListener(MouseEvent.ROLL_OVER, handleMouseRollOver, false, 0, true);
            this.clickArea.addEventListener(MouseEvent.ROLL_OUT, handleMouseRollOut, false, 0, true);
            this.clickArea.addEventListener(MouseEvent.MOUSE_DOWN, handleMousePress, false, 0, true);
            this.clickArea.addEventListener(MouseEvent.CLICK, handleMouseRelease, false, 0, true);
            this.clickArea.addEventListener(MouseEvent.DOUBLE_CLICK, handleMouseRelease, false, 0, true);
            this.clickArea.buttonMode = false;
            this.clickArea.soundEnabled = false;
        }
        if (_focusIndicator != null && !_focused && _focusIndicator.totalFrames == 1) {
            focusIndicator.visible = false;
        }
    }

    override protected function draw():void {
        var _loc1_:String = null;
        super.draw();
        if (isInvalid(InvalidationType.DATA) && data) {
            this.ddm.addEventListener(ListEvent.INDEX_CHANGE, this.onChangeHandler);
            this.ddm.selectedIndex = !!this.toInventory ? 1 : 0;
            if (this.ddm.selectedIndex == 1) {
                if (!this.isRemovable) {
                    this.money.textColor = GOLD_COLOR;
                    this.money.text = this.getSign(-this._removePrice, Currencies.GOLD);
                    this.money.icon = Currencies.GOLD;
                    this.alertIcon.visible = true;
                    if (this._removePrice != 0) {
                        if (this._actionPriceRemoveVo) {
                            this._actionPriceRemoveVo.useSign = true;
                            this._actionPriceRemoveVo.externalSign = DASH;
                            this._actionPriceRemoveVo.forCredits = false;
                        }
                        this.actionPrice.setData(this._actionPriceRemoveVo);
                    }
                    else {
                        this.actionPrice.visible = false;
                    }
                }
                else {
                    this.money.text = DEFAULT_MONEY_TEXT;
                    this.money.textColor = CREDITS_COLOR;
                    this.money.icon = Currencies.CREDITS;
                    this.alertIcon.visible = false;
                    this.actionPrice.visible = false;
                }
            }
            else {
                this.alertIcon.visible = false;
                this.money.text = this.getSign(this._moneyValue, Currencies.CREDITS);
                this.money.textColor = CREDITS_COLOR;
                this.money.icon = Currencies.CREDITS;
                if (this._actionPriceDataVo) {
                    this._actionPriceDataVo.useSign = true;
                    this._actionPriceDataVo.forCredits = true;
                    this._actionPriceDataVo.newPrice = this.moneyValue;
                }
                this.actionPrice.setData(this._actionPriceDataVo);
            }
            this.money.visible = !this.actionPrice.visible;
        }
        if (this._type == FITTING_TYPES.SHELL) {
            if (this._kind != Values.EMPTY_STR) {
                _loc1_ = App.utils.locale.makeString(ITEM_TYPES.shell_kindsabbreviation(this._kind));
                this.tfShort.label = _loc1_ + " " + this._id;
                this.tfShort.altToolTip = App.utils.locale.makeString(ITEM_TYPES.shell_kinds(this._kind)) + " " + data.id;
            }
        }
        else {
            this.tfShort.label = this._id;
        }
        constraints.update(this._width, this._height);
    }

    public function hideLine():void {
        this.itemUnderline.visible = false;
    }

    public function setColor(param1:Number):void {
        this.money.textColor = param1;
    }

    private function getSign(param1:Number, param2:String):String {
        if (param2 == Currencies.CREDITS) {
            return (param1 > 0 ? PLUS_STR : EMPTY_STR) + App.utils.locale.integer(param1);
        }
        return (param1 > 0 ? PLUS_STR : EMPTY_STR) + App.utils.locale.gold(param1);
    }

    public function get toInventory():Boolean {
        return this._toInventory;
    }

    public function get fromInventory():Boolean {
        return this._fromInventory;
    }

    public function get isRemovable():Boolean {
        return this._isRemovable;
    }

    public function get moneyValue():Number {
        return this._moneyValue;
    }

    public function get type():String {
        return this._type;
    }

    public function get intCD():Number {
        return this._intCD;
    }

    public function get count():Number {
        return this._count;
    }

    public function get sellExternalData():Array {
        return this._sellExternalData;
    }

    private function onAlertIconRollOverHandler(param1:MouseEvent):void {
        var _loc2_:int = 0;
        var _loc3_:TooltipProps = null;
        if (this.ddm.selectedIndex == 1) {
            _loc2_ = 330;
            _loc3_ = new TooltipProps(BaseTooltips.TYPE_INFO, 0, 0, 0, -1, 0, _loc2_);
            App.toolTipMgr.showComplex(TOOLTIPS.VEHICLESELLDIALOG_RENDERER_ALERTICON, _loc3_);
        }
    }

    private function onAlertIconRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onChangeHandler(param1:ListEvent):void {
        if (param1.index == 1) {
            this._toInventory = true;
            if (!this.isRemovable) {
                this.money.text = this.getSign(-this._removePrice, Currencies.GOLD);
                this.money.textColor = GOLD_COLOR;
                this.money.icon = Currencies.GOLD;
                this.alertIcon.visible = true;
                if (this._removePrice != 0) {
                    if (this._actionPriceRemoveVo) {
                        this._actionPriceRemoveVo.useSign = true;
                        this._actionPriceRemoveVo.externalSign = DASH;
                        this._actionPriceRemoveVo.forCredits = false;
                    }
                    this.actionPrice.setData(this._actionPriceRemoveVo);
                }
                else {
                    this.actionPrice.visible = false;
                }
            }
            else {
                this.money.text = DEFAULT_MONEY_TEXT;
                this.money.textColor = CREDITS_COLOR;
                this.money.icon = Currencies.CREDITS;
                this.alertIcon.visible = false;
                this.actionPrice.visible = false;
            }
        }
        else {
            this.alertIcon.visible = false;
            this._toInventory = false;
            this.money.text = this.getSign(this.moneyValue, Currencies.CREDITS);
            this.money.icon = Currencies.CREDITS;
            this.money.textColor = CREDITS_COLOR;
            if (this._actionPriceDataVo) {
                this._actionPriceDataVo.useSign = true;
                this._actionPriceDataVo.forCredits = true;
                this._actionPriceDataVo.newPrice = this.moneyValue;
            }
            this.actionPrice.setData(this._actionPriceDataVo);
        }
        this.money.visible = !this.actionPrice.visible;
        dispatchEvent(new VehicleSellDialogEvent(VehicleSellDialogEvent.UPDATE_RESULT));
    }
}
}
