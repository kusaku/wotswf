package net.wg.gui.lobby.christmas {
import flash.display.InteractiveObject;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.gui.lobby.christmas.data.ChristmasFiltersVO;
import net.wg.gui.lobby.christmas.event.ChristmasFilterEvent;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IFocusChainContainer;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ListEvent;

public class ChristmasDecorationsFilters extends UIComponentEx implements IFocusChainContainer {

    public var lblFilter:TextField = null;

    public var listFilter:ChristmasDecorationsFiltersList = null;

    public function ChristmasDecorationsFilters() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.lblFilter.autoSize = TextFieldAutoSize.LEFT;
        this.listFilter.addEventListener(ListEvent.ITEM_CLICK, this.onListFilterItemClickHandler);
    }

    override protected function onDispose():void {
        this.listFilter.removeEventListener(ListEvent.ITEM_CLICK, this.onListFilterItemClickHandler);
        this.listFilter.dispose();
        this.listFilter = null;
        this.lblFilter = null;
        super.onDispose();
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        return this.listFilter.getFocusChain();
    }

    public function setData(param1:ChristmasFiltersVO):void {
        this.lblFilter.htmlText = param1.label;
        if (this.listFilter.dataProvider != null) {
            this.listFilter.dataProvider.cleanUp();
        }
        this.listFilter.dataProvider = new DataProvider(param1.items);
        this.listFilter.validateNow();
    }

    private function onListFilterItemClickHandler(param1:ListEvent):void {
        dispatchEvent(new ChristmasFilterEvent(ChristmasFilterEvent.CHANGE, param1.index));
    }
}
}
