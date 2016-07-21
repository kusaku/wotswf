package net.wg.gui.battle.views.minimap.components.entries.fortconsumables {
import flash.display.Sprite;

import net.wg.data.constants.AtlasConstants;
import net.wg.gui.battle.components.BattleUIComponent;
import net.wg.gui.battle.views.minimap.components.entries.constants.FortConsumablesMinimapEntryConst;
import net.wg.infrastructure.managers.IAtlasManager;

public class ArtilleryMinimapEntry extends BattleUIComponent {

    public var atlasPlaceholder:Sprite = null;

    private var _atlasManager:IAtlasManager;

    public function ArtilleryMinimapEntry() {
        this._atlasManager = App.atlasMgr;
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this._atlasManager.drawGraphics(AtlasConstants.BATTLE_ATLAS, FortConsumablesMinimapEntryConst.ARTILLERY_ATLAS_ITEM_NAME, this.atlasPlaceholder.graphics, "", true);
    }

    override protected function onDispose():void {
        this.atlasPlaceholder = null;
        this._atlasManager = null;
        super.onDispose();
    }
}
}
