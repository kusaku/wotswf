package net.wg.gui.lobby.window {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.text.TextField;
import flash.text.TextLineMetrics;

import net.wg.data.constants.ValObject;
import net.wg.data.constants.generated.FITTING_TYPES;
import net.wg.gui.components.advanced.ExtraModuleIcon;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.lobby.hangar.data.ModuleInfoActionVO;
import net.wg.gui.lobby.moduleInfo.ModuleEffects;
import net.wg.gui.lobby.moduleInfo.ModuleParameters;
import net.wg.infrastructure.base.meta.IModuleInfoMeta;
import net.wg.infrastructure.base.meta.impl.ModuleInfoMeta;
import net.wg.utils.IClassFactory;

import scaleform.clik.core.UIComponent;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.utils.Padding;

public class ModuleInfo extends ModuleInfoMeta implements IModuleInfoMeta {

    private static const BOTTOM_PADDING:uint = 15;

    private static const MIDDLE_PADDING:uint = 5;

    protected static const TF_GUTTER:int = 4;

    public var moduleIcon:ExtraModuleIcon;

    public var moduleName:TextField;

    public var moduleDescription:TextField;

    public var moduleParams:ModuleParameters;

    public var moduleEffects:ModuleEffects;

    public var closeBottomBtn:SoundButtonEx;

    public var actionButtonBottom:SoundButtonEx;

    private var addedChildren:Array;

    private var _moduleInfo:Object;

    public function ModuleInfo() {
        super();
        this.addedChildren = [];
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(this.closeBottomBtn);
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.closeBottomBtn.addEventListener(ButtonEvent.CLICK, this.onClose);
        this.actionButtonBottom.addEventListener(ButtonEvent.CLICK, this.onActionClick);
        window.useBottomBtns = true;
        var _loc1_:Padding = window.contentPadding as Padding;
        _loc1_.right = _loc1_.right + 10;
        window.contentPadding = _loc1_;
    }

    override protected function onDispose():void {
        var _loc1_:DisplayObject = null;
        if (this.moduleIcon != null) {
            this.moduleIcon.dispose();
            this.moduleIcon = null;
        }
        this.moduleName = null;
        this.moduleDescription = null;
        if (this.moduleParams != null) {
            this.moduleParams.dispose();
            this.moduleParams = null;
        }
        if (this.moduleEffects != null) {
            this.moduleEffects.dispose();
            this.moduleEffects = null;
        }
        if (this.closeBottomBtn != null) {
            this.closeBottomBtn.removeEventListener(ButtonEvent.CLICK, this.onClose);
            this.closeBottomBtn.dispose();
            this.closeBottomBtn = null;
        }
        if (this.actionButtonBottom != null) {
            this.actionButtonBottom.removeEventListener(ButtonEvent.CLICK, this.onActionClick);
            this.actionButtonBottom.dispose();
            this.actionButtonBottom = null;
        }
        App.utils.data.cleanupDynamicObject(this._moduleInfo);
        this._moduleInfo = null;
        for each(_loc1_ in this.addedChildren) {
            removeChild(_loc1_);
            if (_loc1_ is UIComponent) {
                (_loc1_ as UIComponent).dispose();
            }
        }
        this.addedChildren.splice(0);
        this.addedChildren = null;
        super.onDispose();
    }

    override protected function setActionButton(param1:ModuleInfoActionVO):void {
        var _loc2_:Boolean = false;
        _loc2_ = param1.visible;
        this.actionButtonBottom.visible = _loc2_;
        if (_loc2_) {
            this.actionButtonBottom.label = param1.label;
        }
    }

    public function as_setModuleInfo(param1:Object):void {
        window.title = param1.windowTitle;
        this.moduleInfo = param1;
    }

    public function get moduleInfo():Object {
        return this._moduleInfo;
    }

    public function set moduleInfo(param1:Object):void {
        var _loc2_:String = null;
        var _loc3_:Number = NaN;
        var _loc4_:uint = 0;
        var _loc5_:int = 0;
        var _loc6_:Boolean = false;
        var _loc7_:Number = NaN;
        var _loc8_:String = null;
        var _loc9_:int = 0;
        var _loc10_:Class = null;
        var _loc11_:ModuleParameters = null;
        var _loc12_:Object = null;
        var _loc13_:Object = null;
        var _loc14_:IClassFactory = null;
        var _loc15_:MovieClip = null;
        var _loc16_:TextField = null;
        var _loc17_:TextLineMetrics = null;
        var _loc18_:int = 0;
        var _loc19_:MovieClip = null;
        var _loc20_:TextField = null;
        this._moduleInfo = param1;
        if (this.moduleInfo) {
            _loc2_ = this.moduleInfo.type;
            this.moduleName.text = this.moduleInfo.name;
            _loc3_ = 0;
            if (_loc2_ == FITTING_TYPES.EQUIPMENT) {
                this.moduleDescription.text = "";
            }
            else {
                this.moduleDescription.text = this.moduleInfo.description;
                _loc3_ = this.moduleDescription.textHeight - this.moduleDescription.height + TF_GUTTER;
                if (_loc3_ > 0) {
                    this.moduleDescription.height = this.moduleDescription.height + _loc3_;
                    this.moduleParams.y = this.moduleParams.y + _loc3_;
                    this.moduleEffects.y = this.moduleEffects.y + _loc3_;
                }
            }
            this.moduleIcon.setValueLabel(this.moduleInfo.moduleLabel, this.moduleInfo.moduleLevel);
            this.moduleIcon.extraIconSource = this.moduleInfo[ValObject.EXTRA_MODULE_INFO];
            this.moduleParams.headerText = this.moduleInfo.parameters.headerText;
            this.moduleParams.setParameters(this.moduleInfo.parameters.params);
            this.moduleEffects.setEffects(this.moduleInfo.effects);
            _loc4_ = this.moduleParams.y + this.moduleParams.height;
            if (_loc2_ == FITTING_TYPES.VEHICLE_GUN) {
                _loc8_ = "otherParameters";
                if (this.moduleInfo.hasOwnProperty(_loc8_)) {
                    _loc9_ = 10;
                    _loc10_ = Object(this.moduleParams).constructor;
                    _loc11_ = new _loc10_();
                    _loc12_ = this.moduleInfo[_loc8_];
                    _loc11_.y = _loc4_;
                    _loc11_.x = this.moduleParams.x;
                    _loc11_.height = 45;
                    addChild(_loc11_);
                    this.addedChildren.push(_loc11_);
                    _loc11_.headerText = _loc12_.headerText;
                    _loc11_.setParameters(_loc12_.params);
                    _loc4_ = _loc11_.y + _loc11_.actualHeight + _loc9_;
                }
            }
            _loc5_ = this.moduleInfo.compatible.length;
            _loc6_ = this.moduleInfo.hasOwnProperty("additionalInfo");
            if (_loc5_ > 0) {
                _loc14_ = App.utils.classFactory;
                for each(_loc13_ in this.moduleInfo.compatible) {
                    _loc15_ = _loc14_.getComponent("ModuleCompatibilityMC", MovieClip) as MovieClip;
                    _loc15_.x = this.moduleParams.x;
                    _loc15_.y = _loc4_;
                    addChild(_loc15_);
                    this.addedChildren.push(_loc15_);
                    _loc15_.header.text = _loc13_.type;
                    _loc16_ = _loc15_.compValue;
                    _loc16_.htmlText = _loc13_.value;
                    _loc17_ = _loc16_.getLineMetrics(0);
                    _loc18_ = _loc17_.leading + _loc17_.descent;
                    _loc16_.height = _loc16_.textHeight + _loc18_;
                    _loc4_ = _loc4_ + (_loc15_.height + (!!_loc6_ ? MIDDLE_PADDING : BOTTOM_PADDING));
                }
            }
            if (_loc6_) {
                _loc19_ = _loc14_.getComponent("additionalInfoUI", MovieClip) as MovieClip;
                _loc19_.x = this.moduleParams.x;
                _loc19_.y = _loc4_;
                _loc20_ = _loc19_.textField;
                _loc20_.text = this.moduleInfo.additionalInfo;
                addChild(_loc19_);
                this.addedChildren.push(_loc19_);
                _loc4_ = _loc4_ + (_loc19_.height + BOTTOM_PADDING);
            }
            _loc7_ = this.moduleEffects.y + this.moduleEffects.height;
            if (_loc4_ < _loc7_) {
                _loc4_ = _loc7_;
            }
            this.closeBottomBtn.y = _loc4_ + MIDDLE_PADDING;
            this.actionButtonBottom.y = this.closeBottomBtn.y;
            height = _loc4_ + this.closeBottomBtn.height + MIDDLE_PADDING;
        }
    }

    private function onClose(param1:ButtonEvent):void {
        onCancelClickS();
    }

    private function onActionClick(param1:ButtonEvent):void {
        onActionButtonClickS();
    }
}
}
