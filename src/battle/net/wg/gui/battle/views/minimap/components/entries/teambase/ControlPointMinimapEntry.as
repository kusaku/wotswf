package net.wg.gui.battle.views.minimap.components.entries.teambase {
import flash.display.Sprite;

import net.wg.data.constants.AtlasConstants;
import net.wg.gui.battle.components.BattleUIComponent;
import net.wg.gui.battle.views.minimap.components.entries.constants.TeamBaseMinimapEntryConst;
import net.wg.infrastructure.managers.IAtlasManager;

public class ControlPointMinimapEntry extends BattleUIComponent {

    public var atlasPlaceholder:Sprite = null;

    private var _atlasManager:IAtlasManager;

    public function ControlPointMinimapEntry() {
        this._atlasManager = App.atlasMgr;
        super();
    }

    public function setPointNumber(param1:int):void {
        this._atlasManager.drawGraphics(AtlasConstants.BATTLE_ATLAS, TeamBaseMinimapEntryConst.CONTROL_POINT_ATLAS_ITEM_NAME + "_" + param1, this.atlasPlaceholder.graphics, "", true);
    }

    override protected function onDispose():void {
        this.atlasPlaceholder = null;
        this._atlasManager = null;
        super.onDispose();
    }
}
}
