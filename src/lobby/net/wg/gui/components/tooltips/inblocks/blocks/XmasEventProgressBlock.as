package net.wg.gui.components.tooltips.inblocks.blocks {
import flash.text.TextField;

import net.wg.gui.components.tooltips.inblocks.data.XmasEventProgressBlockVO;
import net.wg.utils.ICommons;

import scaleform.clik.controls.StatusIndicator;

public class XmasEventProgressBlock extends BaseTooltipBlock {

    public var levelTf:TextField;

    public var progressTf:TextField;

    public var progressIndicator:StatusIndicator = null;

    private var _data:XmasEventProgressBlockVO = null;

    public function XmasEventProgressBlock() {
        super();
    }

    override public function setBlockData(param1:Object):void {
        this._data = new XmasEventProgressBlockVO(param1);
        invalidateBlock();
    }

    override public function setBlockWidth(param1:int):void {
        if (param1 > 0) {
            this.progressIndicator.width = param1;
            this.layoutProgressTf();
        }
    }

    override protected function onDispose():void {
        this.levelTf = null;
        this.progressTf = null;
        this.progressIndicator.dispose();
        this.progressIndicator = null;
        this._data.dispose();
        this._data = null;
        super.onDispose();
    }

    override protected function onValidateBlock():Boolean {
        this.levelTf.htmlText = this._data.levelText;
        this.progressTf.htmlText = this._data.progressText;
        this.progressIndicator.value = this._data.progress;
        var _loc1_:ICommons = App.utils.commons;
        _loc1_.updateTextFieldSize(this.levelTf, true, true);
        _loc1_.updateTextFieldSize(this.progressTf, true, true);
        this.layoutProgressTf();
        return false;
    }

    private function layoutProgressTf():void {
        this.progressTf.x = this.progressIndicator.x + this.progressIndicator.width - this.progressTf.width | 0;
    }
}
}
