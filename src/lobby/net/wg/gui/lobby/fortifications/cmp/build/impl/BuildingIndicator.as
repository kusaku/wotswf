package net.wg.gui.lobby.fortifications.cmp.build.impl {
import flash.display.MovieClip;

import net.wg.gui.components.controls.StatusIndicatorAnim;
import net.wg.gui.fortBase.IBuildingBaseVO;
import net.wg.gui.lobby.fortifications.cmp.build.IBuildingIndicator;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.utils.ILocale;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.StatusIndicator;

public class BuildingIndicator extends UIComponentEx implements IBuildingIndicator {

    private static const LEVEL_INDICATOR_LEFT_POS:Number = 0;

    private static const LEVEL_INDICATOR_CENTER_POS:Number = 45;

    private static const STOP_FRAME:String = "stop";

    public var buildingLevel:MovieClip = null;

    public var hpIndicator:StatusIndicatorAnim = null;

    public var defResIndicator:StatusIndicatorAnim = null;

    private var _labels:IndicatorLabels = null;

    private var _locale:ILocale = null;

    private var _model:IBuildingBaseVO = null;

    private var _playAnimation:Boolean = true;

    private var _visible:Boolean = false;

    private var _showBars:Boolean = true;

    public function BuildingIndicator() {
        super();
        this._locale = App.utils.locale;
        gotoAndPlay(STOP_FRAME);
        this.buildingLevel.mouseEnabled = false;
        this.hpIndicator.mouseEnabled = false;
        this.hpIndicator.callback = this.updateHpLabel;
        this.defResIndicator.mouseEnabled = false;
        this.defResIndicator.callback = this.updateDefResLabel;
        this._labels.mouseEnabled = false;
        this._labels.visible = false;
        this.mouseChildren = false;
        this._visible = this.visible;
    }

    override protected function onDispose():void {
        this.hpIndicator.dispose();
        this.hpIndicator = null;
        this.defResIndicator.dispose();
        this.defResIndicator = null;
        this._labels.dispose();
        this._labels = null;
        this.buildingLevel = null;
        this._model = null;
        this._locale = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (this._model != null && isInvalid(InvalidationType.DATA)) {
            if (this._showBars) {
                this.hpIndicator.maximum = this._model.maxHpValue;
                this.defResIndicator.maximum = this._model.maxDefResValue;
                this.setValue(this.hpIndicator, this._model.hpVal);
                this.setValue(this.defResIndicator, this._model.defResVal);
            }
            this.buildingLevel.gotoAndStop(this._model.buildingLevel);
        }
    }

    public function applyVOData(param1:IBuildingBaseVO):void {
        this._model = param1;
        invalidateData();
    }

    private function updateHpLabel():void {
        this._labels.hpValue.htmlText = this._locale.integer(this.hpIndicator.value);
    }

    private function updateDefResLabel():void {
        var _loc1_:Number = this.defResIndicator.value < this.defResIndicator.maximum ? Number(this.defResIndicator.value) : Number(this._model.defResVal);
        this._labels.defResValue.htmlText = this._locale.integer(_loc1_);
    }

    private function setValue(param1:StatusIndicatorAnim, param2:int):void {
        param1.useAnim = this._playAnimation;
        param1.value = param2;
    }

    override public function get visible():Boolean {
        return this._visible;
    }

    override public function set visible(param1:Boolean):void {
        this._labels.visible = param1;
        this.defResIndicator.visible = param1;
        this.hpIndicator.visible = param1;
        this.buildingLevel.visible = param1;
        this._visible = param1;
    }

    public function set showBars(param1:Boolean):void {
        this._showBars = param1;
        this.defResIndicator.visible = param1;
        this.hpIndicator.visible = param1;
        this.buildingLevel.x = !!param1 ? Number(LEVEL_INDICATOR_LEFT_POS) : Number(LEVEL_INDICATOR_CENTER_POS);
    }

    public function get labels():IndicatorLabels {
        return this._labels;
    }

    public function set labels(param1:IndicatorLabels):void {
        this._labels = param1;
    }

    public function get defResIndicatorComponent():StatusIndicator {
        return this.defResIndicator;
    }

    public function get playAnimation():Boolean {
        return this._playAnimation;
    }

    public function set playAnimation(param1:Boolean):void {
        this._playAnimation = param1;
    }
}
}
