package net.wg.gui.battle.components.damageIndicator {
import flash.display.Sprite;

import net.wg.data.constants.AtlasConstants;
import net.wg.gui.utils.RootSWFAtlasManager;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class DamageIndicator extends Sprite implements IDisposable {

    private static const DEFAULT_HEIGHT:int = 1018;

    public var hit_0:DamageIndicatorItem = null;

    public var hit_1:DamageIndicatorItem = null;

    public var hit_2:DamageIndicatorItem = null;

    public var hit_3:DamageIndicatorItem = null;

    public var hit_4:DamageIndicatorItem = null;

    private var _items:Vector.<DamageIndicatorItem> = null;

    private var _stageHeight:int = 1018;

    private var _guiScale:int = 1;

    public function DamageIndicator() {
        super();
        RootSWFAtlasManager.instance.initAtlas(AtlasConstants.DAMAGE_INDICATOR_ATLAS);
        this._items = new <DamageIndicatorItem>[this.hit_0, this.hit_1, this.hit_2, this.hit_3, this.hit_4];
        this.hit_0.init();
        this.hit_1.init();
        this.hit_2.init();
        this.hit_3.init();
        this.hit_4.init();
    }

    public function as_setScreenSettings(param1:Number, param2:Number, param3:Number):void {
        var _loc4_:DamageIndicatorItem = null;
        this._guiScale = param1;
        this._stageHeight = param3;
        for each(_loc4_ in this._items) {
            _loc4_.scaleX = _loc4_.scaleY = this._guiScale;
            if (param1 <= 1) {
                _loc4_.standardAnimation.stateContainer.setYOffset(DEFAULT_HEIGHT - this._stageHeight >> 1);
            }
            else {
                _loc4_.standardAnimation.stateContainer.setYOffset(DEFAULT_HEIGHT - this._stageHeight / this._guiScale >> 1);
            }
        }
    }

    public function as_hide(param1:int):void {
        this._items[param1].hide();
    }

    public function as_setYaw(param1:int, param2:Number):void {
        this._items[param1].setYaw(param2);
    }

    public function as_showExtended(param1:int, param2:String, param3:String, param4:int, param5:String, param6:String, param7:String):void {
        var _loc8_:DamageIndicatorItem = this._items[param1];
        _loc8_.showExtended(param2, param3, param4, param5, param6, param7);
        setChildIndex(_loc8_, numChildren - 1);
    }

    public function as_showStandard(param1:int, param2:String, param3:int):void {
        var _loc4_:DamageIndicatorItem = this._items[param1];
        _loc4_.showStandard(param2, param3);
        setChildIndex(_loc4_, numChildren - 1);
    }

    public function as_updateSettings(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean):void {
        this.hit_0.updateSettings(param1, param2, param3, param4);
        this.hit_1.updateSettings(param1, param2, param3, param4);
        this.hit_2.updateSettings(param1, param2, param3, param4);
        this.hit_3.updateSettings(param1, param2, param3, param4);
        this.hit_4.updateSettings(param1, param2, param3, param4);
    }

    public final function dispose():void {
        this._items.splice(0, this._items.length);
        this._items = null;
        this.hit_0.dispose();
        this.hit_1.dispose();
        this.hit_2.dispose();
        this.hit_3.dispose();
        this.hit_4.dispose();
        this.hit_0 = null;
        this.hit_1 = null;
        this.hit_2 = null;
        this.hit_3 = null;
        this.hit_4 = null;
        RootSWFAtlasManager.instance.dispose();
    }
}
}
