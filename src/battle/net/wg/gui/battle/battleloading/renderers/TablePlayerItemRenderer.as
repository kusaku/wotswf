package net.wg.gui.battle.battleloading.renderers {
import net.wg.data.constants.BattleAtlasItem;

public class TablePlayerItemRenderer extends BasePlayerItemRenderer {

    public function TablePlayerItemRenderer(param1:RendererContainer, param2:int, param3:Boolean) {
        super(param1, param2, param3);
    }

    override protected function setSelfBG():void {
        if (_selfBg != null) {
            _selfBg.visible = _model.isCurrentPlayer;
            if (_selfBg.visible) {
                _selfBg.imageName = BattleAtlasItem.BATTLE_LOADING_TABLE_SELF_BACKGROUND;
            }
        }
    }
}
}
