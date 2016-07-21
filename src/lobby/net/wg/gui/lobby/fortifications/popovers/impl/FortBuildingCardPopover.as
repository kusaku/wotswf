package net.wg.gui.lobby.fortifications.popovers.impl {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.geom.Point;

import net.wg.data.utilData.TwoDimensionalPadding;
import net.wg.gui.components.popOvers.PopOver;
import net.wg.gui.lobby.fortifications.cmp.build.impl.BuildingIndicatorsCmp;
import net.wg.gui.lobby.fortifications.data.BuildingCardPopoverVO;
import net.wg.gui.lobby.fortifications.events.FortBuildingCardPopoverEvent;
import net.wg.infrastructure.base.meta.IFortBuildingCardPopoverMeta;
import net.wg.infrastructure.base.meta.impl.FortBuildingCardPopoverMeta;
import net.wg.infrastructure.interfaces.IWrapper;

public class FortBuildingCardPopover extends FortBuildingCardPopoverMeta implements IFortBuildingCardPopoverMeta {

    private static const DYN_SEPARATOR_PADDING:uint = 32;

    private static const PLAYERS_PADDING:uint = 19;

    private static const BUILDINGS_PADDING_LEFT:Point = new Point(-12, 0);

    private static const BUILDINGS_PADDING_RIGHT:Point = new Point(12, 0);

    public var header:FortPopoverHeader = null;

    public var progressBar:BuildingIndicatorsCmp = null;

    public var body:FortPopoverBody = null;

    public var controlPanel:FortPopoverControlPanel = null;

    public var dynSeparator:MovieClip = null;

    public var assignPlayers:FortPopoverAssignPlayer = null;

    private var _model:BuildingCardPopoverVO = null;

    public function FortBuildingCardPopover() {
        super();
    }

    override protected function onPopulate():void {
        super.onPopulate();
    }

    override protected function onDispose():void {
        App.utils.scheduler.cancelTask(this.invalidateFocus);
        this.header.removeEventListener(FortBuildingCardPopoverEvent.DESTROY_BUILDING, this.onDestroyBuildingHandler);
        this.header.removeEventListener(FortBuildingCardPopoverEvent.UPGRADE_BUILDING, this.onUpgradeBuildingHandler);
        this.header.dispose();
        this.header = null;
        this.assignPlayers.removeEventListener(FortBuildingCardPopoverEvent.ASSIGN_PLAYERS, this.onAssignPlayersHandler);
        this.assignPlayers.dispose();
        this.assignPlayers = null;
        this.progressBar.dispose();
        this.progressBar = null;
        this.body.dispose();
        this.body = null;
        this.controlPanel.removeEventListener(FortBuildingCardPopoverEvent.DIRECTION_CONTROLL, this.onDirectionControlHandler);
        this.controlPanel.dispose();
        this.controlPanel = null;
        this._model = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.header.addEventListener(FortBuildingCardPopoverEvent.DESTROY_BUILDING, this.onDestroyBuildingHandler);
        this.header.addEventListener(FortBuildingCardPopoverEvent.UPGRADE_BUILDING, this.onUpgradeBuildingHandler);
        this.assignPlayers.addEventListener(FortBuildingCardPopoverEvent.ASSIGN_PLAYERS, this.onAssignPlayersHandler);
        this.controlPanel.addEventListener(FortBuildingCardPopoverEvent.DIRECTION_CONTROLL, this.onDirectionControlHandler);
        this.controlPanel.addEventListener(FortBuildingCardPopoverEvent.BUY_ORDER, this.onBuyOrderHandler);
    }

    override protected function getKeyPointPadding():TwoDimensionalPadding {
        var _loc1_:DisplayObject = null;
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        var _loc4_:Point = null;
        var _loc5_:Point = null;
        if (!this._model) {
            return super.getKeyPointPadding();
        }
        _loc1_ = DisplayObject(App.popoverMgr.popoverCaller.getTargetButton());
        _loc2_ = Math.floor(_loc1_.width / 2);
        _loc3_ = Math.floor(_loc1_.height / 2);
        _loc4_ = BUILDINGS_PADDING_LEFT;
        _loc5_ = BUILDINGS_PADDING_RIGHT;
        return new TwoDimensionalPadding(new Point(0, -_loc3_), new Point(_loc2_ + _loc5_.x, 0 + _loc5_.y), new Point(0, _loc3_), new Point(-_loc2_ + _loc4_.x, 0 + _loc4_.y));
    }

    override protected function setData(param1:BuildingCardPopoverVO):void {
        this._model = param1;
        this.header.setData(this._model.buildingHeader);
        this.progressBar.setData(this._model.buildingsIndicators);
        this.progressBar.showToolTips(true);
        this.body.setData(this._model.defResInfo);
        var _loc2_:* = this._model.actionData.currentState != FortPopoverControlPanel.NOT_BASE_NOT_COMMANDER;
        this.controlPanel.visible = _loc2_;
        if (this.controlPanel.visible) {
            this.controlPanel.setData(this._model.actionData);
        }
        var _loc3_:String = !!this._model.isAssigned ? this._model.assignLbl : null;
        this.assignPlayers.setData(_loc3_, this._model.garrisonLbl, this._model.playerCount, this._model.isTutorial, this._model.maxPlayerCount);
        if (!_loc2_) {
            this.dynSeparator.y = Math.round(this.body.y + this.body.height - DYN_SEPARATOR_PADDING);
            this.assignPlayers.y = Math.round(this.dynSeparator.y + this.dynSeparator.height + PLAYERS_PADDING);
            setViewSize(this.width, Math.round(this.assignPlayers.y + this.assignPlayers.height + 1));
        }
        initLayout();
        App.utils.scheduler.scheduleOnNextFrame(this.invalidateFocus);
    }

    public function as_setModernizationDestructionEnabling(param1:Boolean, param2:Boolean, param3:String, param4:String):void {
        this.header.setModernizationDestructionEnabling(param1, param2, param3, param4);
    }

    private function invalidateFocus():void {
        if (this._model.buildingHeader.isModernization && this.header.upgradeBtn.visible && this._model.canUpgradeBuilding) {
            setFocus(this.header.upgradeBtn);
        }
        else if (this.controlPanel.currentState == FortPopoverControlPanel.ACTION_STATE && this.controlPanel.visible && this.controlPanel.actionButton.enabled && this._model.canAddOrder) {
            setFocus(this.controlPanel.actionButton);
        }
        else {
            setFocus(this.assignPlayers.assignBtn);
        }
    }

    override public function set wrapper(param1:IWrapper):void {
        super.wrapper = param1;
        PopOver(param1).isCloseBtnVisible = true;
    }

    private function onDestroyBuildingHandler(param1:FortBuildingCardPopoverEvent):void {
        openDemountBuildingWindowS(this._model.buildingType);
        App.popoverMgr.hide();
    }

    private function onUpgradeBuildingHandler(param1:FortBuildingCardPopoverEvent):void {
        openUpgradeWindowS(this._model.buildingType);
        App.popoverMgr.hide();
    }

    private function onAssignPlayersHandler(param1:FortBuildingCardPopoverEvent):void {
        openAssignedPlayersWindowS(this._model.buildingType);
        App.popoverMgr.hide();
    }

    private function onDirectionControlHandler(param1:FortBuildingCardPopoverEvent):void {
        openDirectionControlWindowS();
        App.popoverMgr.hide();
    }

    private function onBuyOrderHandler(param1:FortBuildingCardPopoverEvent):void {
        openBuyOrderWindowS();
        App.popoverMgr.hide();
    }
}
}
