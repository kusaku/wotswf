package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.components.MinimapEntity;

public class MinimapLobbyMeta extends MinimapEntity {

    public var setMap:Function;

    public var setMinimapData:Function;

    public function MinimapLobbyMeta() {
        super();
    }

    public function setMapS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.setMap, "setMap" + Errors.CANT_NULL);
        this.setMap(param1);
    }

    public function setMinimapDataS(param1:int, param2:int, param3:int):void {
        App.utils.asserter.assertNotNull(this.setMinimapData, "setMinimapData" + Errors.CANT_NULL);
        this.setMinimapData(param1, param2, param3);
    }
}
}
