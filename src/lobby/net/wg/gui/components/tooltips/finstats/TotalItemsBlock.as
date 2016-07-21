package net.wg.gui.components.tooltips.finstats {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.gui.components.controls.achievements.RedCounter;
import net.wg.gui.components.tooltips.VO.finalStats.TotalItemsBlockData;
import net.wg.gui.components.tooltips.inblocks.blocks.BaseTooltipBlock;

public class TotalItemsBlock extends BaseTooltipBlock {

    private static const TEXT_COUNTER_GAP:int = 11;

    public var textTF:TextField;

    public var counter:RedCounter;

    public var whiteBg:Sprite;

    private var _blockWidth:int = 0;

    private var _data:TotalItemsBlockData;

    public function TotalItemsBlock() {
        super();
    }

    override public function cleanUp():void {
        this.clearData();
        super.cleanUp();
    }

    override public function getBg():DisplayObject {
        return this.whiteBg;
    }

    override public function setBlockData(param1:Object):void {
        this.clearData();
        this._data = new TotalItemsBlockData(param1);
        invalidateBlock();
    }

    override public function setBlockWidth(param1:int):void {
        this._blockWidth = param1;
    }

    override protected function onDispose():void {
        this.counter.dispose();
        this.counter = null;
        this.textTF = null;
        this.whiteBg = null;
        this.clearData();
        super.onDispose();
    }

    override protected function onValidateBlock():Boolean {
        this.applyData();
        return false;
    }

    private function clearData():void {
        if (this._data != null) {
            this._data.dispose();
            this._data = null;
        }
    }

    private function applyData():void {
        this.textTF.htmlText = this._data.text;
        this.counter.visible = this._data.counterVisible;
        if (this.counter.visible) {
            this.counter.text = this._data.counter;
            this.counter.validateNow();
        }
        this.layout();
    }

    private function layout():void {
        var _loc1_:Number = 0;
        if (this.counter.visible) {
            _loc1_ = _loc1_ + (this.counter.x + this.counter.width + TEXT_COUNTER_GAP);
        }
        this.textTF.x = _loc1_ | 0;
        if (this._blockWidth > 0) {
            this.textTF.width = this._blockWidth - this.textTF.x;
        }
    }
}
}
