package net.wg.gui.lobby.questsWindow.components {
import flash.display.InteractiveObject;
import flash.text.TextField;

import net.wg.data.constants.Linkages;
import net.wg.gui.components.assets.interfaces.ISeparatorAsset;
import net.wg.gui.components.controls.ScrollPane;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.questsWindow.QuestAwardsBlock;
import net.wg.gui.lobby.questsWindow.components.interfaces.ITutorialHangarQuestDetails;
import net.wg.gui.lobby.questsWindow.data.TutorialHangarQuestDetailsVO;
import net.wg.infrastructure.base.meta.impl.TutorialHangarQuestDetailsMeta;

public class TutorialHangarQuestDetailsBase extends TutorialHangarQuestDetailsMeta implements ITutorialHangarQuestDetails {

    private static const SCROLL_PANE_STEP_FACTOR:int = 20;

    private static const SCROLL_PANE_PADDING:int = 10;

    public var titleTF:TextField;

    public var imgLoader:UILoaderAlt;

    public var awards:QuestAwardsBlock;

    public var descScrollPane:ScrollPane;

    public var topImageSeparator:ISeparatorAsset;

    public var bottomImageSeparator:ISeparatorAsset;

    public function TutorialHangarQuestDetailsBase() {
        super();
    }

    override protected function updateQuestInfo(param1:TutorialHangarQuestDetailsVO):void {
        this.titleTF.htmlText = param1.title;
        this.imgLoader.source = param1.image;
        this.awards.setData(param1.awards);
        this.awards.validateNow();
    }

    override protected function configUI():void {
        super.configUI();
        this.topImageSeparator.setCenterAsset(Linkages.SEPARATOR_UI);
        this.bottomImageSeparator.setCenterAsset(Linkages.SHADOW_SEPARATOR_UI);
        this.descScrollPane.scrollStepFactor = SCROLL_PANE_STEP_FACTOR;
    }

    override protected function onDispose():void {
        this.titleTF = null;
        this.imgLoader.dispose();
        this.imgLoader = null;
        this.awards.dispose();
        this.awards = null;
        this.descScrollPane.dispose();
        this.descScrollPane = null;
        this.topImageSeparator.dispose();
        this.topImageSeparator = null;
        this.bottomImageSeparator.dispose();
        this.bottomImageSeparator = null;
        super.onDispose();
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return null;
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        return new Vector.<InteractiveObject>(0);
    }

    public function update(param1:Object):void {
        requestQuestInfoS(String(param1));
    }

    protected function layout():void {
        this.awards.y = this.height - this.awards.height | 0;
        this.descScrollPane.setSize(width - SCROLL_PANE_PADDING, this.awards.y - this.descScrollPane.y);
    }
}
}
