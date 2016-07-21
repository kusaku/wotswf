package net.wg.gui.lobby.fortifications.orderInfo {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.gui.lobby.fortifications.data.orderInfo.OrderParamsVO;
import net.wg.gui.lobby.fortifications.interfaces.IConsumablesOrderParams;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;

public class ConsumablesOrderValuesElement extends UIComponentEx implements IConsumablesOrderParams {

    private static const SEPARATOR_ADDITIONAL_WIDTH:Number = 55.85;

    private static const SEPARATOR_ROTATE:int = 90;

    private static const SEPARATOR_PADDING:int = 40;

    private static const DYN_WIDTH_OFFSET:int = -2;

    private static const ADDITIONAL_TEXT_HEIGHT:int = 6;

    public var titleTF:TextField = null;

    public var paramsValues:TextField = null;

    public var separator:MovieClip = null;

    public function ConsumablesOrderValuesElement() {
        super();
        this.separator.visible = false;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE) && this.separator && this.separator.visible) {
            this.separator.width = this.paramsValues.height + SEPARATOR_ADDITIONAL_WIDTH;
            this.separator.rotation = SEPARATOR_ROTATE;
            this.separator.y = 0;
            this.separator.x = this.paramsValues.x + this.paramsValues.width + SEPARATOR_PADDING;
        }
    }

    override protected function onDispose():void {
        this.titleTF = null;
        this.paramsValues = null;
        this.separator = null;
        super.onDispose();
    }

    public function getTFHeight():int {
        return this.paramsValues.height;
    }

    public function getTFWidth():int {
        return this.paramsValues.x + this.paramsValues.width + DYN_WIDTH_OFFSET;
    }

    public function update(param1:Object):void {
        var _loc2_:OrderParamsVO = OrderParamsVO(param1);
        this.titleTF.htmlText = _loc2_.orderLevel;
        this.paramsValues.htmlText = _loc2_.params;
        this.separator.visible = _loc2_.isShowSeparator;
        this.paramsValues.height = this.paramsValues.textHeight + ADDITIONAL_TEXT_HEIGHT ^ 0;
        _loc2_.dispose();
        _loc2_ = null;
        invalidateSize();
    }
}
}
