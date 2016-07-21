package net.wg.gui.lobby.fortifications.cmp.build.impl {
import flash.display.MovieClip;

import net.wg.gui.fortBase.IArrowWithNut;
import net.wg.gui.fortBase.IFortBuildingUIBase;
import net.wg.gui.fortBase.IFortModeVO;
import net.wg.gui.lobby.fortifications.cmp.build.IBuildingIndicator;
import net.wg.gui.lobby.fortifications.cmp.build.ICooldownIcon;
import net.wg.gui.lobby.fortifications.cmp.build.impl.animationImpl.BuildingsAnimationController;
import net.wg.infrastructure.base.UIComponentEx;

public class FortBuildingUIBase extends UIComponentEx implements IFortBuildingUIBase {

    public var cooldownIcon:ICooldownIcon = null;

    public var hitAreaControl:HitAreaControl = null;

    public var indicators:IBuildingIndicator = null;

    public var orderProcess:MovieClip = null;

    public var buildingMc:FortBuildingBtn = null;

    public var trowel:TrowelCmp = null;

    public var ground:MovieClip = null;

    public var animationController:BuildingsAnimationController;

    private var _exportArrow:IArrowWithNut = null;

    private var _importArrow:IArrowWithNut = null;

    public function FortBuildingUIBase() {
        super();
        this._exportArrow.mouseEnabled = this._exportArrow.mouseChildren = false;
        this._importArrow.mouseEnabled = this._importArrow.mouseChildren = false;
    }

    override protected function onDispose():void {
        this.hitAreaControl.dispose();
        this.hitAreaControl = null;
        this.indicators.dispose();
        this.indicators = null;
        this.buildingMc.dispose();
        this.buildingMc = null;
        this.trowel.dispose();
        this.trowel = null;
        this.orderProcess = null;
        this._exportArrow.dispose();
        this._exportArrow = null;
        this._importArrow.dispose();
        this._importArrow = null;
        this.cooldownIcon.dispose();
        this.cooldownIcon = null;
        this.animationController.dispose();
        this.animationController = null;
        this.ground = null;
        super.onDispose();
    }

    public function onPopoverClose():void {
    }

    public function onPopoverOpen():void {
    }

    public function updateCommonMode(param1:IFortModeVO):void {
    }

    public function updateDirectionsMode(param1:IFortModeVO):void {
    }

    public function updateTransportMode(param1:IFortModeVO):void {
    }

    public function get exportArrow():IArrowWithNut {
        return this._exportArrow;
    }

    public function set exportArrow(param1:IArrowWithNut):void {
        this._exportArrow = param1;
    }

    public function get importArrow():IArrowWithNut {
        return this._importArrow;
    }

    public function set importArrow(param1:IArrowWithNut):void {
        this._importArrow = param1;
    }
}
}
