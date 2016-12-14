package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractView;
import net.wg.infrastructure.exceptions.AbstractException;

public class BattlePageMeta extends AbstractView {

    private var _vectorString:Vector.<String>;

    private var _vectorString1:Vector.<String>;

    public function BattlePageMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._vectorString) {
            this._vectorString.splice(0, this._vectorString.length);
            this._vectorString = null;
        }
        if (this._vectorString1) {
            this._vectorString1.splice(0, this._vectorString1.length);
            this._vectorString1 = null;
        }
        super.onDispose();
    }

    public final function as_setComponentsVisibility(param1:Array, param2:Array):void {
        var _loc4_:uint = 0;
        var _loc5_:int = 0;
        var _loc3_:Vector.<String> = this._vectorString;
        this._vectorString = new Vector.<String>(0);
        _loc4_ = param1.length;
        _loc5_ = 0;
        while (_loc5_ < _loc4_) {
            this._vectorString[_loc5_] = param1[_loc5_];
            _loc5_++;
        }
        var _loc6_:Vector.<String> = this._vectorString1;
        this._vectorString1 = new Vector.<String>(0);
        _loc4_ = param2.length;
        _loc5_ = 0;
        while (_loc5_ < _loc4_) {
            this._vectorString1[_loc5_] = param2[_loc5_];
            _loc5_++;
        }
        this.setComponentsVisibility(this._vectorString, this._vectorString1);
        if (_loc3_) {
            _loc3_.splice(0, _loc3_.length);
        }
        if (_loc6_) {
            _loc6_.splice(0, _loc6_.length);
        }
    }

    protected function setComponentsVisibility(param1:Vector.<String>, param2:Vector.<String>):void {
        var _loc3_:String = "as_setComponentsVisibility" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc3_);
        throw new AbstractException(_loc3_);
    }
}
}
