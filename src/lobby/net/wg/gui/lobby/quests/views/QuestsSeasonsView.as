package net.wg.gui.lobby.quests.views {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.Linkages;
import net.wg.data.constants.generated.QUESTS_ALIASES;
import net.wg.gui.components.controls.ResizableScrollPane;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.quests.components.QuestsContentTabs;
import net.wg.gui.lobby.quests.components.SeasonsListView;
import net.wg.gui.lobby.quests.components.SlotsPanel;
import net.wg.gui.lobby.quests.components.interfaces.IQuestsSeasonsView;
import net.wg.gui.lobby.quests.data.QuestSlotsDataVO;
import net.wg.gui.lobby.quests.data.QuestsSeasonsViewVO;
import net.wg.gui.lobby.quests.data.SeasonsDataVO;
import net.wg.gui.lobby.quests.events.PersonalQuestEvent;
import net.wg.infrastructure.base.meta.impl.QuestsSeasonsViewMeta;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.events.ButtonEvent;

public class QuestsSeasonsView extends QuestsSeasonsViewMeta implements IQuestsSeasonsView {

    private static const PANE_WIDTH:Number = 1012;

    private static const PANE_HEIGHT:Number = 392;

    private static const SCROLL_STEP_FACTOR:Number = 10;

    private static const SCROLL_BAR_MARGIN:Number = 10;

    public var scrollPane:ResizableScrollPane = null;

    public var seasonsList:SeasonsListView = null;

    public var slotsPanel:SlotsPanel = null;

    public var separatorBottom:MovieClip = null;

    public var awardsButton:SoundButtonEx;

    public var bgLoader:UILoaderAlt;

    public var tabs:QuestsContentTabs;

    public function QuestsSeasonsView() {
        super();
    }

    override protected function setData(param1:QuestsSeasonsViewVO):void {
        this.awardsButton.label = param1.awardsButtonLabel;
        this.awardsButton.tooltip = param1.awardsButtonTooltip;
        var _loc2_:String = param1.background;
        this.bgLoader.source = _loc2_;
        this.bgLoader.visible = StringUtils.isNotEmpty(_loc2_);
    }

    override protected function configUI():void {
        super.configUI();
        this.scrollPane.scrollStepFactor = SCROLL_STEP_FACTOR;
        this.scrollPane.scrollBarMargin = SCROLL_BAR_MARGIN;
        this.scrollPane.scrollBar = Linkages.SCROLL_BAR;
        this.scrollPane.setSize(PANE_WIDTH, PANE_HEIGHT);
        this.seasonsList = SeasonsListView(this.scrollPane.target);
        this.separatorBottom.mouseChildren = this.separatorBottom.mouseEnabled = false;
        this.awardsButton.focusable = false;
        this.awardsButton.autoSize = TextFieldAutoSize.RIGHT;
        this.awardsButton.addEventListener(ButtonEvent.CLICK, this.onAwardsButtonPressHandler);
        addEventListener(PersonalQuestEvent.TILE_CLICK, this.onTileClickHandler);
        addEventListener(PersonalQuestEvent.SLOT_CLICK, this.onSlotClickHandler);
    }

    override protected function onPopulate():void {
        super.onPopulate();
        registerFlashComponentS(this.tabs, QUESTS_ALIASES.QUESTS_CONTENT_TABS_PY_ALIAS);
    }

    override protected function onDispose():void {
        removeEventListener(PersonalQuestEvent.TILE_CLICK, this.onTileClickHandler);
        removeEventListener(PersonalQuestEvent.SLOT_CLICK, this.onSlotClickHandler);
        this.awardsButton.removeEventListener(ButtonEvent.CLICK, this.onAwardsButtonPressHandler);
        this.awardsButton.dispose();
        this.awardsButton = null;
        this.seasonsList = null;
        this.separatorBottom = null;
        this.scrollPane.dispose();
        this.scrollPane = null;
        this.slotsPanel.dispose();
        this.slotsPanel = null;
        this.bgLoader.dispose();
        this.bgLoader = null;
        this.tabs = null;
        super.onDispose();
    }

    override protected function setSeasonsData(param1:SeasonsDataVO):void {
        this.seasonsList.setData(param1);
    }

    override protected function setSlotsData(param1:QuestSlotsDataVO):void {
        this.slotsPanel.setData(param1);
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return this;
    }

    public function update(param1:Object):void {
    }

    private function onSlotClickHandler(param1:PersonalQuestEvent):void {
        onSlotClickS(param1.id);
    }

    private function onTileClickHandler(param1:PersonalQuestEvent):void {
        onTileClickS(param1.id);
    }

    private function onAwardsButtonPressHandler(param1:ButtonEvent):void {
        onShowAwardsClickS();
    }
}
}
