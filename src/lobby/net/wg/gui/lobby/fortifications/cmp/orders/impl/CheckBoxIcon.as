package net.wg.gui.lobby.fortifications.cmp.orders.impl {
import flash.events.Event;

import net.wg.data.constants.Values;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.fortifications.cmp.orders.ICheckBoxIcon;
import net.wg.gui.lobby.fortifications.data.CheckBoxIconVO;
import net.wg.infrastructure.base.UIComponentEx;

public class CheckBoxIcon extends UIComponentEx implements ICheckBoxIcon {

    public var checkOrders:CheckBox = null;

    public var checkIcon:UILoaderAlt = null;

    private var _isInited:Boolean = false;

    public function CheckBoxIcon() {
        super();
        this.checkOrders.label = Values.EMPTY_STR;
        this.checkIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_FORTIFICATION_AIM;
        this.checkIcon.mouseEnabled = true;
        this.buttonMode = true;
        this.useHandCursor = true;
        this.mouseChildren = true;
    }

    public function isInited():Boolean {
        return this._isInited;
    }

    override protected function configUI():void {
        super.configUI();
        this.checkOrders.addEventListener(Event.SELECT, this.onSelectHandler);
    }

    private function onSelectHandler(param1:Event):void {
        dispatchEvent(new Event(Event.SELECT, true));
    }

    public function update(param1:Object):void {
        var _loc2_:CheckBoxIconVO = CheckBoxIconVO(param1);
        this.checkIcon.source = _loc2_.icon;
        this.checkOrders.selected = _loc2_.isSelected;
        this.checkOrders.label = _loc2_.label;
        _loc2_.dispose();
        _loc2_ = null;
        this._isInited = true;
    }

    public function isSelected():Boolean {
        return this.checkOrders.selected;
    }

    override protected function onDispose():void {
        this.checkOrders.removeEventListener(Event.SELECT, this.onSelectHandler);
        this.checkOrders.dispose();
        this.checkOrders = null;
        this.checkIcon.dispose();
        this.checkIcon = null;
        super.onDispose();
    }
}
}
