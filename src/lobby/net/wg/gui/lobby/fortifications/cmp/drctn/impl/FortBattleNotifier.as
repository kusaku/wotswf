package net.wg.gui.lobby.fortifications.cmp.drctn.impl {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;

import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
import net.wg.gui.fortBase.IBattleNotifierVO;
import net.wg.gui.fortBase.IFortModeVO;
import net.wg.gui.lobby.fortifications.cmp.drctn.IFortBattleNotifier;
import net.wg.gui.lobby.fortifications.data.FunctionalStates;
import net.wg.gui.lobby.fortifications.utils.impl.FortCommonUtils;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.utils.ITweenAnimator;

import scaleform.clik.constants.InvalidationType;

public class FortBattleNotifier extends UIComponentEx implements IFortBattleNotifier {

    private static const NORMAL:String = "normal";

    private static const HAS_ACTIVE_BATTLES:String = "hasActiveBattles";

    private static const OVER_POSTFIX:String = "_hover";

    private static const OUT_POSTFIX:String = "_out";

    public var typeMC:MovieClip;

    public var dotMC:MovieClip;

    private var _data:IBattleNotifierVO = null;

    private var _isInHoverState:Boolean = false;

    public function FortBattleNotifier() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        addEventListener(MouseEvent.CLICK, this.onClickHandler);
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverHandler);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
        mouseChildren = false;
        buttonMode = true;
        useHandCursor = true;
    }

    override protected function draw():void {
        buttonMode = true;
        useHandCursor = true;
        if (isInvalid(InvalidationType.DATA)) {
            if (this._data) {
                App.utils.scheduler.scheduleOnNextFrame(this.applyData);
            }
            else {
                this.visible = false;
            }
        }
    }

    override protected function onDispose():void {
        App.utils.scheduler.cancelTask(this.applyData);
        removeEventListener(MouseEvent.CLICK, this.onClickHandler);
        removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverHandler);
        removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
        this._data = null;
        this.typeMC = null;
        this.dotMC = null;
        App.utils.tweenAnimator.removeAnims(this);
    }

    public function getHitArea():DisplayObject {
        return this;
    }

    public function getTargetButton():DisplayObject {
        return this;
    }

    public function onComplete():void {
    }

    public function setData(param1:IBattleNotifierVO):void {
        this._data = param1;
        invalidateData();
    }

    public function updateDirectionsMode(param1:IFortModeVO):void {
        this.updateMode(param1);
    }

    public function updateTransportMode(param1:IFortModeVO):void {
        this.updateMode(param1);
    }

    private function applyData():void {
        var _loc1_:String = null;
        if (this._data) {
            this.visible = true;
            this.updateHover();
            _loc1_ = !!this._data.hasActiveBattles ? HAS_ACTIVE_BATTLES : NORMAL;
            gotoAndPlay(_loc1_);
        }
        else {
            this.visible = false;
        }
    }

    private function updateMode(param1:IFortModeVO):void {
        var _loc2_:Number = FortCommonUtils.instance.getFunctionalState(param1);
        if (FunctionalStates.ENTER == _loc2_) {
            this.showNotifier(false);
        }
        else if (FunctionalStates.LEAVE == _loc2_) {
            this.showNotifier(true);
        }
    }

    private function showNotifier(param1:Boolean):void {
        var _loc2_:ITweenAnimator = null;
        if (this._data) {
            _loc2_ = App.utils.tweenAnimator;
            _loc2_.removeAnims(this);
            if (param1) {
                _loc2_.addFadeInAnim(this, this);
            }
            else {
                _loc2_.addFadeOutAnim(this, this);
            }
        }
    }

    private function updateHover():void {
        if (this._data) {
            this.typeMC.gotoAndPlay(this._data.battleType + (!!this._isInHoverState ? OVER_POSTFIX : OUT_POSTFIX));
            this.dotMC.gotoAndPlay(!!this._isInHoverState ? OVER_POSTFIX : OUT_POSTFIX);
        }
    }

    private function onClickHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
        if (this._data) {
            App.popoverMgr.show(this, FORTIFICATION_ALIASES.FORT_BATTLE_DIRECTION_POPOVER_ALIAS, this._data.direction);
            this._data.hasActiveBattles = false;
            invalidateData();
        }
    }

    private function onMouseOverHandler(param1:MouseEvent):void {
        if (this._data && this._data.tooltip) {
            App.toolTipMgr.showComplex(this._data.tooltip);
        }
        this._isInHoverState = true;
        this.updateHover();
    }

    private function onMouseOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
        this._isInHoverState = false;
        this.updateHover();
    }
}
}
