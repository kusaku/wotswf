package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.battle.components.BattleDisplayable;
import net.wg.infrastructure.exceptions.AbstractException;

public class DamagePanelMeta extends BattleDisplayable {

    public var clickToTankmanIcon:Function;

    public var clickToDeviceIcon:Function;

    public var clickToFireIcon:Function;

    public var getTooltipData:Function;

    private var _array:Array;

    private var _array1:Array;

    public function DamagePanelMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._array) {
            this._array.splice(0, this._array.length);
            this._array = null;
        }
        if (this._array1) {
            this._array1.splice(0, this._array1.length);
            this._array1 = null;
        }
        super.onDispose();
    }

    public function clickToTankmanIconS(param1:String):void {
        App.utils.asserter.assertNotNull(this.clickToTankmanIcon, "clickToTankmanIcon" + Errors.CANT_NULL);
        this.clickToTankmanIcon(param1);
    }

    public function clickToDeviceIconS(param1:String):void {
        App.utils.asserter.assertNotNull(this.clickToDeviceIcon, "clickToDeviceIcon" + Errors.CANT_NULL);
        this.clickToDeviceIcon(param1);
    }

    public function clickToFireIconS():void {
        App.utils.asserter.assertNotNull(this.clickToFireIcon, "clickToFireIcon" + Errors.CANT_NULL);
        this.clickToFireIcon();
    }

    public function getTooltipDataS(param1:String, param2:String):String {
        App.utils.asserter.assertNotNull(this.getTooltipData, "getTooltipData" + Errors.CANT_NULL);
        return this.getTooltipData(param1, param2);
    }

    public final function as_setup(param1:String, param2:int, param3:String, param4:Array, param5:Array, param6:Boolean, param7:Boolean):void {
        var _loc8_:Array = this._array;
        this._array = param4;
        var _loc9_:Array = this._array1;
        this._array1 = param5;
        this.setup(param1, param2, param3, this._array, this._array1, param6, param7);
        if (_loc8_) {
            _loc8_.splice(0, _loc8_.length);
        }
        if (_loc9_) {
            _loc9_.splice(0, _loc9_.length);
        }
    }

    protected function setup(param1:String, param2:int, param3:String, param4:Array, param5:Array, param6:Boolean, param7:Boolean):void {
        var _loc8_:String = "as_setup" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc8_);
        throw new AbstractException(_loc8_);
    }
}
}
