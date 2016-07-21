package net.wg.gui.lobby.fortifications.data {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.fortBase.IBattleNotifierVO;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class BattleNotifiersDataVO extends DAAPIDataClass {

    private static const DIRECTIONS_BATTLES:String = "directionsBattles";

    private var _directionsBattles:Vector.<IBattleNotifierVO>;

    public function BattleNotifiersDataVO(param1:Object) {
        this._directionsBattles = new Vector.<IBattleNotifierVO>();
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        if (param1 == DIRECTIONS_BATTLES) {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, DIRECTIONS_BATTLES + Errors.INVALID_TYPE + Array);
            for each(_loc4_ in _loc3_) {
                this._directionsBattles.push(new BattleNotifierVO(_loc4_));
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        for each(_loc1_ in this._directionsBattles) {
            _loc1_.dispose();
        }
        this._directionsBattles.splice(0, this._directionsBattles.length);
        this._directionsBattles = null;
        super.onDispose();
    }

    public function get directionsBattles():Vector.<IBattleNotifierVO> {
        return this._directionsBattles;
    }
}
}
