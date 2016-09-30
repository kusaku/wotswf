package net.wg.gui.battle.views.postmortemPanel {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.data.constants.BattleAtlasItem;
import net.wg.gui.battle.components.BattleAtlasSprite;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.gfx.TextFieldEx;

public class PostmortemGasInfo extends Sprite implements IDisposable {

    public var infoTF:TextField = null;

    public var respawnInfoTF:TextField = null;

    public var deadIcon:BattleAtlasSprite = null;

    public var bg:BattleAtlasSprite = null;

    public function PostmortemGasInfo() {
        super();
        this.deadIcon.visible = false;
        this.bg.imageName = BattleAtlasItem.POSTMORTEM_GAS_INFO_BG;
        this.deadIcon.imageName = BattleAtlasItem.POSTMORTEM_GAS_INFO_DEAD_ICON;
        TextFieldEx.setNoTranslate(this.infoTF, true);
        TextFieldEx.setNoTranslate(this.respawnInfoTF, true);
    }

    public function dispose():void {
        this.infoTF = null;
        this.respawnInfoTF = null;
        this.deadIcon = null;
        this.bg = null;
    }

    public function setInfo(param1:String, param2:String, param3:Boolean):void {
        this.infoTF.text = param1;
        this.respawnInfoTF.text = param2;
        this.deadIcon.visible = param3;
    }
}
}
