package net.wg.gui.battle.views.ribbonsPanel {
import net.wg.data.constants.InvalidationType;
import net.wg.gui.battle.views.ribbonsPanel.VO.RibbonVO;
import net.wg.infrastructure.base.meta.IRibbonsPanelMeta;
import net.wg.infrastructure.base.meta.impl.RibbonsPanelMeta;

public class RibbonsPanel extends RibbonsPanelMeta implements IRibbonsPanelMeta {

    private static const POSITION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

    public var ribbonsAnimation:RibbonsAnimation = null;

    private var _ribbonsQueue:Vector.<RibbonVO> = null;

    private var _isPlaySounds:Boolean;

    private var _xOffset:int = 0;

    public function RibbonsPanel() {
        super();
        this._ribbonsQueue = new Vector.<RibbonVO>(0);
    }

    public function as_setup(param1:Boolean, param2:Boolean):void {
        this.enabled = param1;
        this._isPlaySounds = param2;
    }

    public function as_addBattleEfficiencyEvent(param1:String, param2:String, param3:int):void {
        if (enabled && visible) {
            this.addEvent(param1, param2, param3);
        }
    }

    public function as_setOffsetX(param1:int):void {
        this._xOffset = param1;
        invalidate(POSITION);
    }

    private function onShowRibbon():void {
        if (this._isPlaySounds) {
            onShowS();
        }
    }

    private function onChangeRibbon():void {
        if (this._isPlaySounds) {
            onChangeS();
        }
    }

    private function onIncCountRibbon():void {
        if (this._isPlaySounds) {
            onIncCountS();
        }
    }

    private function onHideRibbon():void {
        if (this._isPlaySounds) {
            onHideS();
        }
    }

    private function addEvent(param1:String, param2:String, param3:int):void {
        var _loc4_:RibbonVO = this.findEvent(param1);
        if (_loc4_) {
            _loc4_.incCount(param3);
        }
        else {
            this._ribbonsQueue.push(new RibbonVO(param1, param2, param3));
        }
        if (!this.ribbonsAnimation.isRunning) {
            this.runQueue();
        }
    }

    private function runQueue():void {
        var _loc1_:RibbonVO = this._ribbonsQueue.shift();
        this.ribbonsAnimation.show(_loc1_);
        this.onShowRibbon();
    }

    private function findEvent(param1:String):RibbonVO {
        var _loc2_:RibbonVO = null;
        var _loc3_:int = this._ribbonsQueue.length;
        var _loc4_:uint = 0;
        while (_loc4_ < _loc3_) {
            _loc2_ = this._ribbonsQueue[_loc4_];
            if (_loc2_.type == param1) {
                return _loc2_;
            }
            _loc4_++;
        }
        return null;
    }

    private function gotoNextEvent():void {
        var _loc1_:RibbonVO = this._ribbonsQueue.shift();
        if (_loc1_.type == this.ribbonsAnimation.currentType) {
            this.ribbonsAnimation.incCount(_loc1_.count);
            this.onIncCountRibbon();
        }
        else {
            this.ribbonsAnimation.change(_loc1_);
            this.onChangeRibbon();
        }
    }

    private function hideRibbon():void {
        this.ribbonsAnimation.hide();
        this.onHideRibbon();
    }

    private function onRibbonAnmShowingCompleteCallBack():void {
        if (this._ribbonsQueue.length > 0) {
            this.gotoNextEvent();
        }
        else {
            this.hideRibbon();
        }
    }

    private function onRibbonAnmHideCallBack():void {
        if (this._ribbonsQueue.length > 0) {
            this.runQueue();
        }
    }

    private function clear():void {
        this.ribbonsAnimation.reset();
        this._ribbonsQueue.length = 0;
    }

    override public function set enabled(param1:Boolean):void {
        super.enabled = param1;
        if (!param1) {
            this.clear();
        }
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(POSITION)) {
            x = this._xOffset;
        }
    }

    override protected function configUI():void {
        this.ribbonsAnimation.addSCallBackFunctions(this.onRibbonAnmShowingCompleteCallBack, this.onRibbonAnmHideCallBack);
    }

    override protected function onDispose():void {
        this.ribbonsAnimation.dispose();
        this.ribbonsAnimation = null;
        this._ribbonsQueue.length = 0;
        this._ribbonsQueue = null;
        super.onDispose();
    }
}
}
