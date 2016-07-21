package net.wg.gui.lobby.barracks {
import flash.display.InteractiveObject;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

import net.wg.gui.components.controls.CloseButton;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.events.CrewEvent;
import net.wg.infrastructure.base.meta.IBarracksMeta;
import net.wg.infrastructure.base.meta.impl.BarracksMeta;
import net.wg.infrastructure.exceptions.TypeCastException;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.ButtonBar;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.InputEvent;
import scaleform.clik.events.ListEvent;

public class Barracks extends BarracksMeta implements IBarracksMeta {

    private static const MY_HEIGHT_OFFSET:Number = 18;

    public var form:BarracksForm = null;

    private var closeButton:CloseButton = null;

    private var myWidth:Number = 0;

    private var myHeight:Number = 0;

    public function Barracks() {
        super();
    }

    override public function setViewSize(param1:Number, param2:Number):void {
        this.myWidth = param1;
        this.myHeight = param2;
        invalidateSize();
    }

    override public function updateStage(param1:Number, param2:Number):void {
        this.setViewSize(param1, param2);
    }

    override protected function configUI():void {
        super.configUI();
        this.form.addEventListener(CrewEvent.OPEN_PERSONAL_CASE, this.openPersonalCaseHandler);
        this.form.addEventListener(CrewEvent.ON_INVALID_TANK_LIST, this.invalidateTanksListHandler);
        this.form.addEventListener(CrewEvent.SHOW_BERTH_BUY_DIALOG, this.buyBerthsHandler);
        this.form.addEventListener(CrewEvent.DISMISS_TANKMAN, this.showDismissDialogHandler);
        this.form.addEventListener(CrewEvent.UNLOAD_TANKMAN, this.unloadTankmanHandler);
        this.form.addEventListener(CrewEvent.SHOW_RECRUIT_WINDOW, this.showRecruitWindowHandler);
        this.form.addEventListener(CrewEvent.ON_CHANGE_BARRACKS_FILTER, this.setFiltersHandler);
        this.form.tankmenTileList.addEventListener(ListEvent.INDEX_CHANGE, this.setFocusToControlHandler);
        this.closeButton = this.form.closeButton;
        this.closeButton.addEventListener(ButtonEvent.CLICK, this.barracksCloseHandler);
        App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE, KeyboardEvent.KEY_DOWN, this.escapeHandle, true);
    }

    override protected function onDispose():void {
        this.form.removeEventListener(CrewEvent.OPEN_PERSONAL_CASE, this.openPersonalCaseHandler);
        this.form.removeEventListener(CrewEvent.ON_INVALID_TANK_LIST, this.invalidateTanksListHandler);
        this.form.removeEventListener(CrewEvent.SHOW_BERTH_BUY_DIALOG, this.buyBerthsHandler);
        this.form.removeEventListener(CrewEvent.DISMISS_TANKMAN, this.showDismissDialogHandler);
        this.form.removeEventListener(CrewEvent.UNLOAD_TANKMAN, this.unloadTankmanHandler);
        this.form.removeEventListener(CrewEvent.SHOW_RECRUIT_WINDOW, this.showRecruitWindowHandler);
        this.form.removeEventListener(CrewEvent.ON_CHANGE_BARRACKS_FILTER, this.setFiltersHandler);
        this.form.tankmenTileList.removeEventListener(ListEvent.INDEX_CHANGE, this.setFocusToControlHandler);
        this.closeButton.removeEventListener(ButtonEvent.CLICK, this.barracksCloseHandler);
        this.closeButton = null;
        this.form.dispose();
        this.form = null;
        App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE, KeyboardEvent.KEY_DOWN);
        super.onDispose();
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.form.onPopulate();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.x = this.myWidth - _originalWidth >> 1;
            this.y = this.myHeight + MY_HEIGHT_OFFSET - _originalHeight >> 1;
        }
    }

    public function as_setTankmen(param1:Number, param2:Number, param3:Number, param4:Number, param5:Array):void {
        this.form.as_setTankmen(param1, param2, param3, param4, param5);
    }

    public function as_setTankmenFilter(param1:Number, param2:String, param3:String, param4:String, param5:String):void {
        this.form.as_setTankmenFilter(param1, param2, param3, param4, param5);
    }

    public function as_updateTanksList(param1:Array):void {
        this.form.as_updateTanksList(param1);
    }

    private function updateSelectedIndex(param1:Object, param2:Object):void {
        var _loc3_:Boolean = param1 is ButtonBar || param1 is DropdownMenu;
        var _loc4_:String = "object in ... must be ButtonBar or DropdownMenu";
        assert(_loc3_, _loc4_, TypeCastException);
        var _loc5_:int = param1.dataProvider.length;
        param1.selectedIndex = 0;
        var _loc6_:Number = 0;
        while (_loc6_ < _loc5_) {
            if (param1.dataProvider[_loc6_].data == param2) {
                param1.selectedIndex = _loc6_;
                return;
            }
            _loc6_++;
        }
    }

    private function openPersonalCaseHandler(param1:CrewEvent):void {
        openPersonalCaseS(param1.initProp.tankmanID.toString(), param1.selectedTab);
    }

    private function showRecruitWindowHandler(param1:CrewEvent):void {
        onShowRecruitWindowClickS(param1.initProp, param1.menuEnabled);
    }

    private function unloadTankmanHandler(param1:CrewEvent):void {
        unloadTankmanS(param1.initProp.compact);
    }

    private function showDismissDialogHandler(param1:CrewEvent):void {
        dismissTankmanS(param1.initProp.compact);
    }

    private function buyBerthsHandler(param1:CrewEvent):void {
        buyBerthsS();
    }

    private function setFiltersHandler(param1:CrewEvent):void {
        setFilterS(param1.initProp.nation, param1.initProp.role, param1.initProp.tankType, param1.initProp.location, param1.initProp.nationID);
    }

    private function escapeHandle(param1:InputEvent):void {
        closeBarracksS();
    }

    private function barracksCloseHandler(param1:ButtonEvent):void {
        closeBarracksS();
    }

    private function invalidateTanksListHandler(param1:CrewEvent):void {
        invalidateTanksListS();
    }

    private function setFocusToControlHandler(param1:ListEvent):void {
        setFocus(InteractiveObject(param1.target));
    }
}
}