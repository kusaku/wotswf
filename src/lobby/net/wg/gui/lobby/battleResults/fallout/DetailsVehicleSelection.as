package net.wg.gui.lobby.battleResults.fallout {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.data.constants.Values;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.battleResults.data.VehicleStatsVO;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ListEvent;

public class DetailsVehicleSelection extends UIComponentEx {

    public var selectVehicleDropdown:DropdownMenu;

    public var selectVehicleTitle:TextField;

    public var tankIcon:UILoaderAlt;

    public var tankFlag:MovieClip;

    private var _vehicles:Vector.<VehicleStatsVO>;

    public function DetailsVehicleSelection() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.selectVehicleTitle.text = BATTLE_RESULTS.SELECTVEHICLE;
        this.selectVehicleDropdown.addEventListener(ListEvent.INDEX_CHANGE, this.onSelectVehicleDropdownIndexChangeHandler);
    }

    override protected function onDispose():void {
        this.selectVehicleDropdown.removeEventListener(ListEvent.INDEX_CHANGE, this.onSelectVehicleDropdownIndexChangeHandler);
        this.selectVehicleDropdown.dispose();
        this.selectVehicleDropdown = null;
        this.selectVehicleTitle = null;
        this.tankIcon.dispose();
        this.tankIcon = null;
        this.tankFlag = null;
        this._vehicles = null;
        super.onDispose();
    }

    public function setData(param1:Vector.<VehicleStatsVO>, param2:Array, param3:int):void {
        this._vehicles = param1;
        this.selectVehicleDropdown.dataProvider = new DataProvider(param2);
        this.selectVehicleDropdown.selectedIndex = param3;
        this.applyVehicleData();
    }

    private function applyVehicleData():void {
        var _loc1_:String = null;
        if (this._vehicles) {
            this.tankIcon.source = this._vehicles[this.selectVehicleDropdown.selectedIndex].tankIcon;
            _loc1_ = this._vehicles[this.selectVehicleDropdown.selectedIndex].flag;
            this.tankFlag.visible = _loc1_ != Values.EMPTY_STR;
            if (_loc1_ != Values.EMPTY_STR) {
                this.tankFlag.gotoAndStop(_loc1_);
            }
        }
    }

    private function onSelectVehicleDropdownIndexChangeHandler(param1:ListEvent):void {
        if (this._vehicles) {
            this.applyVehicleData();
        }
    }
}
}
