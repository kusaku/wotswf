package net.wg.gui.battle.components {
import flash.display.Sprite;

import net.wg.data.constants.AtlasConstants;

public class BattleAtlasSprite extends Sprite {

    protected var _imageName:String = "";

    protected var _imageAltName:String = "";

    protected var _isFilled:Boolean = false;

    protected var _drawImmediately:Boolean = false;

    private var _defaultPosX:int = -1;

    private var _isCentralize:Boolean = false;

    public function BattleAtlasSprite() {
        super();
    }

    public function drawImmediately():void {
        this._drawImmediately = true;
        if (!this._isFilled && this._imageName) {
            this.fill(this._imageName, this._imageAltName);
        }
    }

    public function setImageNames(param1:String, param2:String):void {
        if (this._imageName == param1 && this._imageAltName == param2) {
            return;
        }
        this._imageName = param1;
        this._imageAltName = param2;
        this._isFilled = false;
        if (visible || this._drawImmediately) {
            this.fill(this._imageName, this._imageAltName);
        }
    }

    private function fill(param1:String, param2:String):void {
        if (App.atlasMgr) {
            App.atlasMgr.drawGraphics(AtlasConstants.BATTLE_ATLAS, param1, graphics, param2);
        }
        this._isFilled = true;
        if (this._isCentralize) {
            x = this._defaultPosX - width / 2;
        }
    }

    override public function set visible(param1:Boolean):void {
        if (param1 && !this._isFilled && this._imageName) {
            this.fill(this._imageName, this._imageAltName);
        }
        super.visible = param1;
    }

    public function get imageName():String {
        return this._imageName;
    }

    public function set imageName(param1:String):void {
        if (this._imageName == param1) {
            return;
        }
        this._imageName = param1;
        this._isFilled = false;
        if (visible || this._drawImmediately) {
            this.fill(this._imageName, this._imageAltName);
        }
    }

    public function set isCetralize(param1:Boolean):void {
        this._isCentralize = param1;
        if (this._isCentralize) {
            this._defaultPosX = x;
        }
    }
}
}
