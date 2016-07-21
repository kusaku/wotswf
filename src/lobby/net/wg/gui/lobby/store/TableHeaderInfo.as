package net.wg.gui.lobby.store {
import flash.text.TextField;

import net.wg.infrastructure.base.UIComponentEx;

public class TableHeaderInfo extends UIComponentEx {

    public var countField:TextField = null;

    public var textField:TextField = null;

    public function TableHeaderInfo() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.textField.text = MENU.SHOP_TABLE_HEADER_PRICE;
    }

    override protected function onDispose():void {
        this.countField = null;
        this.textField = null;
        super.onDispose();
    }
}
}
