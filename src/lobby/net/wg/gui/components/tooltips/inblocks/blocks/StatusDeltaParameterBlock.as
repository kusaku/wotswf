package net.wg.gui.components.tooltips.inblocks.blocks {
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.Errors;
import net.wg.gui.components.advanced.interfaces.IStatusDeltaIndicatorAnim;
import net.wg.gui.components.tooltips.inblocks.data.StatusDeltaParameterBlockVO;

import org.idmedia.as3commons.util.StringUtils;

public class StatusDeltaParameterBlock extends BaseTooltipBlock {

    private static const DECREASE_ARROW_PADDING:int = -17;

    public var titleTF:TextField;

    public var valueTF:TextField;

    public var statusBar:IStatusDeltaIndicatorAnim;

    public var decreaseIcon:Sprite = null;

    private var _data:StatusDeltaParameterBlockVO;

    private var _isDataApplied:Boolean = false;

    public function StatusDeltaParameterBlock() {
        super();
        this.valueTF.autoSize = TextFieldAutoSize.RIGHT;
    }

    override public function cleanUp():void {
        this.clearData();
        this.titleTF.text = this.titleTF.htmlText = this.valueTF.text = this.valueTF.htmlText = null;
    }

    override public function setBlockData(param1:Object):void {
        this.clearData();
        this._data = new StatusDeltaParameterBlockVO(param1);
        this._isDataApplied = false;
        invalidateBlock();
    }

    override public function setBlockWidth(param1:int):void {
    }

    override protected function onDispose():void {
        this.cleanUp();
        this.statusBar.dispose();
        this.statusBar = null;
        this.titleTF = null;
        this.valueTF = null;
        this.decreaseIcon = null;
        super.onDispose();
    }

    override protected function onValidateBlock():Boolean {
        if (!this._isDataApplied) {
            this.applyData();
            this.decreaseIcon.visible = this._data.showDecreaseArrow;
            if (this.decreaseIcon.visible) {
                this.decreaseIcon.x = this.valueTF.x + this.valueTF.width - this.valueTF.textWidth + DECREASE_ARROW_PADDING ^ 0;
            }
            return true;
        }
        return false;
    }

    private function applyData():void {
        App.utils.asserter.assertNotNull(this._data, "_data " + Errors.CANT_NULL);
        this.applyTextData(this.titleTF, this._data.title);
        this.applyTextData(this.valueTF, this._data.valueStr);
        this.statusBar.setData(this._data.statusBarData);
        this._isDataApplied = true;
    }

    private function applyTextData(param1:TextField, param2:String):void {
        if (param1 != null) {
            param1.visible = StringUtils.isNotEmpty(param2);
            if (param1.visible) {
                param1.htmlText = param2;
            }
        }
    }

    private function clearData():void {
        if (this._data != null) {
            this._data.dispose();
            this._data = null;
        }
    }
}
}
