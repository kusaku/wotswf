package net.wg.gui.components.advanced.tutorial {
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import net.wg.data.constants.Directions;
import net.wg.data.constants.Values;
import net.wg.gui.components.advanced.events.TutorialHintEvent;
import net.wg.gui.components.advanced.interfaces.ITutorialHintAnimation;
import net.wg.gui.components.advanced.interfaces.ITutorialHintArrowAnimation;
import net.wg.gui.components.advanced.interfaces.ITutorialHintTextAnimation;
import net.wg.gui.components.advanced.vo.TutorialHintVO;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;

public class TutorialHint extends UIComponentEx {

    private static const GLOW_OFFSET:int = 13;

    private static const ARROW_OFFSET:int = 32;

    private static const HINT_BG_H_OFFSET:int = 14;

    private static const HINT_BG_V_OFFSET:int = 27;

    private static const TEXT_PADDING:int = 20;

    private static const HINT_BG_MIN_WIDTH:int = 130;

    private static const ROTATE_90:int = 90;

    private static const ROTATE_180:int = 180;

    public var hintArrow:ITutorialHintArrowAnimation = null;

    public var hintBox:ITutorialHintAnimation = null;

    public var hintBG:ITutorialHintAnimation = null;

    public var hintText:ITutorialHintTextAnimation = null;

    private var _hintWidth:int = 0;

    private var _hintHeight:int = 0;

    private var _model:TutorialHintVO = null;

    private var _isHidden:Boolean = false;

    public function TutorialHint() {
        super();
    }

    override public function setSize(param1:Number, param2:Number):void {
        this._hintWidth = param1 + (GLOW_OFFSET << 1) ^ 0;
        this._hintHeight = param2 + (GLOW_OFFSET << 1) ^ 0;
        invalidateSize();
    }

    override protected function onDispose():void {
        this.hintArrow.removeEventListener(TutorialHintEvent.LOOP_ENDED, this.onLoopEndedHandler);
        this.hintArrow.dispose();
        this.hintArrow = null;
        this.hintBox.dispose();
        this.hintBox = null;
        this.hintBG.dispose();
        this.hintBG = null;
        this.hintText.dispose();
        this.hintText = null;
        this._model = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        mouseEnabled = mouseChildren = false;
    }

    override protected function draw():void {
        super.draw();
        if (this._model != null) {
            if (isInvalid(InvalidationType.DATA) || isInvalid(InvalidationType.SIZE)) {
                if (this._model.hasBox) {
                    this.hintBox.setSize(this._hintWidth, this._hintHeight);
                }
                if (this._model.hasArrow) {
                    this.layoutArrow();
                    this.hintArrow.isLooped = this._model.arrowLoop;
                }
                if (this._model.hintText != Values.EMPTY_STR) {
                    this.hintText.setText(this._model.hintText);
                    this.layoutTextAndBg();
                }
            }
            if (isInvalid(InvalidationType.STATE)) {
                if (this._model.hasBox) {
                    this.hintBox.show();
                }
                if (this._model.hasArrow) {
                    this.hintArrow.show();
                }
                if (this._model.hintText != Values.EMPTY_STR) {
                    this.hintText.show();
                    this.hintBG.show();
                }
            }
        }
    }

    public function hide():void {
        if (this._isHidden) {
            return;
        }
        if (this._model.hasArrow) {
            if (this.hintArrow.isLooped) {
                this.hintArrow.needToHide(true);
                this.hintArrow.addEventListener(TutorialHintEvent.LOOP_ENDED, this.onLoopEndedHandler);
                return;
            }
            this.hintArrow.hide();
        }
        if (this._model.hasBox) {
            this.hintBox.hide();
        }
        if (this._model.hintText != Values.EMPTY_STR) {
            this.hintBG.hide();
            this.hintText.hide();
        }
        this._isHidden = true;
    }

    public function show():void {
        this._isHidden = false;
        this.hintArrow.needToHide(false);
        invalidateState();
    }

    private function layoutArrow():void {
        switch (this._model.arrowDir) {
            case Directions.LEFT:
                this.hintArrow.rotation = 0;
                this.hintArrow.x = -this.hintArrow.width + ARROW_OFFSET;
                this.hintArrow.y = this._hintHeight - this.hintArrow.height >> 1;
                break;
            case Directions.RIGHT:
                this.hintArrow.rotation = ROTATE_180;
                this.hintArrow.x = this._hintWidth + this.hintArrow.width - ARROW_OFFSET;
                this.hintArrow.y = (this._hintHeight - this.hintArrow.height >> 1) + this.hintArrow.height;
                break;
            case Directions.TOP:
                this.hintArrow.rotation = ROTATE_90;
                this.hintArrow.x = (this._hintWidth - this.hintArrow.width >> 1) + this.hintArrow.width;
                this.hintArrow.y = -this.hintArrow.height + ARROW_OFFSET;
                break;
            case Directions.BOTTOM:
                this.hintArrow.rotation = -ROTATE_90;
                this.hintArrow.x = this._hintWidth - this.hintArrow.width >> 1;
                this.hintArrow.y = this._hintHeight + this.hintArrow.height - ARROW_OFFSET;
        }
    }

    private function layoutTextAndBg():void {
        var _loc1_:String = TextFormatAlign.LEFT;
        if (!this._model.hasArrow && this._model.hasBox) {
            this.hintText.setSize(this.hintBox.width - (TEXT_PADDING << 1));
        }
        var _loc2_:int = this.hintText.width + (TEXT_PADDING << 1) > HINT_BG_MIN_WIDTH ? int(this.hintText.width + (TEXT_PADDING << 1)) : int(HINT_BG_MIN_WIDTH);
        var _loc3_:int = this.hintBG.height;
        this.hintBG.setSize(_loc2_, _loc3_);
        if (!this._model.hasArrow) {
            this.hintBG.x = 0;
            this.hintBG.y = -_loc3_ + GLOW_OFFSET;
            this.hintText.x = TEXT_PADDING;
        }
        else {
            switch (this._model.arrowDir) {
                case Directions.LEFT:
                    this.hintBG.x = -_loc2_ - HINT_BG_H_OFFSET;
                    this.hintBG.y = this._hintHeight - _loc3_ >> 1;
                    break;
                case Directions.RIGHT:
                    this.hintBG.x = this._hintWidth + HINT_BG_H_OFFSET;
                    this.hintBG.y = this._hintHeight - _loc3_ >> 1;
                    break;
                case Directions.TOP:
                    this.hintBG.x = this._hintWidth - _loc2_ >> 1;
                    this.hintBG.y = -_loc3_ - HINT_BG_V_OFFSET;
                    break;
                case Directions.BOTTOM:
                    this.hintBG.x = this._hintWidth - _loc2_ >> 1;
                    this.hintBG.y = this._hintHeight + HINT_BG_V_OFFSET;
            }
            _loc1_ = TextFormatAlign.CENTER;
            this.hintText.x = this.hintBG.x + (this.hintBG.width - this.hintText.width >> 1);
        }
        this.hintText.y = this.hintBG.y + (_loc3_ - this.hintText.height >> 1);
        var _loc4_:TextFormat = new TextFormat();
        _loc4_.align = _loc1_;
        this.hintText.setTextAlign(_loc1_);
    }

    public function get model():TutorialHintVO {
        return this._model;
    }

    public function set model(param1:TutorialHintVO):void {
        this._model = param1;
        invalidateData();
    }

    private function onLoopEndedHandler(param1:TutorialHintEvent):void {
        this.hide();
    }
}
}
