package net.wg.infrastructure.tutorial.builders {
import flash.display.DisplayObject;
import flash.geom.Point;

import net.wg.data.constants.Errors;
import net.wg.gui.lobby.techtree.ResearchPage;
import net.wg.infrastructure.interfaces.IView;

public class TutorialResearchOverlayBldr extends TutorialOverlayBuilder {

    private static const FIRST_HINT_IDX:int = 0;

    private static const SECOND_HINT_IDX:int = 1;

    private static const THIRD_HINT_IDX:int = 2;

    private var _researchPage:ResearchPage = null;

    private var _researchItems:DisplayObject = null;

    private var _rGraphics:DisplayObject = null;

    public function TutorialResearchOverlayBldr(param1:IView, param2:Object) {
        super(param1, param2);
    }

    override protected function onDispose():void {
        this._researchPage = null;
        this._researchItems = null;
        this._rGraphics = null;
        super.onDispose();
    }

    override protected function getViewForHint():void {
        super.getViewForHint();
        this._researchPage = view as ResearchPage;
        App.utils.asserter.assertNotNull(this._researchPage, "view as ResearchPage" + Errors.CANT_NULL);
        this._researchItems = this._researchPage.researchItems;
        this._rGraphics = this._researchPage.researchItems.rGraphics;
    }

    override protected function layoutOverlay():void {
        var _loc1_:* = 0;
        this.calculateSize();
        _loc1_ = App.stage.localToGlobal(new Point(this._rGraphics.x, this._rGraphics.y)).y / App.appScale ^ 0;
        tutorialOverlay.x = model.padding.left;
        tutorialOverlay.y = _loc1_ + model.padding.top;
        tutorialOverlay.setSize(view.width - model.padding.left - model.padding.right, view.height - _loc1_ - model.padding.top - model.padding.bottom);
    }

    private function calculateSize():void {
        var _loc1_:int = App.stage.localToGlobal(new Point(this._researchItems.x, this._researchItems.y)).x;
        var _loc2_:int = model.hints.length;
        model.hints[FIRST_HINT_IDX].width = _loc1_ / App.appScale + model.hints[FIRST_HINT_IDX].addWidth ^ 0;
        model.hints[SECOND_HINT_IDX].padding.left = model.hints[FIRST_HINT_IDX].width;
        var _loc3_:int = THIRD_HINT_IDX;
        while (_loc3_ < _loc2_) {
            model.hints[_loc3_].padding.left = model.hints[_loc3_ - 1].padding.left + model.hints[_loc3_ - 1].width;
            _loc3_++;
        }
    }
}
}
