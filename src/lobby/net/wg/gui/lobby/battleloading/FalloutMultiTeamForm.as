package net.wg.gui.lobby.battleloading {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.geom.Point;

import net.wg.data.constants.Linkages;
import net.wg.gui.components.controls.ReadOnlyScrollingList;
import net.wg.gui.lobby.battleloading.components.MultiTeamIcons;
import net.wg.gui.lobby.battleloading.constants.FalloutMultiTeamTypes;
import net.wg.gui.lobby.battleloading.data.TeamVehiclesDataProvider;
import net.wg.gui.lobby.battleloading.interfaces.IFalloutLoadingForm;
import net.wg.gui.lobby.battleloading.vo.MultiTeamIconInfoVO;
import net.wg.gui.lobby.battleloading.vo.VehicleInfoVO;
import net.wg.gui.lobby.eventInfoPanel.EventInfoPanel;
import net.wg.gui.lobby.eventInfoPanel.data.EventInfoPanelVO;

import scaleform.clik.constants.InvalidationType;

public class FalloutMultiTeamForm extends BaseLoadingForm implements IFalloutLoadingForm {

    private static const LIST_BOTTOM_PADDING:int = 10;

    private static const LOADING_BAR_BOTTOM_PADDING:int = 15;

    public var playersList:ReadOnlyScrollingList;

    public var background:MovieClip;

    public var multiTeamIcons:MultiTeamIcons;

    private var _battleType:String = "fallout_ffa";

    private var _playersDP:TeamVehiclesDataProvider;

    private var _multiTeamIconData:Vector.<MultiTeamIconInfoVO>;

    public function FalloutMultiTeamForm() {
        super();
        this._playersDP = new TeamVehiclesDataProvider();
        this._multiTeamIconData = new Vector.<MultiTeamIconInfoVO>();
    }

    override public function setEventInfo(param1:EventInfoPanelVO):void {
        super.setEventInfo(param1);
        this.updateEventInfoPanelVisibility();
    }

    override protected function onDispose():void {
        this.cleanMultiTeamIconData();
        this.playersList.dispose();
        this.playersList = null;
        this._playersDP.cleanUp();
        this._playersDP = null;
        this.multiTeamIcons.dispose();
        this.multiTeamIcons = null;
        this.background = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.playersList.dataProvider = this._playersDP;
        this.background.stop();
    }

    override protected function draw():void {
        var _loc1_:* = false;
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            this.background.gotoAndStop(this._battleType);
            this.multiTeamIcons.visible = this._battleType != FalloutMultiTeamTypes.FFA;
        }
        if (isInvalid(InvalidationType.SIZE)) {
            _loc1_ = this.playersList.y + this.playersList.height + LIST_BOTTOM_PADDING > loadingBar.y;
            if (_loc1_) {
                loadingBar.y = this.playersList.y + this.playersList.height + LIST_BOTTOM_PADDING;
                DisplayObject(eventInfoPanel).y = loadingBar.y + loadingBar.height + LOADING_BAR_BOTTOM_PADDING;
            }
            this.updateEventInfoPanelVisibility();
        }
    }

    public function addVehicleInfo(param1:Object, param2:Array):void {
        if (this._playersDP.addVehicleInfo(param1, param2)) {
            this._playersDP.invalidate(this._playersDP.length);
            this.updateMultiTeamIcons();
        }
    }

    public function beforePopulateData():void {
        this._playersDP.setSelfBgSource(RES_ICONS.MAPS_ICONS_BATTLELOADING_SELFTABLEBACKGROUND);
    }

    public function setPlayerInfo(param1:Number, param2:Number):void {
        this._playersDP.setPlayerVehicleID(param1);
        this._playersDP.setPrebattleID(param2);
    }

    public function setPlayerStatus(param1:Number, param2:uint):void {
        if (this._playersDP.setPlayerStatus(param1, param2)) {
            this._playersDP.invalidate(this._playersDP.length);
            this.updateMultiTeamIcons();
        }
    }

    public function setVehicleStatus(param1:Number, param2:uint, param3:Array):void {
        var _loc4_:Boolean = this._playersDP.setVehicleStatus(param1, param2);
        _loc4_ = this._playersDP.setSorting(param3) || _loc4_;
        if (_loc4_) {
            this._playersDP.invalidate(this._playersDP.length);
            this.updateMultiTeamIcons();
        }
    }

    public function setVehiclesData(param1:Array):void {
        this._playersDP.setSource(param1);
        this._playersDP.invalidate(this._playersDP.length);
        this.updateMultiTeamIcons();
    }

    public function updateVehicleInfo(param1:Object, param2:Array):void {
        var _loc3_:Boolean = this._playersDP.updateVehicleInfo(param1);
        _loc3_ = this._playersDP.setSorting(param2) || _loc3_;
        if (_loc3_) {
            this._playersDP.invalidate(this._playersDP.length);
            this.updateMultiTeamIcons();
        }
    }

    private function updateMultiTeamIcons():void {
        var _loc6_:MultiTeamIconInfoVO = null;
        var _loc8_:VehicleInfoVO = null;
        var _loc9_:* = false;
        var _loc10_:* = false;
        var _loc11_:Boolean = false;
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        this.cleanMultiTeamIconData();
        this._multiTeamIconData = new Vector.<MultiTeamIconInfoVO>();
        var _loc3_:int = this._playersDP.length;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc7_:int = 0;
        while (_loc7_ < _loc3_) {
            _loc8_ = this._playersDP[_loc7_];
            _loc9_ = _loc8_.squadIndex == VehicleInfoVO.DEFAULT_SQUAD_IDX;
            _loc10_ = _loc3_ - 1 < _loc7_;
            _loc11_ = this._multiTeamIconData.length > 0 && !_loc10_;
            if (_loc9_ || _loc4_ != _loc8_.squadIndex) {
                _loc5_ = 0;
                _loc4_ = _loc8_.squadIndex;
                _loc6_ = this.getDefaultIconVO(!_loc9_, _loc4_, _loc11_);
                this._multiTeamIconData.push(_loc6_);
            }
            if (_loc9_) {
                _loc1_++;
            }
            else {
                _loc2_++;
            }
            _loc6_.points = _loc6_.points + _loc8_.points;
            _loc6_.countItems++;
            _loc6_.isSelf = _loc8_.isCurrentPlayer || _loc8_.isCurrentSquad;
            _loc7_++;
        }
        this.multiTeamIcons.setData(this._multiTeamIconData);
        this.updateListHeight(_loc3_);
        this.updateBattleType(_loc1_, _loc2_);
    }

    private function getDefaultIconVO(param1:Boolean, param2:int, param3:Boolean):MultiTeamIconInfoVO {
        var _loc4_:MultiTeamIconInfoVO = new MultiTeamIconInfoVO();
        _loc4_.isSquad = param1;
        _loc4_.isSelf = false;
        _loc4_.label = param2.toString();
        _loc4_.countItems = 0;
        _loc4_.isWithSeparator = param3;
        return _loc4_;
    }

    private function updateEventInfoPanelVisibility():void {
        var _loc1_:Point = localToGlobal(new Point(loadingBar.x, loadingBar.y));
        var _loc2_:int = App.appHeight - _loc1_.y - loadingBar.height;
        var _loc3_:* = _loc2_ >= LOADING_BAR_BOTTOM_PADDING + EventInfoPanel.HEIGHT_WITHOUT_SHADOW;
        eventInfoPanel.visible = _loc3_ && !eventInfoPanel.isEmptyData;
    }

    private function updateBattleType(param1:int, param2:int):void {
        var _loc3_:String = null;
        if (param2 == 0) {
            this._battleType = FalloutMultiTeamTypes.FFA;
            _loc3_ = Linkages.MULTI_TEAM_FFA_RENDERER_UI;
        }
        else if (param1 == 0 && param2 > 0) {
            this._battleType = FalloutMultiTeamTypes.TEAMS;
            _loc3_ = Linkages.MULTI_TEAM_RENDERER_UI;
        }
        else if (param1 > 0 && param2 > 0) {
            this._battleType = FalloutMultiTeamTypes.MIX;
            _loc3_ = Linkages.MULTI_TEAM_RENDERER_UI;
        }
        this.playersList.itemRendererName = _loc3_;
        invalidateData();
    }

    private function updateListHeight(param1:int):void {
        var _loc2_:int = MultiTeamRenderer.DEFAULT_RENDERER_HEIGHT * param1;
        if (this.playersList.height != _loc2_) {
            this.playersList.height = _loc2_;
        }
        invalidateSize();
    }

    private function cleanMultiTeamIconData():void {
        var _loc3_:MultiTeamIconInfoVO = null;
        var _loc1_:int = this._multiTeamIconData.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            _loc3_ = this._multiTeamIconData[_loc2_];
            _loc3_.dispose();
            _loc2_++;
        }
        this._multiTeamIconData.splice(0, this._multiTeamIconData.length);
        this._multiTeamIconData = null;
    }
}
}
