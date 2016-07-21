package net.wg.gui.cyberSport.staticFormation.views {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.utils.Dictionary;

import net.wg.data.constants.Errors;
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.SortableTable;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.cyberSport.staticFormation.components.LadderIconMessage;
import net.wg.gui.cyberSport.staticFormation.components.renderers.StaticFormationLadderTableRenderer;
import net.wg.gui.cyberSport.staticFormation.data.LadderStateDataVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationLadderTableRendererVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationLadderViewHeaderVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationLadderViewIconsVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationLadderViewLadderVO;
import net.wg.gui.cyberSport.staticFormation.events.FormationLadderEvent;
import net.wg.gui.events.SortableTableListEvent;
import net.wg.infrastructure.base.meta.IStaticFormationLadderViewMeta;
import net.wg.infrastructure.base.meta.impl.StaticFormationLadderViewMeta;
import net.wg.infrastructure.interfaces.IViewStackContent;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.data.DataProvider;
import scaleform.clik.interfaces.IDataProvider;
import scaleform.clik.interfaces.IListItemRenderer;
import scaleform.clik.utils.Padding;

public class StaticFormationLadderView extends StaticFormationLadderViewMeta implements IStaticFormationLadderViewMeta, IViewStackContent {

    private static const FORMATION_ID_FIELD:String = "formationId";

    public var formationIconLoader:UILoaderAlt = null;

    public var divisionNameTf:TextField = null;

    public var divisionPositionTf:TextField = null;

    public var ladderTable:SortableTable = null;

    public var message:LadderIconMessage = null;

    public var separator:MovieClip = null;

    private var _clubDBID:Number = NaN;

    public function StaticFormationLadderView() {
        super();
    }

    private static function onFormationIconLoaderRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    override protected function configUI():void {
        super.configUI();
        this.ladderTable.addEventListener(FormationLadderEvent.SHOW_FORMATION_PROFILE, this.onLadderTableShowFormationProfileHandler);
        this.ladderTable.addEventListener(SortableTableListEvent.RENDERERS_DATA_CNAHGE, this.onLadderTableRenderersDataChangeHandler);
        this.ladderTable.listPadding = new Padding(4, 0, 0, 0);
        this.ladderTable.scrollbarPadding = new Padding(-4, 0, 4, 0);
        this.formationIconLoader.addEventListener(MouseEvent.ROLL_OVER, this.onFormationIconLoaderRollOverHandler);
        this.formationIconLoader.addEventListener(MouseEvent.ROLL_OUT, onFormationIconLoaderRollOutHandler);
        this.message.visible = false;
    }

    override protected function updateHeaderData(param1:StaticFormationLadderViewHeaderVO):void {
        this.divisionNameTf.htmlText = param1.divisionName;
        this.divisionPositionTf.htmlText = param1.divisionPositionText;
        this.formationIconLoader.source = param1.formationIconPath;
        this.ladderTable.headerDP = new DataProvider(App.utils.data.vectorToArray(param1.tableHeader));
        this._clubDBID = param1.clubDBID;
    }

    override protected function updateLadderData(param1:StaticFormationLadderViewLadderVO):void {
        this.ladderTable.listDP.cleanUp();
        var _loc2_:Boolean = param1 != null && param1.hasFormations();
        var _loc3_:int = Values.DEFAULT_INT;
        if (_loc2_) {
            this.ladderTable.listDP = new DataProvider(param1.formations);
            if (!isNaN(this._clubDBID)) {
                _loc3_ = this.findClubInListDP(this._clubDBID);
            }
        }
        else {
            this.ladderTable.listDP = new DataProvider([]);
            _loc3_ = Values.DEFAULT_INT;
        }
        this.ladderTable.scrollListToItemByUniqKey(FORMATION_ID_FIELD, _loc3_);
        this.ladderTable.validateNow();
    }

    override protected function onDispose():void {
        this.ladderTable.removeEventListener(FormationLadderEvent.SHOW_FORMATION_PROFILE, this.onLadderTableShowFormationProfileHandler);
        this.ladderTable.removeEventListener(SortableTableListEvent.RENDERERS_DATA_CNAHGE, this.onLadderTableRenderersDataChangeHandler);
        this.formationIconLoader.removeEventListener(MouseEvent.ROLL_OVER, this.onFormationIconLoaderRollOverHandler);
        this.formationIconLoader.removeEventListener(MouseEvent.ROLL_OUT, onFormationIconLoaderRollOutHandler);
        this.formationIconLoader.dispose();
        this.ladderTable.dispose();
        this.message.dispose();
        this.formationIconLoader = null;
        this.ladderTable = null;
        this.divisionNameTf = null;
        this.divisionPositionTf = null;
        this.message = null;
        this.separator = null;
        super.onDispose();
    }

    override protected function setLadderState(param1:LadderStateDataVO):void {
        var _loc2_:* = false;
        _loc2_ = !param1.showStateMessage;
        this.formationIconLoader.visible = _loc2_;
        this.ladderTable.visible = _loc2_;
        this.divisionNameTf.visible = _loc2_;
        this.divisionPositionTf.visible = _loc2_;
        this.separator.visible = _loc2_;
        this.message.visible = !_loc2_;
        if (this.message.visible) {
            this.message.setData(param1.stateMessage);
            this.message.x = this.width - this.message.width >> 1;
        }
    }

    override protected function onUpdateClubIcons(param1:StaticFormationLadderViewIconsVO):void {
        var _loc3_:String = null;
        var _loc6_:int = 0;
        var _loc8_:StaticFormationLadderTableRenderer = null;
        var _loc2_:Dictionary = param1.iconsMap;
        App.utils.asserter.assertNotNull(_loc2_, "Icons map" + Errors.CANT_NULL);
        var _loc4_:int = this.ladderTable.listDP.length;
        var _loc5_:StaticFormationLadderTableRendererVO = null;
        _loc6_ = 0;
        while (_loc6_ < _loc4_) {
            _loc5_ = this.ladderTable.listDP[_loc6_];
            _loc3_ = _loc2_[_loc5_.formationId];
            if (_loc3_ != null) {
                _loc5_.emblemIconPath = _loc3_;
            }
            _loc6_++;
        }
        var _loc7_:int = this.ladderTable.totalRenderers;
        _loc6_ = 0;
        while (_loc6_ < _loc7_) {
            _loc8_ = StaticFormationLadderTableRenderer(this.ladderTable.getRendererAt(_loc6_, 0));
            if (!isNaN(_loc8_.formationId)) {
                _loc3_ = _loc2_[_loc8_.formationId];
                if (_loc3_ != null) {
                    _loc8_.updateEmblemIcon();
                }
            }
            _loc6_++;
        }
    }

    public function as_onUpdateClubIcon(param1:Number, param2:String):void {
        var _loc4_:StaticFormationLadderTableRendererVO = null;
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        var _loc7_:StaticFormationLadderTableRenderer = null;
        var _loc3_:int = this.findClubInListDP(param1);
        if (_loc3_ >= 0) {
            _loc4_ = StaticFormationLadderTableRendererVO(this.ladderTable.listDP.requestItemAt(_loc3_));
            _loc4_.emblemIconPath = param2;
            _loc5_ = this.ladderTable.totalRenderers;
            _loc6_ = 0;
            while (_loc6_ < _loc5_) {
                _loc7_ = StaticFormationLadderTableRenderer(this.ladderTable.getRendererAt(_loc6_, 0));
                if (param1 == _loc7_.formationId) {
                    _loc7_.updateEmblemIcon();
                    break;
                }
                _loc6_++;
            }
        }
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return null;
    }

    public function update(param1:Object):void {
    }

    private function findClubInListDP(param1:Number):int {
        var _loc2_:IDataProvider = this.ladderTable.listDP;
        var _loc3_:int = _loc2_.length;
        var _loc4_:StaticFormationLadderTableRendererVO = null;
        var _loc5_:int = 0;
        while (_loc5_ < _loc3_) {
            _loc4_ = StaticFormationLadderTableRendererVO(_loc2_.requestItemAt(_loc5_));
            if (_loc4_.formationId == param1) {
                return _loc5_;
            }
            _loc5_++;
        }
        return Values.DEFAULT_INT;
    }

    private function onFormationIconLoaderRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.LADDER, null, this._clubDBID);
    }

    private function onLadderTableShowFormationProfileHandler(param1:FormationLadderEvent):void {
        showFormationProfileS(param1.formationId);
    }

    private function onLadderTableRenderersDataChangeHandler(param1:SortableTableListEvent):void {
        var _loc3_:IListItemRenderer = null;
        var _loc4_:StaticFormationLadderTableRenderer = null;
        var _loc2_:Vector.<IListItemRenderer> = param1.changedRenderers;
        var _loc5_:Array = [];
        for each(_loc3_ in _loc2_) {
            if (_loc3_.getData() != null) {
                _loc4_ = _loc3_ as StaticFormationLadderTableRenderer;
                if (_loc4_ != null && StringUtils.isEmpty(_loc4_.emblemIconPath)) {
                    _loc5_.push(_loc4_.formationId);
                }
            }
        }
        if (_loc5_.length > 0) {
            updateClubIconsS(_loc5_);
        }
    }
}
}
