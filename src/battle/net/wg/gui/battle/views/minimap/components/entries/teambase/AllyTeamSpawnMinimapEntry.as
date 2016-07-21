package net.wg.gui.battle.views.minimap.components.entries.teambase {
import flash.display.Sprite;

import net.wg.data.constants.AtlasConstants;
import net.wg.gui.battle.components.BattleUIComponent;
import net.wg.gui.battle.views.minimap.components.entries.constants.TeamBaseMinimapEntryConst;
import net.wg.gui.battle.views.minimap.constants.MinimapColorConst;
import net.wg.infrastructure.managers.IAtlasManager;

public class AllyTeamSpawnMinimapEntry extends BattleUIComponent {

    public var atlasPlaceholder:Sprite = null;

    private var _atlasManager:IAtlasManager;

    public function AllyTeamSpawnMinimapEntry() {
        this._atlasManager = App.atlasMgr;
        super();
    }

    public function setPointNumber(param1:int):void {
        this._atlasManager.drawGraphics(AtlasConstants.BATTLE_ATLAS, TeamBaseMinimapEntryConst.ALLY_TEAM_SPAWN_ATLAS_ITEM_NAME + "_" + MinimapColorConst.GREEN + "_" + param1, this.atlasPlaceholder.graphics, "", true);
    }

    override protected function onDispose():void {
        this.atlasPlaceholder = null;
        this._atlasManager = null;
        super.onDispose();
    }
}
}
