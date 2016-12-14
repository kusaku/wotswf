package net.wg.gui.lobby.vehicleCustomization {
import flash.display.DisplayObject;

import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.interfaces.IDataProvider;

public class CustomizationSlotsPanel extends UIComponentEx {

    private var _gap:int = 0;

    private var _renderersData:IDataProvider = null;

    private var _renderers:Vector.<ISlotsPanelRenderer> = null;

    private var _itemRendererName:String = "";

    private var _ownerId:int = -1;

    public function CustomizationSlotsPanel() {
        super();
    }

    override protected function draw():void {
        var _loc1_:ISlotsPanelRenderer = null;
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        super.draw();
        if (this._renderersData != null && isInvalid(InvalidationType.DATA)) {
            if (this._renderers == null) {
                this._renderers = new Vector.<ISlotsPanelRenderer>();
            }
            _loc1_ = null;
            _loc2_ = this._renderersData.length;
            _loc3_ = this._renderers.length;
            _loc4_ = 0;
            _loc4_ = 0;
            while (_loc4_ < _loc2_) {
                if (_loc4_ < _loc3_) {
                    this._renderers[_loc4_].setData(this.getDataItem(_loc4_));
                }
                else {
                    _loc1_ = this.createNewRenderer();
                    _loc1_.ownerId = this._ownerId;
                    _loc1_.id = _loc4_;
                    _loc1_.setData(this.getDataItem(_loc4_));
                    this._renderers.push(_loc1_);
                    this.addChild(DisplayObject(_loc1_));
                }
                _loc4_++;
            }
            _loc5_ = _loc3_ - _loc2_;
            while (_loc5_ > 0) {
                _loc1_ = this._renderers.pop();
                this.removeChild(DisplayObject(_loc1_));
                _loc1_.dispose();
                _loc1_ = null;
                _loc5_--;
            }
            this._renderersData = null;
        }
        if (isInvalid(InvalidationType.SIZE)) {
            this.setRealLayout();
        }
    }

    override protected function onDispose():void {
        this.clearRenderers();
        super.onDispose();
    }

    public function setData(param1:IDataProvider):void {
        this._renderersData = param1;
        invalidateData();
        validateNow();
    }

    public function setRenderersState(param1:String):void {
        var _loc2_:ISlotsPanelRenderer = null;
        for each(_loc2_ in this._renderers) {
            _loc2_.setState(param1);
        }
    }

    public function showAllGroups():void {
        var _loc1_:ISlotsPanelRenderer = null;
        for each(_loc1_ in this._renderers) {
            _loc1_.show();
        }
        this.setRealLayout();
    }

    public function showOneGroup(param1:int):void {
        var _loc2_:int = 0;
        var _loc3_:int = this._renderers.length;
        var _loc4_:ISlotsPanelRenderer = null;
        _loc2_ = 0;
        while (_loc2_ < _loc3_) {
            _loc4_ = this._renderers[_loc2_];
            _loc4_.hide();
            _loc2_++;
        }
        this._renderers[param1].showPartly();
        this.setRealLayout();
    }

    public function updateSlot(param1:int, param2:DAAPIDataClass):void {
        if (this._renderers.length > param1) {
            this._renderers[param1].update(param2);
        }
    }

    protected function createNewRenderer():ISlotsPanelRenderer {
        return App.utils.classFactory.getComponent(this._itemRendererName, ISlotsPanelRenderer);
    }

    private function getDataItem(param1:int):DAAPIDataClass {
        return DAAPIDataClass(this._renderersData.requestItemAt(param1));
    }

    private function setRealLayout():void {
        var _loc1_:Number = NaN;
        var _loc2_:Number = NaN;
        var _loc3_:ISlotsPanelRenderer = null;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        if (this._renderers != null && this._renderers.length > 0) {
            _loc1_ = 0;
            _loc2_ = 0;
            _loc3_ = null;
            _loc4_ = 0;
            _loc5_ = this._renderers.length;
            _loc6_ = 0;
            _loc4_ = 0;
            while (_loc4_ < _loc5_) {
                _loc3_ = this._renderers[_loc4_];
                if (_loc3_.visible) {
                    _loc1_ = _loc1_ + _loc3_.width;
                    _loc1_ = _loc1_ + this._gap;
                    if (_loc2_ < _loc3_.height) {
                        _loc2_ = _loc3_.height;
                    }
                    _loc3_.x = _loc6_;
                    _loc6_ = _loc6_ + (this._gap + _loc3_.width);
                }
                _loc4_++;
            }
            if (this._renderers.length >= 0) {
                _loc1_ = _loc1_ - this._gap;
            }
            _originalWidth = _loc1_;
            _originalHeight = _loc2_;
            setActualSize(_loc1_, _loc2_);
            setActualScale(1, 1);
        }
    }

    private function clearRenderers():void {
        var _loc1_:int = 0;
        var _loc2_:int = this._renderers.length;
        var _loc3_:ISlotsPanelRenderer = null;
        _loc1_ = 0;
        while (_loc1_ < _loc2_) {
            _loc3_ = this._renderers[_loc1_];
            _loc3_.dispose();
            _loc1_++;
        }
        this._renderers.splice(0, this._renderers.length);
        this._renderers = null;
        this._renderersData = null;
    }

    public function get itemRendererName():String {
        return this._itemRendererName;
    }

    public function set itemRendererName(param1:String):void {
        if (_inspector && param1 == "" || param1 == "" || param1 == "DefaultListItemRenderer") {
            return;
        }
        this._itemRendererName = param1;
    }

    public function get gap():int {
        return this._gap;
    }

    public function set gap(param1:int):void {
        this._gap = param1;
        invalidateSize();
    }

    public function get renderers():Vector.<ISlotsPanelRenderer> {
        return this._renderers;
    }

    public function get ownerId():int {
        return this._ownerId;
    }

    public function set ownerId(param1:int):void {
        this._ownerId = param1;
    }
}
}
