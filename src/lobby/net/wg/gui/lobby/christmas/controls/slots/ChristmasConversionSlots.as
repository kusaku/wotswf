package net.wg.gui.lobby.christmas.controls.slots {
import flash.display.InteractiveObject;
import flash.text.TextField;
import flash.ui.Keyboard;

import net.wg.gui.components.controls.CloseButtonText;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.christmas.data.slots.ConversionDataVO;
import net.wg.gui.lobby.christmas.data.slots.ConversionStaticDataVO;
import net.wg.gui.lobby.christmas.data.slots.SlotsDataVO;
import net.wg.gui.lobby.christmas.data.slots.SlotsStaticDataVO;
import net.wg.gui.lobby.christmas.event.ChristmasConversionEvent;
import net.wg.gui.lobby.christmas.interfaces.IChristmasDroppableSlot;
import net.wg.gui.lobby.christmas.interfaces.IChristmasSlot;

import scaleform.clik.constants.InputValue;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.InputEvent;
import scaleform.clik.ui.InputDetails;

public class ChristmasConversionSlots extends ChristmasSlots {

    public var slot1:IChristmasDroppableSlot = null;

    public var slot2:IChristmasDroppableSlot = null;

    public var slot3:IChristmasDroppableSlot = null;

    public var slot4:IChristmasDroppableSlot = null;

    public var slot5:IChristmasDroppableSlot = null;

    public var resultSlot:IChristmasSlot = null;

    public var closeBtn:CloseButtonText = null;

    public var titleTf:TextField = null;

    public var descriptionTf:TextField = null;

    public var convertBtn:ISoundButtonEx = null;

    public var cancelBtn:ISoundButtonEx = null;

    public function ChristmasConversionSlots() {
        super();
        addSlots(this.slot1, this.slot2, this.slot3, this.slot4, this.slot5, this.resultSlot);
        addDropActors(this.slot1, this.slot2, this.slot3, this.slot4, this.slot5);
    }

    override public function getFocusChain():Vector.<InteractiveObject> {
        var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>(0);
        _loc1_.push(this.convertBtn, this.cancelBtn);
        _loc1_ = _loc1_.concat(super.getFocusChain());
        return _loc1_;
    }

    override public function setData(param1:SlotsDataVO):void {
        super.setData(param1);
        this.convertBtn.enabled = ConversionDataVO(param1).enableConvertBtn;
    }

    override public function setStaticData(param1:SlotsStaticDataVO):void {
        super.setStaticData(param1);
        var _loc2_:ConversionStaticDataVO = ConversionStaticDataVO(param1);
        this.titleTf.htmlText = _loc2_.title;
        this.descriptionTf.htmlText = _loc2_.description;
        this.convertBtn.label = _loc2_.convertBtnLabel;
        this.cancelBtn.label = _loc2_.cancelBtnLabel;
    }

    override protected function configUI():void {
        super.configUI();
        this.closeBtn.visibleText = false;
        this.convertBtn.addEventListener(ButtonEvent.CLICK, this.onConvertBtnClickHandler);
        this.cancelBtn.addEventListener(ButtonEvent.CLICK, this.onCancelBtnClickHandler);
        this.closeBtn.addEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
    }

    override protected function onDispose():void {
        this.convertBtn.removeEventListener(ButtonEvent.CLICK, this.onConvertBtnClickHandler);
        this.cancelBtn.removeEventListener(ButtonEvent.CLICK, this.onCancelBtnClickHandler);
        this.closeBtn.removeEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
        this.titleTf = null;
        this.descriptionTf = null;
        this.convertBtn.dispose();
        this.convertBtn = null;
        this.cancelBtn.dispose();
        this.cancelBtn = null;
        this.closeBtn.dispose();
        this.closeBtn = null;
        super.onDispose();
    }

    override public function handleInput(param1:InputEvent):void {
        if (param1.handled) {
            return;
        }
        var _loc2_:InputDetails = param1.details;
        if (_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN) {
            param1.handled = true;
            dispatchEvent(new ChristmasConversionEvent(ChristmasConversionEvent.CANCEL_CONVERSION, true));
        }
    }

    private function onConvertBtnClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new ChristmasConversionEvent(ChristmasConversionEvent.CONVERT_ITEMS, true));
    }

    private function onCancelBtnClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new ChristmasConversionEvent(ChristmasConversionEvent.CANCEL_CONVERSION, true));
    }

    private function onCloseBtnClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new ChristmasConversionEvent(ChristmasConversionEvent.CANCEL_CONVERSION, true));
    }
}
}
