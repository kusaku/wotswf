package net.wg.gui.lobby.christmas.controls {
import net.wg.data.constants.Cursors;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.lobby.christmas.data.DecorationInfoVO;
import net.wg.gui.lobby.christmas.interfaces.IChristmasDropItem;

public class ChristmasDecorationSlotBack extends SoundButtonEx implements IChristmasDropItem {

    private var _dropData:DecorationInfoVO;

    public function ChristmasDecorationSlotBack() {
        super();
    }

    override protected function onDispose():void {
        this._dropData = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        buttonMode = false;
    }

    public function setDropData(param1:DecorationInfoVO):void {
        this._dropData = param1;
        this.data = param1;
    }

    public function get decorationInfo():DecorationInfoVO {
        return this._dropData;
    }

    public function get getCursorType():String {
        return Cursors.DRAG_OPEN;
    }
}
}
