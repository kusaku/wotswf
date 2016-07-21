package net.wg.gui.lobby.vehicleCustomization {
import flash.display.InteractiveObject;

import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationSlotUpdateVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationSlotsGroupVO;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IFocusChainContainer;

import scaleform.clik.data.DataProvider;

public class CustomizationSlotsPanelView extends UIComponentEx implements IFocusChainContainer {

    public var mainPanel:CustomizationGroupsSlotPanel = null;

    public function CustomizationSlotsPanelView() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.mainPanel.ownerId = 0;
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc1_:Vector.<InteractiveObject> = this.mainPanel.getFocusChain();
        return _loc1_;
    }

    override protected function onDispose():void {
        this.mainPanel.dispose();
        this.mainPanel = null;
        super.onDispose();
    }

    public function setData(param1:Vector.<CustomizationSlotsGroupVO>):void {
        this.mainPanel.setData(new DataProvider(App.utils.data.vectorToArray(param1)));
    }

    public function updateSlot(param1:CustomizationSlotUpdateVO):void {
        this.mainPanel.updateSlot(param1.type, param1);
    }
}
}
