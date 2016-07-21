package net.wg.gui.components.tooltips {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.data.constants.Linkages;
import net.wg.gui.components.interfaces.IToolTipRefSysAwardsBlock;
import net.wg.gui.components.tooltips.VO.ToolTipRefSysDescriptionVO;
import net.wg.gui.components.tooltips.helpers.Utils;
import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.utils.ICommons;

import scaleform.clik.utils.Padding;

public class ToolTipRefSysDescription extends ToolTipSpecial {

    private static const CONTENT_WIDTH:int = 357;

    private static const ACTION_TF_PADDING:int = 10;

    private static const CONDITIONS_TF_PADDING:int = 4;

    private static const SEPARATOR_PADDING:int = 18;

    private static const AWARDS_TITLE_TF_PADDING:int = 16;

    private static const TEXT_BLOCK_PADDING:int = 25;

    private static const TEXT_BLOCK_CORRECTION:int = 4;

    private static const BOTTOM_TF_PADDING:int = 17;

    private static const CONTENT_PADDING:Padding = new Padding(18, 12, 12, 24);

    private var _titleTF:TextField = null;

    private var _actionTF:TextField = null;

    private var _conditionsTF:TextField = null;

    private var _awardsTitleTF:TextField = null;

    private var _bottomTF:TextField = null;

    private var _whiteBg:Sprite = null;

    private var _textBlocks:Vector.<IToolTipRefSysAwardsBlock> = null;

    private var _model:ToolTipRefSysDescriptionVO = null;

    public function ToolTipRefSysDescription() {
        super();
        separators = new Vector.<Separator>();
        contentWidth = CONTENT_WIDTH;
        contentMargin = CONTENT_PADDING;
        this._titleTF = content.titleTF;
        this._actionTF = content.actionTF;
        this._conditionsTF = content.conditionsTF;
        this._awardsTitleTF = content.awardsTitleTF;
        this._bottomTF = content.bottomTF;
        this._whiteBg = content.whiteBg;
        this._textBlocks = new Vector.<IToolTipRefSysAwardsBlock>();
    }

    override protected function redraw():void {
        this.setData();
        this.updatePositions();
        super.redraw();
    }

    override protected function updateSize():void {
        super.updateSize();
        if (this._whiteBg.visible) {
            this._whiteBg.width = contentWidth + bgShadowMargin.horizontal;
        }
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        this._titleTF = null;
        this._actionTF = null;
        this._conditionsTF = null;
        this._awardsTitleTF = null;
        this._bottomTF = null;
        this._whiteBg = null;
        while (content.numChildren > 0) {
            content.removeChildAt(0);
        }
        for each(_loc1_ in this._textBlocks) {
            _loc1_.dispose();
        }
        this._textBlocks.splice(0, this._textBlocks.length);
        this._textBlocks = null;
        this.tryDisposeModel();
        super.onDispose();
    }

    override protected function updatePositions():void {
        var _loc7_:DisplayObject = null;
        var _loc8_:Separator = null;
        var _loc1_:IToolTipRefSysAwardsBlock = null;
        var _loc2_:Vector.<TextField> = new <TextField>[this._titleTF, this._actionTF, this._conditionsTF, this._awardsTitleTF, this._bottomTF];
        var _loc3_:int = contentWidth - contentMargin.horizontal;
        var _loc4_:ICommons = App.utils.commons;
        var _loc5_:int = this._model.blocksVOs.length;
        var _loc6_:int = 0;
        while (_loc6_ < _loc5_) {
            _loc1_ = this.createTextBlock(content);
            _loc1_.update(this._model.blocksVOs[_loc6_]);
            _loc1_.x = contentMargin.left;
            this._textBlocks.push(_loc1_);
            if (_loc1_.width > _loc3_) {
                _loc3_ = _loc1_.width;
            }
            _loc6_++;
        }
        contentWidth = _loc3_ + contentMargin.horizontal;
        for each(_loc7_ in _loc2_) {
            _loc7_.x = contentMargin.left;
            _loc7_.width = _loc3_;
        }
        this._titleTF.y = contentMargin.top;
        this._actionTF.y = this._titleTF.y + this._titleTF.height + ACTION_TF_PADDING ^ 0;
        _loc4_.updateTextFieldSize(this._actionTF, false, true);
        this._conditionsTF.y = this._actionTF.y + this._actionTF.height + CONDITIONS_TF_PADDING ^ 0;
        _loc4_.updateTextFieldSize(this._conditionsTF, false, true);
        _loc8_ = Utils.instance.createSeparate(content);
        _loc8_.x = contentMargin.left + (contentWidth - _loc8_.width >> 1);
        _loc8_.y = this._conditionsTF.y + this._conditionsTF.height + SEPARATOR_PADDING ^ 0;
        separators.push(_loc8_);
        this._whiteBg.y = _loc8_.y + _loc8_.height ^ 0;
        this._awardsTitleTF.y = _loc8_.y + _loc8_.height + AWARDS_TITLE_TF_PADDING ^ 0;
        var _loc9_:int = this._awardsTitleTF.y + TEXT_BLOCK_PADDING;
        _loc6_ = 0;
        while (_loc6_ < _loc5_) {
            _loc1_ = this._textBlocks[_loc6_];
            _loc1_.y = _loc9_;
            _loc9_ = _loc9_ + (_loc1_.height - TEXT_BLOCK_CORRECTION);
            _loc6_++;
        }
        _loc8_ = Utils.instance.createSeparate(content);
        _loc8_.y = _loc9_ + SEPARATOR_PADDING;
        separators.push(_loc8_);
        this._whiteBg.height = _loc8_.y - this._whiteBg.y ^ 0;
        this._bottomTF.y = _loc8_.y + _loc8_.height + BOTTOM_TF_PADDING ^ 0;
        _loc4_.updateTextFieldSize(this._bottomTF, false, true);
    }

    private function createTextBlock(param1:MovieClip):IToolTipRefSysAwardsBlock {
        var _loc2_:IToolTipRefSysAwardsBlock = App.utils.classFactory.getComponent(Linkages.REF_SYS_AWARDS_BLOCK_UI, ToolTipRefSysAwardsBlock);
        param1.addChild(DisplayObject(_loc2_));
        return _loc2_;
    }

    private function tryDisposeModel():void {
        if (this._model != null) {
            this._model.dispose();
            this._model = null;
        }
    }

    private function setData():void {
        this.tryDisposeModel();
        this._model = new ToolTipRefSysDescriptionVO(_data);
        this._titleTF.htmlText = this._model.titleTF;
        this._actionTF.htmlText = this._model.actionTF;
        this._conditionsTF.htmlText = this._model.conditionsTF;
        this._awardsTitleTF.htmlText = this._model.awardsTitleTF;
        this._bottomTF.htmlText = this._model.bottomTF;
    }
}
}
