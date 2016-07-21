package net.wg.gui.lobby.battleloading {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.gui.components.controls.ReadOnlyScrollingList;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.battleloading.data.EnemyVehiclesDataProvider;
import net.wg.gui.lobby.battleloading.data.TeamVehiclesDataProvider;
import net.wg.gui.lobby.battleloading.interfaces.IBattleLoadingForm;
import net.wg.gui.lobby.battleloading.interfaces.IVehiclesDataProvider;
import net.wg.gui.lobby.battleloading.vo.LoadingFormDisplayDataVO;
import net.wg.gui.lobby.components.MinimapLobby;
import net.wg.gui.tutorial.controls.TipLoadingForm;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;

public class BattleLoadingForm extends TipLoadingForm implements IBattleLoadingForm {

    private static const MAP_SIZE:int = 360;

    private static const LOADING_BAR_MIN:int = 0;

    private static const LOADING_BAR_MAX:int = 1;

    private static const LOADING_BAR_DEF_VALUE:int = 0;

    public var team1Text:TextField;

    public var team2Text:TextField;

    public var team1List:ReadOnlyScrollingList;

    public var team2List:ReadOnlyScrollingList;

    public var tipImage:UILoaderAlt;

    public var map:MinimapLobby;

    public var mapBorder:MovieClip;

    public var tipBackground:MovieClip;

    public var mapBackground:MovieClip;

    public var formBackgroundTips:MovieClip;

    public var formBackgroundTable:MovieClip;

    private var _teamDP:TeamVehiclesDataProvider;

    private var _enemyDP:EnemyVehiclesDataProvider;

    private var _leftTeamName:String = "";

    private var _rightTeamName:String = "";

    public function BattleLoadingForm() {
        super();
    }

    override public function toString():String {
        return "[WG BattleLoadingForm " + name + "]";
    }

    override protected function onDispose():void {
        this.team1Text = null;
        this.team2Text = null;
        this.tipBackground = null;
        this.mapBackground = null;
        this.formBackgroundTips = null;
        this.formBackgroundTable = null;
        this.mapBorder = null;
        this.team1List.dispose();
        this.team1List = null;
        this.team2List.dispose();
        this.team2List = null;
        this._teamDP.cleanUp();
        this._teamDP = null;
        this._enemyDP.cleanUp();
        this._enemyDP = null;
        this.tipImage.dispose();
        this.tipImage = null;
        this.map = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            this.team1Text.text = this._leftTeamName;
            this.team2Text.text = this._rightTeamName;
        }
    }

    override protected function initialize():void {
        super.initialize();
        battleIcon.visible = false;
        this.formBackgroundTips.visible = false;
        this.hideMap();
        this.map.size = MAP_SIZE;
        this.configureTip(BattleLoadingHelper.TIP_TITLE_TABLE_TOP, BattleLoadingHelper.TIP_BODY_TABLE_TOP);
        this.team1List.visible = this.team2List.visible = false;
        this._teamDP = new TeamVehiclesDataProvider();
        this._enemyDP = new EnemyVehiclesDataProvider();
        this.team1List.dataProvider = this._teamDP;
        this.team2List.dataProvider = this._enemyDP;
        mapIcon.autoSize = false;
        loadingBar.minimum = LOADING_BAR_MIN;
        loadingBar.maximum = LOADING_BAR_MAX;
        loadingBar.value = LOADING_BAR_DEF_VALUE;
    }

    public function addVehicleInfo(param1:Boolean, param2:Object, param3:Array):void {
        var _loc4_:IVehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
        if (_loc4_.addVehicleInfo(param2, param3)) {
            _loc4_.invalidate(_loc4_.length);
        }
    }

    public function getMapComponent():MinimapLobby {
        return this.map;
    }

    public function setFormDisplayData(param1:String, param2:String, param3:int, param4:int, param5:Boolean):void {
        var _loc6_:BattleLoadingHelper = BattleLoadingHelper.instance;
        var _loc7_:LoadingFormDisplayDataVO = _loc6_.getLoadingFormDisplayData(param1);
        this._teamDP.setSelfBgSource(_loc7_.selfBgSource);
        this.formBackgroundTable.visible = _loc7_.showTableBackground;
        this.formBackgroundTips.visible = _loc7_.showTipsBackground;
        this.team1Text.x = _loc7_.leftTeamTitleLeft;
        this.team2Text.x = _loc7_.rightTeamTitleLeft;
        if (param5) {
            this.showMap(param3, param4);
        }
        else if (param2 != null) {
            this.configureTip(_loc7_.tipTitleTop, _loc7_.tipBodyTop, param2);
        }
        _loc6_.configureLists(this.team1List, this.team2List, _loc7_);
        this.team1List.visible = this.team2List.visible = true;
    }

    public function setPlayerInfo(param1:Number, param2:Number):void {
        this._teamDP.setPlayerVehicleID(param1);
        this._teamDP.setPrebattleID(param2);
    }

    public function setPlayerStatus(param1:Boolean, param2:Number, param3:uint):void {
        var _loc4_:IVehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
        if (_loc4_.setPlayerStatus(param2, param3)) {
            _loc4_.invalidate(_loc4_.length);
        }
    }

    public function setVehicleStatus(param1:Boolean, param2:Number, param3:uint, param4:Array):void {
        var _loc5_:IVehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
        var _loc6_:Boolean = _loc5_.setVehicleStatus(param2, param3);
        _loc6_ = _loc5_.setSorting(param4) || _loc6_;
        if (_loc6_) {
            _loc5_.invalidate(_loc5_.length);
        }
    }

    public function setVehiclesData(param1:Boolean, param2:Array):void {
        var _loc3_:IVehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
        _loc3_.setSource(param2);
        _loc3_.invalidate(_loc3_.length);
    }

    public function updateTeamsHeaders(param1:String, param2:String):void {
        this._leftTeamName = param1;
        this._rightTeamName = param2;
        invalidateData();
    }

    public function updateVehicleInfo(param1:Boolean, param2:Object, param3:Array):void {
        var _loc4_:IVehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
        var _loc5_:Boolean = _loc4_.updateVehicleInfo(param2);
        _loc5_ = _loc4_.setSorting(param3) || _loc5_;
        if (_loc5_) {
            _loc4_.invalidate(_loc4_.length);
        }
    }

    private function hideMap():void {
        this.map.visible = false;
        this.mapBackground.visible = false;
        this.mapBorder.visible = false;
    }

    private function showMap(param1:int, param2:int):void {
        this.mapBackground.visible = true;
        this.mapBorder.visible = true;
        this.map.setMinimapDataS(param1, param2, MAP_SIZE);
        this.map.border.visible = false;
        this.map.grid.visible = true;
        this.map.visible = true;
    }

    private function configureTip(param1:int, param2:int, param3:String = null):void {
        helpTip.y = param1;
        tipText.y = param2;
        var _loc4_:Boolean = StringUtils.isNotEmpty(param3);
        this.tipBackground.visible = this.tipImage.visible = _loc4_;
        if (_loc4_) {
            this.tipImage.source = param3;
        }
    }
}
}
