package net.wg.gui.prebattle.company {
import flash.events.Event;
import flash.events.MouseEvent;

import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.prebattle.company.events.CompanyDropDownEvent;
import net.wg.gui.prebattle.company.events.CompanyEvent;

public class GroupPlayersDropDownMenu extends DropdownMenu {

    private var _prbID:int;

    public function GroupPlayersDropDownMenu() {
        super();
    }

    public function set prbID(param1:int):void {
        this._prbID = param1;
    }

    override protected function onDispose():void {
        if (_dropdownRef) {
            _dropdownRef.removeEventListener(MouseEvent.MOUSE_DOWN, this.onClickDropDownMenu, false);
        }
        super.onDispose();
    }

    override protected function showDropdown():void {
        super.showDropdown();
        if (_dropdownRef) {
            _dropdownRef.buttonMode = true;
            _dropdownRef.mouseEnabled = true;
            _dropdownRef.addEventListener(MouseEvent.MOUSE_DOWN, this.onClickDropDownMenu, false, 1110, true);
            dispatchEvent(new CompanyDropDownEvent(CompanyDropDownEvent.SHOW_DROP_DOWN, _dropdownRef));
        }
    }

    private function onClickDropDownMenu(param1:MouseEvent):void {
        var _loc2_:CompanyEvent = new CompanyEvent(CompanyEvent.DROP_LIST_CLICK, true);
        _loc2_.prbID = this._prbID;
        dispatchEvent(_loc2_);
    }

    override public function open():void {
        selected = true;
        this.showDropdown();
    }

    override protected function changeFocus():void {
    }

    override public function close():void {
        selected = false;
        hideDropdown();
    }

    override protected function updateDDPosition(param1:Event):void {
    }
}
}
