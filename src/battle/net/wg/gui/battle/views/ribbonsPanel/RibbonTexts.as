package net.wg.gui.battle.views.ribbonsPanel {
import flash.display.MovieClip;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.utils.Dictionary;

import net.wg.gui.battle.views.ribbonsPanel.data.PaddingSettings;
import net.wg.gui.battle.views.ribbonsPanel.data.RibbonSettings;
import net.wg.gui.battle.views.ribbonsPanel.data.RibbonTextSettings;
import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.utils.ICommons;

public class RibbonTexts extends MovieClip implements IDisposable {

    private static const EMPTY_STR:String = "";

    private static const VEH_COUNTER_X_PADDING:Number = -17;

    private static const VALUE_DEFAULT_WIDTH:Number = 80;

    private static const UPDATE_FRAME_LBL:String = "update";

    public var countVehAnim:MovieClip = null;

    public var valueAnim:MovieClip = null;

    public var ribbonNameTF:TextField = null;

    public var vNameTF:TextField = null;

    private var _countVehiclesTF:TextField = null;

    private var _valueTF:TextField = null;

    private var _vNameIsVisible:Boolean = false;

    private var _valueIsVisible:Boolean = false;

    private var _countVehiclesIsVisible:Boolean = false;

    private var _vNameValue:String = "";

    private var _value:String = "";

    private var _countVehicles:String = "";

    private var _common:ICommons = null;

    private var _isWithVehName:Boolean = false;

    private var _valuePadding:Number = 0;

    private var _vehicleNamePosX:Number = 0;

    private var _iconPaddings:Dictionary = null;

    public function RibbonTexts() {
        super();
        this._common = App.utils.commons;
        this.valueAnim.stop();
        this.countVehAnim.stop();
        this.valueAnim.visible = false;
        this.countVehAnim.visible = false;
        this._valueTF = this.valueAnim.wrapper.tf;
        this._countVehiclesTF = this.countVehAnim.wrapper.tf;
        this._countVehiclesTF.autoSize = TextFieldAutoSize.LEFT;
        this._valueTF.autoSize = TextFieldAutoSize.LEFT;
        this.ribbonNameTF.autoSize = TextFieldAutoSize.LEFT;
        this._valueTF.autoSize = TextFieldAutoSize.LEFT;
        this._countVehiclesTF.autoSize = TextFieldAutoSize.LEFT;
        this._iconPaddings = RibbonSettings.ICON_X_PADDINGS;
    }

    public final function dispose():void {
        this._iconPaddings = null;
        this.ribbonNameTF = null;
        this.vNameTF = null;
        this._valueTF = null;
        this._countVehiclesTF = null;
        this.countVehAnim = null;
        this.valueAnim = null;
        this._common = null;
    }

    public function init(param1:RibbonSettings):void {
        var _loc3_:TextField = null;
        this.ribbonNameTF.text = param1.ribbonText;
        var _loc2_:Vector.<TextField> = new <TextField>[this._valueTF, this._countVehiclesTF];
        var _loc4_:int = _loc2_.length;
        var _loc5_:RibbonTextSettings = param1.textSettings;
        var _loc6_:int = 0;
        while (_loc6_ < _loc4_) {
            _loc3_ = _loc2_[_loc6_];
            _loc3_.textColor = _loc5_.valueTextColor;
            this._common.setShadowFilterWithParams(_loc3_, RibbonTextSettings.SHADOW_DISTANCE, RibbonTextSettings.SHADOW_DISTANCE, _loc5_.shadowColor, RibbonTextSettings.SHADOW_ALPHA, RibbonTextSettings.SHADOW_BLUR, RibbonTextSettings.SHADOW_BLUR, RibbonTextSettings.SHADOW_STRENGTH);
            _loc6_++;
        }
        this._common.setShadowFilterWithParams(this.ribbonNameTF, RibbonTextSettings.SHADOW_DISTANCE, RibbonTextSettings.SHADOW_DISTANCE, _loc5_.shadowColor, RibbonTextSettings.SHADOW_ALPHA, RibbonTextSettings.SHADOW_BLUR, RibbonTextSettings.SHADOW_BLUR, RibbonTextSettings.SHADOW_STRENGTH);
        this.ribbonNameTF.textColor = _loc5_.ribbonNameTextColor;
        var _loc7_:int = this.ribbonNameTF.x + this.ribbonNameTF.textWidth;
        this.countVehAnim.x = _loc7_ + VEH_COUNTER_X_PADDING;
        this.countVehAnim.gotoAndStop(this.countVehAnim.totalFrames - 1);
        this.valueAnim.gotoAndStop(this.valueAnim.totalFrames - 1);
    }

    public function setData(param1:String, param2:String, param3:String, param4:String):void {
        var _loc5_:* = false;
        var _loc6_:* = false;
        var _loc7_:* = false;
        if (this._vNameValue != param1) {
            this._vNameValue = param1;
            if (this._isWithVehName) {
                _loc5_ = param1 != EMPTY_STR;
                if (this._vNameIsVisible != _loc5_) {
                    this._vNameIsVisible = _loc5_;
                    this.vNameTF.visible = _loc5_;
                }
                if (_loc5_) {
                    this.vNameTF.text = param1;
                    this.vNameTF.x = this._vehicleNamePosX + (this._iconPaddings[param4] << 1);
                }
            }
        }
        if (this._value != param2) {
            this._value = param2;
            _loc6_ = param2 != EMPTY_STR;
            if (this._valueIsVisible != _loc6_) {
                this._valueIsVisible = _loc6_;
                this.valueAnim.visible = _loc6_;
            }
            if (_loc6_) {
                this._valueTF.text = param2;
                this.valueAnim.x = VALUE_DEFAULT_WIDTH - this._valueTF.textWidth + this._valuePadding;
            }
        }
        if (this._countVehicles != param3) {
            this._countVehicles = param3;
            _loc7_ = param3 != EMPTY_STR;
            if (this._countVehiclesIsVisible != _loc7_) {
                this._countVehiclesIsVisible = _loc7_;
                this.countVehAnim.visible = _loc7_;
            }
            if (_loc7_) {
                this._countVehiclesTF.text = param3;
            }
        }
    }

    public function setSettings(param1:Boolean, param2:Boolean, param3:Boolean):void {
        var _loc5_:int = 0;
        var _loc4_:PaddingSettings = RibbonSettings.getPaddings(param2, param3);
        this._isWithVehName = param3;
        this._valuePadding = _loc4_.valuePaddingX;
        this._vNameIsVisible = this._isWithVehName;
        if (this._isWithVehName) {
            this._vNameIsVisible = this._vNameValue != EMPTY_STR;
            this.vNameTF.text = this._vNameValue;
        }
        this.vNameTF.visible = this._vNameIsVisible;
        this.ribbonNameTF.visible = param2;
        if (param2) {
            _loc5_ = this.ribbonNameTF.x + this.ribbonNameTF.textWidth;
        }
        else {
            _loc5_ = this.ribbonNameTF.x;
        }
        _loc5_ = _loc5_ + _loc4_.tankNamePaddingX;
        this._vehicleNamePosX = _loc5_;
        this.vNameTF.x = _loc5_;
        this.countVehAnim.x = _loc5_ + this.vNameTF.textWidth + VEH_COUNTER_X_PADDING;
        if (!param1) {
            this.countVehAnim.gotoAndStop(this.countVehAnim.totalFrames - 1);
            this.valueAnim.gotoAndPlay(this.valueAnim.totalFrames - 1);
        }
    }

    public function showUpdateAnim():void {
        if (this._countVehiclesIsVisible) {
            this.countVehAnim.gotoAndPlay(1);
        }
        if (this._valueIsVisible) {
            this.valueAnim.gotoAndPlay(UPDATE_FRAME_LBL);
        }
    }
}
}
