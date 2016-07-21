package net.wg.gui.lobby.questsWindow.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class QuestDetailsSpacingVO extends DAAPIDataClass {

    private var _linkage:String;

    private var _spacing:int = 0;

    public function QuestDetailsSpacingVO(param1:Object) {
        super(param1);
    }

    public function get spacing():int {
        return this._spacing;
    }

    public function set spacing(param1:int):void {
        this._spacing = param1;
    }

    public function get linkage():String {
        return this._linkage;
    }

    public function set linkage(param1:String):void {
        this._linkage = param1;
    }
}
}
