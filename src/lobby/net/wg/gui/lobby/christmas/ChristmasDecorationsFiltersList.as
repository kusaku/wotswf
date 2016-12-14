package net.wg.gui.lobby.christmas {
import flash.display.InteractiveObject;

import net.wg.gui.components.controls.TileList;
import net.wg.gui.components.controls.ToggleRenderer;
import net.wg.infrastructure.events.FocusChainChangeEvent;
import net.wg.infrastructure.interfaces.IFocusChainContainer;

public class ChristmasDecorationsFiltersList extends TileList implements IFocusChainContainer {

    public function ChristmasDecorationsFiltersList() {
        super();
    }

    override protected function drawRenderers(param1:Number):void {
        super.drawRenderers(param1);
        dispatchEvent(new FocusChainChangeEvent(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE));
    }

    override protected function configUI():void {
        super.configUI();
        tabChildren = true;
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc3_:int = 0;
        var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
        var _loc2_:int = _renderers != null ? int(_renderers.length) : 0;
        if (_loc2_ > 0) {
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _loc1_.push(ToggleRenderer(getRendererAt(_loc3_)).btn);
                _loc3_++;
            }
        }
        return _loc1_;
    }
}
}
