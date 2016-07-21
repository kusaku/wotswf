package net.wg.gui.cyberSport.popups {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.text.TextField;
import flash.utils.Dictionary;

import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.cyberSport.controls.VehicleSelector;
import net.wg.gui.cyberSport.controls.events.VehicleSelectorEvent;
import net.wg.gui.cyberSport.controls.events.VehicleSelectorFilterEvent;
import net.wg.gui.cyberSport.vo.VehicleSelectorFilterVO;
import net.wg.gui.cyberSport.vo.VehicleSelectorItemVO;
import net.wg.infrastructure.base.meta.IVehicleSelectorPopupMeta;
import net.wg.infrastructure.base.meta.impl.VehicleSelectorPopupMeta;

import scaleform.clik.events.ButtonEvent;

public class VehicleSelectorPopup extends VehicleSelectorPopupMeta implements IVehicleSelectorPopupMeta {

    private static const INVALID_LAYOUT:String = "invalidLayout";

    private static const TEXT_PADDING:Number = 5;

    public var selector:VehicleSelector;

    public var selectButton:SoundButtonEx;

    public var cancelButton:SoundButtonEx;

    public var separator:MovieClip;

    public var infoTF:TextField;

    private var selectedItems:Array;

    private var _movableComponents:Array;

    private var _originalPos:Dictionary;

    private var _componentsOffset:Number;

    private var _selectDefaultItem:Boolean = false;

    public function VehicleSelectorPopup() {
        var _loc1_:DisplayObject = null;
        this.selectedItems = [];
        super();
        isModal = true;
        this.infoTF.mouseEnabled = false;
        this._originalPos = new Dictionary();
        this._movableComponents = [this.selector, this.selectButton, this.cancelButton, this.separator];
        for each(_loc1_ in this._movableComponents) {
            this._originalPos[_loc1_] = _loc1_.y;
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.selector.addEventListener(VehicleSelectorFilterEvent.CHANGE, this.onFiltersChanged);
        this.selector.addEventListener(VehicleSelectorEvent.SELECTION_CHANGED, this.onSelectionChanged);
        this.selectButton.addEventListener(ButtonEvent.CLICK, this.onSelectClick);
        this.cancelButton.addEventListener(ButtonEvent.CLICK, this.onCancelClick);
    }

    override protected function draw():void {
        var _loc1_:Number = NaN;
        var _loc2_:Number = NaN;
        super.draw();
        if (isInvalid(INVALID_LAYOUT)) {
            _loc1_ = this.width;
            _loc2_ = this.height + this._componentsOffset;
            App.utils.scheduler.scheduleOnNextFrame(window.updateSize, _loc1_, _loc2_, true);
        }
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.useBottomBtns = true;
        window.title = CYBERSPORT.WINDOW_VEHICLESELECTOR_TITLE;
    }

    override protected function onDispose():void {
        this.selector.removeEventListener(VehicleSelectorFilterEvent.CHANGE, this.onFiltersChanged);
        this.selector.removeEventListener(VehicleSelectorEvent.SELECTION_CHANGED, this.onSelectionChanged);
        this.selectButton.removeEventListener(ButtonEvent.CLICK, this.onSelectClick);
        this.cancelButton.removeEventListener(ButtonEvent.CLICK, this.onCancelClick);
        this.selector.dispose();
        this.selectButton.dispose();
        this.cancelButton.dispose();
        App.utils.data.cleanupDynamicObject(this._originalPos);
        this._movableComponents.splice(0, this._movableComponents.length);
        this.separator = null;
        this.selectButton = null;
        this.cancelButton = null;
        this.selector = null;
        this.infoTF = null;
        this._movableComponents = null;
        this._originalPos = null;
        super.onDispose();
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(this.selector.list);
        this._selectDefaultItem = true;
        if (this.selector.list.renderersCount > 0) {
            this.selectDefaultItem();
        }
    }

    public function as_setFiltersData(param1:Object):void {
        this.selector.setFiltersData(new VehicleSelectorFilterVO(param1));
    }

    public function as_setInfoText(param1:String, param2:int):void {
        this.infoTF.text = param1;
        this._componentsOffset = param2;
        this.layout();
        invalidate(INVALID_LAYOUT);
    }

    public function as_setListData(param1:Array, param2:Array):void {
        var _loc4_:Object = null;
        var _loc5_:VehicleSelectorItemVO = null;
        var _loc3_:Array = [];
        var _loc6_:Array = App.utils.getGUINationsS();
        for each(_loc4_ in param1) {
            _loc5_ = new VehicleSelectorItemVO(_loc4_, true);
            _loc5_.nationOrderIdx = _loc6_.indexOf(App.utils.nations.getNationName(_loc5_.nationID));
            _loc3_.push(_loc5_);
        }
        this.selector.setupSelectionOverrides(param2);
        this.selector.setListItems(_loc3_);
        this.selectDefaultItem();
    }

    public function as_setListMode(param1:Boolean):void {
        this.selector.multiSelection = param1;
    }

    private function selectDefaultItem():void {
        var _loc1_:int = 0;
        if (this._selectDefaultItem) {
            _loc1_ = 0;
            while (_loc1_ < this.selector.list.renderersCount) {
                if (this.selector.list.getRendererAt(_loc1_).enabled) {
                    this.selector.list.selectedIndex = _loc1_;
                    return;
                }
                _loc1_++;
            }
            this._selectDefaultItem = false;
        }
    }

    private function layout():void {
        var _loc1_:DisplayObject = null;
        this.infoTF.height = this.infoTF.textHeight + TEXT_PADDING;
        for each(_loc1_ in this._movableComponents) {
            _loc1_.y = this._originalPos[_loc1_] + this._componentsOffset;
        }
    }

    private function onSelectionChanged(param1:VehicleSelectorEvent):void {
        this.selectedItems = param1.selectedDescriptors;
        this.selectButton.enabled = this.selectedItems.length > 0;
        if (param1.forceSelect) {
            onSelectVehiclesS(this.selectedItems);
        }
    }

    private function onFiltersChanged(param1:VehicleSelectorFilterEvent):void {
        onFiltersUpdateS(param1.nation, param1.vehicleType, param1.isMain, param1.level, param1.compatibleOnly);
    }

    private function onCancelClick(param1:ButtonEvent):void {
        onWindowClose();
    }

    private function onSelectClick(param1:ButtonEvent):void {
        onSelectVehiclesS(this.selectedItems);
    }
}
}
