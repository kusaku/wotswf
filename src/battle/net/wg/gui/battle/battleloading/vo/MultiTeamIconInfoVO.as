package net.wg.gui.battle.battleloading.vo {
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class MultiTeamIconInfoVO implements IDisposable {

    public var isSquad:Boolean = false;

    public var isSelf:Boolean = false;

    public var label:String = "";

    public var countItems:int = 0;

    public var isWithSeparator:Boolean = false;

    public var points:int = 0;

    public function MultiTeamIconInfoVO() {
        super();
    }

    public function dispose():void {
    }
}
}
