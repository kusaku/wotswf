package net.wg.gui.battle.components.damageIndicator {
import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.display.Sprite;
import flash.utils.Dictionary;

import net.wg.data.constants.AtlasConstants;
import net.wg.data.constants.generated.DAMAGE_INDICATOR_ATLAS_ITEMS;
import net.wg.gui.utils.RootSWFAtlasManager;
import net.wg.infrastructure.events.AtlasEvent;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class StandardStateContainer extends Sprite implements IDisposable {

    private static const BLOCK_Y_OFFSET:int = -447;

    private static const DAMAGE_Y_OFFSET:int = -440;

    protected var statesBG:Dictionary = null;

    protected var currentState:Shape = null;

    protected var currentBGStr:String;

    private var _offsetY:int = 0;

    public function StandardStateContainer() {
        super();
    }

    protected static function createIndicatorAtlasShape(param1:String, param2:DisplayObjectContainer):Shape {
        var _loc3_:Shape = null;
        _loc3_ = new Shape();
        RootSWFAtlasManager.instance.drawWithCenterAlign(AtlasConstants.DAMAGE_INDICATOR_ATLAS, param1, _loc3_.graphics, true, true);
        param2.addChildAt(_loc3_, 0);
        _loc3_.visible = false;
        return _loc3_;
    }

    public function dispose():void {
        RootSWFAtlasManager.instance.removeEventListener(AtlasEvent.ATLAS_INITIALIZED, this.onAtlasInitializedHandler);
        App.utils.data.cleanupDynamicObject(this.statesBG);
        this.statesBG = null;
        this.currentState = null;
    }

    public function init():void {
        this.statesBG = this.createItemsFromAtlas(this.stateNames, this, null);
        RootSWFAtlasManager.instance.addEventListener(AtlasEvent.ATLAS_INITIALIZED, this.onAtlasInitializedHandler);
        this.currentState = this.statesBG[DAMAGE_INDICATOR_ATLAS_ITEMS.DAMAGE_STANDARD];
    }

    public function setYOffset(param1:int):void {
        this._offsetY = param1;
        this.updatePosition();
    }

    public function updateBGState(param1:String):void {
        if (this.currentBGStr != param1) {
            this.currentBGStr = param1;
            this.currentState.visible = false;
            this.currentState = this.statesBG[param1];
            this.currentState.visible = true;
        }
    }

    protected function createItemsFromAtlas(param1:Vector.<String>, param2:DisplayObjectContainer, param3:Dictionary):Dictionary {
        var _loc6_:Shape = null;
        var _loc7_:String = null;
        var _loc4_:Dictionary = param3;
        if (param3 == null) {
            _loc4_ = new Dictionary();
        }
        var _loc5_:int = param1.length;
        var _loc8_:int = 0;
        while (_loc8_ < _loc5_) {
            _loc7_ = param1[_loc8_];
            _loc6_ = createIndicatorAtlasShape(param1[_loc8_], param2);
            _loc4_[_loc7_] = _loc6_;
            _loc8_++;
        }
        return _loc4_;
    }

    protected function updatePosition():void {
        this.statesBG[DAMAGE_INDICATOR_ATLAS_ITEMS.BLOCKED_STANDARD].y = BLOCK_Y_OFFSET + this._offsetY;
        var _loc1_:int = DAMAGE_Y_OFFSET + this._offsetY;
        this.statesBG[DAMAGE_INDICATOR_ATLAS_ITEMS.DAMAGE_STANDARD].y = _loc1_;
        this.statesBG[DAMAGE_INDICATOR_ATLAS_ITEMS.DAMAGE_STANDARD_BLIND].y = _loc1_;
    }

    protected function get stateNames():Vector.<String> {
        return new <String>[DAMAGE_INDICATOR_ATLAS_ITEMS.DAMAGE_STANDARD, DAMAGE_INDICATOR_ATLAS_ITEMS.DAMAGE_STANDARD_BLIND, DAMAGE_INDICATOR_ATLAS_ITEMS.BLOCKED_STANDARD];
    }

    private function onAtlasInitializedHandler(param1:AtlasEvent):void {
        this.updatePosition();
    }
}
}
