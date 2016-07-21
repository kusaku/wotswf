package net.wg.infrastructure.tutorial.builders {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.geom.Point;

import net.wg.gui.components.advanced.ContentTabRenderer;
import net.wg.gui.lobby.hangar.tcarousel.TankCarousel;
import net.wg.gui.lobby.header.headerButtonBar.HeaderButton;
import net.wg.gui.lobby.techtree.nodes.NationTreeNode;
import net.wg.gui.lobby.techtree.nodes.ResearchRoot;
import net.wg.infrastructure.interfaces.IView;

public class TutorialCustomHintBuilder extends TutorialHintBuilder {

    private static const NATION_TREE_ADD_X:int = 164;

    private static const NATION_TREE_ADD_Y:int = -106;

    private static const NATION_TREE_ADD_WIDTH:int = 38;

    private static const NATION_TREE_ADD_HEIGHT:int = 71;

    public function TutorialCustomHintBuilder(param1:IView, param2:Object, param3:DisplayObject) {
        super(param1, param2, param3);
    }

    override protected function layoutHint():void {
        var _loc6_:TankCarousel = null;
        var _loc7_:HeaderButton = null;
        var _loc8_:MovieClip = null;
        var _loc9_:ContentTabRenderer = null;
        var _loc1_:Point = new Point();
        var _loc2_:* = 0;
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        if (component is TankCarousel) {
            _loc6_ = TankCarousel(component);
            _loc1_.x = viewForHint.globalToLocal(_loc6_.localToGlobal(new Point(_loc6_.leftArrow.x, _loc6_.leftArrow.y))).x;
            _loc1_.y = viewForHint.globalToLocal(_loc6_.localToGlobal(new Point(0, 0))).y;
            _loc4_ = _loc6_.rightArrow.x + _loc6_.rightArrow.width - _loc6_.leftArrow.x;
            _loc5_ = _loc6_.scrollList.height;
        }
        else if (component is HeaderButton) {
            _loc7_ = HeaderButton(component);
            _loc1_ = component.localToGlobal(new Point(0, 0));
            _loc1_ = viewForHint.globalToLocal(_loc1_);
            _loc4_ = _loc7_.bounds.width;
            _loc5_ = component.height;
        }
        else if (component is ResearchRoot) {
            _loc8_ = ResearchRoot(component).hit;
            _loc1_ = _loc8_.localToGlobal(new Point(0, 0));
            _loc1_ = viewForHint.globalToLocal(_loc1_);
            _loc4_ = _loc8_.width;
            _loc5_ = _loc8_.height;
        }
        else if (component is NationTreeNode) {
            _loc8_ = NationTreeNode(component).hit;
            _loc2_ = int(NATION_TREE_ADD_X);
            _loc3_ = -model.padding.top + NATION_TREE_ADD_Y;
            _loc4_ = _loc8_.width + NATION_TREE_ADD_WIDTH;
            _loc5_ = _loc8_.height + NATION_TREE_ADD_HEIGHT;
            _loc1_ = _loc8_.localToGlobal(new Point(0, 0));
            _loc1_ = viewForHint.globalToLocal(new Point(_loc1_.x, viewForHint.height - _loc5_ >> 1));
        }
        else if (component is ContentTabRenderer) {
            _loc9_ = ContentTabRenderer(component);
            _loc1_ = _loc9_.owner.localToGlobal(new Point(0, 0));
            _loc1_ = viewForHint.globalToLocal(_loc1_);
            _loc2_ = _loc9_.owner.width >> 1;
            _loc4_ = _loc9_.width;
            _loc5_ = _loc9_.height;
        }
        hint.x = _loc1_.x - HINT_GLOW_OFFSET + model.padding.left + _loc2_ ^ 0;
        hint.y = _loc1_.y - HINT_GLOW_OFFSET + model.padding.top + _loc3_ ^ 0;
        hint.setSize(_loc4_ - model.padding.left - model.padding.right, _loc5_ - model.padding.top - model.padding.bottom);
    }
}
}
