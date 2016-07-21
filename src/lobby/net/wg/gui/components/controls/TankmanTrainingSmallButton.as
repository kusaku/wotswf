package net.wg.gui.components.controls {
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.ComponentState;
import net.wg.data.constants.IconsTypes;
import net.wg.data.constants.SoundTypes;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.gui.components.controls.VO.TankmanTrainingSmallButtonVO;
import net.wg.gui.components.controls.data.constants.TrainingType;
import net.wg.utils.ILocale;

import scaleform.clik.constants.InvalidationType;

public class TankmanTrainingSmallButton extends SoundButton {

    private static const PRICE_COLORS:Object = {
        "normal": 16314069,
        "disabled": 16711680,
        "buy": 5330004
    };

    private static const NORMAL_STATE:String = "normal";

    private static const RETRAINING_PREFIX:String = "retraining_";

    private static const PRICE_LABEL_DEFAULT_POSITION:int = 268;

    private static const PRICE_LABEL_Y_OFFSET:int = 10;

    private static const INVALIDATE_SELECTION:String = "selectionInvalid";

    private static const INVALIDATE_LEVEL:String = "invalidateLevel";

    private static const INVALIDATE_RETRAINING:String = "invalidateRetraning";

    private static const INVALIDATE_PRICE:String = "invalidatePrice";

    private static const INVALIDATE_TYPE:String = "invalidateType";

    public var bg:MovieClip;

    public var typeSwitcher:MovieClip;

    public var border:MovieClip;

    public var actionPrice:ActionPrice;

    public var priceLabel:IconText;

    public var levelLabel:TextField;

    public var labelField:TextField;

    public var trainingLabel:TextField;

    public var inspectableGroupName:String;

    protected var _level:Number = 0;

    protected var _model:TankmanTrainingSmallButtonVO;

    protected var _hasMoney:Boolean = false;

    protected var _specializationLevel:int = 0;

    protected var _minGroupSpecializationLevel:int = 0;

    private var _actionPriceVo:ActionPriceVO;

    private var _buy:Boolean = false;

    private var _type:String = "free";

    private var _retraining:Boolean = true;

    private var _scopeType:String = "";

    private var _isNativeVehicle:Boolean = false;

    private var _price:String;

    public function TankmanTrainingSmallButton() {
        super();
        useFocusedAsSelect = true;
        _stateMap = {
            "up": [ComponentState.UP],
            "over": [ComponentState.OVER],
            "down": [ComponentState.DOWN],
            "release": [ComponentState.RELEASE, ComponentState.OVER],
            "out": [ComponentState.OUT, ComponentState.UP],
            "disabled": [ComponentState.DISABLED],
            "selecting": [ComponentState.SELECTING, ComponentState.OVER],
            "toggle": [ComponentState.TOGGLE, ComponentState.UP],
            "kb_selecting": [ComponentState.KB_SELECTING, ComponentState.UP],
            "kb_release": [ComponentState.KB_RELEASE, ComponentState.OUT, ComponentState.UP],
            "kb_down": [ComponentState.KB_DOWN, ComponentState.DOWN]
        };
        soundType = SoundTypes.RNDR_NORMAL;
        soundId = "";
        preventAutosizing = true;
        constraintsDisabled = true;
    }

    override protected function configUI():void {
        super.configUI();
        this.type = this._type;
        if (label) {
            this.labelField.text = label;
            this.trainingLabel.text = "";
        }
        this.actionPrice.setup(this);
    }

    override protected function draw():void {
        var _loc2_:ILocale = null;
        var _loc1_:String = _newFrame;
        super.draw();
        if (isInvalid(INVALIDATE_LEVEL)) {
            this.levelLabel.text = this._level.toString() + "%";
        }
        if (isInvalid(INVALIDATE_RETRAINING)) {
            this.typeSwitcher.gotoAndPlay(!!this._retraining ? RETRAINING_PREFIX + this._type : this._type);
            this.trainingLabel.text = !!this._retraining ? MENU.TANKMANTRAININGBUTTON2_RETRAININGTO : MENU.TANKMANTRAININGBUTTON2_TRAININGTO;
        }
        if (isInvalid(INVALIDATE_SELECTION)) {
            dispatchEvent(new Event(Event.SELECT));
        }
        if (isInvalid(INVALIDATE_PRICE) || isInvalid(INVALIDATE_TYPE)) {
            this.setTextColorToPriceLabel();
            _loc2_ = App.utils.locale;
            switch (this._type) {
                case TrainingType.FREE:
                    this.priceLabel.text = MENU.TANKMANRETRAININGBTN_FREE;
                    break;
                case TrainingType.ACADEMY:
                    this.priceLabel.text = _loc2_.gold(this._price);
                    break;
                case TrainingType.SCHOOL:
                    this.priceLabel.text = _loc2_.integer(this._price);
            }
        }
        if (isInvalid(INVALIDATE_TYPE)) {
            switch (this._scopeType) {
                case "dropSkills":
                    this.labelField.text = MENU.skilldropwindow_study(this._type);
                    this.trainingLabel.text = MENU.tankmantrainingwindow(this._type);
                    break;
                default:
                    this.labelField.text = MENU.tankmantrainingwindow(this._type);
            }
            if (this._type == TrainingType.FREE) {
                this.priceLabel.icon = IconsTypes.EMPTY;
                this.priceLabel.textAlign = TextFieldAutoSize.RIGHT;
                this.priceLabel.x = PRICE_LABEL_DEFAULT_POSITION + PRICE_LABEL_Y_OFFSET;
                this.actionPrice.visible = false;
                this.priceLabel.visible = !this.actionPrice.visible;
            }
            else {
                this.priceLabel.icon = this._type == TrainingType.ACADEMY ? IconsTypes.GOLD : IconsTypes.CREDITS;
                this.priceLabel.x = PRICE_LABEL_DEFAULT_POSITION;
            }
            if (this.priceLabel is ActionPrice || this.priceLabel is IconText) {
                this.priceLabel.invalidate();
                this.priceLabel.validateNow();
            }
        }
        if (_loc1_ && isInvalid(InvalidationType.STATE)) {
            this.alpha = _loc1_ != ComponentState.DISABLED ? Number(ENABLED_ALPHA) : Number(DISABLED_ALPHA);
        }
    }

    override protected function onDispose():void {
        this.priceLabel.dispose();
        this.priceLabel = null;
        this.actionPrice.dispose();
        this.actionPrice = null;
        this.bg = null;
        this.levelLabel = null;
        this.labelField = null;
        this.trainingLabel = null;
        this.typeSwitcher = null;
        this.border = null;
        this.clearData();
        this.clearActionPrice();
        super.onDispose();
    }

    public function setData(param1:TankmanTrainigButtonVO):void {
        if (param1.costs == null) {
            return;
        }
        this.clearData();
        this.clearActionPrice();
        this._model = new TankmanTrainingSmallButtonVO(param1.costs);
        this._isNativeVehicle = param1.isNativeVehicle;
        this._specializationLevel = param1.specializationLevel;
        this._minGroupSpecializationLevel = param1.minGroupSpecializationLevel;
        this.level = this.calculateCurrentLevel(param1.isNativeType, param1.specializationLevel, this._model.baseRoleLoss, this._model.classChangeRoleLoss, this._model.roleLevel);
        this._hasMoney = !!this._model.isPremium ? param1.gold >= this._model.gold : param1.credits >= this._model.credits;
        enabled = this.isEnabled();
        this.buy = this._isNativeVehicle && this._minGroupSpecializationLevel >= this.level;
        this.nation = param1.nationID;
        this.retraining = !param1.isNativeVehicle;
        var _loc2_:Number = !!this._model.isPremium ? Number(this._model.gold) : Number(this._model.credits);
        this.price = _loc2_.toString();
        if (param1.actionPriceData) {
            this._actionPriceVo = new ActionPriceVO(param1.actionPriceData);
            this._actionPriceVo.ico = this.getIcoOfButtonType();
        }
        this.actionPrice.setData(this._actionPriceVo);
        this.actionPrice.textColorType = !!this._hasMoney ? ActionPrice.TEXT_COLOR_TYPE_ICON : ActionPrice.TEXT_COLOR_TYPE_ERROR;
        this.priceLabel.visible = !this.actionPrice.visible;
        this.type = this._type;
        invalidate();
    }

    public function setDataForDropSkills(param1:Number, param2:Boolean, param3:ActionPriceVO):void {
        if (!isNaN(param1)) {
            this.price = param1.toString();
        }
        enabled = this._hasMoney = param2;
        var _loc4_:String = !param2 ? ComponentState.DISABLED : NORMAL_STATE;
        this.priceLabel.textColor = PRICE_COLORS[_loc4_];
        this.actionPrice.textColorType = !!param2 ? ActionPrice.TEXT_COLOR_TYPE_ICON : ActionPrice.TEXT_COLOR_TYPE_ERROR;
        if (param3) {
            param3.ico = this.getIcoOfButtonType();
        }
        this.actionPrice.setData(param3);
        this.priceLabel.visible = !this.actionPrice.visible;
    }

    protected function isEnabled():Boolean {
        return !!this._isNativeVehicle ? this._minGroupSpecializationLevel < this.level && this._hasMoney : Boolean(this._hasMoney);
    }

    protected function calculateCurrentLevel(param1:Boolean, param2:Number, param3:Number, param4:Number, param5:Number):Number {
        var _loc6_:Number = NaN;
        var _loc7_:Number = NaN;
        if (param1) {
            _loc6_ = param2 - Math.floor(param2 * param3);
        }
        else {
            _loc7_ = param3 + param4;
            _loc6_ = param2 - Math.floor(param2 * _loc7_);
        }
        _loc6_ = _loc6_ < param5 ? Number(param5) : Number(_loc6_);
        return _loc6_;
    }

    private function clearActionPrice():void {
        if (this._actionPriceVo) {
            this._actionPriceVo.dispose();
            this._actionPriceVo = null;
        }
    }

    private function clearData():void {
        if (this._model) {
            this._model.dispose();
            this._model = null;
        }
    }

    private function getIcoOfButtonType():String {
        return this._type == TrainingType.FREE ? "" : this._type == TrainingType.ACADEMY ? IconsTypes.GOLD : IconsTypes.CREDITS;
    }

    private function setTextColorToPriceLabel():void {
        var _loc1_:String = null;
        var _loc2_:String = null;
        if (this._model == null || !this._minGroupSpecializationLevel || !this.priceLabel) {
            return;
        }
        if (this._isNativeVehicle) {
            if (this._minGroupSpecializationLevel >= this.level) {
                this.priceLabel.textColor = PRICE_COLORS["buy"];
                this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_DISABLE;
            }
            else {
                _loc1_ = !this._hasMoney ? ComponentState.DISABLED : NORMAL_STATE;
                this.priceLabel.textColor = PRICE_COLORS[_loc1_];
                this.actionPrice.textColorType = !!this._hasMoney ? ActionPrice.TEXT_COLOR_TYPE_ICON : ActionPrice.TEXT_COLOR_TYPE_ERROR;
            }
        }
        else if (!this._hasMoney) {
            this.priceLabel.textColor = PRICE_COLORS[ComponentState.DISABLED];
            this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ERROR;
        }
        else {
            _loc2_ = !!enabled ? NORMAL_STATE : ComponentState.DISABLED;
            this.priceLabel.textColor = PRICE_COLORS[_loc2_];
            this.actionPrice.textColorType = !!enabled ? ActionPrice.TEXT_COLOR_TYPE_ICON : ActionPrice.TEXT_COLOR_TYPE_DISABLE;
        }
    }

    override public function set alpha(param1:Number):void {
        if (alpha == param1) {
            return;
        }
        super.alpha = param1;
        this.border.alpha = Math.max(1, 1 / param1);
    }

    override public function set selected(param1:Boolean):void {
        var _loc2_:Boolean = false;
        if (_selected == param1) {
            return;
        }
        _selected = param1;
        if (enabled) {
            if (!_focused) {
                setState(ComponentState.TOGGLE);
            }
            else if (_pressedByKeyboard && _focusIndicator != null) {
                setState(ComponentState.KB_SELECTING);
            }
            else {
                setState(ComponentState.OVER);
            }
            if (owner) {
                _loc2_ = _selected && owner != null && checkOwnerFocused();
                setState(_loc2_ && _focusIndicator == null ? ComponentState.SELECTING : ComponentState.TOGGLE);
                displayFocus = _loc2_;
            }
        }
        else {
            setState(ComponentState.DISABLED);
        }
        invalidate(INVALIDATE_SELECTION);
    }

    public function get scopeType():String {
        return this._scopeType;
    }

    public function set scopeType(param1:String):void {
        if (this._scopeType == param1) {
            return;
        }
        this._scopeType = param1;
        invalidate(INVALIDATE_TYPE);
    }

    public function get retraining():Boolean {
        return this._retraining;
    }

    public function set retraining(param1:Boolean):void {
        if (this._retraining == param1) {
            return;
        }
        this._retraining = param1;
        invalidate(INVALIDATE_RETRAINING);
    }

    public function set nation(param1:Number):void {
        this.bg.gotoAndPlay(App.utils.nations.getNationName(param1));
    }

    public function get level():Number {
        return this._level;
    }

    public function set level(param1:Number):void {
        if (this._level == param1) {
            return;
        }
        this._level = param1;
        invalidate(INVALIDATE_LEVEL);
    }

    public function get type():String {
        return this._type;
    }

    public function set type(param1:String):void {
        if (this._type == param1) {
            return;
        }
        this._type = param1;
        invalidate(INVALIDATE_TYPE);
    }

    public function get price():String {
        return this.priceLabel.text;
    }

    public function set price(param1:String):void {
        if (this._price == param1) {
            return;
        }
        this._price = param1;
        invalidate(INVALIDATE_PRICE);
    }

    public function get buy():Boolean {
        return this._buy;
    }

    public function set buy(param1:Boolean):void {
        if (this._buy == param1) {
            return;
        }
        this._buy = param1;
        if (this._buy) {
            if (this._isNativeVehicle) {
                setState(ComponentState.DISABLED);
            }
            else {
                setState(!!this._hasMoney ? ComponentState.UP : ComponentState.DISABLED);
            }
        }
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        super.handleMouseRollOver(param1);
        if (!param1.buttonDown && enabled) {
            setState(ComponentState.OVER);
        }
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        super.handleMouseRollOut(param1);
        if (!param1.buttonDown && enabled) {
            setState(ComponentState.OUT);
        }
    }
}
}
