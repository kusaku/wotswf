package net.wg.gui.battle.views.vehicleMarkers {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.gfx.TextFieldEx;

public class DamageLabel extends Sprite implements IDisposable {

    public var green:TextField = null;

    public var red:TextField = null;

    public var gold:TextField = null;

    public var blue:TextField = null;

    public var yellow:TextField = null;

    public var purple:TextField = null;

    private var _currentTF:TextField = null;

    private var tfMap:Object;

    public function DamageLabel() {
        this.tfMap = {};
        super();
        this._currentTF = this.green;
        this.green.visible = false;
        this.red.visible = false;
        this.gold.visible = false;
        this.blue.visible = false;
        this.yellow.visible = false;
        this.purple.visible = false;
        TextFieldEx.setNoTranslate(this.green, true);
        TextFieldEx.setNoTranslate(this.red, true);
        TextFieldEx.setNoTranslate(this.gold, true);
        TextFieldEx.setNoTranslate(this.blue, true);
        TextFieldEx.setNoTranslate(this.yellow, true);
        TextFieldEx.setNoTranslate(this.purple, true);
        this.tfMap["green"] = this.green;
        this.tfMap["red"] = this.red;
        this.tfMap["gold"] = this.gold;
        this.tfMap["blue"] = this.blue;
        this.tfMap["yellow"] = this.yellow;
        this.tfMap["purple"] = this.purple;
    }

    public function dispose():void {
        this.green = null;
        this.red = null;
        this.gold = null;
        this.blue = null;
        this.yellow = null;
        this.purple = null;
        this._currentTF = null;
        App.utils.data.cleanupDynamicObject(this.tfMap);
        this.tfMap = null;
    }

    private function showTF(param1:String):void {
        if (this.tfMap[param1]) {
            this._currentTF.visible = false;
            this._currentTF = this.tfMap[param1];
            this._currentTF.visible = true;
        }
        else {
            App.utils.asserter.assert(false, "Can\'t find TextField " + param1 + " in DamageLabel");
        }
    }

    public function set color(param1:String):void {
        this.showTF(param1);
    }

    public function set text(param1:String):void {
        if (this._currentTF) {
            this._currentTF.text = param1;
        }
    }

    public function get textWidth():Number {
        return !!this._currentTF ? Number(this._currentTF.textWidth) : Number(0);
    }
}
}
