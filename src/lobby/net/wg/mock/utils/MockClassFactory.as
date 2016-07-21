package net.wg.mock.utils {
import flash.display.DisplayObject;
import flash.utils.getDefinitionByName;

import net.wg.data.constants.Errors;
import net.wg.infrastructure.exceptions.ArgumentException;
import net.wg.infrastructure.exceptions.InvalidComponentCastException;
import net.wg.utils.IAssertable;
import net.wg.utils.IClassFactory;

public class MockClassFactory implements IClassFactory {

    public function MockClassFactory() {
        super();
    }

    public function dispose():void {
    }

    public function getClass(param1:String):Class {
        var classpath:String = param1;
        var outcomeClass:Class = null;
        try {
            outcomeClass = getDefinitionByName(classpath) as Class;
        }
        catch (e:ReferenceError) {
            DebugUtils.LOG_ERROR(Errors.BAD_LINKAGE + classpath);
        }
        return outcomeClass;
    }

    public function getClassName(param1:*):String {
        return "";
    }

    public function getComponent(param1:String, param2:Class, param3:Object = null):* {
        var _loc4_:Object = this.getObject(param1, param3);
        var _loc5_:* = "object with \"" + param1 + "\" linkage ";
        var _loc6_:* = _loc5_ + "is not a component from library!";
        var _loc7_:String = _loc5_ + "can`t cast to " + param2;
        var _loc8_:IAssertable = App.utils.asserter;
        _loc8_.assert(_loc4_ is DisplayObject, _loc6_, InvalidComponentCastException);
        _loc8_.assert(_loc4_ is param2, _loc7_, InvalidComponentCastException);
        return _loc4_;
    }

    public function getObject(param1:String, param2:Object = null):Object {
        var _loc5_:* = null;
        var _loc6_:* = null;
        var _loc3_:Object = null;
        var _loc4_:Class = this.getClass(param1);
        if (_loc4_ != null) {
            _loc3_ = new _loc4_();
            if (param2 != null) {
                for (_loc5_ in param2) {
                    if (_loc3_.hasOwnProperty(_loc5_)) {
                        _loc3_[_loc5_] = param2[_loc5_];
                        continue;
                    }
                    _loc6_ = "object with linkage \'" + param1 + "\' doesn`t contain property " + "with name \'" + _loc5_ + "\'. Initialization error.";
                    throw new ArgumentException(_loc6_);
                }
            }
        }
        return _loc3_;
    }

    public function get createComponentCallback():Function {
        return null;
    }

    public function set createComponentCallback(param1:Function):void {
    }
}
}
