package net.wg.gui.lobby.quests.data {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;

public class SeasonsDataVO extends DAAPIDataClass {

    private static const SEASONS:String = "seasons";

    private var _seasons:Vector.<SeasonVO> = null;

    public function SeasonsDataVO(param1:Object) {
        super(param1);
    }

    override protected function onDispose():void {
        var _loc1_:SeasonVO = null;
        for each(_loc1_ in this._seasons) {
            _loc1_.dispose();
        }
        this._seasons.splice(0, this._seasons.length);
        this._seasons = null;
        super.onDispose();
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        if (SEASONS == param1) {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, SEASONS + Errors.CANT_EMPTY);
            this._seasons = new Vector.<SeasonVO>(0);
            for each(_loc4_ in _loc3_) {
                this._seasons.push(new SeasonVO(_loc4_));
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    public function get seasons():Vector.<SeasonVO> {
        return this._seasons;
    }
}
}
