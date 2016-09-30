package net.wg.gui.lobby.questsWindow {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.gui.lobby.quests.components.AwardCarousel;
import net.wg.gui.lobby.quests.components.RadioButtonScrollBar;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.interfaces.IDataProvider;

public class QuestCarouselAwardsBlock extends UIComponentEx {

    public var radioButtonScrollBar:RadioButtonScrollBar = null;

    public var awardCarousel:AwardCarousel = null;

    public var rewardTF:TextField = null;

    public var flagBottom:MovieClip = null;

    public function QuestCarouselAwardsBlock() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.radioButtonScrollBar.setScroller(this.awardCarousel.scrollList);
        this.rewardTF.text = QUESTS.QUESTS_TABS_AWARD_TEXT;
        this.flagBottom.mouseEnabled = false;
        this.flagBottom.mouseChildren = false;
    }

    public function setDataProvider(param1:IDataProvider):void {
        this.awardCarousel.dataProvider = param1;
    }

    override protected function onDispose():void {
        this.radioButtonScrollBar.dispose();
        this.radioButtonScrollBar = null;
        this.awardCarousel.dispose();
        this.awardCarousel = null;
        this.rewardTF = null;
        this.flagBottom = null;
        super.onDispose();
    }
}
}
