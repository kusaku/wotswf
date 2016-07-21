package net.wg.gui.lobby.fortifications.cmp.build.impl.animationImpl {
import net.wg.gui.lobby.fortifications.cmp.build.IBuildingTexture;

public class DemountBuildingsAnimation extends FortBuildingAnimationBase {

    public var animationBuilding:IBuildingTexture;

    public function DemountBuildingsAnimation() {
        super();
    }

    override public function dispose():void {
        if (this.animationBuilding) {
            this.animationBuilding.dispose();
            this.animationBuilding = null;
        }
        super.dispose();
    }

    public function getBuildingTexture():IBuildingTexture {
        return this.animationBuilding;
    }
}
}
