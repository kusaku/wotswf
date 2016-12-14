package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractView;
import net.wg.infrastructure.exceptions.AbstractException;

public class HangarMeta extends AbstractView {

    public var onEscape:Function;

    public var showHelpLayout:Function;

    public var closeHelpLayout:Function;

    private var _array:Array;

    public function HangarMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._array) {
            this._array.splice(0, this._array.length);
            this._array = null;
        }
        super.onDispose();
    }

    public function onEscapeS():void {
        App.utils.asserter.assertNotNull(this.onEscape, "onEscape" + Errors.CANT_NULL);
        this.onEscape();
    }

    public function showHelpLayoutS():void {
        App.utils.asserter.assertNotNull(this.showHelpLayout, "showHelpLayout" + Errors.CANT_NULL);
        this.showHelpLayout();
    }

    public function closeHelpLayoutS():void {
        App.utils.asserter.assertNotNull(this.closeHelpLayout, "closeHelpLayout" + Errors.CANT_NULL);
        this.closeHelpLayout();
    }

    public final function as_show3DSceneTooltip(param1:String, param2:Array):void {
        var _loc3_:Array = this._array;
        this._array = param2;
        this.show3DSceneTooltip(param1, this._array);
        if (_loc3_) {
            _loc3_.splice(0, _loc3_.length);
        }
    }

    protected function show3DSceneTooltip(param1:String, param2:Array):void {
        var _loc3_:String = "as_show3DSceneTooltip" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc3_);
        throw new AbstractException(_loc3_);
    }
}
}
