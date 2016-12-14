package net.wg.gui.battle.battleloading.renderers {
import net.wg.data.constants.BattleAtlasItem;

public class TipPlayerItemRenderer extends BasePlayerItemRenderer {

    public function TipPlayerItemRenderer(param1:RendererContainer, param2:int, param3:Boolean) {
        super(param1, param2, param3);
    }

    override protected function setSelfBG():void {
        if (_selfBg != null) {
            _selfBg.visible = _model.isCurrentPlayer;
            if (_selfBg.visible) {
                _selfBg.imageName = BattleAtlasItem.BATTLE_LOADING_TIPS_SELF_BACKGROUND;
            }
        }
    }
}
}
