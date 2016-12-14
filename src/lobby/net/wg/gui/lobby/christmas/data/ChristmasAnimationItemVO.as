package net.wg.gui.lobby.christmas.data {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.lobby.christmas.interfaces.IChristmasAnimationItemVO;

public class ChristmasAnimationItemVO extends DAAPIDataClass implements IChristmasAnimationItemVO {

    private var _toyImage:String = "";

    private var _rankImage:String = "";

    public function ChristmasAnimationItemVO(param1:Object = null) {
        super(param1);
    }

    public function get toyImage():String {
        return this._toyImage;
    }

    public function set toyImage(param1:String):void {
        this._toyImage = param1;
    }

    public function get rankImage():String {
        return this._rankImage;
    }

    public function set rankImage(param1:String):void {
        this._rankImage = param1;
    }
}
}
