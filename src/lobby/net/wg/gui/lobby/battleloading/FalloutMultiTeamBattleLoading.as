package net.wg.gui.lobby.battleloading {
import net.wg.gui.lobby.battleloading.interfaces.IFalloutLoadingForm;
import net.wg.gui.lobby.battleloading.vo.PlayerStatusVO;
import net.wg.gui.lobby.battleloading.vo.ShortInfoVO;
import net.wg.gui.lobby.battleloading.vo.VehInfoWithSortedIDVO;
import net.wg.gui.lobby.battleloading.vo.VehStatusVO;
import net.wg.gui.lobby.battleloading.vo.VehicleDataVO;
import net.wg.gui.lobby.battleloading.vo.VisualTipInfoVO;
import net.wg.gui.lobby.eventInfoPanel.data.EventInfoPanelVO;

public class FalloutMultiTeamBattleLoading extends BaseBattleLoading {

    private static const FORM_HEIGHT_WITHOUT_SHADOW:int = 800;

    public var form:IFalloutLoadingForm;

    public function FalloutMultiTeamBattleLoading() {
        super();
    }

    override public function as_addVehicleInfo(param1:Object):void {
        var _loc2_:VehInfoWithSortedIDVO = new VehInfoWithSortedIDVO(param1);
        this.form.addVehicleInfo(_loc2_.vehicleInfo, _loc2_.vehiclesIDs);
        _loc2_.dispose();
    }

    override public function as_setArenaInfo(param1:Object):void {
        var _loc2_:ShortInfoVO = new ShortInfoVO(param1);
        this.form.setBattleTypeName(_loc2_.battleTypeLocaleStr);
        this.form.updateWinText(_loc2_.winText);
        this.form.updateMapName(_loc2_.mapName);
        this.form.setBattleTypeFrameName(_loc2_.battleTypeFrameLabel);
        _loc2_.dispose();
    }

    override public function as_setMapIcon(param1:String):void {
        this.form.setMapIcon(param1);
    }

    override public function as_setPlayerData(param1:Number, param2:Number):void {
        this.form.setPlayerInfo(param1, param2);
    }

    override public function as_setProgress(param1:Number):void {
        this.form.updateProgress(param1);
    }

    override public function as_setVehicleStatus(param1:Object):void {
        var _loc2_:VehStatusVO = new VehStatusVO(param1);
        this.form.setVehicleStatus(_loc2_.vehicleID, _loc2_.status, _loc2_.vehiclesIDs);
        _loc2_.dispose();
    }

    override public function as_setVehiclesData(param1:Object):void {
        var _loc2_:VehicleDataVO = new VehicleDataVO(param1);
        this.form.setVehiclesData(_loc2_.vehiclesInfo);
        _loc2_.dispose();
    }

    override public function as_updateVehicleInfo(param1:Object):void {
        var _loc2_:VehInfoWithSortedIDVO = new VehInfoWithSortedIDVO(param1);
        this.form.updateVehicleInfo(_loc2_.vehicleInfo, _loc2_.vehiclesIDs);
        _loc2_.dispose();
    }

    override public function updateStage(param1:Number, param2:Number):void {
        super.updateStage(param1, param2);
        this.form.x = param1 >> 1;
        this.form.y = param2 - FORM_HEIGHT_WITHOUT_SHADOW >> 1;
        this.form.invalidateSize();
    }

    override protected function setEventInfoPanelData(param1:EventInfoPanelVO):void {
        this.form.setEventInfo(param1);
    }

    override protected function setPlayerStatus(param1:PlayerStatusVO):void {
        this.form.setPlayerStatus(param1.vehicleID, param1.status);
    }

    override protected function setVisualTipInfo(param1:VisualTipInfoVO):void {
    }

    override protected function onDispose():void {
        this.form.dispose();
        this.form = null;
        super.onDispose();
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.form.beforePopulateData();
    }
}
}
