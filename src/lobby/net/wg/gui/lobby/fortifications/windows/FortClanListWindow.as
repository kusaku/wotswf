package net.wg.gui.lobby.fortifications.windows {
import net.wg.data.constants.SortingInfo;
import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.gui.components.controls.SortableTable;
import net.wg.gui.events.SortableTableListEvent;
import net.wg.gui.lobby.fortifications.data.FortClanListWindowVO;
import net.wg.infrastructure.base.meta.IFortClanListWindowMeta;
import net.wg.infrastructure.base.meta.impl.FortClanListWindowMeta;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;
import scaleform.gfx.MouseEventEx;

public class FortClanListWindow extends FortClanListWindowMeta implements IFortClanListWindowMeta {

    private static const TOTAL_MINING:String = "intTotalMining";

    private static const IS_SELF:String = "himself";

    public var table:SortableTable;

    private var _data:FortClanListWindowVO = null;

    public function FortClanListWindow() {
        super();
        isModal = false;
        isCentered = true;
        this.table.addEventListener(SortableTableListEvent.RENDERER_CLICK, this.onTableRendererClickHandler);
    }

    override protected function draw():void {
        super.draw();
        if (this._data && isInvalid(InvalidationType.DATA)) {
            window.title = this._data.windowTitle;
            this.table.headerDP = new DataProvider(App.utils.data.vectorToArray(this._data.tableHeader));
            this.table.sortByField(TOTAL_MINING, SortingInfo.DESCENDING_SORT);
            this.table.listDP = this._data.members;
            this.table.scrollListToItemByUniqKey(IS_SELF, true);
        }
    }

    override protected function onDispose():void {
        this.table.removeEventListener(SortableTableListEvent.RENDERER_CLICK, this.onTableRendererClickHandler);
        this.table.dispose();
        this.table = null;
        super.onDispose();
    }

    override protected function setData(param1:FortClanListWindowVO):void {
        this._data = param1;
        invalidateData();
    }

    private function onTableRendererClickHandler(param1:SortableTableListEvent):void {
        if (param1.buttonIdx == MouseEventEx.RIGHT_BUTTON) {
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.BASE_USER, this, param1.itemData);
        }
        else {
            App.contextMenuMgr.hide();
        }
    }
}
}
