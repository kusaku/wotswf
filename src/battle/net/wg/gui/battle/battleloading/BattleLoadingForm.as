package net.wg.gui.battle.battleloading {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
import net.wg.data.constants.Linkages;
import net.wg.gui.battle.battleloading.data.EnemyVehiclesDataProvider;
import net.wg.gui.battle.battleloading.data.TeamVehiclesDataProvider;
import net.wg.gui.battle.battleloading.interfaces.IVehiclesDataProvider;
import net.wg.gui.battle.battleloading.renderers.BasePlayerItemRenderer;
import net.wg.gui.battle.battleloading.renderers.RendererContainer;
import net.wg.gui.battle.battleloading.renderers.TablePlayerItemRenderer;
import net.wg.gui.battle.battleloading.renderers.TipPlayerItemRenderer;
import net.wg.gui.battle.battleloading.vo.VisualTipInfoVO;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.components.minimap.MinimapPresentation;
import net.wg.gui.tutorial.controls.TipLoadingForm;
import net.wg.infrastructure.events.ListDataProviderEvent;
import net.wg.utils.IClassFactory;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;

public class BattleLoadingForm extends TipLoadingForm {

    private static const MAP_SIZE:int = 360;

    private static const LOADING_BAR_MIN:int = 0;

    private static const LOADING_BAR_MAX:int = 1;

    private static const LOADING_BAR_DEF_VALUE:int = 0;

    public var team1Text:TextField;

    public var team2Text:TextField;

    public var tipImage:UILoaderAlt;

    public var map:MinimapPresentation;

    public var mapBorder:MovieClip;

    public var tipBackground:MovieClip;

    public var mapBackground:MovieClip;

    public var formBackgroundTips:MovieClip;

    public var formBackgroundTable:MovieClip;

    private var _teamDP:TeamVehiclesDataProvider;

    private var _enemyDP:EnemyVehiclesDataProvider;

    private var _leftTeamName:String = "";

    private var _rightTeamName:String = "";

    private var _allyRenderers:Vector.<BasePlayerItemRenderer>;

    private var _enemyRenderers:Vector.<BasePlayerItemRenderer>;

    private var _renderersContainer:RendererContainer;

    public function BattleLoadingForm() {
        super();
    }

    override public function toString():String {
        return "[WG BattleLoadingForm " + name + "]";
    }

    override protected function onDispose():void {
        var _loc1_:BasePlayerItemRenderer = null;
        this.team1Text = null;
        this.team2Text = null;
        this.tipBackground = null;
        this.mapBackground = null;
        this.formBackgroundTips = null;
        this.formBackgroundTable = null;
        this.mapBorder = null;
        this._teamDP.removeEventListener(ListDataProviderEvent.VALIDATE_ITEMS, this.onAllyDataProviderUpdateItemHandler);
        this._teamDP.cleanUp();
        this._teamDP = null;
        this._enemyDP.removeEventListener(ListDataProviderEvent.VALIDATE_ITEMS, this.onEnemyDataProviderUpdateItemHandler);
        this._enemyDP.cleanUp();
        this._enemyDP = null;
        this.tipImage.dispose();
        this.tipImage = null;
        this.map = null;
        if (this._renderersContainer) {
            this._renderersContainer.dispose();
            this._renderersContainer = null;
        }
        for each(_loc1_ in this._allyRenderers) {
            _loc1_.dispose();
        }
        this._allyRenderers.splice(0, this._allyRenderers.length);
        this._allyRenderers = null;
        for each(_loc1_ in this._enemyRenderers) {
            _loc1_.dispose();
        }
        this._enemyRenderers.splice(0, this._enemyRenderers.length);
        this._enemyRenderers = null;
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
        this._teamDP = new TeamVehiclesDataProvider();
        this._teamDP.addEventListener(ListDataProviderEvent.VALIDATE_ITEMS, this.onAllyDataProviderUpdateItemHandler);
        this._enemyDP = new EnemyVehiclesDataProvider();
        this._enemyDP.addEventListener(ListDataProviderEvent.VALIDATE_ITEMS, this.onEnemyDataProviderUpdateItemHandler);
        mapIcon.autoSize = false;
        loadingBar.minimum = LOADING_BAR_MIN;
        loadingBar.maximum = LOADING_BAR_MAX;
        loadingBar.value = LOADING_BAR_DEF_VALUE;
        this._allyRenderers = new Vector.<BasePlayerItemRenderer>(0);
        this._enemyRenderers = new Vector.<BasePlayerItemRenderer>(0);
    }

    private function onAllyDataProviderUpdateItemHandler(param1:ListDataProviderEvent):void {
        var _loc4_:int = 0;
        var _loc2_:uint = this._allyRenderers.length - 1;
        var _loc3_:Vector.<int> = Vector.<int>(param1.data);
        for each(_loc4_ in _loc3_) {
            if (_loc4_ <= _loc2_) {
                this._allyRenderers[_loc4_].setData(this._teamDP.requestItemAt(_loc4_));
            }
        }
    }

    private function onEnemyDataProviderUpdateItemHandler(param1:ListDataProviderEvent):void {
        var _loc4_:int = 0;
        var _loc2_:uint = this._enemyRenderers.length - 1;
        var _loc3_:Vector.<int> = Vector.<int>(param1.data);
        for each(_loc4_ in _loc3_) {
            if (_loc4_ <= _loc2_) {
                this._enemyRenderers[_loc4_].setData(this._enemyDP.requestItemAt(_loc4_));
            }
        }
    }

    public function addVehiclesInfo(param1:Boolean, param2:Vector.<DAAPIVehicleInfoVO>, param3:Vector.<Number>):void {
        var _loc4_:IVehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
        if (_loc4_.addVehiclesInfo(param2, param3)) {
            _loc4_.invalidate();
        }
    }

    public function getMapComponent():MinimapPresentation {
        return this.map;
    }

    public function setFormDisplayData(param1:VisualTipInfoVO):void {
        this.formBackgroundTable.visible = param1.showTableBackground;
        this.formBackgroundTips.visible = param1.showTipsBackground;
        this.team1Text.x = param1.leftTeamTitleLeft;
        this.team2Text.x = param1.rightTeamTitleLeft;
        if (param1.showMinimap) {
            this.showMap(param1.arenaTypeID, param1.minimapTeam);
        }
        else if (param1.tipIcon != null) {
            this.configureTip(param1.tipTitleTop, param1.tipBodyTop, param1.tipIcon);
        }
        if (this._renderersContainer) {
            this._renderersContainer.dispose();
            removeChild(this._renderersContainer);
        }
        var _loc2_:IClassFactory = App.utils.classFactory;
        var _loc3_:String = param1.settingID == BattleLoadingHelper.SETTING_TEXT ? Linkages.BATTLE_LOADING_TABLE_RENDERERS : Linkages.BATTLE_LOADING_TIPS_RENDERERS;
        var _loc4_:Class = param1.settingID == BattleLoadingHelper.SETTING_TEXT ? TablePlayerItemRenderer : TipPlayerItemRenderer;
        this._renderersContainer = _loc2_.getComponent(_loc3_, RendererContainer);
        this._renderersContainer.mouseEnabled = false;
        this._renderersContainer.mouseChildren = false;
        this._renderersContainer.x = -506;
        this._renderersContainer.y = 112;
        var _loc5_:int = 15;
        var _loc6_:int = 0;
        while (_loc6_ < _loc5_) {
            this._allyRenderers.push(new _loc4_(this._renderersContainer, _loc6_, false));
            this._enemyRenderers.push(new _loc4_(this._renderersContainer, _loc6_, true));
            _loc6_++;
        }
        addChild(this._renderersContainer);
    }

    public function setPlayerInfo(param1:Number, param2:Number):void {
        this._teamDP.setPlayerVehicleID(param1);
        this._teamDP.setPrebattleID(param2);
    }

    public function setPlayerStatus(param1:Boolean, param2:Number, param3:uint):void {
        var _loc4_:IVehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
        if (_loc4_.setPlayerStatus(param2, param3)) {
            _loc4_.invalidate();
        }
    }

    public function setVehicleStatus(param1:Boolean, param2:Number, param3:uint, param4:Vector.<Number>):void {
        var _loc5_:IVehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
        var _loc6_:Boolean = _loc5_.setVehicleStatus(param2, param3);
        _loc6_ = _loc5_.setSorting(param4) || _loc6_;
        if (_loc6_) {
            _loc5_.invalidate();
        }
    }

    public function setVehiclesData(param1:Boolean, param2:Array, param3:Vector.<Number>):void {
        var _loc4_:IVehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
        _loc4_.setSource(param2);
        _loc4_.setSorting(param3);
        _loc4_.invalidate();
    }

    public function updateTeamsHeaders(param1:String, param2:String):void {
        this._leftTeamName = param1;
        this._rightTeamName = param2;
        invalidateData();
    }

    public function updateVehiclesInfo(param1:Boolean, param2:Vector.<DAAPIVehicleInfoVO>, param3:Vector.<Number>):void {
        var _loc4_:IVehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
        var _loc5_:Boolean = _loc4_.updateVehiclesInfo(param2);
        _loc5_ = _loc4_.setSorting(param3) || _loc5_;
        if (_loc5_) {
            _loc4_.invalidate();
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

    public function setUserTags(param1:Boolean, param2:Vector.<DAAPIVehicleUserTagsVO>):void {
        var _loc3_:IVehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
        if (_loc3_.setUserTags(param2)) {
            _loc3_.invalidate();
        }
    }
}
}
