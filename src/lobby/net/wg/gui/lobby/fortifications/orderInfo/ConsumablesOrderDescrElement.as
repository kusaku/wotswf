package net.wg.gui.lobby.fortifications.orderInfo {
import flash.text.TextField;

import net.wg.gui.lobby.fortifications.data.orderInfo.OrderParamsVO;
import net.wg.gui.lobby.fortifications.interfaces.IConsumablesOrderParams;
import net.wg.infrastructure.base.UIComponentEx;

public class ConsumablesOrderDescrElement extends UIComponentEx implements IConsumablesOrderParams {

    private static const TEST_HIGHT_PADDING:int = 5;

    public var descrTF:TextField = null;

    public function ConsumablesOrderDescrElement() {
        super();
    }

    override protected function onDispose():void {
        this.descrTF = null;
        super.onDispose();
    }

    public function getTFHeight():int {
        return 0;
    }

    public function getTFWidth():int {
        return 0;
    }

    public function update(param1:Object):void {
        var _loc2_:OrderParamsVO = OrderParamsVO(param1);
        this.descrTF.htmlText = _loc2_.params;
        this.descrTF.height = this.descrTF.textHeight + TEST_HIGHT_PADDING;
        _loc2_.dispose();
        _loc2_ = null;
    }
}
}
