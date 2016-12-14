package net.wg.gui.lobby.christmas.controls.slots {
import flash.display.Sprite;

import net.wg.gui.lobby.christmas.data.DecorationInfoVO;
import net.wg.gui.lobby.christmas.interfaces.IChristmasDropItem;
import net.wg.gui.lobby.christmas.interfaces.IChristmasSlotHitArea;

public class ChristmasTreeSlotHitArea extends Sprite implements IChristmasSlotHitArea {

    private var _dropItem:IChristmasDropItem;

    public function ChristmasTreeSlotHitArea() {
        super();
        mouseChildren = false;
        buttonMode = true;
    }

    public final function dispose():void {
        this._dropItem = null;
    }

    public function setDropItem(param1:IChristmasDropItem):void {
        this._dropItem = param1;
    }

    public function get decorationInfo():DecorationInfoVO {
        return this._dropItem.decorationInfo;
    }

    public function get getCursorType():String {
        return this._dropItem.getCursorType;
    }

    public function get data():Object {
        return this._dropItem.data;
    }

    public function get enabled():Boolean {
        return true;
    }
}
}
