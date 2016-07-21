package net.wg.gui.lobby.vehicleCustomization {
import flash.display.InteractiveObject;

import net.wg.data.constants.Values;
import net.wg.gui.lobby.vehicleCustomization.events.CustomizationSlotEvent;
import net.wg.infrastructure.interfaces.IFocusChainContainer;

import scaleform.clik.constants.InvalidationType;

public class CustomizationGroupsSlotPanel extends CustomizationSlotsPanel implements IFocusChainContainer {

    private var _allRenderers:Vector.<CustomizationSlotRenderer> = null;

    private var _selectedIndex:int = -1;

    public function CustomizationGroupsSlotPanel() {
        super();
    }

    override protected function draw():void {
        var _loc1_:Vector.<ISlotsPanelRenderer> = null;
        var _loc2_:CustomizationGroupRenderer = null;
        var _loc3_:ISlotsPanelRenderer = null;
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            this._allRenderers = new Vector.<CustomizationSlotRenderer>();
            _loc1_ = null;
            for each(_loc2_ in renderers) {
                _loc1_ = _loc2_.slots.renderers;
                for each(_loc3_ in _loc1_) {
                    this._allRenderers.push(_loc3_ as CustomizationSlotRenderer);
                    _loc3_.selectId = this._allRenderers.length - 1;
                }
            }
        }
        addEventListener(CustomizationSlotEvent.SELECT_SLOT, this.onSelectSlotHandler);
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
        var _loc2_:CustomizationSlotRenderer = null;
        for each(_loc2_ in this.allRenderers) {
            _loc1_ = _loc1_.concat(_loc2_.getFocusChain());
        }
        return _loc1_;
    }

    override protected function onDispose():void {
        removeEventListener(CustomizationSlotEvent.SELECT_SLOT, this.onSelectSlotHandler);
        this._allRenderers.splice(0, this._allRenderers.length);
        this._allRenderers = null;
        super.onDispose();
    }

    public function diselectAll():void {
        this._allRenderers[this._selectedIndex].selected = false;
    }

    private function onSelectSlotHandler(param1:CustomizationSlotEvent):void {
        if (this._selectedIndex != Values.DEFAULT_INT) {
            this._allRenderers[this._selectedIndex].selected = false;
        }
        this._selectedIndex = param1.selectId;
        this._allRenderers[this._selectedIndex].selected = true;
    }

    public function get allRenderers():Vector.<CustomizationSlotRenderer> {
        return this._allRenderers;
    }
}
}
