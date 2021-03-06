package net.wg.gui.lobby.sellDialog {
import fl.transitions.easing.Strong;

import flash.display.Sprite;
import flash.events.Event;

import net.wg.data.constants.ColorSchemeNames;
import net.wg.data.constants.generated.FITTING_TYPES;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.IconText;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.events.VehicleSellDialogEvent;
import net.wg.gui.interfaces.ISaleItemBlockRenderer;
import net.wg.gui.lobby.sellDialog.VO.SellDialogVO;
import net.wg.gui.lobby.sellDialog.VO.SellVehicleVo;
import net.wg.infrastructure.base.meta.IVehicleSellDialogMeta;
import net.wg.infrastructure.base.meta.impl.VehicleSellDialogMeta;
import net.wg.infrastructure.interfaces.IWindow;
import net.wg.utils.ILocale;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ListEvent;
import scaleform.clik.motion.Tween;
import scaleform.clik.utils.Padding;

public class VehicleSellDialog extends VehicleSellDialogMeta implements IVehicleSellDialogMeta {

    public static const ICONS_TEXT_OFFSET:Number = -2;

    private static const SLIDING_SPEED:Number = 350;

    private static const DISMISS_TANKMEN:int = 1;

    private static const CONTENT_RIGHT_ADDITIONAL_PADDING:int = -4;

    private static const RED_COLOR:Number = 16711680;

    private static const POSITIVE_PREFIX:String = "+ ";

    private static const NEGATIVE_PREFIX:String = "- ";

    private static const INV_CONTROL_QUESTION:String = "invControlQuestion";

    private static const INV_BARRACKS_DROP:String = "invBarracksDrop";

    private static const INV_GOLD:String = "invalidateGold";

    public var headerComponent:SellHeaderComponent = null;

    public var slidingComponent:SellSlidingComponent = null;

    public var devicesComponent:SellDevicesComponent = null;

    public var controlQuestion:ControlQuestionComponent = null;

    public var windBgForm:Sprite = null;

    public var cancelBtn:SoundButtonEx = null;

    public var submitBtn:SoundButtonEx = null;

    public var result_mc:TotalResult = null;

    private var _resultIT:IconText = null;

    private var _settingsBtn:SettingsButton = null;

    private var _creditsIT:IconText = null;

    private var _setingsDropBtn:CheckBox = null;

    private var _removeDevicesFullCost:Number = 0;

    private var _listVisibleHeight:Number = 0;

    private var _creditsComplDev:Number = 0;

    private var _accGold:Number = 0;

    private var _tweens:Vector.<Tween>;

    private var _countTweenObjects:int = 0;

    private var _countCallBack:int = 0;

    private var _vehicleVo:SellVehicleVo = null;

    private var _data:SellDialogVO = null;

    private var _controlQuestionVisible:Boolean = false;

    public function VehicleSellDialog() {
        this._tweens = new Vector.<Tween>();
        super();
    }

    override public function setWindow(param1:IWindow):void {
        var _loc2_:Padding = null;
        super.setWindow(param1);
        if (param1) {
            _loc2_ = Padding(window.contentPadding);
            _loc2_.right = _loc2_.right + CONTENT_RIGHT_ADDITIONAL_PADDING;
            window.contentPadding = _loc2_;
            window.titleUseHtml = true;
        }
    }

    override public function updateStage(param1:Number, param2:Number):void {
        super.updateStage(param1, param2);
        this.updateWindowPosition();
    }

    override protected function initialize():void {
        super.initialize();
        isModal = true;
        isCentered = true;
        canDrag = false;
        showWindowBgForm = false;
        scaleX = scaleY = 1;
        this.controlQuestion.visible = this._controlQuestionVisible;
        this._settingsBtn = this.slidingComponent.settingsBtn;
        this._setingsDropBtn = this._settingsBtn.setingsDropBtn;
        this._creditsIT = this._settingsBtn.creditsIT;
    }

    override protected function configUI():void {
        super.configUI();
        this._resultIT = this.result_mc.goldIT;
        this.controlQuestion.visible = false;
        this.controlQuestion.addEventListener(ControlQuestionComponent.USER_INPUT_HANDLER, this.onControlQuestionUserInputHandler);
        this.slidingComponent.slidingScrList.addEventListener(VehicleSellDialogEvent.LIST_WAS_DRAWN, this.onSlidingComponentListWasDrawnHandler, false, 1);
        this.cancelBtn.label = DIALOGS.VEHICLESELLDIALOG_CANCEL;
        this.addEventListener(VehicleSellDialogEvent.UPDATE_RESULT, this.onUpdateResultHandler);
        this.cancelBtn.addEventListener(ButtonEvent.CLICK, this.onCancelBtnClickHandler);
        this.submitBtn.addEventListener(ButtonEvent.CLICK, this.onSubmitBtnClickHandler);
        this.headerComponent.inBarracksDrop.addEventListener(ListEvent.INDEX_CHANGE, this.onHeaderComponentIndexChangeHandler);
        setFocus(this.submitBtn);
    }

    override protected function onDispose():void {
        var _loc1_:Tween = null;
        App.utils.scheduler.cancelTask(setFocus);
        this.slidingComponent.slidingScrList.removeEventListener(VehicleSellDialogEvent.LIST_WAS_DRAWN, this.onSlidingComponentListWasDrawnHandler);
        this.removeEventListener(VehicleSellDialogEvent.UPDATE_RESULT, this.onUpdateResultHandler);
        this._setingsDropBtn.removeEventListener(Event.SELECT, this.onSlidingComponentSelectHandler);
        this.controlQuestion.removeEventListener(ControlQuestionComponent.USER_INPUT_HANDLER, this.onControlQuestionUserInputHandler);
        this.cancelBtn.removeEventListener(ButtonEvent.CLICK, this.onCancelBtnClickHandler);
        this.submitBtn.removeEventListener(ButtonEvent.CLICK, this.onSubmitBtnClickHandler);
        this.headerComponent.inBarracksDrop.removeEventListener(ListEvent.INDEX_CHANGE, this.onHeaderComponentIndexChangeHandler);
        for each(_loc1_ in this._tweens) {
            _loc1_.paused = true;
            _loc1_ = null;
        }
        this._resultIT = null;
        this._settingsBtn = null;
        this._setingsDropBtn = null;
        this._creditsIT = null;
        this.headerComponent.dispose();
        this.headerComponent = null;
        this.result_mc.dispose();
        this.result_mc = null;
        this.slidingComponent.dispose();
        this.devicesComponent.dispose();
        this.controlQuestion.dispose();
        this._vehicleVo = null;
        this.slidingComponent = null;
        this.devicesComponent = null;
        this.controlQuestion = null;
        this.windBgForm = null;
        this.cancelBtn.dispose();
        this.cancelBtn = null;
        this.submitBtn.dispose();
        this.submitBtn = null;
        if (this._tweens != null) {
            this._tweens.splice(0, this._tweens.length);
        }
        this._tweens = null;
        this._data = null;
        App.toolTipMgr.hide();
        super.onDispose();
    }

    override protected function draw():void {
        if (this._data != null) {
            if (isInvalid(INV_BARRACKS_DROP)) {
                if (this._controlQuestionVisible) {
                    this.cleanAndFocusControlQuestion();
                }
                checkControlQuestionS(this.headerComponent.inBarracksDrop.selectedIndex == DISMISS_TANKMEN);
            }
            if (isInvalid(InvalidationType.DATA)) {
                this.setGoldText(this.headerComponent.creditsCommon, this._removeDevicesFullCost);
            }
            if (isInvalid(INV_CONTROL_QUESTION)) {
                this.controlQuestion.visible = this._controlQuestionVisible;
                this.setGoldText(this.headerComponent.creditsCommon, this._removeDevicesFullCost);
                this.checkGold();
            }
            if (isInvalid(INV_GOLD)) {
                this.checkGold();
            }
            if (isInvalid(InvalidationType.SIZE)) {
                this.updateComponentsPosition();
            }
        }
    }

    override protected function setData(param1:SellDialogVO):void {
        this._data = param1;
        this._vehicleVo = param1.sellVehicleVO;
        this._accGold = param1.accountGold;
        this._removeDevicesFullCost = 0;
        this.devicesComponent.removePrice = this._data.removePrice;
        this.devicesComponent.setRemoveActionPriceData(this._data.removeActionPrice);
        var _loc2_:String = !!this._vehicleVo.isRented ? DIALOGS.VEHICLEREMOVEDIALOG_TITLE : DIALOGS.VEHICLESELLDIALOG_TITLE;
        if (this._vehicleVo.isRented) {
            _loc2_ = DIALOGS.VEHICLEREMOVEDIALOG_TITLE;
        }
        else {
            _loc2_ = DIALOGS.VEHICLESELLDIALOG_TITLE;
        }
        this.window.title = App.utils.locale.makeString(_loc2_, {"name": this._vehicleVo.userName});
        this.submitBtn.label = !!this._vehicleVo.isRented ? DIALOGS.VEHICLESELLDIALOG_REMOVE : DIALOGS.VEHICLESELLDIALOG_SUBMIT;
        this.headerComponent.setData(this._vehicleVo);
        this.devicesComponent.setData(this._data.optionalDevicesOnVehicle);
        this.slidingComponent.sellData = this.devicesComponent.sellData;
        this.slidingComponent.isOpened = this._data.isSlidingComponentOpened;
        this.slidingComponent.setShells(this._data.shellsOnVehicle);
        this.slidingComponent.setEquipment(this._data.equipmentsOnVehicle);
        this.slidingComponent.setInventory(this._data.modulesInInventory, this._data.shellsInInventory);
        invalidate(InvalidationType.DATA, InvalidationType.SIZE);
    }

    public function as_checkGold(param1:Number):void {
        this._accGold = param1;
        invalidate(INV_GOLD);
    }

    public function as_enableButton(param1:Boolean):void {
        var _loc2_:Boolean = this.submitBtn.enabled;
        this.submitBtn.enabled = this.controlQuestion.isValidControlInput && param1 && this._accGold >= this.isHasGold();
        if (this.submitBtn.enabled && !_loc2_) {
            App.utils.scheduler.scheduleOnNextFrame(setFocus, this.submitBtn);
        }
    }

    public function as_setControlQuestionData(param1:Boolean, param2:String, param3:String):void {
        var _loc4_:String = null;
        if (param1) {
            _loc4_ = App.utils.locale.gold(param2);
            _loc4_ = StringUtils.trim(_loc4_);
        }
        else {
            _loc4_ = App.utils.locale.integer(param2);
        }
        this.controlQuestion.controlText = param2;
        this.controlQuestion.formattedControlText = _loc4_;
        this.controlQuestion.headerText = DIALOGS.VEHICLESELLDIALOG_CTRLQUESTION_HEADER;
        this.controlQuestion.errorText = DIALOGS.VEHICLESELLDIALOG_CTRLQUESTION_ERRORMESSAGE;
        this.controlQuestion.questionText = param3;
        this.controlQuestion.invalidateData();
    }

    public function as_visibleControlBlock(param1:Boolean):void {
        if (this.controlQuestion.visible == param1) {
            return;
        }
        if (this._controlQuestionVisible) {
            setFocus(this.controlQuestion.userInput);
        }
        else {
            setFocus(this.submitBtn);
        }
        this._controlQuestionVisible = param1;
        invalidate(INV_CONTROL_QUESTION, InvalidationType.SIZE);
    }

    public function compCompletedTween():Boolean {
        return this._countTweenObjects == this._countCallBack;
    }

    public function motionCallBack(param1:Tween):void {
        this._countCallBack++;
        if (this.compCompletedTween()) {
            this.updateComponentsPosition();
            if (this.controlQuestion.userInput == lastFocusedElement) {
                App.utils.scheduler.scheduleOnNextFrame(setFocus, this.controlQuestion.userInput);
            }
        }
    }

    private function checkGold():void {
        var _loc1_:Number = NaN;
        var _loc4_:ISaleItemBlockRenderer = null;
        var _loc2_:Vector.<ISaleItemBlockRenderer> = this.devicesComponent.deviceItemRenderer;
        if (this._accGold < this.isHasGold()) {
            _loc1_ = RED_COLOR;
            this.enabledSubmitBtn(false);
        }
        else {
            _loc1_ = App.colorSchemeMgr.getRGB(ColorSchemeNames.TEXT_COLOR_GOLD);
            this.enabledSubmitBtn(!!this._controlQuestionVisible ? Boolean(this.controlQuestion.isValidControlInput) : true);
        }
        var _loc3_:int = _loc2_.length;
        var _loc5_:uint = 0;
        while (_loc5_ < _loc3_) {
            _loc4_ = _loc2_[_loc5_];
            if (_loc4_.toInventory && !_loc4_.isRemovable) {
                _loc4_.setColor(_loc1_);
                _loc4_.validateNow();
            }
            _loc5_++;
        }
        this._resultIT.textColor = _loc1_;
    }

    private function enabledSubmitBtn(param1:Boolean):void {
        this.submitBtn.enabled = param1;
    }

    private function isHasGold():Number {
        return this._removeDevicesFullCost - this.headerComponent.tankGoldPrice;
    }

    private function updateWindowPosition():void {
        window.x = App.appWidth - window.width >> 1;
        window.y = App.appHeight - window.getBackground().height >> 1;
    }

    private function setGoldText(param1:Number, param2:Number):void {
        var _loc9_:* = false;
        var _loc10_:int = 0;
        var _loc3_:ILocale = App.utils.locale;
        var _loc4_:Number = this.headerComponent.tankGoldPrice - param2;
        var _loc5_:String = _loc3_.gold(Math.abs(_loc4_));
        var _loc6_:Number = param1 + this._creditsComplDev;
        var _loc7_:String = "";
        if (_loc4_ != 0) {
            _loc7_ = _loc4_ > 0 ? POSITIVE_PREFIX : NEGATIVE_PREFIX;
        }
        this._resultIT.text = _loc7_ + _loc5_;
        _loc7_ = _loc6_ > 0 ? POSITIVE_PREFIX : "";
        this.result_mc.creditsIT.text = _loc7_ + _loc3_.integer(_loc6_);
        if (this._controlQuestionVisible) {
            _loc9_ = _loc6_ == 0;
            _loc10_ = !!_loc9_ ? int(_loc4_) : int(_loc6_);
            setResultCreditS(_loc9_, _loc10_);
            this.cleanAndFocusControlQuestion();
        }
        var _loc8_:Number = param1 - this.headerComponent.tankPrice;
        _loc7_ = _loc8_ > 0 ? POSITIVE_PREFIX : "";
        this._creditsIT.text = _loc7_ + _loc3_.integer(_loc8_);
        this._creditsIT.visible = !this._setingsDropBtn.selected;
        this._creditsIT.alpha = !!this._setingsDropBtn.selected ? Number(0) : Number(1);
        this._creditsIT.validateNow();
    }

    private function updateComponentsPosition():void {
        this.slidingComponent.visible = this._listVisibleHeight != 0;
        if (this._listVisibleHeight != 0) {
            this._settingsBtn.visible = true;
            this.slidingComponent.expandBg.visible = true;
        }
        var _loc1_:int = this.headerComponent.y + this.headerComponent.getNextPosition();
        if (this.devicesComponent.isActive) {
            this.devicesComponent.y = _loc1_;
            _loc1_ = this.devicesComponent.y + this.devicesComponent.getNextPosition();
        }
        if (this.slidingComponent.visible) {
            this._setingsDropBtn.addEventListener(Event.SELECT, this.onSlidingComponentSelectHandler);
            this.slidingComponent.y = _loc1_;
            _loc1_ = this.slidingComponent.y + this.slidingComponent.getNextPosition();
        }
        this.result_mc.y = _loc1_;
        if (this._controlQuestionVisible) {
            this.controlQuestion.y = this.result_mc.y + this.result_mc.getSize();
            _loc1_ = this.controlQuestion.y + this.controlQuestion.getNextPosition();
        }
        else {
            this.controlQuestion.y = 0;
            _loc1_ = this.result_mc.y + this.result_mc.getSize();
        }
        this.windBgForm.height = _loc1_;
        this.submitBtn.y = this.cancelBtn.y = this.windBgForm.y + this.windBgForm.height + window.contentPadding.bottom - window.formBgPadding.bottom;
        window.getBackground().height = this.submitBtn.y + this.submitBtn.height + window.contentPadding.top + window.contentPadding.bottom;
        this.updateWindowPosition();
    }

    private function updateElements():void {
        this.slidingComponent.slidingScrList.y = this._settingsBtn.y + this._settingsBtn.height;
        this._creditsIT.visible = true;
        this.slidingComponent.slidingScrList.visible = this.slidingComponent.isOpened;
    }

    private function onSlidingComponentSelectHandler(param1:Event):void {
        var _loc5_:Tween = null;
        var _loc6_:int = 0;
        var _loc7_:int = 0;
        var _loc8_:int = 0;
        var _loc9_:int = 0;
        var _loc10_:int = 0;
        var _loc11_:int = 0;
        var _loc12_:Boolean = false;
        var _loc13_:int = 0;
        if (!this.compCompletedTween()) {
            this._setingsDropBtn.removeEventListener(Event.SELECT, this.onSlidingComponentSelectHandler);
            this._setingsDropBtn.selected = !this._setingsDropBtn.selected;
            this._setingsDropBtn.addEventListener(Event.SELECT, this.onSlidingComponentSelectHandler);
            return;
        }
        this._countCallBack = 0;
        var _loc2_:Number = SLIDING_SPEED;
        var _loc3_:int = !!this.slidingComponent.isOpened ? int(-this.slidingComponent.resultExpand) : int(this.slidingComponent.resultExpand);
        var _loc4_:* = App.appHeight - window.getBackground().height - _loc3_ >> 1;
        for each(_loc5_ in this._tweens) {
            _loc5_.paused = true;
            _loc5_ = null;
        }
        _loc6_ = this.slidingComponent.height + _loc3_;
        _loc7_ = this.submitBtn.y + _loc3_;
        _loc8_ = this.cancelBtn.y + _loc3_;
        _loc9_ = this.windBgForm.height + _loc3_;
        _loc10_ = window.getBackground().height + _loc3_;
        _loc11_ = this.result_mc.y + _loc3_;
        _loc12_ = this.slidingComponent.isOpened;
        _loc13_ = !!_loc12_ ? 0 : int(this.slidingComponent.mask_mc.height + _loc3_);
        var _loc14_:int = this.slidingComponent.expandBg.height + _loc3_;
        var _loc15_:int = !!this._controlQuestionVisible ? int(this.controlQuestion.y + _loc3_) : 0;
        var _loc16_:Number = !!_loc12_ ? Number(1) : Number(0);
        var _loc17_:Number = !!_loc12_ ? Number(0) : Number(1);
        this.slidingComponent.isOpened = !_loc12_;
        this._tweens = Vector.<Tween>([new Tween(_loc2_, this.slidingComponent, {"height": _loc6_}, {
            "paused": false,
            "ease": Strong.easeOut,
            "onComplete": null
        }), new Tween(_loc2_, this.windBgForm, {"height": _loc9_}, {
            "paused": false,
            "ease": Strong.easeOut,
            "onComplete": null
        }), new Tween(_loc2_, this.submitBtn, {"y": _loc7_}, {
            "paused": false,
            "ease": Strong.easeOut,
            "onComplete": null
        }), new Tween(_loc2_, this.cancelBtn, {"y": _loc8_}, {
            "paused": false,
            "ease": Strong.easeOut,
            "onComplete": null
        }), new Tween(_loc2_, this.result_mc, {"y": _loc11_}, {
            "paused": false,
            "ease": Strong.easeOut,
            "onComplete": null
        }), new Tween(_loc2_, this.slidingComponent.mask_mc, {"height": _loc13_}, {
            "paused": false,
            "ease": Strong.easeOut,
            "onComplete": null
        }), new Tween(_loc2_, this.slidingComponent.expandBg, {"height": _loc14_}, {
            "paused": false,
            "ease": Strong.easeOut,
            "onComplete": null
        }), new Tween(_loc2_, this._creditsIT, {"alpha": _loc16_}, {
            "paused": false,
            "ease": Strong.easeOut,
            "onComplete": null
        }), new Tween(_loc2_, this._settingsBtn.ddLine, {"alpha": _loc17_}, {
            "paused": false,
            "ease": Strong.easeOut,
            "onComplete": null
        }), new Tween(_loc2_, this.controlQuestion, {"y": _loc15_}, {
            "paused": false,
            "ease": Strong.easeOut,
            "onComplete": null
        }), new Tween(_loc2_, window, {"y": _loc4_}, {
            "paused": false,
            "ease": Strong.easeOut,
            "onComplete": null
        }), new Tween(_loc2_, window.getBackground(), {"height": _loc10_}, {
            "paused": false,
            "ease": Strong.easeOut,
            "onComplete": null
        })]);
        this._countTweenObjects = this._tweens.length;
        var _loc18_:int = 0;
        while (_loc18_ < this._countTweenObjects) {
            this._tweens[_loc18_].onComplete = this.motionCallBack;
            this._tweens[_loc18_].fastTransform = false;
            _loc18_++;
        }
        this.updateElements();
    }

    private function onSubmitBtnClickHandler(param1:ButtonEvent):void {
        var _loc8_:int = 0;
        var _loc10_:ISaleItemBlockRenderer = null;
        var _loc2_:Vector.<ISaleItemBlockRenderer> = this.slidingComponent.slidingScrList.getRenderers();
        var _loc3_:Vector.<ISaleItemBlockRenderer> = this.devicesComponent.deviceItemRenderer;
        var _loc4_:Array = [];
        var _loc5_:Array = [];
        var _loc6_:Array = [];
        var _loc7_:Array = [];
        var _loc9_:int = _loc2_.length;
        _loc8_ = 0;
        while (_loc8_ < _loc9_) {
            _loc10_ = _loc2_[_loc8_];
            if (!_loc10_.toInventory) {
                switch (_loc10_.type) {
                    case FITTING_TYPES.OPTIONAL_DEVICE:
                        _loc4_.push({
                            "intCD": _loc10_.intCD,
                            "count": _loc10_.count
                        });
                        break;
                    case FITTING_TYPES.SHELL:
                        if (_loc10_.fromInventory) {
                            _loc7_.push({
                                "intCD": _loc10_.intCD,
                                "count": _loc10_.count
                            });
                        }
                        else {
                            _loc5_.push({
                                "intCD": _loc10_.intCD,
                                "count": _loc10_.count
                            });
                        }
                        break;
                    case FITTING_TYPES.EQUIPMENT:
                        _loc6_.push({
                            "intCD": _loc10_.intCD,
                            "count": _loc10_.count
                        });
                        break;
                    case FITTING_TYPES.MODULE:
                        if (_loc10_.sellExternalData) {
                            _loc7_ = _loc7_.concat(_loc10_.sellExternalData);
                        }
                }
            }
            _loc8_++;
        }
        _loc9_ = _loc3_.length;
        _loc8_ = 0;
        while (_loc8_ < _loc9_) {
            if (!_loc3_[_loc8_].toInventory) {
                _loc4_.push({
                    "intCD": _loc3_[_loc8_].intCD,
                    "count": _loc3_[_loc8_].count
                });
            }
            _loc8_++;
        }
        var _loc11_:* = this.headerComponent.inBarracksDrop.selectedIndex == 1;
        setDialogSettingsS(this._setingsDropBtn.selected);
        sellS(this._vehicleVo.intCD, _loc5_, _loc6_, _loc4_, _loc7_, _loc11_);
        onWindowCloseS();
    }

    private function onSlidingComponentListWasDrawnHandler(param1:VehicleSellDialogEvent):void {
        this._listVisibleHeight = param1.listVisibleHight;
        this.updateComponentsPosition();
    }

    private function onUpdateResultHandler(param1:VehicleSellDialogEvent = null):void {
        this.headerComponent.creditsCommon = this.headerComponent.tankPrice;
        this._creditsComplDev = 0;
        this._removeDevicesFullCost = 0;
        var _loc2_:Vector.<ISaleItemBlockRenderer> = this.slidingComponent.slidingScrList.getRenderers();
        var _loc3_:int = _loc2_.length;
        var _loc4_:uint = 0;
        while (_loc4_ < _loc3_) {
            if (!_loc2_[_loc4_].toInventory) {
                this.headerComponent.creditsCommon = this.headerComponent.creditsCommon + _loc2_[_loc4_].moneyValue;
            }
            _loc4_++;
        }
        var _loc5_:Vector.<ISaleItemBlockRenderer> = this.devicesComponent.deviceItemRenderer;
        _loc3_ = _loc5_.length;
        var _loc6_:uint = 0;
        while (_loc6_ < _loc3_) {
            if (_loc5_[_loc6_].toInventory) {
                if (!_loc5_[_loc6_].isRemovable) {
                    this._removeDevicesFullCost = this._removeDevicesFullCost + this.devicesComponent.removePrice;
                }
            }
            else {
                this._creditsComplDev = this._creditsComplDev + _loc5_[_loc6_].moneyValue;
            }
            _loc6_++;
        }
        this.setGoldText(this.headerComponent.creditsCommon, this._removeDevicesFullCost);
        this.checkGold();
    }

    private function onCancelBtnClickHandler(param1:ButtonEvent):void {
        onWindowCloseS();
    }

    private function onControlQuestionUserInputHandler(param1:Event):void {
        setUserInputS(this.controlQuestion.getUserText());
    }

    private function onHeaderComponentIndexChangeHandler(param1:ListEvent):void {
        invalidate(INV_BARRACKS_DROP);
    }

    private function cleanAndFocusControlQuestion():void {
        this.controlQuestion.cleanField();
        if (this.controlQuestion.userInput.focused == false) {
            App.utils.scheduler.scheduleOnNextFrame(setFocus, this.controlQuestion.userInput);
        }
    }
}
}
