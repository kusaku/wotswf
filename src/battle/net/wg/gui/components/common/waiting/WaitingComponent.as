package net.wg.gui.components.common.waiting {
import flash.display.Sprite;
import flash.geom.Point;

import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.ConstrainMode;
import scaleform.clik.constants.InvalidationType;
import scaleform.clik.utils.Constraints;

public class WaitingComponent extends UIComponentEx {

    private static const TEXT_INVALID:String = "textInv";

    private static const ANIMATION_STATUS_INVALID:String = "animStatusInv";

    private static const INV_BACKGROUND_VISIBILITY:String = "InvBackgroundVisibility";

    public var waitingMc:WaitingMc = null;

    public var backgroundMc:Sprite = null;

    private var _waitingOffset:Point = null;

    private var _text:String = "";

    private var _isStopped:Boolean = false;

    private var _backgroundVisibility:Boolean = true;

    public function WaitingComponent() {
        super();
    }

    override protected function preInitialize():void {
        super.preInitialize();
        this._waitingOffset = new Point(0, 0);
        constraints = new Constraints(this, ConstrainMode.REFLOW);
    }

    override protected function configUI():void {
        super.configUI();
        constraints.addElement(this.waitingMc.name, this.waitingMc, Constraints.CENTER_H | Constraints.CENTER_V);
        constraints.addElement(this.backgroundMc.name, this.backgroundMc, Constraints.ALL);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            constraints.update(_width, _height);
            this.backgroundMc.x = this.backgroundMc.x ^ 0;
            this.backgroundMc.y = this.backgroundMc.y ^ 0;
            this.waitingMc.x = this.waitingMc.x + (this._waitingOffset.x ^ 0);
            this.waitingMc.y = this.waitingMc.y + (this._waitingOffset.y ^ 0);
            this.waitingMc.x = this.waitingMc.x ^ 0;
            this.waitingMc.y = this.waitingMc.y ^ 0;
        }
        if (isInvalid(TEXT_INVALID)) {
            this.waitingMc.setMessage(this._text);
        }
        if (isInvalid(ANIMATION_STATUS_INVALID)) {
            if (this._isStopped) {
                this.waitingMc.stop();
            }
            else {
                this.waitingMc.play();
            }
        }
        if (isInvalid(INV_BACKGROUND_VISIBILITY)) {
            this.backgroundMc.alpha = !!this._backgroundVisibility ? Number(1) : Number(0);
        }
    }

    override protected function onDispose():void {
        this.waitingMc.dispose();
        this.waitingMc = null;
        this.backgroundMc = null;
        this._waitingOffset = null;
        super.onDispose();
    }

    public function setAnimationStatus(param1:Boolean):void {
        if (this._isStopped != param1) {
            this._isStopped = param1;
            invalidate(ANIMATION_STATUS_INVALID);
        }
    }

    public function setMessage(param1:String):void {
        this._text = param1;
        invalidate(TEXT_INVALID);
    }

    public function setWaitingOffset(param1:Point):void {
        this._waitingOffset = param1;
    }

    public function get backgroundVisibility():Boolean {
        return this._backgroundVisibility;
    }

    public function set backgroundVisibility(param1:Boolean):void {
        this._backgroundVisibility = param1;
        invalidate(INV_BACKGROUND_VISIBILITY);
    }
}
}
