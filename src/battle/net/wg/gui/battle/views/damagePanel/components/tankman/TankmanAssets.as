package net.wg.gui.battle.views.damagePanel.components.tankman {
import flash.display.Bitmap;
import flash.display.DisplayObject;

import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
import net.wg.gui.battle.views.damagePanel.DamagePanel;
import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemClickArea;
import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelClickableItem;

public class TankmanAssets implements IDamagePanelClickableItem {

    private static const TANKMAN_HIT_AREA_PADDING:int = 5;

    public static const Y_POS:int = 197;

    private static const X_STEP:int = 25;

    private static const X_OFFSET:int = -3;

    private var _critical:Bitmap;

    private var _normal:Bitmap;

    private var _state:String = "";

    private var _name:String;

    private var _tankmanHit:DamagePanelItemClickArea;

    public function TankmanAssets(param1:String, param2:String, param3:String, param4:int, param5:int, param6:int) {
        var _loc11_:int = 0;
        super();
        this._name = param1;
        var _loc7_:Class = App.utils.classFactory.getClass(param2);
        var _loc8_:Class = App.utils.classFactory.getClass(param3);
        this._normal = new Bitmap(new _loc7_());
        this._critical = new Bitmap(new _loc8_());
        this._tankmanHit = new DamagePanelItemClickArea(param1, this._critical.width, this._critical.height, TANKMAN_HIT_AREA_PADDING);
        var _loc9_:int = (DamagePanel.PANEL_WIDTH - param5 * X_STEP >> 1) + X_OFFSET;
        var _loc10_:int = _loc9_ + X_STEP * param4;
        _loc11_ = Y_POS;
        this.state = BATTLE_ITEM_STATES.NORMAL;
        this._tankmanHit.x = this._critical.x = this._normal.x = _loc10_ + param6;
        this._tankmanHit.y = this._critical.y = this._normal.y = _loc11_;
        this._tankmanHit.visible = false;
    }

    public function dispose():void {
        this._tankmanHit.dispose();
        this._tankmanHit = null;
        this._critical.bitmapData.dispose();
        this._critical = null;
        this._normal.bitmapData.dispose();
        this._normal = null;
    }

    public function getDisplayItems():Vector.<DisplayObject> {
        return new <DisplayObject>[this._critical, this._normal];
    }

    public function showDestroyed():void {
        this._critical.visible = true;
        this._normal.visible = false;
    }

    public function get state():String {
        return this._state;
    }

    public function set state(param1:String):void {
        this._state = param1;
        var _loc2_:* = this.state == BATTLE_ITEM_STATES.NORMAL;
        this._normal.visible = _loc2_;
        this._critical.visible = !_loc2_;
    }

    public function get name():String {
        return this._name;
    }

    public function get mouseEventHitElement():DamagePanelItemClickArea {
        return this._tankmanHit;
    }
}
}
