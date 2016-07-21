package net.wg.gui.lobby.modulesPanel {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.text.TextField;

import net.wg.data.constants.LobbyMetrics;
import net.wg.data.constants.generated.FITTING_TYPES;
import net.wg.gui.components.controls.ScrollingListEx;
import net.wg.gui.components.popOvers.PopOver;
import net.wg.gui.components.popOvers.PopOverConst;
import net.wg.gui.events.DeviceEvent;
import net.wg.gui.events.ModuleInfoEvent;
import net.wg.gui.lobby.modulesPanel.components.FittingListSelectionNavigator;
import net.wg.gui.lobby.modulesPanel.data.DeviceVO;
import net.wg.gui.lobby.modulesPanel.data.FittingSelectPopoverVO;
import net.wg.infrastructure.base.meta.IFittingSelectPopoverMeta;
import net.wg.infrastructure.base.meta.impl.FittingSelectPopoverMeta;
import net.wg.infrastructure.interfaces.IWrapper;
import net.wg.utils.IAssertable;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ListEvent;

public class FittingSelectPopover extends FittingSelectPopoverMeta implements IFittingSelectPopoverMeta {

    private static const BOTTOM_MARGIN:int = 15;

    private static const LIST_BOTTOM_MARGIN:int = 2;

    public var textTf:TextField;

    public var itemsList:ScrollingListEx;

    public var bottomSeparator:MovieClip;

    public var topSeparator:MovieClip;

    private var _minAvailableListHeight:int = 0;

    private var _data:FittingSelectPopoverVO;

    private var _stage:Stage;

    public function FittingSelectPopover() {
        super();
        this._stage = App.stage;
    }

    override protected function configUI():void {
        super.configUI();
        this.setEmptyHitArea(this.topSeparator);
        this.setEmptyHitArea(this.bottomSeparator);
        this.itemsList.setSelectionNavigator(new FittingListSelectionNavigator());
        this.itemsList.addEventListener(ModuleInfoEvent.SHOW_INFO, this.onItemsListShowInfoHandler);
        this.itemsList.addEventListener(DeviceEvent.DEVICE_REMOVE, this.onItemsListDeviceRemoveHandler);
        this.itemsList.addEventListener(DeviceEvent.DEVICE_DESTROY, this.onItemsListDeviceDestroyHandler);
        this.itemsList.addEventListener(ListEvent.ITEM_CLICK, this.onItemsListItemClickHandler);
        this._stage.addEventListener(Event.RESIZE, this.onStageResizeHandler);
    }

    override protected function update(param1:FittingSelectPopoverVO):void {
        this._data = param1;
        this.textTf.htmlText = param1.title;
        width = this.topSeparator.width = this.bottomSeparator.width = this._data.width;
        var _loc2_:IAssertable = App.utils.asserter;
        _loc2_.assert(param1.minAvailableHeight > 0, "minAvailableHeight must be greater then zero! received: " + param1.minAvailableHeight);
        this._minAvailableListHeight = param1.minAvailableHeight - this.itemsList.y - BOTTOM_MARGIN;
        var _loc3_:String = param1.rendererName;
        _loc2_.assert(FITTING_TYPES.FITTING_RENDERERS.indexOf(_loc3_) >= 0, "Unknown renderer name: " + _loc3_);
        this.itemsList.itemRendererName = _loc3_;
        if (this.itemsList.dataProvider != null) {
            this.itemsList.dataProvider.cleanUp();
        }
        this.itemsList.dataProvider = new DataProvider(param1.availableDevices);
        this.itemsList.selectedIndex = param1.selectedIndex;
        invalidateSize();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            if (!isNaN(this.itemsList.rowHeight)) {
                this.updateSize();
            }
            else {
                App.utils.scheduler.scheduleOnNextFrame(this.updateSize);
            }
        }
    }

    override protected function onDispose():void {
        this.itemsList.removeEventListener(ModuleInfoEvent.SHOW_INFO, this.onItemsListShowInfoHandler);
        this.itemsList.removeEventListener(DeviceEvent.DEVICE_REMOVE, this.onItemsListDeviceRemoveHandler);
        this.itemsList.removeEventListener(DeviceEvent.DEVICE_DESTROY, this.onItemsListDeviceDestroyHandler);
        this.itemsList.removeEventListener(ListEvent.ITEM_CLICK, this.onItemsListItemClickHandler);
        this._stage.removeEventListener(Event.RESIZE, this.onStageResizeHandler);
        App.utils.scheduler.cancelTask(this.updateSize);
        this.textTf = null;
        this.itemsList.dispose();
        this.itemsList = null;
        this.bottomSeparator.hitArea = null;
        this.bottomSeparator = null;
        this.topSeparator.hitArea = null;
        this.topSeparator = null;
        this._data = null;
        this._stage = null;
        super.onDispose();
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(this.itemsList);
    }

    override protected function initLayout():void {
        popoverLayout.preferredLayout = PopOverConst.ARROW_BOTTOM;
        super.initLayout();
    }

    private function updateSize():void {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        if (this._data != null && this._data.availableDevices != null) {
            _loc2_ = App.appHeight - LobbyMetrics.MIN_STAGE_HEIGHT;
            _loc3_ = this._minAvailableListHeight + _loc2_;
            this.itemsList.rowCount = Math.min(_loc3_ / this.itemsList.rowHeight, this._data.availableDevices.length);
        }
        this.itemsList.width = width;
        var _loc1_:int = this.itemsList.y + this.itemsList.height;
        height = _loc1_ + BOTTOM_MARGIN;
        this.bottomSeparator.y = _loc1_ + (this.bottomSeparator.height >> 1) + LIST_BOTTOM_MARGIN;
    }

    private function setEmptyHitArea(param1:Sprite):void {
        var _loc2_:Sprite = new Sprite();
        addChild(_loc2_);
        param1.hitArea = _loc2_;
    }

    override public function set wrapper(param1:IWrapper):void {
        super.wrapper = param1;
        PopOver(param1).isCloseBtnVisible = true;
    }

    private function onStageResizeHandler(param1:Event):void {
        invalidateSize();
    }

    private function onItemsListShowInfoHandler(param1:ModuleInfoEvent):void {
        showModuleInfoS(param1.id);
    }

    private function onItemsListDeviceRemoveHandler(param1:DeviceEvent):void {
        var _loc2_:Number = param1.deviceId;
        setVehicleModuleS(_loc2_, _loc2_, true);
    }

    private function onItemsListDeviceDestroyHandler(param1:DeviceEvent):void {
        setVehicleModuleS(param1.deviceId, -1, true);
    }

    private function onItemsListItemClickHandler(param1:ListEvent):void {
        var _loc4_:DeviceVO = null;
        var _loc5_:DeviceVO = null;
        var _loc6_:Number = NaN;
        var _loc2_:int = this._data.selectedIndex;
        var _loc3_:int = param1.index;
        if (_loc2_ != _loc3_) {
            _loc4_ = null;
            _loc5_ = null;
            if (_loc2_ >= 0) {
                _loc4_ = this._data.availableDevices[_loc2_];
            }
            if (_loc3_ >= 0) {
                _loc5_ = this._data.availableDevices[_loc3_];
            }
            _loc6_ = _loc4_ != null ? Number(_loc4_.id) : Number(-1);
            setVehicleModuleS(_loc5_.id, _loc6_, false);
        }
    }
}
}
