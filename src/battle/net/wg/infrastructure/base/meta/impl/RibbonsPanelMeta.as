package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.battle.components.BattleDisplayable;
import net.wg.infrastructure.exceptions.AbstractException;

public class RibbonsPanelMeta extends BattleDisplayable {

    public var onShow:Function;

    public var onChange:Function;

    public var onHide:Function;

    private var _array:Array;

    public function RibbonsPanelMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._array) {
            this._array.splice(0, this._array.length);
            this._array = null;
        }
        super.onDispose();
    }

    public function onShowS():void {
        App.utils.asserter.assertNotNull(this.onShow, "onShow" + Errors.CANT_NULL);
        this.onShow();
    }

    public function onChangeS():void {
        App.utils.asserter.assertNotNull(this.onChange, "onChange" + Errors.CANT_NULL);
        this.onChange();
    }

    public function onHideS(param1:String):void {
        App.utils.asserter.assertNotNull(this.onHide, "onHide" + Errors.CANT_NULL);
        this.onHide(param1);
    }

    public final function as_setup(param1:Array, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean):void {
        var _loc6_:Array = this._array;
        this._array = param1;
        this.setup(this._array, param2, param3, param4, param5);
        if (_loc6_) {
            _loc6_.splice(0, _loc6_.length);
        }
    }

    protected function setup(param1:Array, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean):void {
        var _loc6_:String = "as_setup" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc6_);
        throw new AbstractException(_loc6_);
    }
}
}
