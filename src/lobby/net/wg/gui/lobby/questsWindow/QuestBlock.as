package net.wg.gui.lobby.questsWindow {
import flash.events.Event;

import net.wg.data.constants.QuestsStates;
import net.wg.gui.lobby.questsWindow.data.QuestDataVO;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.core.UIComponent;

public class QuestBlock extends UIComponent {

    public var requirementsView:RequirementBlock;

    public var conditionsView:ConditionBlock;

    private var questData:QuestDataVO = null;

    private var currentView:String = "conditions";

    public function QuestBlock() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.requirementsView.addEventListener(Event.RESIZE, this.layoutBlocks);
        this.conditionsView.addEventListener(Event.RESIZE, this.layoutBlocks);
    }

    public function setData(param1:QuestDataVO):void {
        this.questData = param1;
        this.requirementsView.isReadyForLayout = false;
        this.conditionsView.isReadyForLayout = false;
        invalidateData();
    }

    public function setAvailableQuests(param1:Vector.<String>):void {
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA) && this.questData) {
            this.requirementsView.setData(this.questData.requirements);
            this.conditionsView.setData(this.questData.conditions);
        }
    }

    private function layoutBlocks(param1:Event):void {
        if (this.conditionsView.isReadyForLayout && this.requirementsView.isReadyForLayout) {
            this.layoutCurrentView(this.currentView);
        }
    }

    public function changeView(param1:Object):void {
        this.currentView = String(param1);
        if (this.conditionsView.isReadyForLayout && this.requirementsView.isReadyForLayout) {
            this.layoutCurrentView(this.currentView);
        }
    }

    private function layoutCurrentView(param1:String):void {
        if (param1 == QuestsStates.REQUIREMENTS) {
            this.requirementsView.visible = true;
            setSize(this.width, Math.round(this.requirementsView.height));
            this.conditionsView.visible = false;
            dispatchEvent(new Event(Event.RESIZE));
        }
        else if (param1 == QuestsStates.CONDITIONS) {
            this.requirementsView.visible = false;
            setSize(this.width, Math.round(this.conditionsView.height));
            this.conditionsView.visible = true;
            dispatchEvent(new Event(Event.RESIZE));
        }
    }

    override protected function onDispose():void {
        this.requirementsView.removeEventListener(Event.RESIZE, this.layoutBlocks);
        this.conditionsView.removeEventListener(Event.RESIZE, this.layoutBlocks);
        this.requirementsView.dispose();
        this.conditionsView.dispose();
        this.questData = null;
        this.requirementsView = null;
        this.conditionsView = null;
        super.onDispose();
    }
}
}
