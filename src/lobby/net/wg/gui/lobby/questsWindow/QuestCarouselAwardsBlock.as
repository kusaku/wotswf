package net.wg.gui.lobby.questsWindow {
import flash.display.MovieClip;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.gui.lobby.quests.components.AwardCarousel;
import net.wg.gui.lobby.quests.components.RadioButtonScrollBar;
import net.wg.gui.lobby.questsWindow.components.QuestsDashlineItem;
import net.wg.gui.lobby.questsWindow.data.QuestDashlineItemVO;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.interfaces.IDataProvider;

public class QuestCarouselAwardsBlock extends UIComponentEx {

    public var radioButtonScrollBar:RadioButtonScrollBar = null;

    public var awardCarousel:AwardCarousel = null;

    public var rewardTF:TextField = null;

    public var flagBottom:MovieClip = null;

    public var description:QuestsDashlineItem;

    public function QuestCarouselAwardsBlock() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.radioButtonScrollBar.setScroller(this.awardCarousel.scrollList);
        this.rewardTF.autoSize = TextFieldAutoSize.LEFT;
        this.rewardTF.text = QUESTS.QUESTS_TABS_AWARD_TEXT;
        this.description.x = this.rewardTF.x + this.rewardTF.width + 5;
        this.description.width = width - this.description.x;
        this.flagBottom.mouseEnabled = false;
        this.flagBottom.mouseChildren = false;
    }

    public function setData(param1:IDataProvider, param2:QuestDashlineItemVO):void {
        this.awardCarousel.dataProvider = param1;
        this.description.setData(param2);
        invalidateSize();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.description.y = this.awardCarousel.y - this.description.height >> 1;
        }
    }

    override protected function onDispose():void {
        this.radioButtonScrollBar.dispose();
        this.radioButtonScrollBar = null;
        this.awardCarousel.dispose();
        this.awardCarousel = null;
        this.description.dispose();
        this.description = null;
        this.rewardTF = null;
        this.flagBottom = null;
        super.onDispose();
    }
}
}
