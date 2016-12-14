package net.wg.gui.components.tooltips {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.gui.components.interfaces.IToolTipRefSysXPMultiplierBlock;
import net.wg.gui.components.tooltips.VO.ToolTipRefSysXPMultiplierVO;
import net.wg.gui.components.tooltips.helpers.Utils;

import scaleform.clik.utils.Padding;

public class ToolTipRefSysXPMultiplier extends ToolTipSpecial {

    private static const XP_BLOCK_UI:String = "ToolTipRefSysXPMultiplierBlockUI";

    private static const BG_WIDTH:int = 374;

    private static const BOTTOM_SEPARATOR_PADDING:int = 15;

    private static const BOTTOM_PADDING:int = 25;

    private static const TEXT_PADDING:int = 5;

    private static const XP_BLOCK_PADDING:int = 40;

    public var titleTF:TextField = null;

    public var descriptionTF:TextField = null;

    public var conditionsTF:TextField = null;

    public var bottomTF:TextField = null;

    public var whiteBg:Sprite = null;

    private var xpBlocks:Vector.<ToolTipRefSysXPMultiplierBlock> = null;

    private var model:ToolTipRefSysXPMultiplierVO = null;

    public function ToolTipRefSysXPMultiplier() {
        super();
        contentMargin = new Padding(18, 19, 18, 19);
        this.titleTF = content.titleTF;
        this.descriptionTF = content.descriptionTF;
        this.conditionsTF = content.conditionsTF;
        this.bottomTF = content.bottomTF;
        this.whiteBg = content.whiteBg;
        separators = new Vector.<Separator>();
        this.xpBlocks = new Vector.<ToolTipRefSysXPMultiplierBlock>();
    }

    override protected function onDispose():void {
        var _loc1_:IToolTipRefSysXPMultiplierBlock = null;
        this.titleTF = null;
        this.descriptionTF = null;
        this.conditionsTF = null;
        this.bottomTF = null;
        this.whiteBg = null;
        while (content.numChildren > 0) {
            content.removeChildAt(0);
        }
        for each(_loc1_ in this.xpBlocks) {
            _loc1_.dispose();
        }
        this.xpBlocks.splice(0, this.xpBlocks.length);
        this.xpBlocks = null;
        if (this.model) {
            this.model.dispose();
            this.model = null;
        }
        super.onDispose();
    }

    override protected function redraw():void {
        this.setData();
        this.updatePositions();
        super.redraw();
    }

    override protected function updateSize():void {
        super.updateSize();
        background.width = BG_WIDTH;
        background.height = this.bottomTF.y + this.bottomTF.height + BOTTOM_PADDING ^ 0;
    }

    override protected function updatePositions():void {
        var _loc1_:Separator = null;
        _loc1_ = null;
        var _loc2_:IToolTipRefSysXPMultiplierBlock = null;
        this.descriptionTF.x = this.conditionsTF.x = this.bottomTF.x = this.titleTF.x = contentMargin.left + bgShadowMargin.left;
        this.titleTF.y = topPosition;
        this.descriptionTF.y = this.titleTF.y + this.titleTF.height + 1 ^ 0;
        this.descriptionTF.height = this.descriptionTF.textHeight + TEXT_PADDING;
        _loc1_ = Utils.instance.createSeparate(content);
        _loc1_.y = this.descriptionTF.y + this.descriptionTF.height + 13 ^ 0;
        separators.push(_loc1_);
        this.whiteBg.x = 0;
        this.whiteBg.y = _loc1_.y + _loc1_.height ^ 0;
        this.whiteBg.width = background.width;
        this.conditionsTF.y = _loc1_.y + _loc1_.height + 16 ^ 0;
        this.conditionsTF.height = this.conditionsTF.textHeight;
        var _loc3_:int = this.model.xpBlocksVOs.length;
        var _loc4_:int = this.conditionsTF.y + BOTTOM_PADDING;
        var _loc5_:int = 0;
        while (_loc5_ < _loc3_) {
            _loc2_ = this.createXPBlock(content);
            _loc2_.update(this.model.xpBlocksVOs[_loc5_]);
            _loc2_.x = this.conditionsTF.x + XP_BLOCK_PADDING;
            _loc2_.y = _loc4_ ^ 0;
            _loc4_ = _loc4_ + _loc2_.height;
            this.xpBlocks.push(_loc2_);
            _loc5_++;
        }
        this.whiteBg.height = _loc2_.y + _loc2_.height - this.whiteBg.y + BOTTOM_SEPARATOR_PADDING ^ 0;
        _loc1_ = Utils.instance.createSeparate(content);
        _loc1_.y = this.whiteBg.y + this.whiteBg.height ^ 0;
        separators.push(_loc1_);
        this.bottomTF.y = _loc1_.y + _loc1_.height + 14 ^ 0;
        this.bottomTF.height = this.bottomTF.textHeight + TEXT_PADDING;
        super.updatePositions();
    }

    private function createXPBlock(param1:MovieClip):IToolTipRefSysXPMultiplierBlock {
        var _loc2_:IToolTipRefSysXPMultiplierBlock = App.utils.classFactory.getComponent(XP_BLOCK_UI, ToolTipRefSysXPMultiplierBlock);
        param1.addChild(MovieClip(_loc2_));
        return _loc2_;
    }

    private function setData():void {
        this.model = new ToolTipRefSysXPMultiplierVO(_data);
        this.titleTF.htmlText = this.model.titleText;
        this.descriptionTF.htmlText = this.model.descriptionText;
        this.conditionsTF.htmlText = this.model.conditionsText;
        this.bottomTF.htmlText = this.model.bottomText;
    }
}
}
