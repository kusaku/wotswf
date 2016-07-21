package net.wg.gui.lobby.clans.profile.cmp {
import flash.events.MouseEvent;
import flash.geom.Rectangle;

import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.infrastructure.base.UIComponentEx;

public class BuildingShape extends UIComponentEx {

    private var _uid:String;

    private var _buildingLevel:int;

    public function BuildingShape(param1:Rectangle, param2:String, param3:int) {
        super();
        this._uid = param2;
        this._buildingLevel = param3;
        graphics.beginFill(0, 0);
        graphics.drawRect(param1.x, param1.y, param1.width, param1.height);
        graphics.endFill();
        addEventListener(MouseEvent.ROLL_OVER, this.onShapeRollOverHandler);
        addEventListener(MouseEvent.ROLL_OUT, this.onShapeRollOutHandler);
    }

    override protected function onDispose():void {
        removeEventListener(MouseEvent.ROLL_OVER, this.onShapeRollOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT, this.onShapeRollOutHandler);
        super.onDispose();
    }

    private function onShapeRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CLAN_PROFILE_FORT_BUILDING, null, this._uid, this._buildingLevel);
    }

    private function onShapeRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }
}
}
