package net.wg.gui.lobby.quests.components {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;

import net.wg.data.constants.Values;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.lobby.quests.components.interfaces.IQuestSlotRenderer;
import net.wg.gui.lobby.quests.data.QuestSlotVO;
import net.wg.gui.lobby.quests.events.PersonalQuestEvent;
import net.wg.infrastructure.managers.ITooltipMgr;
import net.wg.utils.ICommons;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.utils.Constraints;

public class QuestSlotRenderer extends SoundButtonEx implements IQuestSlotRenderer {

    private static const DESCRIPTION_OFFSET:Number = 2;

    private static const MAX_LINES:Number = 4;

    private static const CUT_SYMBOLS_STR:String = " ...";

    public var titleTF:TextField;

    public var descriptionTF:TextField;

    public var noDataTF:TextField;

    public var separator:MovieClip;

    private var _model:QuestSlotVO;

    public function QuestSlotRenderer() {
        super();
        constraintsDisabled = false;
    }

    override protected function configUI():void {
        super.configUI();
        constraints.addElement(this.titleTF.name, this.titleTF, Constraints.LEFT | Constraints.RIGHT);
        constraints.addElement(this.descriptionTF.name, this.descriptionTF, Constraints.LEFT | Constraints.RIGHT);
        constraints.addElement(this.noDataTF.name, this.noDataTF, Constraints.LEFT | Constraints.RIGHT);
        focusable = false;
        mouseEnabledOnDisabled = true;
        addEventListener(ButtonEvent.CLICK, this.onClickHandler);
    }

    override protected function onDispose():void {
        removeEventListener(ButtonEvent.CLICK, this.onClickHandler);
        this._model = null;
        this.titleTF = null;
        this.descriptionTF = null;
        this.noDataTF = null;
        this.separator = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:ICommons = null;
        var _loc2_:Boolean = false;
        var _loc3_:Number = NaN;
        var _loc4_:Number = NaN;
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            if (this._model != null) {
                _loc1_ = App.utils.commons;
                _loc2_ = this._model.isEmpty;
                this.noDataTF.visible = _loc2_;
                this.titleTF.visible = !_loc2_;
                this.descriptionTF.visible = !_loc2_;
                if (_loc2_) {
                    this.noDataTF.htmlText = this._model.description;
                    _loc1_.updateTextFieldSize(this.noDataTF, false, true);
                    this.noDataTF.y = height - this.noDataTF.height >> 1;
                }
                else {
                    this.titleTF.htmlText = this._model.title;
                    this.descriptionTF.htmlText = this._model.description;
                    _loc1_.updateTextFieldSize(this.titleTF, false, true);
                    if (this._model.inProgress) {
                        this.descriptionTF.y = this.titleTF.y + this.titleTF.height + DESCRIPTION_OFFSET ^ 0;
                        this.cutDescription();
                    }
                    else {
                        _loc3_ = this.titleTF.y + this.titleTF.height;
                        _loc4_ = height - _loc3_;
                        this.descriptionTF.y = _loc3_ + (_loc4_ - this.descriptionTF.textHeight >> 1) ^ 0;
                    }
                    _loc1_.updateTextFieldSize(this.descriptionTF, false, true);
                }
            }
        }
    }

    public function update(param1:Object):void {
        this._model = QuestSlotVO(param1);
        enabled = this._model != null && !this._model.isEmpty;
        invalidateData();
    }

    private function cutDescription():void {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        var _loc4_:TextFormat = null;
        var _loc5_:int = 0;
        var _loc1_:int = this.titleTF.numLines + this.descriptionTF.numLines;
        if (_loc1_ > MAX_LINES) {
            _loc2_ = MAX_LINES - this.titleTF.numLines;
            _loc3_ = this.descriptionTF.getLineOffset(_loc2_);
            _loc4_ = this.descriptionTF.getTextFormat(0, 1);
            this.descriptionTF.text = this.descriptionTF.text.substring(0, _loc3_) + CUT_SYMBOLS_STR;
            _loc5_ = 1;
            while (this.descriptionTF.numLines > _loc2_) {
                this.descriptionTF.text = this.descriptionTF.text.substring(0, _loc3_ - _loc5_) + CUT_SYMBOLS_STR;
                _loc5_++;
            }
            this.descriptionTF.textColor = uint(_loc4_.color);
        }
    }

    public function get separatorVisible():Boolean {
        return this.separator.visible;
    }

    public function set separatorVisible(param1:Boolean):void {
        this.separator.visible = param1;
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        var _loc2_:ITooltipMgr = null;
        var _loc3_:String = null;
        super.handleMouseRollOver(param1);
        if (this._model != null) {
            _loc2_ = App.toolTipMgr;
            _loc3_ = _loc2_.getNewFormatter().addHeader(this._model.ttHeader).addBody(this._model.ttBody).addNote(this._model.ttNote).addAttention(this._model.ttAttention).make();
            if (_loc3_.length > 0) {
                _loc2_.showComplex(_loc3_);
            }
        }
    }

    private function onClickHandler(param1:ButtonEvent):void {
        var _loc2_:int = this._model != null ? int(this._model.id) : int(Values.DEFAULT_INT);
        dispatchEvent(new PersonalQuestEvent(PersonalQuestEvent.SLOT_CLICK, _loc2_));
    }
}
}
