package net.wg.gui.lobby.battleResults.components {
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

import net.wg.data.VO.UserVO;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.components.controls.UserNameField;
import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
import net.wg.gui.lobby.battleResults.data.VehicleStatsVO;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IUserProps;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ListEvent;

public class TankStatsView extends UIComponentEx {

    private static const GARAGE:String = "garage";

    private static const DEFAULT:String = "default";

    private static const PLAYER_NAME_BOTTOM_PADDING:int = 20;

    private static const DEAD_NAME_TEXT_COLOR:int = 8684674;

    private static const LIVING_PLAYER_TEXT_COLOR:int = 8684674;

    private static const TEXT_POSITIONS:Object = {
        "default": new Point(264, 20),
        "garage": new Point(264, 6)
    };

    public var playerNameLbl:UserNameField = null;

    public var arenaCreateDateLbl:TextField = null;

    public var vehicleStateLbl:TextField = null;

    public var tankNameLbl:TextField = null;

    public var selectTank:TextField = null;

    public var tankIcon:UILoaderAlt = null;

    public var bgOverlay:UILoaderAlt = null;

    public var areaIcon:UILoaderAlt = null;

    public var dropDown:DropdownMenu = null;

    private var _data:BattleResultsVO = null;

    private var _playerVehicles:Vector.<VehicleStatsVO> = null;

    private var _toolTip:String = "";

    public function TankStatsView() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.dropDown.addEventListener(ListEvent.INDEX_CHANGE, this.onDropDownIndexChangeHandler);
        this.selectTank.text = App.utils.locale.makeString(BATTLE_RESULTS.SELECTVEHICLE);
    }

    override protected function draw():void {
        var _loc1_:CommonStatsVO = null;
        var _loc2_:* = false;
        super.draw();
        if (this._data && isInvalid(InvalidationType.DATA)) {
            _loc1_ = this._data.common;
            this.areaIcon.source = _loc1_.arenaIcon;
            this.playerNameLbl.userVO = new UserVO({
                "fullName": _loc1_.playerFullNameStr,
                "userName": _loc1_.playerNameStr,
                "clanAbbrev": _loc1_.clanNameStr,
                "region": _loc1_.regionNameStr
            });
            _loc2_ = _loc1_.playerVehicles.length == 1;
            if (_loc2_) {
                this.tankNameLbl.htmlText = _loc1_.playerVehicleNames[0];
                this.setVehicleStateLbl();
            }
            this.arenaCreateDateLbl.text = _loc1_.arenaCreateTimeStr;
            this.customizeByCountVehicles(_loc2_);
        }
    }

    override protected function onDispose():void {
        this.selectTank = null;
        this._data = null;
        this._playerVehicles = null;
        this.playerNameLbl.dispose();
        this.playerNameLbl = null;
        this.arenaCreateDateLbl = null;
        this.tankNameLbl = null;
        this.vehicleStateLbl.removeEventListener(MouseEvent.ROLL_OVER, this.onVehicleStateLblRollOverHandler);
        this.vehicleStateLbl.removeEventListener(MouseEvent.ROLL_OUT, this.onVehicleStateLblRollOutHandler);
        this.vehicleStateLbl = null;
        this.tankIcon.dispose();
        this.tankIcon = null;
        this.bgOverlay.dispose();
        this.bgOverlay = null;
        this.areaIcon.dispose();
        this.areaIcon = null;
        this.dropDown.removeEventListener(ListEvent.INDEX_CHANGE, this.onDropDownIndexChangeHandler);
        this.dropDown.dispose();
        this.dropDown = null;
        super.onDispose();
    }

    public function setData(param1:BattleResultsVO):void {
        this._data = param1;
        this._playerVehicles = this._data.common.playerVehicles;
        var _loc2_:int = this._playerVehicles.length;
        if (_loc2_ > 1) {
            this.dropDown.dataProvider = new DataProvider(param1.common.playerVehicleNames);
        }
        var _loc3_:VehicleStatsVO = this._playerVehicles[0];
        this.tankIcon.source = _loc3_.tankIcon;
        invalidateData();
    }

    public function setVehicleIdxInGarageDropdown(param1:int):void {
        this.dropDown.selectedIndex = param1;
    }

    private function setVehicleStateLbl():void {
        var _loc2_:IUserProps = null;
        var _loc3_:Boolean = false;
        var _loc1_:VehicleStatsVO = this._playerVehicles[0];
        if (_loc1_.isPrematureLeave || _loc1_.killerID <= 0) {
            this.vehicleStateLbl.text = _loc1_.vehicleStateStr;
        }
        else if (_loc1_.killerID > 0) {
            _loc2_ = App.utils.commons.getUserProps(_loc1_.killerNameStr, _loc1_.killerClanNameStr, _loc1_.killerRegionNameStr);
            _loc2_.prefix = _loc1_.vehicleStatePrefixStr;
            _loc2_.suffix = _loc1_.vehicleStateSuffixStr;
            _loc3_ = App.utils.commons.formatPlayerName(this.vehicleStateLbl, _loc2_);
            if (_loc3_) {
                this.toolTip = _loc1_.vehicleStatePrefixStr + _loc1_.killerFullNameStr + _loc1_.vehicleStateSuffixStr;
            }
        }
        this.vehicleStateLbl.textColor = _loc1_.killerID == 0 ? uint(LIVING_PLAYER_TEXT_COLOR) : uint(DEAD_NAME_TEXT_COLOR);
    }

    private function customizeByCountVehicles(param1:Boolean):void {
        this.vehicleStateLbl.visible = param1;
        this.tankNameLbl.visible = param1;
        this.dropDown.visible = !param1;
        this.selectTank.visible = !param1;
        var _loc2_:String = !!param1 ? DEFAULT : GARAGE;
        var _loc3_:Point = TEXT_POSITIONS[_loc2_];
        this.playerNameLbl.x = _loc3_.x;
        this.playerNameLbl.y = _loc3_.y;
        this.arenaCreateDateLbl.x = _loc3_.x;
        this.arenaCreateDateLbl.y = _loc3_.y + PLAYER_NAME_BOTTOM_PADDING;
    }

    public function get toolTip():String {
        return this._toolTip;
    }

    public function set toolTip(param1:String):void {
        this._toolTip = param1;
        this.vehicleStateLbl.addEventListener(MouseEvent.ROLL_OVER, this.onVehicleStateLblRollOverHandler);
        this.vehicleStateLbl.addEventListener(MouseEvent.ROLL_OUT, this.onVehicleStateLblRollOutHandler);
    }

    private function onVehicleStateLblRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.show(this.toolTip);
    }

    private function onVehicleStateLblRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onDropDownIndexChangeHandler(param1:ListEvent):void {
        var _loc2_:int = param1.index;
        this._data.selectedIdxInGarageDropdown = _loc2_;
        var _loc3_:VehicleStatsVO = this._playerVehicles[_loc2_];
        this.tankIcon.source = _loc3_.tankIcon;
    }
}
}
