package net.wg.gui.cyberSport.staticFormation.data {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class StaticFormationStaffViewStaffVO extends DAAPIDataClass {

    public var members:Array;

    public function StaticFormationStaffViewStaffVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Object = null;
        var _loc4_:Array = null;
        if (param1 == "members") {
            _loc4_ = param2 as Array;
            for each(_loc3_ in _loc4_) {
                if (_loc3_) {
                    if (this.members == null) {
                        this.members = new Array();
                    }
                    this.members.push(new StaticFormationStaffTableRendererVO(_loc3_));
                }
            }
            return false;
        }
        return true;
    }

    public function hasMembers():Boolean {
        return this.members != null && this.members.length > 0;
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        while (this.members.length > 0) {
            _loc1_ = this.members.pop() as IDisposable;
            if (_loc1_ != null) {
                _loc1_.dispose();
            }
        }
        this.members = null;
        super.onDispose();
    }
}
}
