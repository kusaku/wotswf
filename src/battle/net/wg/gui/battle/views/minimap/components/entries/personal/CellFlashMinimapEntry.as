package net.wg.gui.battle.views.minimap.components.entries.personal {
import flash.display.MovieClip;

import net.wg.gui.battle.components.BattleUIComponent;

public class CellFlashMinimapEntry extends BattleUIComponent {

    public var mcAnimation:MovieClip = null;

    private const _START_ANIMATION_FRAME:Number = 1;

    public function CellFlashMinimapEntry() {
        super();
    }

    public function playAnimation():void {
        this.mcAnimation.gotoAndPlay(this._START_ANIMATION_FRAME);
    }

    override protected function onDispose():void {
        this.mcAnimation = null;
        super.onDispose();
    }
}
}
