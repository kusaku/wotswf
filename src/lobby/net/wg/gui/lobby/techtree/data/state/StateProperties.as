package net.wg.gui.lobby.techtree.data.state {
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class StateProperties implements IDisposable {

    public var id:uint;

    public var index:uint;

    public var label:String;

    public var enough:uint;

    public var visible:Boolean;

    public var animation:AnimationProperties;

    public var icoAlpha:Number;

    public function StateProperties(param1:uint, param2:uint, param3:String = null, param4:uint = 0, param5:Boolean = false, param6:AnimationProperties = null, param7:Number = 1) {
        super();
        this.id = param1;
        this.index = param2;
        this.label = param3;
        this.enough = param4;
        this.visible = param5;
        this.animation = param6;
        this.icoAlpha = param7;
    }

    public final function dispose():void {
        this.onDispose();
    }

    public function toString():String {
        var _loc1_:String = "StateProperties(";
        _loc1_ = _loc1_ + ("id = " + this.id);
        _loc1_ = _loc1_ + (", index = " + this.index);
        _loc1_ = _loc1_ + (", label = " + this.label);
        _loc1_ = _loc1_ + (", enough = " + this.enough);
        _loc1_ = _loc1_ + (", visible = " + this.visible);
        _loc1_ = _loc1_ + (" animation = " + this.animation);
        _loc1_ = _loc1_ + (", icoAlpha = " + this.icoAlpha);
        return _loc1_ + ")";
    }

    protected function onDispose():void {
        if (this.animation != null) {
            this.animation.dispose();
            this.animation = null;
        }
    }
}
}
