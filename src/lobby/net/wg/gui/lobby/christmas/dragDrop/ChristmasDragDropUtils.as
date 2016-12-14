package net.wg.gui.lobby.christmas.dragDrop {
import flash.display.InteractiveObject;
import flash.display.Sprite;

import net.wg.gui.lobby.christmas.interfaces.IChristmasDropItem;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class ChristmasDragDropUtils {

    private static var _instance:ChristmasDragDropUtils;

    public function ChristmasDragDropUtils() {
        super();
    }

    public static function get instance():ChristmasDragDropUtils {
        if (_instance == null) {
            _instance = new ChristmasDragDropUtils();
        }
        return _instance;
    }

    public function detachCursorItem():void {
        var _loc1_:Sprite = App.cursor.getAttachedSprite();
        if (_loc1_ != null) {
            if (_loc1_ is IDisposable) {
                IDisposable(_loc1_).dispose();
            }
            App.cursor.detachFromCursor();
        }
    }

    public function getDropItem(param1:InteractiveObject):IChristmasDropItem {
        if (param1 is IChristmasDropItem) {
            return IChristmasDropItem(param1);
        }
        return null;
    }
}
}
