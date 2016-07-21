package net.wg.gui.lobby.fortifications.cmp.build.impl {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.StatusIndicatorAnim;
import net.wg.gui.lobby.fortifications.cmp.build.IBuildingIndicatorsCmp;
import net.wg.gui.lobby.fortifications.data.BuildingIndicatorsVO;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.utils.ILocale;

import scaleform.clik.constants.InvalidationType;

public class BuildingIndicatorsCmp extends UIComponentEx implements IBuildingIndicatorsCmp {

    public var hpLbl:TextField = null;

    public var defResLbl:TextField = null;

    public var hpProgress:StatusIndicatorAnim = null;

    public var defResProgress:StatusIndicatorAnim = null;

    public var hpProgressLabels:ProgressTotalLabels = null;

    public var defResLabels:ProgressTotalLabels = null;

    public var hpToolTipArea:MovieClip = null;

    public var defResToolTipArea:MovieClip = null;

    private var _model:BuildingIndicatorsVO = null;

    private var _invokeFirstTime:Boolean = true;

    private var _areTooltipsEnabled:Boolean = false;

    private var _locale:ILocale = null;

    public function BuildingIndicatorsCmp() {
        super();
        this.hpProgress.callback = this.updateHpLabel;
        this.defResProgress.callback = this.updateResLabel;
        this._locale = App.utils.locale;
    }

    private static function onTooltipAreaRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    override protected function onDispose():void {
        this.removeListeners();
        this._locale = null;
        this.hpLbl = null;
        this.defResLbl = null;
        this.hpToolTipArea = null;
        this.defResToolTipArea = null;
        this.hpProgress.dispose();
        this.hpProgress = null;
        this.defResProgress.dispose();
        this.defResProgress = null;
        this.hpProgressLabels.dispose();
        this.hpProgressLabels = null;
        this.defResLabels.dispose();
        this.defResLabels = null;
        this._model = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (this._model != null && isInvalid(InvalidationType.DATA)) {
            this.hpLbl.htmlText = this._model.hpLabel;
            this.defResLbl.htmlText = this._model.defResLabel;
            this.hpProgress.maximum = this._model.hpTotalValue;
            this.defResProgress.maximum = this._model.defResTotalValue;
            this.hpProgress.useAnim = !this._invokeFirstTime;
            this.defResProgress.useAnim = !this._invokeFirstTime;
            this._invokeFirstTime = false;
            this.hpProgress.value = this._model.hpCurrentValue;
            this.defResProgress.value = this._model.defResCurrentValue;
        }
    }

    public function setData(param1:BuildingIndicatorsVO):void {
        this._model = param1;
        invalidateData();
    }

    public function showToolTips(param1:Boolean):void {
        if (this._areTooltipsEnabled == param1) {
            return;
        }
        this._areTooltipsEnabled = param1;
        if (param1) {
            this.hpToolTipArea.addEventListener(MouseEvent.ROLL_OVER, this.onHpToolTipAreaRollOverHandler);
            this.hpToolTipArea.addEventListener(MouseEvent.ROLL_OUT, onTooltipAreaRollOutHandler);
            this.defResToolTipArea.addEventListener(MouseEvent.ROLL_OVER, this.onDefResToolTipAreaRollOverHandler);
            this.defResToolTipArea.addEventListener(MouseEvent.ROLL_OUT, onTooltipAreaRollOutHandler);
        }
        else {
            this.removeListeners();
        }
    }

    private function removeListeners():void {
        this.hpToolTipArea.removeEventListener(MouseEvent.ROLL_OVER, this.onHpToolTipAreaRollOverHandler);
        this.hpToolTipArea.removeEventListener(MouseEvent.ROLL_OUT, onTooltipAreaRollOutHandler);
        this.defResToolTipArea.removeEventListener(MouseEvent.ROLL_OVER, this.onDefResToolTipAreaRollOverHandler);
        this.defResToolTipArea.removeEventListener(MouseEvent.ROLL_OUT, onTooltipAreaRollOutHandler);
    }

    private function updateHpLabel():void {
        if (this._model) {
            this._model.hpProgressLabels.currentValue = this._locale.integer(this.hpProgress.value);
            this.hpProgressLabels.setData = this._model.hpProgressLabels;
        }
    }

    private function updateResLabel():void {
        var _loc1_:Number = NaN;
        if (this._model) {
            _loc1_ = this.defResProgress.value < this.defResProgress.maximum ? Number(this.defResProgress.value) : Number(this._model.defResCurrentValue);
            this._model.defResProgressLabels.currentValue = this._locale.integer(_loc1_);
            this.defResLabels.setData = this._model.defResProgressLabels;
        }
    }

    private function onHpToolTipAreaRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_POPOVER_HPPROGRESS);
    }

    private function onDefResToolTipAreaRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.FORT_POPOVER_DEFRESPROGRESS, null, this._model.defResCompensationValue > 0 ? this._locale.integer(this._model.defResCompensationValue) : null);
    }
}
}
