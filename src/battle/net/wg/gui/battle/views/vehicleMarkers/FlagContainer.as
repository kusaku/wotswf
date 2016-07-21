package net.wg.gui.battle.views.vehicleMarkers {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.utils.getDefinitionByName;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class FlagContainer extends Sprite implements IDisposable {

    private static const LINKAGE_FLAG_GREEN:String = "FlagGreenUI";

    private static const LINKAGE_FLAG_RED:String = "FlagRedUI";

    private static const LINKAGE_FLAG_PURPLE:String = "FlagPurpleUI";

    private var _flagGreen:MovieClip = null;

    private var _flagRed:MovieClip = null;

    private var _flagPurple:MovieClip = null;

    private var _currFlag:MovieClip = null;

    public function FlagContainer() {
        super();
    }

    public function dispose():void {
        this._flagGreen = null;
        this._flagRed = null;
        this._flagPurple = null;
        this._currFlag = null;
    }

    public function showGreen():void {
        this._flagGreen = this.showFlag(this._flagGreen, LINKAGE_FLAG_GREEN);
    }

    public function showRed():void {
        this._flagRed = this.showFlag(this._flagRed, LINKAGE_FLAG_RED);
    }

    public function showPurple():void {
        this._flagPurple = this.showFlag(this._flagGreen, LINKAGE_FLAG_GREEN);
    }

    public function hide():void {
        if (this._currFlag) {
            this._currFlag.visible = false;
            this._currFlag = null;
        }
    }

    private function showFlag(param1:MovieClip, param2:String):MovieClip {
        var _loc3_:Class = null;
        if (this._currFlag && param1 == this._currFlag) {
            return param1;
        }
        if (param1) {
            param1.visible = true;
        }
        else {
            _loc3_ = getDefinitionByName(param2) as Class;
            param1 = new _loc3_();
            addChild(param1);
        }
        this._currFlag = param1;
        return param1;
    }
}
}
