package net.wg.gui.lobby.questsWindow.components {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.data.constants.Linkages;
import net.wg.gui.components.common.containers.GroupLayout;
import net.wg.gui.components.common.containers.VerticalGroupLayout;
import net.wg.gui.lobby.questsWindow.data.TutorialQuestDescVO;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.utils.ICommons;

public class TutorialQuestDescriptionContainer extends UIComponentEx {

    private static const GAP:int = 10;

    private static const BOTTOM_PADDING:int = 12;

    public var conditionsTitleTF:TextField;

    public var conditionsGroup:ConditionsGroup;

    public var descTitleTF:TextField;

    public var descTextTF:TextField;

    public var separator:Sprite;

    public function TutorialQuestDescriptionContainer() {
        super();
        this.conditionsGroup.itemRendererLinkage = Linkages.TUTORIAL_QUEST_CONDITION_RENDERER;
        var _loc1_:GroupLayout = new VerticalGroupLayout();
        _loc1_.gap = GAP;
        this.conditionsGroup.layout = _loc1_;
    }

    override protected function onDispose():void {
        this.conditionsGroup.dispose();
        this.conditionsGroup = null;
        this.conditionsTitleTF = null;
        this.descTitleTF = null;
        this.descTextTF = null;
        this.separator = null;
        super.onDispose();
    }

    public function setData(param1:TutorialQuestDescVO):void {
        this.conditionsTitleTF.htmlText = param1.conditionsTitle;
        this.descTitleTF.htmlText = param1.descTitle;
        this.descTextTF.htmlText = param1.descText;
        this.conditionsGroup.dataProvider = param1.conditionItems;
        this.conditionsGroup.validateNow();
        this.layout();
    }

    private function layout():void {
        var _loc2_:Number = NaN;
        var _loc1_:ICommons = App.utils.commons;
        _loc1_.updateTextFieldSize(this.conditionsTitleTF, false, true);
        _loc1_.updateTextFieldSize(this.descTitleTF, false, true);
        _loc1_.updateTextFieldSize(this.descTextTF, false, true);
        _loc2_ = this.conditionsTitleTF.y + this.conditionsTitleTF.height;
        this.conditionsGroup.y = _loc2_ | 0;
        _loc2_ = _loc2_ + (this.conditionsGroup.height + GAP);
        this.separator.y = _loc2_;
        _loc2_ = _loc2_ + (this.separator.height + GAP);
        this.descTitleTF.y = _loc2_ | 0;
        _loc2_ = _loc2_ + this.descTitleTF.height;
        this.descTextTF.y = _loc2_ | 0;
        setSize(width, actualHeight + BOTTOM_PADDING);
    }
}
}
