package net.wg.gui.lobby.fortifications.windows {
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;

import net.wg.data.constants.Errors;
import net.wg.gui.components.controls.SortableTable;
import net.wg.gui.events.SortableTableListEvent;
import net.wg.gui.lobby.fortifications.cmp.buildingProcess.impl.BuildingProcessInfo;
import net.wg.gui.lobby.fortifications.data.buildingProcess.BuildingProcessInfoVO;
import net.wg.gui.lobby.fortifications.data.buildingProcess.BuildingProcessListItemVO;
import net.wg.gui.lobby.fortifications.data.buildingProcess.BuildingProcessVO;
import net.wg.infrastructure.base.meta.IFortBuildingProcessWindowMeta;
import net.wg.infrastructure.base.meta.impl.FortBuildingProcessWindowMeta;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.utils.IAssertable;

public class FortBuildingProcessWindow extends FortBuildingProcessWindowMeta implements IFortBuildingProcessWindowMeta {

    private static const ALPHA_VALUE:Number = 0.33;

    private static const BUILDING_STATUS_AVAILABLE:uint = 3;

    private static const BUILDING_ID:String = "buildingID";

    public var separator:Sprite;

    public var availableCount:TextField = null;

    public var buildingList:SortableTable = null;

    public var buildingInfo:BuildingProcessInfo = null;

    public var textInfo:TextField;

    private var _asserter:IAssertable;

    public function FortBuildingProcessWindow() {
        super();
        isModal = false;
        isCentered = true;
        this.textInfo.mouseEnabled = false;
        this.separator.mouseEnabled = false;
        this.textInfo.alpha = ALPHA_VALUE;
        this.buildingInfo.visible = false;
        this._asserter = App.utils.asserter;
        this.buildingList.uniqKeyForAutoSelect = BUILDING_ID;
        this.buildingList.addEventListener(SortableTableListEvent.LIST_INDEX_CHANGE, this.onBuildingListListIndexChangeHandler);
        this.buildingList.addEventListener(SortableTableListEvent.RENDERER_DOUBLE_CLICK, this.onBuildingListRendererDoubleClickHandler);
        this.buildingInfo.addEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onBuildingInfoRequestFocusHandler);
    }

    override protected function responseBuildingInfo(param1:BuildingProcessInfoVO):void {
        this.textInfo.visible = false;
        this.buildingInfo.visible = true;
        this.buildingInfo.setData(param1);
        this.buildingInfo.addEventListener(BuildingProcessInfo.BUY_BUILDING, this.onBuildingInfoBuyBuildingHandler);
    }

    override protected function onDispose():void {
        this.buildingList.removeEventListener(SortableTableListEvent.LIST_INDEX_CHANGE, this.onBuildingListListIndexChangeHandler);
        this.buildingList.removeEventListener(SortableTableListEvent.RENDERER_DOUBLE_CLICK, this.onBuildingListRendererDoubleClickHandler);
        this.buildingList.dispose();
        this.buildingList = null;
        this.buildingInfo.removeEventListener(BuildingProcessInfo.BUY_BUILDING, this.onBuildingInfoBuyBuildingHandler);
        this.buildingInfo.removeEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onBuildingInfoRequestFocusHandler);
        this.buildingInfo.dispose();
        this.buildingInfo = null;
        this.availableCount = null;
        this.separator = null;
        this.textInfo = null;
        this._asserter = null;
        super.onDispose();
    }

    override protected function setData(param1:BuildingProcessVO):void {
        var _loc2_:BuildingProcessListItemVO = BuildingProcessListItemVO(this.buildingList.getListSelectedItem());
        this.availableCount.htmlText = param1.availableCount;
        this.buildingList.listDP = param1.listItems;
        window.title = param1.windowTitle;
        this.textInfo.x = this.buildingInfo.x + (this.buildingInfo.width - this.textInfo.width >> 1);
        this.textInfo.htmlText = param1.textInfo;
        this.textInfo.visible = true;
        if (_loc2_) {
            requestBuildingInfoS(_loc2_.buildingID);
        }
    }

    private function onBuildingListListIndexChangeHandler(param1:SortableTableListEvent):void {
        var _loc2_:Object = this.buildingList.getListSelectedItem();
        this._asserter.assertNotNull(_loc2_, " [selectItem] selectedItem" + Errors.CANT_NULL);
        requestBuildingInfoS(BuildingProcessListItemVO(_loc2_).buildingID);
    }

    private function onBuildingInfoBuyBuildingHandler(param1:Event):void {
        var _loc2_:String = BuildingProcessInfo(param1.target).getBuildingId();
        this._asserter.assertNotNull(_loc2_, " [buyBuilding] buildingId" + Errors.CANT_NULL);
        applyBuildingProcessS(_loc2_);
    }

    private function onBuildingInfoRequestFocusHandler(param1:FocusRequestEvent):void {
        setFocus(param1.focusContainer.getComponentForFocus());
        this.buildingInfo.removeEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onBuildingInfoRequestFocusHandler);
    }

    private function onBuildingListRendererDoubleClickHandler(param1:SortableTableListEvent):void {
        if (this.buildingList.listSelectedIndex == -1) {
            return;
        }
        var _loc2_:Object = this.buildingList.getListSelectedItem();
        this._asserter.assertNotNull(_loc2_, " [doubleCLICK on buildingItem] selectedItem" + Errors.CANT_NULL);
        var _loc3_:BuildingProcessListItemVO = BuildingProcessListItemVO(_loc2_);
        if (_loc3_.buildingID && _loc3_.buildingStatus == BUILDING_STATUS_AVAILABLE) {
            applyBuildingProcessS(_loc3_.buildingID);
        }
    }
}
}
