package net.wg.gui.lobby.quests.components {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.generated.QUESTS_ALIASES;
import net.wg.gui.components.advanced.interfaces.IBackButton;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.quests.components.interfaces.ITasksProgressComponent;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestsTileChainsViewHeaderVO;
import net.wg.gui.lobby.quests.events.QuestsTileChainViewHeaderEvent;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.utils.IUtils;

import scaleform.clik.events.ButtonEvent;

public class QuestsTileChainsViewHeader extends UIComponentEx {

    private static const PROGRESS_GAP:int = 22;

    public var titleTf:TextField = null;

    public var backBtn:IBackButton = null;

    public var backgroundLoader:UILoaderAlt = null;

    public var progressTf:TextField = null;

    public var tasksProgress:ITasksProgressComponent = null;

    public var shadow:MovieClip = null;

    public var _data:QuestsTileChainsViewHeaderVO;

    public function QuestsTileChainsViewHeader() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.backBtn.addEventListener(ButtonEvent.CLICK, this.onBackBtnClickHandler);
        this.titleTf.addEventListener(MouseEvent.ROLL_OVER, this.onTitleRollOverHandler);
        this.titleTf.addEventListener(MouseEvent.ROLL_OUT, this.onTitleRollOutHandler);
        this.titleTf.autoSize = TextFieldAutoSize.CENTER;
        this.progressTf.autoSize = TextFieldAutoSize.LEFT;
    }

    override protected function onDispose():void {
        this.backBtn.removeEventListener(ButtonEvent.CLICK, this.onBackBtnClickHandler);
        this.backBtn.dispose();
        this.backBtn = null;
        this.titleTf.removeEventListener(MouseEvent.ROLL_OVER, this.onTitleRollOverHandler);
        this.titleTf.removeEventListener(MouseEvent.ROLL_OUT, this.onTitleRollOutHandler);
        this.titleTf = null;
        this.backgroundLoader.dispose();
        this.backgroundLoader = null;
        this.tasksProgress.dispose();
        this.tasksProgress = null;
        this.progressTf = null;
        this.shadow = null;
        this._data = null;
        super.onDispose();
    }

    public function setData(param1:QuestsTileChainsViewHeaderVO):void {
        this._data = param1;
        this.backBtn.label = this._data.backBtnText;
        this.backBtn.tooltip = this._data.backBtnTooltip;
        this.backgroundLoader.source = this._data.backgroundImagePath;
        this.titleTf.htmlText = this._data.titleText;
        this.progressTf.htmlText = this._data.tasksProgressLabel;
        var _loc2_:IUtils = App.utils;
        _loc2_.commons.updateTextFieldSize(this.progressTf);
        if (this.tasksProgress != null) {
            removeChild(DisplayObject(this.tasksProgress));
            this.tasksProgress.dispose();
        }
        var _loc3_:String = this._data.tasksProgressLinkage;
        _loc2_.asserter.assert(QUESTS_ALIASES.QUEST_TASKS_PROGRESS_LINKAGES.indexOf(_loc3_) >= 0, "Invalid tasks progress linkage.");
        this.tasksProgress = _loc2_.classFactory.getComponent(_loc3_, ITasksProgressComponent);
        addChild(DisplayObject(this.tasksProgress));
        this.layout();
    }

    private function layout():void {
        this.tasksProgress.x = this.progressTf.x + this.progressTf.width + PROGRESS_GAP | 0;
        this.tasksProgress.y = this.progressTf.y + (this.progressTf.height - this.tasksProgress.height >> 1) | 0;
    }

    private function onTitleRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onTitleRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showSpecial(this._data.tooltipType, null, this._data.tileID);
    }

    private function onBackBtnClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new QuestsTileChainViewHeaderEvent(QuestsTileChainViewHeaderEvent.BACK_BUTTON_PRESS));
    }
}
}
