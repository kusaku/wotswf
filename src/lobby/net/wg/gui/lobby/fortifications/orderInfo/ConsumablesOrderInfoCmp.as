package net.wg.gui.lobby.fortifications.orderInfo {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.events.Event;

import net.wg.data.constants.Errors;
import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
import net.wg.gui.lobby.fortifications.data.orderInfo.OrderParamsVO;
import net.wg.gui.lobby.fortifications.interfaces.IConsumablesOrderParams;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class ConsumablesOrderInfoCmp extends UIComponentEx {

    private static const LAST_CMP_OFFSET:int = 11;

    public function ConsumablesOrderInfoCmp() {
        super();
    }

    private static function getComponent(param1:String, param2:Class):IConsumablesOrderParams {
        return App.utils.classFactory.getComponent(param1, param2);
    }

    private static function getLinkage(param1:Boolean):String {
        return !!param1 ? FORTIFICATION_ALIASES.FORT_CONSUMABLES_ORDER_DESCR : FORTIFICATION_ALIASES.FORT_CONSUMABLES_ORDER_VALUE;
    }

    public function getElementHeight():int {
        var _loc1_:DisplayObject = null;
        while (this.numChildren > 0) {
            _loc1_ = this.getChildAt(0);
            if (_loc1_ is IConsumablesOrderParams) {
                return IConsumablesOrderParams(_loc1_).getTFHeight();
            }
        }
        return -1;
    }

    override protected function onDispose():void {
        this.clearRenderers();
        super.onDispose();
    }

    public function setData(param1:Vector.<OrderParamsVO>):void {
        var _loc4_:OrderParamsVO = null;
        var _loc5_:* = false;
        var _loc6_:String = null;
        var _loc7_:IConsumablesOrderParams = null;
        App.utils.asserter.assertNotNull(param1, "OrderParamsVO vector : " + Errors.CANT_NULL);
        this.clearRenderers();
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        for each(_loc4_ in param1) {
            _loc3_++;
            _loc5_ = _loc3_ == param1.length;
            _loc6_ = getLinkage(_loc5_);
            _loc7_ = getComponent(_loc6_, InteractiveObject);
            _loc7_.update(_loc4_);
            _loc7_.x = _loc2_ + (!!_loc5_ ? LAST_CMP_OFFSET : 0);
            _loc7_.y = 0;
            this.addChild(InteractiveObject(_loc7_));
            _loc2_ = _loc2_ + _loc7_.getTFWidth();
        }
        dispatchEvent(new Event(Event.RESIZE, true));
    }

    private function clearRenderers():void {
        var _loc1_:DisplayObject = null;
        while (this.numChildren > 0) {
            _loc1_ = this.getChildAt(0);
            if (_loc1_ is IDisposable) {
                IDisposable(_loc1_).dispose();
            }
            this.removeChildAt(0);
        }
    }
}
}
