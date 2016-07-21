package net.wg.gui.lobby.battleloading {
import net.wg.data.Aliases;
import net.wg.data.constants.Errors;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.events.UILoaderEvent;
import net.wg.gui.lobby.battleloading.interfaces.IBattleLoadingForm;
import net.wg.gui.lobby.battleloading.vo.FullInfoVO;
import net.wg.gui.lobby.battleloading.vo.PlayerStatusTeamVO;
import net.wg.gui.lobby.battleloading.vo.VehInfoWithSortedIDTeamVO;
import net.wg.gui.lobby.battleloading.vo.VehStatusTeamVO;
import net.wg.gui.lobby.battleloading.vo.VehicleDataTeamVO;
import net.wg.gui.lobby.battleloading.vo.VisualTipInfoVO;
import net.wg.gui.lobby.eventInfoPanel.data.EventInfoPanelVO;
import net.wg.utils.IAssertable;

public class BattleLoading extends BaseBattleLoading {

    private static const FORM_VISIBLE_AREA_HEIGHT:int = 545;

    public var form:IBattleLoadingForm;

    private var _asserter:IAssertable;

    public function BattleLoading() {
        this._asserter = App.utils.asserter;
        super();
    }

    override public function as_addVehicleInfo(param1:Object):void {
        this._asserter.assertNotNull(param1, this.toString() + " Argument \'data\'" + Errors.CANT_NULL);
        var _loc2_:VehInfoWithSortedIDTeamVO = new VehInfoWithSortedIDTeamVO(param1);
        this.form.addVehicleInfo(_loc2_.isEnemy, _loc2_.vehicleInfo, _loc2_.vehiclesIDs);
        _loc2_.dispose();
    }

    override public function as_setArenaInfo(param1:Object):void {
        this._asserter.assertNotNull(param1, this.toString() + " Argument \'data\'" + Errors.CANT_NULL);
        var _loc2_:FullInfoVO = new FullInfoVO(param1);
        this.form.updateMapName(_loc2_.mapName);
        this.form.setBattleTypeName(_loc2_.battleTypeLocaleStr);
        this.form.updateWinText(_loc2_.winText);
        this.form.updateTeamsHeaders(_loc2_.allyTeamName, _loc2_.enemyTeamName);
        this.form.setBattleTypeFrameName(_loc2_.battleTypeFrameLabel);
        _loc2_.dispose();
    }

    override public function as_setMapIcon(param1:String):void {
        var _loc2_:UILoaderAlt = this.form.getMapIconComponent();
        _loc2_.addEventListener(UILoaderEvent.COMPLETE, this.onMapIconCompleteHandler, false, 0, true);
        _loc2_.addEventListener(UILoaderEvent.IOERROR, this.onMapIconCompleteHandler, false, 0, true);
        this.form.setMapIcon(param1);
    }

    override public function as_setPlayerData(param1:Number, param2:Number):void {
        this.form.setPlayerInfo(param1, param2);
    }

    override public function as_setPlayerStatus(param1:Object):void {
        var _loc2_:PlayerStatusTeamVO = new PlayerStatusTeamVO(param1);
        this.form.setPlayerStatus(_loc2_.isEnemy, _loc2_.vehicleID, _loc2_.status);
        _loc2_.dispose();
    }

    override public function as_setProgress(param1:Number):void {
        this.form.updateProgress(param1);
    }

    override public function as_setTip(param1:String):void {
        this.form.updateTipBody(param1);
    }

    override public function as_setTipTitle(param1:String):void {
        this.form.updateTipTitle(param1);
    }

    override public function as_setVehicleStatus(param1:Object):void {
        this._asserter.assertNotNull(param1, this.toString() + " Argument \'data\'" + Errors.CANT_NULL);
        var _loc2_:VehStatusTeamVO = new VehStatusTeamVO(param1);
        this.form.setVehicleStatus(_loc2_.isEnemy, _loc2_.vehicleID, _loc2_.status, _loc2_.vehiclesIDs);
        _loc2_.dispose();
    }

    override public function as_setVehiclesData(param1:Object):void {
        this._asserter.assertNotNull(param1, this.toString() + " Argument \'data\'" + Errors.CANT_NULL);
        var _loc2_:VehicleDataTeamVO = new VehicleDataTeamVO(param1);
        this.form.setVehiclesData(_loc2_.isEnemy, _loc2_.vehiclesInfo);
        _loc2_.dispose();
    }

    override public function as_updateVehicleInfo(param1:Object):void {
        this._asserter.assertNotNull(param1, this.toString() + " Argument \'data\'" + Errors.CANT_NULL);
        var _loc2_:VehInfoWithSortedIDTeamVO = new VehInfoWithSortedIDTeamVO(param1);
        this.form.updateVehicleInfo(_loc2_.isEnemy, _loc2_.vehicleInfo, _loc2_.vehiclesIDs);
        _loc2_.dispose();
    }

    override public function toString():String {
        return "[WG BattleLoading " + name + "]";
    }

    override public function updateStage(param1:Number, param2:Number):void {
        this.form.x = param1 >> 1;
        this.form.y = param2 - FORM_VISIBLE_AREA_HEIGHT >> 1;
    }

    override protected function setVisualTipInfo(param1:VisualTipInfoVO):void {
        this.form.setFormDisplayData(param1.settingID, param1.tipIcon, param1.arenaTypeID, param1.minimapTeam, param1.showMinimap);
    }

    override protected function onPopulate():void {
        super.onPopulate();
        registerFlashComponentS(this.form.getMapComponent(), Aliases.LOBBY_MINIMAP);
    }

    override protected function canAutoShowView():Boolean {
        return false;
    }

    override protected function setEventInfoPanelData(param1:EventInfoPanelVO):void {
    }

    override protected function onDispose():void {
        this.removeMapIconListeners();
        this.form.dispose();
        this.form = null;
        this._asserter = null;
        super.onDispose();
    }

    private function removeMapIconListeners():void {
        var _loc1_:UILoaderAlt = this.form.getMapIconComponent();
        _loc1_.removeEventListener(UILoaderEvent.COMPLETE, this.onMapIconCompleteHandler);
        _loc1_.removeEventListener(UILoaderEvent.IOERROR, this.onMapIconCompleteHandler);
    }

    private function onMapIconCompleteHandler(param1:UILoaderEvent):void {
        this.removeMapIconListeners();
        this.visible = true;
    }
}
}
