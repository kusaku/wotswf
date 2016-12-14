package net.wg.gui.battle.falloutMultiteam.views.components.fullStats {
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.VO.daapi.DAAPIArenaInfoVO;
import net.wg.data.VO.daapi.DAAPIPlayerStatusVO;
import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
import net.wg.data.VO.daapi.DAAPIVehiclesInteractiveStatsVO;
import net.wg.data.VO.daapi.DAAPIVehiclesUserTagsVO;
import net.wg.data.constants.Errors;
import net.wg.gui.battle.views.stats.BattleTipsController;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.infrastructure.base.meta.IFMStatsMeta;
import net.wg.infrastructure.base.meta.impl.FMStatsMeta;
import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
import net.wg.infrastructure.interfaces.IDAAPIDataClass;

import scaleform.gfx.TextFieldEx;

public class FMFullStats extends FMStatsMeta implements IFMStatsMeta, IBattleComponentDataController {

    private static const SUB_TYPE_FFA:String = "ffa";

    private static const BG_FFA_LINKAGE:String = "FMStatsBgFFA";

    private static const BG_TEAMS_LINKAGE:String = "FMStatsBgTeams";

    private static const HEIGHT:Number = 664;

    private static const WIDTH:Number = 1454;

    public var mapTF:TextField = null;

    public var battleTF:TextField = null;

    public var winTF:TextField = null;

    public var titleTipTF:TextField = null;

    public var bodyTipLeftTF:TextField = null;

    public var bodyTipRightTF:TextField = null;

    public var bodyTipCenterTF:TextField = null;

    public var mapIcon:UILoaderAlt = null;

    public var modalBgSpr:Sprite = null;

    public var table:FMStatsTable = null;

    public var bg:MovieClip = null;

    private var _tableCtrl:FMStatsTableController = null;

    private var _battleTips:BattleTipsController = null;

    public function FMFullStats() {
        super();
        this._tableCtrl = new FMStatsTableController(this.table);
        this._battleTips = new BattleTipsController(this.titleTipTF, this.bodyTipLeftTF, this.bodyTipRightTF, this.bodyTipCenterTF);
        TextFieldEx.setNoTranslate(this.battleTF, true);
        TextFieldEx.setNoTranslate(this.winTF, true);
        TextFieldEx.setNoTranslate(this.mapTF, true);
        visible = false;
    }

    public function as_setSubType(param1:String):void {
        var _loc2_:* = param1 == SUB_TYPE_FFA;
        this.drawBg(_loc2_);
        this._tableCtrl.setTeamsAvailable(!_loc2_);
    }

    public function updateStageSize(param1:Number, param2:Number):void {
        var _loc3_:Number = NaN;
        var _loc4_:Number = NaN;
        this.modalBgSpr.visible = false;
        _loc3_ = param1 - WIDTH >> 1;
        _loc4_ = param2 - HEIGHT >> 1;
        this.x = _loc3_;
        this.y = _loc4_;
        this.modalBgSpr.x = -_loc3_;
        this.modalBgSpr.y = -_loc4_;
        this.modalBgSpr.width = param1;
        this.modalBgSpr.height = param2;
        this.modalBgSpr.visible = true;
    }

    public function setVehiclesData(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
        if (_loc2_.leftVehicleInfos) {
            this._tableCtrl.setVehiclesData(_loc2_.leftVehicleInfos);
        }
        if (_loc2_.leftVehiclesIDs) {
            this._tableCtrl.updateOrder(_loc2_.leftVehiclesIDs);
        }
    }

    public function addVehiclesInfo(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
        if (_loc2_.leftVehicleInfos) {
            this._tableCtrl.addVehiclesData(_loc2_.leftVehicleInfos);
        }
        if (_loc2_.leftVehiclesIDs) {
            this._tableCtrl.updateOrder(_loc2_.leftVehiclesIDs);
        }
    }

    public function updateVehiclesData(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
        if (_loc2_.leftVehicleInfos) {
            this._tableCtrl.updateVehiclesData(_loc2_.leftVehicleInfos);
        }
        if (_loc2_.leftVehiclesIDs) {
            this._tableCtrl.updateOrder(_loc2_.leftVehiclesIDs);
        }
    }

    public function updateVehicleStatus(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(param1);
        this._tableCtrl.setVehicleStatus(_loc2_.vehicleID, _loc2_.status);
        if (_loc2_.leftVehiclesIDs) {
            this._tableCtrl.updateOrder(_loc2_.leftVehiclesIDs);
        }
    }

    public function updatePersonalStatus(param1:uint, param2:uint):void {
    }

    public function setVehicleStats(param1:IDAAPIDataClass):void {
        this.setVehiclesStats(DAAPIVehiclesInteractiveStatsVO(param1));
    }

    public function updateVehiclesStat(param1:IDAAPIDataClass):void {
        this.setVehiclesStats(DAAPIVehiclesInteractiveStatsVO(param1));
    }

    public function updatePlayerStatus(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIPlayerStatusVO = DAAPIPlayerStatusVO(param1);
        this._tableCtrl.setPlayerStatus(_loc2_.vehicleID, _loc2_.status);
    }

    public function setArenaInfo(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIArenaInfoVO = DAAPIArenaInfoVO(param1);
        this.mapIcon.source = _loc2_.mapIcon;
        this.mapTF.text = _loc2_.mapName;
        this.battleTF.text = _loc2_.battleTypeLocaleStr;
        var _loc3_:Number = this.winTF.y + (this.winTF.height >> 1);
        var _loc4_:Number = this.battleTF.y + (this.winTF.height >> 1);
        this.winTF.autoSize = TextFieldAutoSize.CENTER;
        this.winTF.text = _loc2_.winText;
        this.winTF.y = _loc3_ - (this.winTF.height >> 1);
        this.battleTF.y = _loc4_ - (this.winTF.height >> 1);
        if (_loc2_.getQuestTipsTitle()) {
            this._battleTips.setText(_loc2_.getQuestTipsTitle(), _loc2_.getQuestTipsMainCondition(), _loc2_.getQuestTipsAdditionalCondition());
        }
        else {
            this._battleTips.hide();
        }
    }

    public function setUserTags(param1:IDAAPIDataClass):void {
        var _loc4_:DAAPIVehicleUserTagsVO = null;
        var _loc2_:DAAPIVehiclesUserTagsVO = DAAPIVehiclesUserTagsVO(param1);
        var _loc3_:Vector.<DAAPIVehicleUserTagsVO> = _loc2_.leftUserTags;
        for each(_loc4_ in _loc3_) {
            this._tableCtrl.setUserTags(_loc4_.vehicleID, _loc4_.userTags);
        }
    }

    public function updateUserTags(param1:IDAAPIDataClass):void {
        var _loc2_:DAAPIVehicleUserTagsVO = DAAPIVehicleUserTagsVO(param1);
        this._tableCtrl.setUserTags(_loc2_.vehicleID, _loc2_.userTags);
    }

    public function setPersonalStatus(param1:uint):void {
    }

    public function updateInvitationsStatuses(param1:IDAAPIDataClass):void {
    }

    override protected function onDispose():void {
        this.table.dispose();
        this.mapIcon.dispose();
        this._tableCtrl.dispose();
        this._battleTips.dispose();
        this.mapTF = null;
        this.battleTF = null;
        this.winTF = null;
        this.titleTipTF = null;
        this.bodyTipLeftTF = null;
        this.bodyTipRightTF = null;
        this.bodyTipCenterTF = null;
        this.modalBgSpr = null;
        this.table = null;
        this.bg = null;
        this.mapIcon = null;
        this._tableCtrl = null;
        this._battleTips = null;
        super.onDispose();
    }

    private function drawBg(param1:Boolean):void {
        var _loc2_:Graphics = this.bg.graphics;
        var _loc3_:String = !!param1 ? BG_FFA_LINKAGE : BG_TEAMS_LINKAGE;
        var _loc4_:BitmapData = App.utils.classFactory.getObject(_loc3_) as BitmapData;
        App.utils.asserter.assertNotNull(_loc4_, "bitmapData" + Errors.CANT_NULL);
        _loc2_.clear();
        _loc2_.beginBitmapFill(_loc4_, null, false, true);
        _loc2_.drawRect(0, 0, _loc4_.width, _loc4_.height);
        _loc2_.endFill();
    }

    private function setVehiclesStats(param1:DAAPIVehiclesInteractiveStatsVO):void {
        if (param1.leftVehicleStats) {
            this._tableCtrl.setVehiclesStats(param1.leftVehicleStats);
        }
        if (param1.leftItemsIDs) {
            this._tableCtrl.updateOrder(param1.leftItemsIDs);
        }
    }
}
}
