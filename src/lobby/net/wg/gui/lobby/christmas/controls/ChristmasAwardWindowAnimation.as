package net.wg.gui.lobby.christmas.controls {
import net.wg.gui.lobby.christmas.interfaces.IChristmasAnimationItem;
import net.wg.gui.lobby.christmas.interfaces.IChristmasAnimationItemVO;
import net.wg.gui.lobby.christmas.interfaces.IChristmasAnimationVO;
import net.wg.gui.lobby.christmas.interfaces.IChristmasItemsAnimation;
import net.wg.gui.lobby.components.BaseAwardWindowAnimation;
import net.wg.gui.lobby.components.interfaces.IStoppableAnimationVO;

public class ChristmasAwardWindowAnimation extends BaseAwardWindowAnimation {

    public var mainItem:IChristmasAnimationItem = null;

    public var additionalItemsAnimation:IChristmasItemsAnimation = null;

    private var _hasAdditionalItems:Boolean = false;

    public function ChristmasAwardWindowAnimation() {
        super();
        this.additionalItemsAnimation.stop();
    }

    override public function endAnimation():void {
        super.endAnimation();
        if (this._hasAdditionalItems) {
            this.additionalItemsAnimation.gotoAndStop(this.additionalItemsAnimation.totalFrames);
        }
    }

    override public function playAnimation():void {
        super.playAnimation();
        if (this._hasAdditionalItems) {
            this.additionalItemsAnimation.play();
        }
    }

    override public function setData(param1:IStoppableAnimationVO):void {
        var _loc2_:IChristmasAnimationVO = IChristmasAnimationVO(param1);
        var _loc3_:IChristmasAnimationItemVO = _loc2_.mainItem;
        this.mainItem.visible = _loc3_ != null;
        if (_loc3_ != null) {
            this.mainItem.setData(_loc3_);
        }
        var _loc4_:Vector.<IChristmasAnimationItemVO> = _loc2_.additionalItems;
        this._hasAdditionalItems = _loc4_ != null && _loc4_.length > 0;
        this.additionalItemsAnimation.visible = this._hasAdditionalItems;
        if (this._hasAdditionalItems) {
            this.additionalItemsAnimation.setData(_loc4_);
        }
    }

    override protected function onDispose():void {
        this.additionalItemsAnimation.dispose();
        this.additionalItemsAnimation = null;
        this.mainItem.dispose();
        this.mainItem = null;
        super.onDispose();
    }
}
}
