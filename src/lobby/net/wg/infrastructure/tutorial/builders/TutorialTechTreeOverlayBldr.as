package net.wg.infrastructure.tutorial.builders {
import flash.display.DisplayObject;
import flash.display.Stage;
import flash.geom.Point;

import net.wg.data.constants.Errors;
import net.wg.gui.lobby.techtree.TechTreePage;
import net.wg.infrastructure.interfaces.IView;

public class TutorialTechTreeOverlayBldr extends TutorialOverlayBuilder {

    private var _techTreeView:TechTreePage = null;

    private var _ntGraphics:DisplayObject = null;

    public function TutorialTechTreeOverlayBldr(param1:IView, param2:Object) {
        super(param1, param2);
    }

    override protected function onDispose():void {
        this._techTreeView = null;
        this._ntGraphics = null;
        super.onDispose();
    }

    override protected function getViewForHint():void {
        super.getViewForHint();
        this._techTreeView = view as TechTreePage;
        App.utils.asserter.assertNotNull(this._techTreeView, "view as TechTreePage" + Errors.CANT_NULL);
        this._ntGraphics = this._techTreeView.nationTree.ntGraphics;
    }

    override protected function layoutOverlay():void {
        var _loc4_:* = 0;
        var _loc1_:Stage = App.stage;
        var _loc2_:int = _loc1_.localToGlobal(new Point(view.x, view.y)).y;
        var _loc3_:int = _loc1_.localToGlobal(new Point(this._ntGraphics.x, this._ntGraphics.y)).y;
        _loc4_ = _loc3_ / App.appScale - _loc2_ ^ 0;
        tutorialOverlay.x = model.padding.left;
        tutorialOverlay.y = _loc4_ + model.padding.top;
        tutorialOverlay.setSize(view.width - model.padding.left - model.padding.right, view.height - _loc4_ - model.padding.top - model.padding.bottom);
    }
}
}
