package net.wg.gui.lobby.christmas.data.slots {
import net.wg.gui.lobby.christmas.data.BaseDecorationVO;
import net.wg.gui.lobby.christmas.interfaces.IChristmasAnimationItemVO;

public class SlotVO extends BaseDecorationVO implements IChristmasAnimationItemVO {

    public var slotId:int = -1;

    public var btnRemoveVisible:Boolean = false;

    public var isEmpty:Boolean = true;

    public var tooltip:String = "";

    public var showAnimation:Boolean = false;

    public function SlotVO(param1:Object) {
        super(param1);
    }

    public function get toyImage():String {
        return icon;
    }

    public function get rankImage():String {
        return rankIcon;
    }
}
}
