package net.wg.gui.lobby.christmas {
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.text.TextField;
import flash.ui.Keyboard;

import net.wg.gui.components.advanced.BackButton;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.christmas.data.ChestsViewVO;
import net.wg.gui.lobby.christmas.interfaces.IChestAwardRibbon;
import net.wg.gui.lobby.quests.data.AwardCarouselItemRendererVO;
import net.wg.infrastructure.base.meta.IChristmasChestsViewMeta;
import net.wg.infrastructure.base.meta.impl.ChristmasChestsViewMeta;

import scaleform.clik.constants.InputValue;
import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.InputEvent;
import scaleform.clik.ui.InputDetails;

public class ChristmasChestsView extends ChristmasChestsViewMeta implements IChristmasChestsViewMeta {

    private static const CHESTS_NUM_TF_OFFSET:int = 94;

    private static const OPEN_BTN_OFFSET:int = 45;

    private static const AWARD_RIBBON_OFFSET:int = 54;

    private static const CLOSE_BTN_OFFSET:int = 15;

    private static const LIPS_ALPHA:Number = 0.8;

    private static const CNTRLS_ALPHA_ENABLED:Number = 1;

    private static const CNTRLS_ALPHA_DISABLED:Number = 0.4;

    public var chestsNumTF:TextField = null;

    public var openBtn:ISoundButtonEx = null;

    public var closeBtn:ISoundButtonEx = null;

    public var backBtn:BackButton = null;

    public var awardRibbon:IChestAwardRibbon = null;

    public var topLip:Sprite = null;

    public var bottomLip:Sprite = null;

    private var _stage:Stage;

    private var _lipsHitArea:Sprite = null;

    private var _isControlsEnabled:Boolean = true;

    public function ChristmasChestsView() {
        this._stage = App.stage;
        super();
    }

    override public function updateStage(param1:Number, param2:Number):void {
        setViewSize(param1, param2);
    }

    override protected function setAwardData(param1:Vector.<AwardCarouselItemRendererVO>):void {
        this.awardRibbon.setAwards(param1);
    }

    override protected function configUI():void {
        super.configUI();
        this._lipsHitArea = new Sprite();
        addChild(this._lipsHitArea);
        this.topLip.hitArea = this._lipsHitArea;
        this.bottomLip.hitArea = this._lipsHitArea;
        this.topLip.alpha = LIPS_ALPHA;
        this.bottomLip.alpha = LIPS_ALPHA;
        this.awardRibbon.setOwner(this);
        this._stage.addEventListener(Event.RESIZE, this.onStageResizeHandler);
        this.openBtn.addEventListener(ButtonEvent.CLICK, this.onOpenBtnClickHandler);
        this.backBtn.addEventListener(ButtonEvent.CLICK, this.onBackBtnClickHandler);
        this.closeBtn.addEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
    }

    override protected function draw():void {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            _loc1_ = this._stage.stageWidth / App.appScale;
            _loc2_ = height / App.appScale;
            this.chestsNumTF.x = _loc1_ - this.chestsNumTF.width >> 1;
            this.chestsNumTF.y = _loc2_ - CHESTS_NUM_TF_OFFSET;
            this.openBtn.x = _loc1_ - this.openBtn.width >> 1;
            this.openBtn.y = this.chestsNumTF.y + OPEN_BTN_OFFSET;
            this.awardRibbon.x = _loc1_ - this.awardRibbon.width >> 1;
            this.awardRibbon.y = _loc2_ - this.awardRibbon.height - AWARD_RIBBON_OFFSET >> 1;
            this.closeBtn.x = _loc1_ - this.closeBtn.width - CLOSE_BTN_OFFSET ^ 0;
            this.topLip.width = this.bottomLip.width = _loc1_;
            this.bottomLip.x = _loc1_;
            this.bottomLip.y = this._stage.stageHeight / App.appScale;
        }
    }

    override protected function onDispose():void {
        this.openBtn.removeEventListener(ButtonEvent.CLICK, this.onOpenBtnClickHandler);
        this.backBtn.removeEventListener(ButtonEvent.CLICK, this.onBackBtnClickHandler);
        this.closeBtn.removeEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
        this._stage.removeEventListener(Event.RESIZE, this.onStageResizeHandler);
        this.chestsNumTF = null;
        this.openBtn.dispose();
        this.openBtn = null;
        this.awardRibbon.dispose();
        this.awardRibbon = null;
        this.closeBtn.dispose();
        this.closeBtn = null;
        this.backBtn.dispose();
        this.backBtn = null;
        removeChild(this._lipsHitArea);
        this._lipsHitArea = null;
        this.topLip = null;
        this.bottomLip = null;
        this._stage = null;
        super.onDispose();
    }

    override protected function setInitData(param1:ChestsViewVO):void {
        this.backBtn.label = param1.backBtnLabel;
        this.backBtn.descrLabel = param1.backBtnDescrLabel;
        this.closeBtn.label = param1.closeBtnLabel;
        this.closeBtn.validateNow();
        invalidateSize();
    }

    public function as_setBottomTexts(param1:String, param2:String):void {
        this.chestsNumTF.htmlText = param1;
        this.openBtn.label = param2;
        invalidateSize();
    }

    public function as_setControlsEnabled(param1:Boolean):void {
        this._isControlsEnabled = param1;
        this.backBtn.enabled = this.closeBtn.enabled = param1;
        this.backBtn.alpha = this.closeBtn.alpha = !!param1 ? Number(CNTRLS_ALPHA_ENABLED) : Number(CNTRLS_ALPHA_DISABLED);
    }

    public function as_setOpenBtnEnabled(param1:Boolean):void {
        this.openBtn.enabled = param1;
    }

    public function as_showAwardRibbon(param1:Boolean):void {
        if (param1) {
            this.awardRibbon.show();
        }
        else {
            this.awardRibbon.hide();
        }
    }

    override public function handleInput(param1:InputEvent):void {
        if (param1.handled || !this._isControlsEnabled) {
            return;
        }
        var _loc2_:InputDetails = param1.details;
        if (_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN) {
            param1.handled = true;
            onCloseWindowS();
        }
    }

    private function onBackBtnClickHandler(param1:ButtonEvent):void {
        onCloseWindowS();
    }

    private function onCloseBtnClickHandler(param1:ButtonEvent):void {
        onCloseWindowS();
    }

    private function onOpenBtnClickHandler(param1:ButtonEvent):void {
        onOpenBtnClickS();
    }

    private function onStageResizeHandler(param1:Event):void {
        invalidateSize();
    }
}
}
