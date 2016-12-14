package net.wg.gui.cyberSport.popups {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.text.TextField;
import flash.utils.Dictionary;

import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.cyberSport.controls.VehicleSelector;
import net.wg.gui.cyberSport.controls.events.VehicleSelectorEvent;
import net.wg.gui.cyberSport.vo.VehicleSelectorItemVO;
import net.wg.gui.lobby.components.data.VehicleSelectorFilterVO;
import net.wg.gui.lobby.components.events.VehicleSelectorFilterEvent;
import net.wg.infrastructure.base.meta.IVehicleSelectorPopupMeta;
import net.wg.infrastructure.base.meta.impl.VehicleSelectorPopupMeta;
import net.wg.infrastructure.interfaces.IWindow;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.utils.Padding;

public class VehicleSelectorPopup extends VehicleSelectorPopupMeta implements IVehicleSelectorPopupMeta {

    private static const INVALID_LAYOUT:String = "invalidLayout";

    private static const TEXT_PADDING:Number = 5;

    private static const BTN_PADDING:Number = 5;

    private static const WND_PADDING:Number = 16;

    public var selector:VehicleSelector;

    public var selectButton:SoundButtonEx;

    public var cancelButton:SoundButtonEx;

    public var separator:MovieClip;

    public var infoTF:TextField;

    private var _selectedItems:Array;

    private var _movableComponents:Array;

    private var _originalPos:Dictionary;

    private var _componentsOffset:Number = 0;

    public function VehicleSelectorPopup() {
        var _loc1_:DisplayObject = null;
        this._selectedItems = [];
        super();
        isModal = true;
        this.infoTF.mouseEnabled = false;
        this._originalPos = new Dictionary();
        this._movableComponents = [this.selector, this.separator];
        for each(_loc1_ in this._movableComponents) {
            this._originalPos[_loc1_] = _loc1_.y;
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.selector.addEventListener(VehicleSelectorFilterEvent.CHANGE, this.onSelectorFiltersChangeHandler);
        this.selector.addEventListener(VehicleSelectorEvent.SELECTION_CHANGED, this.onSelectorSelectionChangedHandler);
        this.selector.addEventListener(Event.RESIZE, this.onSelectorResizeHandler);
        this.selectButton.addEventListener(ButtonEvent.CLICK, this.onSelectButtonClickHandler);
        this.cancelButton.addEventListener(ButtonEvent.CLICK, this.onCancelButtonClickHandler);
    }

    override protected function draw():void {
        var _loc1_:DisplayObject = null;
        var _loc2_:Number = NaN;
        var _loc3_:Number = NaN;
        super.draw();
        if (isInvalid(INVALID_LAYOUT)) {
            for each(_loc1_ in this._movableComponents) {
                _loc1_.y = this._originalPos[_loc1_] + this._componentsOffset;
            }
            this.selectButton.y = this.cancelButton.y = this.selector.y + this.selector.height + BTN_PADDING ^ 0;
            _loc2_ = this.width;
            _loc3_ = this.actualHeight + WND_PADDING;
            window.updateSize(_loc2_, _loc3_, true);
        }
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.useBottomBtns = true;
        window.title = CYBERSPORT.WINDOW_VEHICLESELECTOR_TITLE;
    }

    override public function setWindow(param1:IWindow):void {
        super.setWindow(param1);
        if (param1) {
            param1.formBgPadding = new Padding(33, 11, 13, 10);
            param1.contentPadding = new Padding(35, 14, 17, 12);
        }
    }

    override protected function onDispose():void {
        this.selector.removeEventListener(VehicleSelectorFilterEvent.CHANGE, this.onSelectorFiltersChangeHandler);
        this.selector.removeEventListener(VehicleSelectorEvent.SELECTION_CHANGED, this.onSelectorSelectionChangedHandler);
        this.selector.removeEventListener(Event.RESIZE, this.onSelectorResizeHandler);
        this.selectButton.removeEventListener(ButtonEvent.CLICK, this.onSelectButtonClickHandler);
        this.cancelButton.removeEventListener(ButtonEvent.CLICK, this.onCancelButtonClickHandler);
        this.selector.dispose();
        this.selectButton.dispose();
        this.cancelButton.dispose();
        this._selectedItems.splice(0, this._movableComponents.length);
        this._selectedItems = null;
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
    }

    override protected function setFiltersData(param1:VehicleSelectorFilterVO):void {
        this.selector.setFiltersData(param1);
    }

    public function as_setInfoText(param1:String, param2:int):void {
        this.infoTF.text = param1;
        this._componentsOffset = param2;
        this.infoTF.height = this.infoTF.textHeight + TEXT_PADDING;
        invalidate(INVALID_LAYOUT);
    }

    override protected function setListData(param1:DataProvider, param2:Array):void {
        var _loc4_:VehicleSelectorItemVO = null;
        var _loc3_:Array = App.utils.getGUINationsS();
        for each(_loc4_ in param1) {
            _loc4_.nationOrderIdx = _loc3_.indexOf(App.utils.nations.getNationName(_loc4_.nationID));
        }
        this.selector.setupSelectionOverrides(param2);
        this.selector.setListItems(param1);
    }

    public function as_setListMode(param1:Boolean):void {
        this.selector.multiSelection = param1;
    }

    private function onSelectorResizeHandler(param1:Event):void {
        invalidate(INVALID_LAYOUT);
    }

    private function onSelectorSelectionChangedHandler(param1:VehicleSelectorEvent):void {
        this._selectedItems = param1.selectedDescriptors;
        this.selectButton.enabled = this._selectedItems.length > 0;
        if (param1.forceSelect) {
            onSelectVehiclesS(this._selectedItems);
        }
    }

    private function onSelectorFiltersChangeHandler(param1:VehicleSelectorFilterEvent):void {
        onFiltersUpdateS(param1.nation, param1.vehicleType, param1.isMain, param1.level, param1.compatibleOnly);
    }

    private function onCancelButtonClickHandler(param1:ButtonEvent):void {
        onWindowClose();
    }

    private function onSelectButtonClickHandler(param1:ButtonEvent):void {
        onSelectVehiclesS(this._selectedItems);
    }
}
}
