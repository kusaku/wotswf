package net.wg.gui.lobby.store {
import flash.events.MouseEvent;

import net.wg.gui.components.controls.ScrollingListEx;

import scaleform.clik.interfaces.IListItemRenderer;

public class StoreList extends ScrollingListEx {

    public function StoreList() {
        super();
    }

    override protected function setupRenderer(param1:IListItemRenderer):void {
        super.setupRenderer(param1);
        param1.addEventListener(MouseEvent.MOUSE_DOWN, this.onRendererMouseDownHandler);
    }

    private function onRendererMouseDownHandler(param1:MouseEvent):void {
        selectedIndex = IListItemRenderer(param1.currentTarget).index;
    }

    override protected function cleanUpRenderer(param1:IListItemRenderer):void {
        param1.removeEventListener(MouseEvent.MOUSE_DOWN, this.onRendererMouseDownHandler);
        super.cleanUpRenderer(param1);
    }
}
}
