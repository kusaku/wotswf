package net.wg.gui.lobby.components {
import net.wg.gui.components.controls.AnimationIcon;
import net.wg.gui.lobby.components.interfaces.IStoppableAnimationVO;

public class ExplosionAwardWindowAnimation extends BaseAwardWindowAnimation {

    public var shineIcon:AnimationIcon;

    public var mainIcon:AnimationIcon;

    public function ExplosionAwardWindowAnimation() {
        super();
    }

    override public function setData(param1:IStoppableAnimationVO):void {
        var _loc2_:String = param1.anmImage;
        this.shineIcon.setImage(_loc2_);
        this.mainIcon.setImage(_loc2_);
    }

    override protected function onDispose():void {
        this.shineIcon.dispose();
        this.shineIcon = null;
        this.mainIcon.dispose();
        this.mainIcon = null;
        super.onDispose();
    }
}
}
