package net.wg.gui.lobby.christmas.controls {
import flash.display.Sprite;

import net.wg.gui.components.controls.Image;
import net.wg.gui.lobby.christmas.interfaces.IChristmasAnimationItem;
import net.wg.gui.lobby.christmas.interfaces.IChristmasAnimationItemVO;

public class ChristmasAnimationItem extends Sprite implements IChristmasAnimationItem {

    public var toyIcon:Image = null;

    public var rankIcon:Image = null;

    public function ChristmasAnimationItem() {
        super();
    }

    public final function dispose():void {
        this.toyIcon.dispose();
        this.toyIcon = null;
        this.rankIcon.dispose();
        this.rankIcon = null;
    }

    public function setData(param1:IChristmasAnimationItemVO):void {
        this.toyIcon.source = param1.toyImage;
        this.rankIcon.source = param1.rankImage;
    }
}
}
