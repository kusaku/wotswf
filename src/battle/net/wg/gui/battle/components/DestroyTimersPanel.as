package net.wg.gui.battle.components {
import net.wg.data.constants.InvalidationType;
import net.wg.data.constants.Linkages;
import net.wg.gui.battle.views.destroyTimers.DestroyTimer;
import net.wg.gui.battle.views.destroyTimers.events.DestroyTimerEvent;
import net.wg.infrastructure.base.meta.IDestroyTimersPanelMeta;
import net.wg.infrastructure.base.meta.impl.DestroyTimersPanelMeta;

public class DestroyTimersPanel extends DestroyTimersPanelMeta implements IDestroyTimersPanelMeta {

    private static const TIMER_OFFSET_X:int = 180;

    private static const TOP_OFFSET_Y:int = 114;

    private static const X_SHIFT:int = 8;

    private static const X_ADDITIONAL_SHIFT:int = TIMER_OFFSET_X - X_SHIFT;

    private static const INVALID_POSITION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

    private var _stageWidth:int = 0;

    private var _stageHeight:int = 0;

    private var _timers:Vector.<DestroyTimer>;

    public function DestroyTimersPanel() {
        var _loc1_:String = null;
        var _loc2_:DestroyTimer = null;
        this._timers = new Vector.<DestroyTimer>();
        super();
        this.mouseChildren = false;
        this.mouseEnabled = false;
        for each(_loc1_ in this.getTimersIcons()) {
            _loc2_ = App.utils.classFactory.getComponent(Linkages.DESTROY_TIMER_UI, DestroyTimer);
            _loc2_.stop();
            _loc2_.visible = false;
            _loc2_.setIcon(_loc1_);
            addChild(_loc2_);
            this._timers.push(_loc2_);
        }
    }

    override protected function draw():void {
        var _loc1_:int = 0;
        var _loc2_:DestroyTimer = null;
        super.draw();
        if (isInvalid(INVALID_POSITION)) {
            _loc1_ = 0;
            for each(_loc2_ in this._timers) {
                if (_loc2_.visible) {
                    _loc1_ = _loc1_ + TIMER_OFFSET_X;
                    _loc2_.x = _loc1_;
                }
            }
            _loc1_ = _loc1_ + X_ADDITIONAL_SHIFT;
            x = this._stageWidth - _loc1_ >> 1;
            y = (this._stageHeight >> 1) + TOP_OFFSET_Y;
        }
    }

    override protected function onDispose():void {
        var _loc1_:DestroyTimer = null;
        for each(_loc1_ in this._timers) {
            _loc1_.removeEventListener(DestroyTimerEvent.TIMER_HIDDEN_EVENT, this.onTimerHiddenHandler);
            _loc1_.dispose();
            _loc1_ = null;
        }
        this._timers.splice(0, this._timers.length);
        this._timers = null;
        super.onDispose();
    }

    public function as_hide(param1:int):void {
        this.hideTimer(this._timers[param1]);
    }

    public function as_show(param1:int, param2:int):void {
        var _loc3_:DestroyTimer = this._timers[param1];
        if (!_loc3_.isActive) {
            _loc3_.addEventListener(DestroyTimerEvent.TIMER_HIDDEN_EVENT, this.onTimerHiddenHandler);
            _loc3_.isActive = true;
            invalidate(INVALID_POSITION);
        }
        _loc3_.updateViewID(param2);
        _loc3_.visible = true;
    }

    public function as_setSpeed(param1:Number):void {
        var _loc2_:DestroyTimer = null;
        for each(_loc2_ in this._timers) {
            _loc2_.setSpeed(param1);
        }
    }

    public function as_setTimeSnapshot(param1:int, param2:int, param3:Number):void {
        param3 = param2 - Math.round(param3);
        this._timers[param1].updateRadialTimer(param2, param3);
    }

    public function as_setTimeInSeconds(param1:int, param2:int, param3:Number):void {
        param3 = Math.round(param3);
        this._timers[param1].updateRadialTimer(param2, param3);
    }

    public function updateStage(param1:int, param2:int):void {
        this._stageWidth = param1;
        this._stageHeight = param2;
        invalidate(INVALID_POSITION);
    }

    protected function getTimersIcons():Vector.<String> {
        return new <String>[Linkages.DROWN_ICON, Linkages.DEATHZONE_ICON, Linkages.OVERTURNED_ICON, Linkages.FIRE_ICON];
    }

    private function hideTimer(param1:DestroyTimer):void {
        param1.resetTimer();
        param1.removeEventListener(DestroyTimerEvent.TIMER_HIDDEN_EVENT, this.onTimerHiddenHandler);
        param1.isActive = false;
        param1.visible = false;
        invalidate(INVALID_POSITION);
    }

    private function onTimerHiddenHandler(param1:DestroyTimerEvent):void {
        this.hideTimer(param1.destroyTimer);
    }
}
}
