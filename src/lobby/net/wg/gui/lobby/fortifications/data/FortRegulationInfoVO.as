package net.wg.gui.lobby.fortifications.data {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class FortRegulationInfoVO extends DAAPIDataClass {

    private static const TIME_LIMITS:String = "timeLimits";

    public var serverName:String = "";

    private var _timeLimits:Array;

    public function FortRegulationInfoVO(param1:Object) {
        this._timeLimits = [];
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        if (TIME_LIMITS == param1) {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, TIME_LIMITS + Errors.CANT_NULL);
            for each(_loc4_ in _loc3_) {
                this._timeLimits.push(new FortCurfewTimeVO(_loc4_));
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        for each(_loc1_ in this._timeLimits) {
            _loc1_.dispose();
        }
        this._timeLimits.splice(0, this._timeLimits.length);
        this._timeLimits = null;
        super.onDispose();
    }

    public function get timeLimits():Array {
        return this._timeLimits;
    }
}
}
