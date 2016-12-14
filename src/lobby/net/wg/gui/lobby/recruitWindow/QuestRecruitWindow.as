package net.wg.gui.lobby.recruitWindow {
import flash.events.Event;

import net.wg.data.Aliases;
import net.wg.data.VO.TankmanCardVO;
import net.wg.gui.components.advanced.RecruitParametersComponent;
import net.wg.gui.components.advanced.TankmanCard;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.infrastructure.base.meta.IQuestRecruitWindowMeta;
import net.wg.infrastructure.base.meta.impl.QuestRecruitWindowMeta;
import net.wg.utils.ILocale;

import scaleform.clik.events.ButtonEvent;

public class QuestRecruitWindow extends QuestRecruitWindowMeta implements IQuestRecruitWindowMeta {

    public var card:TankmanCard;

    public var paramsComponent:RecruitParametersComponent;

    public var btnApply:SoundButtonEx;

    public function QuestRecruitWindow() {
        super();
    }

    override protected function setInitData(param1:TankmanCardVO):void {
        this.card.model = param1;
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.useBottomBtns = true;
    }

    override protected function configUI():void {
        super.configUI();
        registerFlashComponentS(this.paramsComponent, Aliases.RECRUIT_PARAMS);
        this.btnApply.addEventListener(ButtonEvent.CLICK, this.btnApplyClickHandler, false, 0, true);
        this.paramsComponent.addEventListener(Event.CHANGE, this.paramsChangeHandler, false, 0, true);
        var _loc1_:ILocale = App.utils.locale;
        this.window.title = _loc1_.makeString(DIALOGS.RECRUITWINDOW_TITLE);
        this.btnApply.label = _loc1_.makeString(DIALOGS.RECRUITWINDOW_SUBMIT);
    }

    private function btnApplyClickHandler(param1:ButtonEvent):void {
        this.onApplyS({
            "nation": this.paramsComponent.getSelectedNation(),
            "vehicleClass": this.paramsComponent.getSelectedVehicleClass(),
            "vehicle": this.paramsComponent.getSelectedVehicle(),
            "tankmanRole": this.paramsComponent.getSelectedTankmanRole()
        });
    }

    override protected function onDispose():void {
        this.btnApply.removeEventListener(ButtonEvent.CLICK, this.btnApplyClickHandler);
        this.btnApply.dispose();
        this.btnApply = null;
        this.paramsComponent.removeEventListener(Event.CHANGE, this.paramsChangeHandler);
        this.paramsComponent = null;
        this.card.dispose();
        this.card = null;
        super.onDispose();
    }

    private function paramsChangeHandler(param1:Event = null):void {
        this.btnApply.enabled = this.paramsComponent.vehicleClassDropdown.selectedIndex != 0 && this.paramsComponent.vehicleTypeDropdown.selectedIndex != 0 && this.paramsComponent.roleDropdown.selectedIndex != 0;
    }
}
}
