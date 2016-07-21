package net.wg.gui.lobby.vehicleCustomization.events {
import flash.events.Event;

public class CustomizationItemEvent extends Event {

    public static const INSTALL_ITEM:String = "installItemEvent";

    public static const UNINSTALL_ITEM:String = "uninstallItemEvent";

    public static const SELECT_ITEM:String = "selectItemEvent";

    public static const DESELECT_ITEM:String = "deselectItemEvent";

    public static const REMOVE_ITEM:String = "removeItemEvent";

    public static const GO_TO_TASK:String = "goToTaskEvent";

    public static const CHANGE_PRICE:String = "changePriceItemEvent";

    private var _itemId:int = 0;

    private var _groupId:int = 0;

    public function CustomizationItemEvent(param1:String, param2:uint, param3:uint = 0, param4:Boolean = true, param5:Boolean = false) {
        super(param1, param4, param5);
        this._itemId = param2;
        this._groupId = param3;
    }

    public function get itemId():uint {
        return this._itemId;
    }

    public function get groupId():uint {
        return this._groupId;
    }
}
}
