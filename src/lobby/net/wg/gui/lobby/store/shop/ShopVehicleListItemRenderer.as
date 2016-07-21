package net.wg.gui.lobby.store.shop {
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.VO.StoreTableData;
import net.wg.gui.components.advanced.TankIcon;
import net.wg.gui.lobby.store.shop.base.ShopTableItemRenderer;

public class ShopVehicleListItemRenderer extends ShopTableItemRenderer {

    public var vehicleIcon:TankIcon = null;

    public var warnMessageTf:TextField = null;

    public function ShopVehicleListItemRenderer() {
        super();
    }

    override protected function update():void {
        var _loc1_:StoreTableData = null;
        super.update();
        if (data) {
            _loc1_ = StoreTableData(data);
            this.warnMessageTf.text = _loc1_.warnMessage;
            this.warnMessageTf.visible = _loc1_.warnMessage != null && _loc1_.warnMessage.length > 0;
            this.updateVehicleIcon(_loc1_);
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.warnMessageTf.autoSize = TextFieldAutoSize.RIGHT;
    }

    override protected function onDispose():void {
        this.vehicleIcon.dispose();
        this.vehicleIcon = null;
        this.warnMessageTf = null;
        super.onDispose();
    }

    private function updateVehicleIcon(param1:StoreTableData):void {
        getHelper().initVehicleIcon(this.vehicleIcon, param1);
    }
}
}
