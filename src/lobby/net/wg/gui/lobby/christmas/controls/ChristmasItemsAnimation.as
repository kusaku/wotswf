package net.wg.gui.lobby.christmas.controls {
import flash.display.DisplayObject;
import flash.display.MovieClip;

import net.wg.gui.lobby.christmas.interfaces.IChristmasAnimationItem;
import net.wg.gui.lobby.christmas.interfaces.IChristmasAnimationItemVO;
import net.wg.gui.lobby.christmas.interfaces.IChristmasItemsAnimation;

public class ChristmasItemsAnimation extends MovieClip implements IChristmasItemsAnimation {

    public var itemsMask1:DisplayObject = null;

    public var itemsMask2:DisplayObject = null;

    public var item1:IChristmasAnimationItem = null;

    public var item2:IChristmasAnimationItem = null;

    private var _items:Vector.<IChristmasAnimationItem> = null;

    public function ChristmasItemsAnimation() {
        super();
        this._items = new <IChristmasAnimationItem>[this.item1, this.item2];
        this.item1.mask = this.itemsMask1;
        this.item2.mask = this.itemsMask2;
    }

    public final function dispose():void {
        var _loc1_:IChristmasAnimationItem = null;
        for each(_loc1_ in this._items) {
            _loc1_.dispose();
            this[_loc1_.name] = null;
        }
        this._items.splice(0, this._items.length);
        this._items = null;
        this.itemsMask1 = null;
        this.itemsMask2 = null;
    }

    public function setData(param1:Vector.<IChristmasAnimationItemVO>):void {
        var _loc2_:int = Math.min(this._items.length, param1.length);
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            this._items[_loc3_].setData(param1[_loc3_]);
            _loc3_++;
        }
    }
}
}
