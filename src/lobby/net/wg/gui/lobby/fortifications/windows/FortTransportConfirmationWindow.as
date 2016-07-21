package net.wg.gui.lobby.fortifications.windows {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.text.TextField;
import flash.text.TextFormatAlign;

import net.wg.data.constants.Errors;
import net.wg.gui.components.controls.NumericStepper;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.fortifications.cmp.build.IBuildingIndicator;
import net.wg.gui.lobby.fortifications.data.FortInvalidationType;
import net.wg.gui.lobby.fortifications.data.TransportingVO;
import net.wg.gui.lobby.fortifications.data.base.BuildingBaseVO;
import net.wg.gui.lobby.fortifications.utils.impl.FortCommonUtils;
import net.wg.infrastructure.base.meta.IFortTransportConfirmationWindowMeta;
import net.wg.infrastructure.base.meta.impl.FortTransportConfirmationWindowMeta;
import net.wg.utils.IAssertable;
import net.wg.utils.ITweenAnimator;

import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.IndexEvent;
import scaleform.gfx.TextFieldEx;

public class FortTransportConfirmationWindow extends FortTransportConfirmationWindowMeta implements IFortTransportConfirmationWindowMeta {

    public var transportButton:ISoundButtonEx = null;

    public var cancelButton:ISoundButtonEx = null;

    public var resourceNumericStepper:NumericStepper = null;

    public var transportingText:TextField = null;

    public var maxTransportingSizeLabel:TextField = null;

    public var footerFadingText:TextField = null;

    public var sourceTextField:TextField = null;

    public var targetTextField:TextField = null;

    public var nutLoader:UILoaderAlt = null;

    public var sourceIndicator:IBuildingIndicator = null;

    public var targetIndicator:IBuildingIndicator = null;

    public var transportingLoader:UILoaderAlt = null;

    public var arrowLoader:UILoaderAlt = null;

    public var separator:MovieClip = null;

    private var _tweenAnimator:ITweenAnimator;

    private var _data:TransportingVO;

    public function FortTransportConfirmationWindow() {
        super();
        isModal = true;
        canDrag = false;
        isCentered = true;
        this.sourceIndicator.playAnimation = false;
        this.targetIndicator.playAnimation = false;
        TextFieldEx.setVerticalAlign(this.targetTextField, TextFieldEx.VALIGN_CENTER);
        TextFieldEx.setVerticalAlign(this.sourceTextField, TextFieldEx.VALIGN_CENTER);
        this._tweenAnimator = App.utils.tweenAnimator;
    }

    override protected function onClosingApproved():void {
    }

    override protected function setData(param1:TransportingVO):void {
        this._data = param1;
        this.resourceNumericStepper.maximum = this._data.maxTransportingSize;
        this.sourceIndicator.applyVOData(this._data.sourceBaseVO);
        this.updateSourceData(this.resourceNumericStepper.value);
        this.updateTargetData(this.resourceNumericStepper.value);
        this.sourceTextField.text = FORTIFICATIONS.buildings_buildingname(this._data.sourceBaseVO.uid);
        this.targetTextField.text = FORTIFICATIONS.buildings_buildingname(this._data.targetBaseVO.uid);
        this.resourceNumericStepper.stepSize = this._data.defResTep;
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.title = FORTIFICATIONS.FORTTRANSPORTCONFIRMATIONWINDOW_TITLE;
        window.useBottomBtns = true;
    }

    override protected function configUI():void {
        super.configUI();
        this.footerFadingText.alpha = 0;
        this.separator.mouseEnabled = false;
        this.transportButton.label = FORTIFICATIONS.FORTTRANSPORTCONFIRMATIONWINDOW_TRANSPORTBUTTON;
        this.cancelButton.label = FORTIFICATIONS.FORTTRANSPORTCONFIRMATIONWINDOW_CANCELBUTTON;
        this.transportingText.text = FORTIFICATIONS.FORTTRANSPORTCONFIRMATIONWINDOW_TRANSPORTINGTEXT;
        this.transportButton.addEventListener(ButtonEvent.CLICK, this.onTransportButtonClickHandler);
        this.cancelButton.addEventListener(ButtonEvent.CLICK, this.onCancelButtonClickHandler);
        this.resourceNumericStepper.addEventListener(IndexEvent.INDEX_CHANGE, this.onResourceNumericStepperIndexChangeHandler);
        FortCommonUtils.instance.changeTextAlign(this.resourceNumericStepper.textField, TextFormatAlign.RIGHT);
        this._tweenAnimator.addFadeInAnim(this.sourceIndicator.labels, null);
        this._tweenAnimator.addFadeInAnim(this.targetIndicator.labels, null);
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        this.updateFocus();
    }

    override protected function onDispose():void {
        App.utils.scheduler.cancelTask(this.updateFocus);
        this._tweenAnimator.removeAnims(this.footerFadingText);
        this._tweenAnimator.removeAnims(this.sourceIndicator.labels);
        this._tweenAnimator.removeAnims(this.targetIndicator.labels);
        this._tweenAnimator.removeAnims(this.sourceIndicator.defResIndicatorComponent);
        this._tweenAnimator.removeAnims(this.targetIndicator.defResIndicatorComponent);
        this.transportButton.removeEventListener(ButtonEvent.CLICK, this.onTransportButtonClickHandler);
        this.cancelButton.removeEventListener(ButtonEvent.CLICK, this.onCancelButtonClickHandler);
        this.resourceNumericStepper.removeEventListener(IndexEvent.INDEX_CHANGE, this.onResourceNumericStepperIndexChangeHandler);
        this.transportButton.dispose();
        this.transportButton = null;
        this.cancelButton.dispose();
        this.cancelButton = null;
        this.resourceNumericStepper.dispose();
        this.resourceNumericStepper = null;
        this.transportingText = null;
        this.maxTransportingSizeLabel = null;
        this.footerFadingText = null;
        this.nutLoader.dispose();
        this.nutLoader = null;
        this.transportingLoader.dispose();
        this.transportingLoader = null;
        this.arrowLoader.dispose();
        this.arrowLoader = null;
        this.sourceIndicator.dispose();
        this.sourceIndicator = null;
        this.targetIndicator.dispose();
        this.targetIndicator = null;
        this.sourceTextField = null;
        this.targetTextField = null;
        this.separator = null;
        this._tweenAnimator = null;
        this._data = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:* = false;
        super.draw();
        if (isInvalid(FortInvalidationType.INVALID_ENABLING)) {
            _loc1_ = this.resourceNumericStepper.value > 0;
            if (_loc1_ && this.footerFadingText.alpha == 0) {
                this._tweenAnimator.addFadeInAnim(this.footerFadingText, null);
            }
            else if (!_loc1_ && this.footerFadingText.alpha > 0) {
                this._tweenAnimator.addFadeOutAnim(this.footerFadingText, null);
            }
            this.transportButton.enabled = _loc1_;
        }
    }

    public function as_enableForFirstTransporting(param1:Boolean):void {
        var _loc2_:IAssertable = App.utils.asserter;
        _loc2_.assertNotNull(this._data, "_initialData" + Errors.CANT_NULL);
        _loc2_.assertNotNull(this._data.sourceBaseVO, "_initialSourceBaseVO" + Errors.CANT_NULL);
        _loc2_.assertNotNull(this._data.targetBaseVO, "_initialTargetBaseVO" + Errors.CANT_NULL);
        this.maxTransportingSizeLabel.visible = !param1;
        if (param1) {
            this.resourceNumericStepper.value = this.resourceNumericStepper.minimum = this.resourceNumericStepper.maximum;
            this.updateSourceData(this.resourceNumericStepper.value);
            this.updateTargetData(this.resourceNumericStepper.value);
        }
        this.resourceNumericStepper.enabled = !param1;
        if (hasFocus) {
            App.utils.scheduler.scheduleOnNextFrame(this.updateFocus);
        }
        invalidate(FortInvalidationType.INVALID_ENABLING);
    }

    public function as_setFooterText(param1:String):void {
        this.footerFadingText.htmlText = param1;
    }

    public function as_setMaxTransportingSize(param1:String):void {
        this.maxTransportingSizeLabel.htmlText = param1;
    }

    private function updateFocus():void {
        var _loc1_:InteractiveObject = null;
        if (this.resourceNumericStepper.enabled) {
            _loc1_ = this.resourceNumericStepper;
        }
        else if (this.transportButton.enabled) {
            _loc1_ = InteractiveObject(this.transportButton);
        }
        else {
            _loc1_ = InteractiveObject(this.cancelButton);
        }
        setFocus(_loc1_);
    }

    private function updateTargetData(param1:Number):void {
        var _loc2_:BuildingBaseVO = new BuildingBaseVO(this._data.targetBaseVO.toHash());
        var _loc3_:Number = Math.min(_loc2_.maxHpValue - _loc2_.hpVal, param1);
        _loc2_.hpVal = _loc2_.hpVal + _loc3_;
        param1 = param1 - _loc3_;
        if (param1 > 0) {
            _loc2_.defResVal = _loc2_.defResVal + Math.min(_loc2_.maxDefResValue - _loc2_.defResVal, param1);
        }
        if (_loc2_.defResVal == _loc2_.maxDefResValue) {
            this._tweenAnimator.blinkInfinity(this.targetIndicator.defResIndicatorComponent);
        }
        else {
            this._tweenAnimator.removeAnims(this.targetIndicator.defResIndicatorComponent);
            this.targetIndicator.defResIndicatorComponent.alpha = 1;
        }
        this.targetIndicator.applyVOData(_loc2_);
        _loc2_.dispose();
    }

    private function updateSourceData(param1:Number):void {
        var _loc2_:BuildingBaseVO = new BuildingBaseVO(this._data.sourceBaseVO.toHash());
        _loc2_.defResVal = _loc2_.defResVal - param1;
        this.sourceIndicator.applyVOData(_loc2_);
        if (_loc2_.defResVal == 0) {
            this._tweenAnimator.blinkInfinity(this.sourceIndicator.defResIndicatorComponent);
        }
        else {
            this._tweenAnimator.removeAnims(this.sourceIndicator.defResIndicatorComponent);
            this.sourceIndicator.defResIndicatorComponent.alpha = 1;
        }
        _loc2_.dispose();
    }

    private function onResourceNumericStepperIndexChangeHandler(param1:IndexEvent):void {
        var _loc2_:Number = this.resourceNumericStepper.value;
        this.updateSourceData(_loc2_);
        this.updateTargetData(_loc2_);
        invalidate(FortInvalidationType.INVALID_ENABLING);
    }

    private function onTransportButtonClickHandler(param1:ButtonEvent):void {
        App.eventLogManager.logUIEvent(param1, 0);
        onTransportingS(this.resourceNumericStepper.value);
    }

    private function onCancelButtonClickHandler(param1:ButtonEvent):void {
        App.eventLogManager.logUIEvent(param1, 0);
        onCancelS();
    }
}
}
