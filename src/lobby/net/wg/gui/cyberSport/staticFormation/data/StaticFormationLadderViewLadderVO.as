package net.wg.gui.cyberSport.staticFormation.data {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class StaticFormationLadderViewLadderVO extends DAAPIDataClass {

    private static const FORMATIONS_FIELD_NAME:String = "formations";

    public var formations:Array;

    public function StaticFormationLadderViewLadderVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Object = null;
        var _loc4_:Array = null;
        if (param1 == FORMATIONS_FIELD_NAME) {
            _loc4_ = param2 as Array;
            for each(_loc3_ in _loc4_) {
                if (_loc3_) {
                    if (this.formations == null) {
                        this.formations = new Array();
                    }
                    this.formations.push(new StaticFormationLadderTableRendererVO(_loc3_));
                }
            }
            return false;
        }
        return true;
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        while (this.formations.length > 0) {
            _loc1_ = this.formations.pop() as IDisposable;
            if (_loc1_ != null) {
                _loc1_.dispose();
            }
        }
        this.formations = null;
        super.onDispose();
    }

    public function hasFormations():Boolean {
        return this.formations != null && this.formations.length > 0;
    }
}
}
