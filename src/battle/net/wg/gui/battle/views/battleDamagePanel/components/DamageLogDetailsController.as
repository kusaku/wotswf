package net.wg.gui.battle.views.battleDamagePanel.components {
import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.display.Sprite;
import flash.filters.BitmapFilterQuality;
import flash.filters.DropShadowFilter;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import net.wg.data.constants.AtlasConstants;
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.BATTLEDAMAGELOG_IMAGES;
import net.wg.gui.battle.views.battleDamagePanel.constants.BattleDamageLogConstants;
import net.wg.gui.battle.views.battleDamagePanel.models.MessageRenderModel;
import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.infrastructure.managers.IAtlasManager;

public class DamageLogDetailsController implements IDisposable {

    private static const TF_HEIGHT:int = 22;

    private static const TF_WIDTH:int = 100;

    private static const SHADOW_COLOR:uint = 0;

    private static const FONT_NAME:String = "$FieldFont";

    private static const TF_VALUES_COLOR:uint = 65280;

    private static const TF_VEHICLE_NAME_COLOR:uint = 16777215;

    private static const DEFAULT_TEXT_SIZE:int = 14;

    private static const ACTION_TYPE_X_POS:int = 46;

    private static const VEHICLE_TYPE_X_POS:Number = 64;

    private static const VEHICLE_NAME_TF_X_POS:Number = 110;

    private static const VALUES_TF_X_POS:Number = 5;

    private static const CONTAINERS_Y_POS:int = 65;

    private static const TF_PADDING:int = 3;

    private var _visibleCountItems:int = 0;

    private var _scrollPosition:int = 0;

    private var _totalFilledData:int = 0;

    private var _isCreatedPool:Boolean = false;

    private var _poolData:Vector.<MessageRenderModel> = null;

    private var _lastYValue:int = -22;

    private var _damageLogDetailsImages:DamageLogDetailsImages = null;

    private var _damageLogDetailsText:DamageLogDetailsText = null;

    private var _atlasManager:IAtlasManager = null;

    private var _isDetailsInited:Boolean = false;

    private var _visibilityRowsCount:int = 7;

    private var _ctrlButton:Boolean = false;

    private var _lastAdditionalRowsCount:int = 0;

    private var _constVisibleRowsCount:int = 7;

    private var _shadowFilter:DropShadowFilter = null;

    private var _vehicleNameTextFormat:TextFormat = null;

    private var _valuesTextFormat:TextFormat = null;

    public function DamageLogDetailsController(param1:DamageLogDetailsImages, param2:DamageLogDetailsText) {
        super();
        this._atlasManager = App.atlasMgr;
        this._damageLogDetailsImages = param1;
        this._damageLogDetailsImages.y = CONTAINERS_Y_POS;
        this._damageLogDetailsText = param2;
        this._damageLogDetailsText.y = CONTAINERS_Y_POS;
        this._shadowFilter = new DropShadowFilter(0, 45, SHADOW_COLOR, 1, 2, 2, 1, BitmapFilterQuality.MEDIUM);
        this._valuesTextFormat = this.makeTextFormat(TF_VALUES_COLOR, TextFormatAlign.RIGHT);
        this._vehicleNameTextFormat = this.makeTextFormat(TF_VEHICLE_NAME_COLOR, TextFormatAlign.LEFT);
    }

    public function addAdditionalRows(param1:int):void {
        var _loc2_:int = 0;
        var _loc3_:Function = null;
        if (param1 > this._lastAdditionalRowsCount) {
            _loc2_ = param1 - this._lastAdditionalRowsCount;
            _loc3_ = this.increaseContainerYPosition;
        }
        else if (param1 < this._lastAdditionalRowsCount) {
            _loc2_ = this._lastAdditionalRowsCount - param1;
            _loc3_ = this.decreaseContainerYPosition;
        }
        var _loc4_:int = 0;
        while (_loc4_ < _loc2_) {
            _loc3_(BattleDamageLogConstants.RENDER_STEP_SIZE);
            _loc4_++;
        }
        this._lastAdditionalRowsCount = param1;
    }

    public function addDetailsMessage(param1:uint, param2:String, param3:String, param4:String, param5:String):void {
        var _loc6_:MessageRenderModel = new MessageRenderModel();
        _loc6_.valueColor = param1;
        _loc6_.value = param2;
        _loc6_.actionTypeImg = param3;
        _loc6_.vehicleTypeImg = param4;
        _loc6_.vehicleName = param5;
        this.fillNextData(_loc6_);
    }

    public function detailsStats(param1:Boolean, param2:Array):void {
        var _loc4_:Object = null;
        var _loc5_:MessageRenderModel = null;
        this.clearData();
        var _loc3_:int = this._lastAdditionalRowsCount;
        this._lastAdditionalRowsCount = 0;
        this.addAdditionalRows(_loc3_);
        this._isDetailsInited = true;
        this._poolData = new Vector.<MessageRenderModel>();
        this.makeEmptyPoolObjects();
        if (param2 && param2.length > 0) {
            for each(_loc4_ in param2) {
                _loc5_ = new MessageRenderModel();
                _loc5_.valueColor = _loc4_.valueColor;
                _loc5_.value = _loc4_.value;
                _loc5_.actionTypeImg = _loc4_.actionTypeImg;
                _loc5_.vehicleTypeImg = _loc4_.vehicleTypeImg;
                _loc5_.vehicleName = _loc4_.vehicleName;
                this.fillNextData(_loc5_);
            }
        }
        this.changeContainerVisibility(param1);
    }

    public function dispose():void {
        this.clearData();
        this._shadowFilter = null;
        this._vehicleNameTextFormat = null;
        this._valuesTextFormat = null;
        this._damageLogDetailsImages = null;
        this._damageLogDetailsText = null;
        this._atlasManager = null;
    }

    public function isDownAltButton(param1:Boolean):void {
        this.changeContainerVisibility(param1);
        this.reflowRowCount();
    }

    public function isDownCtrlButton(param1:Boolean):void {
        this._ctrlButton = param1;
        this.ctrlButton();
    }

    public function reflowRowCount():void {
        var _loc4_:MessageRenderModel = null;
        var _loc1_:int = 0;
        var _loc2_:int = this._poolData.length - 1;
        var _loc3_:int = _loc2_;
        while (_loc3_ >= 0) {
            _loc4_ = this._poolData[_loc3_];
            if (!(_loc4_.isEmptyImageData && _loc4_.isEmptyTextData)) {
                _loc1_++;
                if (_loc1_ > this._visibilityRowsCount) {
                    this.changeVisibleProperty(_loc4_, false);
                }
                else {
                    this.changeVisibleProperty(_loc4_, true);
                }
                if (this._scrollPosition < this._totalFilledData) {
                    this.scrollItems(1);
                }
            }
            _loc3_--;
        }
        this._visibleCountItems = Math.min(this._visibilityRowsCount, this._totalFilledData);
    }

    public function scroll(param1:int):void {
        if (!this._ctrlButton) {
            return;
        }
        this.scrollItems(param1);
    }

    public function setDetailsCount(param1:int, param2:int):void {
        if (this._visibilityRowsCount == param1 + param2) {
            return;
        }
        this._constVisibleRowsCount = param1;
        this._visibilityRowsCount = this._constVisibleRowsCount + param2;
        if (this._isDetailsInited) {
            this.reflowRowCount();
        }
    }

    private function makeTextFormat(param1:uint, param2:String):TextFormat {
        var _loc3_:TextFormat = new TextFormat();
        _loc3_.font = FONT_NAME;
        _loc3_.size = DEFAULT_TEXT_SIZE;
        _loc3_.color = param1;
        _loc3_.align = param2;
        return _loc3_;
    }

    private function canShow():Boolean {
        return this._scrollPosition == this._totalFilledData;
    }

    private function changeVisibleProperty(param1:MessageRenderModel, param2:Boolean):void {
        param1.imageRenderInstance.visible = param2;
        param1.textRendererInstance.visible = param2;
    }

    private function updateVisibility(param1:MessageRenderModel, param2:MessageRenderModel):void {
        param1.textRendererInstance.visible = true;
        param1.imageRenderInstance.visible = true;
        param2.imageRenderInstance.visible = false;
        param2.textRendererInstance.visible = false;
    }

    private function makePool():void {
        var _loc3_:MessageRenderModel = null;
        var _loc1_:int = BattleDamageLogConstants.DEFAULT_POOL_COUNT;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            _loc3_ = new MessageRenderModel();
            this.makeEmptyPoolElements(_loc3_);
            this._poolData.push(_loc3_);
            _loc2_++;
        }
    }

    private function makeEmptyPoolElements(param1:MessageRenderModel):void {
        var _loc2_:Shape = new Shape();
        var _loc3_:Shape = new Shape();
        var _loc4_:Shape = new Shape();
        var _loc5_:Sprite = new Sprite();
        _loc5_.visible = false;
        _loc5_.addChild(_loc2_);
        _loc5_.addChild(_loc3_);
        _loc5_.addChild(_loc4_);
        this._damageLogDetailsImages.addChild(_loc5_);
        this._atlasManager.drawGraphics(AtlasConstants.BATTLE_ATLAS, BATTLEDAMAGELOG_IMAGES.DAMAGELOG_DAMAGE_DETAIL, _loc2_.graphics, "");
        param1.imageRenderInstance = _loc5_;
        param1.bgImageInstance = _loc2_;
        param1.actionTypeInstance = _loc3_;
        param1.vehicleIconInstance = _loc4_;
        var _loc6_:Sprite = new Sprite();
        _loc6_.visible = false;
        var _loc7_:TextField = this.configureTextField(this._valuesTextFormat, TextFieldAutoSize.RIGHT);
        _loc7_.y = _loc2_.height - _loc7_.height >> 1;
        _loc7_.x = VALUES_TF_X_POS;
        var _loc8_:TextField = this.configureTextField(this._vehicleNameTextFormat, TextFieldAutoSize.LEFT);
        _loc8_.y = _loc2_.height - _loc8_.height >> 1;
        _loc8_.x = VEHICLE_NAME_TF_X_POS;
        _loc6_.addChild(_loc7_);
        _loc6_.addChild(_loc8_);
        this._damageLogDetailsText.addChild(_loc6_);
        param1.textRendererInstance = _loc6_;
        param1.valueTFInstance = _loc7_;
        param1.vehicleNameTFInstance = _loc8_;
        _loc5_.y = _loc5_.y + this._lastYValue;
        _loc6_.y = _loc6_.y + this._lastYValue;
        param1.renderInstanceYPosition = _loc5_.y ^ 0;
        this._lastYValue = this._lastYValue + BattleDamageLogConstants.RENDER_STEP_SIZE;
    }

    private function ctrlButton():void {
        if (!this._ctrlButton && this._scrollPosition < this._totalFilledData) {
            this.reflowRowCount();
        }
    }

    private function changeContainerVisibility(param1:Boolean):void {
        this._damageLogDetailsImages.visible = param1;
        this._damageLogDetailsText.visible = param1;
    }

    private function clearData():void {
        var _loc1_:MessageRenderModel = null;
        for each(_loc1_ in this._poolData) {
            _loc1_.dispose();
        }
        this._poolData = null;
        this.removeViewElements(this._damageLogDetailsImages);
        this.removeViewElements(this._damageLogDetailsText);
        this._damageLogDetailsImages.y = CONTAINERS_Y_POS;
        this._damageLogDetailsText.y = CONTAINERS_Y_POS;
        this._visibleCountItems = 0;
        this._totalFilledData = 0;
        this._isCreatedPool = false;
        this._visibleCountItems = 0;
        this._scrollPosition = 0;
        this._totalFilledData = 0;
        this._isCreatedPool = false;
        this._lastYValue = BattleDamageLogConstants.RENDER_STEP_SIZE;
        this._isDetailsInited = false;
    }

    private function removeViewElements(param1:DisplayObjectContainer):void {
        while (param1.numChildren > 0) {
            param1.removeChildAt(0);
        }
    }

    private function fillNextData(param1:MessageRenderModel):void {
        var _loc6_:MessageRenderModel = null;
        var _loc7_:String = null;
        var _loc8_:String = null;
        var _loc9_:Shape = null;
        var _loc10_:Shape = null;
        var _loc11_:TextField = null;
        var _loc12_:TextFormat = null;
        var _loc13_:TextField = null;
        var _loc14_:MessageRenderModel = null;
        var _loc2_:Boolean = true;
        var _loc3_:Boolean = this.canShow();
        var _loc4_:int = this._poolData.length;
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_) {
            _loc6_ = this._poolData[_loc5_];
            if (_loc6_.isEmptyImageData) {
                _loc7_ = param1.vehicleTypeImg;
                _loc8_ = param1.actionTypeImg;
                _loc9_ = _loc6_.actionTypeInstance;
                this._atlasManager.drawGraphics(AtlasConstants.BATTLE_ATLAS, _loc8_, _loc9_.graphics, "");
                _loc9_.y = _loc6_.bgImageInstance.height - _loc9_.height >> 1;
                _loc9_.x = ACTION_TYPE_X_POS;
                _loc10_ = _loc6_.vehicleIconInstance;
                if (_loc7_ != Values.EMPTY_STR) {
                    this._atlasManager.drawGraphics(AtlasConstants.BATTLE_ATLAS, _loc7_, _loc10_.graphics, "");
                }
                _loc10_.y = _loc6_.bgImageInstance.height - _loc9_.height >> 1;
                _loc10_.x = VEHICLE_TYPE_X_POS;
                _loc6_.imageRenderInstance.visible = _loc3_;
                _loc6_.isEmptyImageData = false;
                _loc6_.actionTypeImg = _loc8_;
                _loc6_.vehicleTypeImg = _loc7_;
                this._visibleCountItems++;
                this._totalFilledData++;
                _loc11_ = _loc6_.valueTFInstance;
                _loc12_ = _loc11_.getTextFormat();
                _loc12_.color = param1.valueColor;
                _loc11_.defaultTextFormat = _loc12_;
                _loc11_.text = param1.value;
                _loc11_.x = _loc9_.x - _loc11_.width - TF_PADDING ^ 0;
                _loc13_ = _loc6_.vehicleNameTFInstance;
                _loc13_.text = param1.vehicleName;
                _loc13_.x = _loc10_.x + (_loc10_.width ^ 0);
                _loc6_.isEmptyTextData = false;
                _loc6_.textRendererInstance.visible = _loc3_;
                _loc6_.value = param1.value;
                _loc6_.vehicleName = param1.vehicleName;
                _loc2_ = false;
                if (_loc3_) {
                    if (this._visibleCountItems > this._visibilityRowsCount) {
                        this._visibleCountItems = this._visibilityRowsCount;
                        _loc14_ = this._poolData[_loc5_ - this._visibilityRowsCount];
                        _loc14_.imageRenderInstance.visible = false;
                        _loc14_.textRendererInstance.visible = false;
                    }
                    this._scrollPosition++;
                    this.increaseContainerYPosition(BattleDamageLogConstants.RENDER_STEP_SIZE * -1);
                }
                break;
            }
            _loc5_++;
        }
        if (_loc2_) {
            this.makePool();
            this.fillNextData(param1);
        }
    }

    private function increaseContainerYPosition(param1:int):void {
        this._damageLogDetailsImages.y = this._damageLogDetailsImages.y + param1;
        this._damageLogDetailsText.y = this._damageLogDetailsText.y + param1;
    }

    private function decreaseContainerYPosition(param1:int):void {
        this._damageLogDetailsImages.y = this._damageLogDetailsImages.y - param1;
        this._damageLogDetailsText.y = this._damageLogDetailsText.y - param1;
    }

    private function scrollItems(param1:int):void {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        var _loc4_:* = false;
        var _loc5_:int = 0;
        var _loc6_:* = false;
        if (param1 > 0) {
            _loc2_ = this._scrollPosition - this._visibilityRowsCount;
            _loc3_ = _loc2_ >= 0 ? int(_loc2_) : 0;
            _loc4_ = this._scrollPosition < this._totalFilledData;
            if (_loc4_) {
                this.updateVisibility(this._poolData[this._scrollPosition], this._poolData[_loc3_]);
                this._scrollPosition++;
                this.decreaseContainerYPosition(BattleDamageLogConstants.RENDER_STEP_SIZE);
            }
        }
        else {
            _loc5_ = this._scrollPosition - this._visibilityRowsCount;
            _loc6_ = _loc5_ > 0;
            if (_loc6_) {
                this.updateVisibility(this._poolData[_loc5_ - 1], this._poolData[this._scrollPosition - 1]);
                this._scrollPosition--;
                this.increaseContainerYPosition(BattleDamageLogConstants.RENDER_STEP_SIZE);
            }
        }
    }

    private function makeEmptyPoolObjects():void {
        if (!this._isCreatedPool) {
            this._isCreatedPool = true;
            this.makePool();
        }
    }

    private function configureTextField(param1:TextFormat, param2:String):TextField {
        var _loc3_:TextField = new TextField();
        _loc3_.embedFonts = false;
        _loc3_.width = TF_WIDTH;
        _loc3_.mouseEnabled = false;
        _loc3_.autoSize = param2;
        _loc3_.multiline = false;
        _loc3_.defaultTextFormat = param1;
        _loc3_.filters = [this._shadowFilter];
        _loc3_.height = TF_HEIGHT;
        return _loc3_;
    }
}
}
