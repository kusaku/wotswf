package net.wg.gui.lobby.battleResults {
import flash.display.InteractiveObject;

import net.wg.gui.lobby.battleResults.components.DetailsStatsScrollPane;
import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
import net.wg.gui.lobby.battleResults.data.VehicleStatsVO;
import net.wg.gui.lobby.battleResults.fallout.DetailsVehicleSelection;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IViewStackContent;

import scaleform.clik.events.ListEvent;

public class DetailsStatsView extends UIComponentEx implements IViewStackContent {

    public var vehicleSelection:DetailsVehicleSelection = null;

    public var scrollPane:DetailsStatsScrollPane = null;

    private var _data:BattleResultsVO = null;

    public function DetailsStatsView() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.vehicleSelection.addEventListener(ListEvent.INDEX_CHANGE, this.onSelectVehicleDropdownIndexChangeHandler);
    }

    override protected function onDispose():void {
        this._data = null;
        this.vehicleSelection.removeEventListener(ListEvent.INDEX_CHANGE, this.onSelectVehicleDropdownIndexChangeHandler);
        this.vehicleSelection.dispose();
        this.vehicleSelection = null;
        this.scrollPane.dispose();
        this.scrollPane = null;
        super.onDispose();
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return null;
    }

    public function update(param1:Object):void {
        var _loc3_:Boolean = false;
        this._data = BattleResultsVO(param1);
        var _loc2_:Vector.<VehicleStatsVO> = this._data.common.playerVehicles;
        _loc3_ = _loc2_ != null && _loc2_.length > 1;
        this.vehicleSelection.visible = _loc3_;
        if (_loc3_) {
            this.vehicleSelection.setData(_loc2_, this._data.common.playerVehicleNames, this._data.selectedIdxInGarageDropdown);
            this.scrollPane.setOffsetY(this.vehicleSelection.height);
        }
        else {
            this.scrollPane.setOffsetY(0);
        }
        this.scrollPane.detailsStats.setBattleResultsVO(this._data);
    }

    private function onSelectVehicleDropdownIndexChangeHandler(param1:ListEvent):void {
        this._data.selectedIdxInGarageDropdown = param1.index;
        this.scrollPane.detailsStats.setSelectedVehicleIndex(param1.index);
    }
}
}
