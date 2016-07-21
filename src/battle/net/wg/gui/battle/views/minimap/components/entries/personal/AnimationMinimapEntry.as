package net.wg.gui.battle.views.minimap.components.entries.personal {
import flash.display.MovieClip;

import net.wg.gui.battle.components.BattleUIComponent;

public class AnimationMinimapEntry extends BattleUIComponent {

    public var mcTopAnimation:MovieClip = null;

    public var mcBearer:MovieClip = null;

    public function AnimationMinimapEntry() {
        super();
        this.mcBearer.visible = false;
        this.mcBearer.stop();
    }

    public function setAnimation(param1:String):void {
        this.mcTopAnimation.gotoAndStop(1);
        this.mcTopAnimation.gotoAndStop(param1);
    }

    public function setFlagBearer(param1:Boolean):void {
        if (param1) {
            this.mcBearer.visible = true;
            this.mcBearer.play();
        }
        else {
            this.mcBearer.visible = false;
            this.mcBearer.stop();
        }
    }

    override protected function onDispose():void {
        this.mcTopAnimation = null;
        this.mcBearer = null;
        super.onDispose();
    }
}
}
