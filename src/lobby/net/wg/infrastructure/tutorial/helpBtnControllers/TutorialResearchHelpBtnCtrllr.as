package net.wg.infrastructure.tutorial.helpBtnControllers {
import flash.display.DisplayObject;
import flash.geom.Point;

import net.wg.data.constants.Errors;
import net.wg.data.constants.Linkages;
import net.wg.gui.lobby.techtree.ResearchPage;

public class TutorialResearchHelpBtnCtrllr extends TutorialHelpBtnController {

    public function TutorialResearchHelpBtnCtrllr() {
        super();
        helpBtnLinkageId = Linkages.TUTORIAL_VIEW_HELP_BTN_UI;
    }

    override public function layoutHelpBtn():void {
        var _loc3_:int = 0;
        var _loc1_:ResearchPage = view as ResearchPage;
        App.utils.asserter.assertNotNull(_loc1_, "view as ResearchPage" + Errors.CANT_NULL);
        var _loc2_:DisplayObject = _loc1_.researchItems.rGraphics;
        _loc3_ = App.stage.localToGlobal(new Point(_loc2_.x, _loc2_.y)).y;
        helpBtn.x = view.width - model.padding.right;
        helpBtn.y = _loc3_ / App.appScale + model.padding.top ^ 0;
    }
}
}
