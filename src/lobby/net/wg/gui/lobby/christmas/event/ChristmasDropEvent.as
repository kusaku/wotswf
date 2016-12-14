package net.wg.gui.lobby.christmas.event {
import flash.events.Event;

import net.wg.gui.lobby.christmas.data.DecorationInfoVO;
import net.wg.gui.lobby.christmas.interfaces.IChristmasDropActor;

public class ChristmasDropEvent extends Event {

    public static const ITEM_DROPPED:String = "christmasItemDropped";

    private var _sender:IChristmasDropActor;

    private var _receiver:IChristmasDropActor;

    private var _dropInfo:DecorationInfoVO;

    public function ChristmasDropEvent(param1:String, param2:IChristmasDropActor, param3:IChristmasDropActor, param4:DecorationInfoVO, param5:Boolean = false, param6:Boolean = false) {
        super(param1, param5, param6);
        this._sender = param2;
        this._receiver = param3;
        this._dropInfo = param4;
    }

    override public function clone():Event {
        return new ChristmasDropEvent(type, this._sender, this._receiver, this._dropInfo, bubbles, cancelable);
    }

    public function get sender():IChristmasDropActor {
        return this._sender;
    }

    public function get receiver():IChristmasDropActor {
        return this._receiver;
    }

    public function get dropInfo():DecorationInfoVO {
        return this._dropInfo;
    }
}
}
