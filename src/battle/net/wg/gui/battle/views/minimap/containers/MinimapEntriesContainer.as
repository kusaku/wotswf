package net.wg.gui.battle.views.minimap.containers {
import flash.display.Sprite;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class MinimapEntriesContainer extends Sprite implements IDisposable {

    public var points:Sprite = null;

    public var icons:Sprite = null;

    public var equipments:Sprite = null;

    public var deadVehicles:Sprite = null;

    public var aliveVehicles:Sprite = null;

    public var personal:Sprite = null;

    public var flags:Sprite = null;

    public function MinimapEntriesContainer() {
        super();
    }

    public function dispose():void {
        this.points = null;
        this.icons = null;
        this.equipments = null;
        this.deadVehicles = null;
        this.aliveVehicles = null;
        this.personal = null;
        this.flags = null;
    }
}
}
