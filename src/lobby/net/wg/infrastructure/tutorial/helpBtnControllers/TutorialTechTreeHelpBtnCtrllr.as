package net.wg.infrastructure.tutorial.helpBtnControllers {
import flash.display.DisplayObject;
import flash.geom.Point;

import net.wg.data.constants.Errors;
import net.wg.gui.lobby.techtree.TechTreePage;

public class TutorialTechTreeHelpBtnCtrllr extends TutorialHelpBtnController {

    public function TutorialTechTreeHelpBtnCtrllr() {
        super();
    }

    override public function layoutHelpBtn():void {
        var _loc3_:int = 0;
        var _loc1_:TechTreePage = view as TechTreePage;
        App.utils.asserter.assertNotNull(_loc1_, "view as TechTreePage" + Errors.CANT_NULL);
        var _loc2_:DisplayObject = _loc1_.nationTree.ntGraphics;
        _loc3_ = App.stage.localToGlobal(new Point(_loc2_.x, _loc2_.y)).y;
        helpBtn.x = view.width - model.padding.right;
        helpBtn.y = _loc3_ / App.appScale + model.padding.top ^ 0;
    }
}
}
