package net.wg.gui.lobby.fortifications.cmp.combatReservesIntro {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.fortifications.data.CombatReservesIntroItemVO;
import net.wg.infrastructure.interfaces.ISpriteEx;

public class CombatReservesIntroItem extends Sprite implements ISpriteEx {

    public var image:UILoaderAlt;

    public var title:TextField;

    public var description:TextField;

    public function CombatReservesIntroItem() {
        super();
        this.image.autoSize = false;
    }

    public function update(param1:Object):void {
        var _loc2_:CombatReservesIntroItemVO = CombatReservesIntroItemVO(param1);
        visible = _loc2_ != null;
        if (_loc2_ != null) {
            this.image.source = _loc2_.imageSource;
            this.title.text = _loc2_.title;
            this.description.text = _loc2_.description;
        }
    }

    public function dispose():void {
        this.image.dispose();
        this.image = null;
    }
}
}
