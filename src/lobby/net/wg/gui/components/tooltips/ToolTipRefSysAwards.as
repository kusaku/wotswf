package net.wg.gui.components.tooltips {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.components.tooltips.VO.ToolTipRefSysAwardsVO;
import net.wg.gui.components.tooltips.helpers.Utils;
import net.wg.gui.events.UILoaderEvent;

public class ToolTipRefSysAwards extends ToolTipSpecial {

    private static const PADDING_LEFT:int = 24;

    private static const BG_WIDTH:int = 352;

    private static const WHITE_BG_HEIGHT:int = 38;

    private static const BOTTOM_PADDING:int = 46;

    private static const INFO_TITLE_PADDING:int = 19;

    private static const AWARDS_TYPE_PADDING_LEFT:int = 1;

    private static const AWARDS_TYPE_PADDING_TOP:int = 33;

    private static const FIRST_SEPARATOR_PADDING:int = 194;

    private static const INFO_BODY_PADDING:int = 17;

    private static const CONDITIONS_PADDING:int = 7;

    private static const SECOND_SEPARATOR_PADDING:int = 7;

    private static const AWARD_STATUS_PADDING:int = 9;

    private var _awardsType:UILoaderAlt = null;

    private var _infoTitle:TextField = null;

    private var _infoBody:TextField = null;

    private var _conditions:TextField = null;

    private var _awardStatus:TextField = null;

    private var _whiteBg:Sprite = null;

    public function ToolTipRefSysAwards() {
        super();
        separators = new Vector.<Separator>();
        this._awardsType = content.awardsType;
        this._awardsType.autoSize = false;
        this._awardsType.addEventListener(UILoaderEvent.COMPLETE, this.onAwardsTypeCompleteHandler);
        this._whiteBg = content.whiteBg;
        this._infoTitle = content.infoTitle;
        this._infoBody = content.infoBody;
        this._conditions = content.conditions;
        this._awardStatus = content.awardStatus;
        this._infoTitle.wordWrap = true;
    }

    override protected function onDispose():void {
        this._awardsType.removeEventListener(UILoaderEvent.COMPLETE, this.onAwardsTypeCompleteHandler);
        this._awardsType.dispose();
        this._awardsType = null;
        this._infoTitle = null;
        this._infoBody = null;
        this._conditions = null;
        this._awardStatus = null;
        this._whiteBg = null;
        super.onDispose();
    }

    override protected function redraw():void {
        this.setData();
        this.updatePositions();
        super.redraw();
    }

    override protected function updateSize():void {
        background.width = BG_WIDTH;
        background.height = this._whiteBg.y + BOTTOM_PADDING;
    }

    override protected function updatePositions():void {
        var _loc1_:Separator = null;
        this._infoTitle.x = PADDING_LEFT;
        this._infoTitle.y = INFO_TITLE_PADDING;
        this._awardsType.x = PADDING_LEFT + AWARDS_TYPE_PADDING_LEFT;
        this._awardsType.y = this._infoTitle.y + this._infoTitle.height + AWARDS_TYPE_PADDING_TOP;
        _loc1_ = Utils.instance.createSeparate(content);
        _loc1_.y = this._infoTitle.y + this._infoTitle.height + FIRST_SEPARATOR_PADDING;
        separators.push(_loc1_);
        this._infoBody.x = PADDING_LEFT;
        this._infoBody.y = _loc1_.y + _loc1_.height + INFO_BODY_PADDING ^ 0;
        this._conditions.x = PADDING_LEFT;
        this._conditions.y = this._infoBody.y + this._infoBody.height + CONDITIONS_PADDING ^ 0;
        _loc1_ = Utils.instance.createSeparate(content);
        _loc1_.y = this._conditions.y + this._conditions.height + SECOND_SEPARATOR_PADDING ^ 0;
        separators.push(_loc1_);
        this._whiteBg.x = 0;
        this._whiteBg.y = _loc1_.y + _loc1_.height ^ 0;
        this._whiteBg.width = background.width;
        this._whiteBg.height = WHITE_BG_HEIGHT;
        this._awardStatus.x = PADDING_LEFT;
        this._awardStatus.y = _loc1_.y + _loc1_.height + AWARD_STATUS_PADDING ^ 0;
        super.updatePositions();
    }

    private function setData():void {
        var _loc1_:ToolTipRefSysAwardsVO = new ToolTipRefSysAwardsVO(_data);
        this._awardsType.source = _loc1_.iconSource;
        this._infoTitle.htmlText = _loc1_.infoTitle;
        this._infoBody.htmlText = _loc1_.infoBody;
        this._conditions.htmlText = _loc1_.conditions;
        this._awardStatus.htmlText = _loc1_.awardStatus;
        App.utils.commons.updateTextFieldSize(this._infoTitle, false, true);
        _loc1_.dispose();
    }

    private function onAwardsTypeCompleteHandler(param1:UILoaderEvent):void {
        this._awardsType.x = background.width - this._awardsType.width >> 1;
    }
}
}
