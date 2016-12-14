package net.wg.gui.lobby.fortifications.windows {
import flash.display.InteractiveObject;
import flash.text.TextField;

import net.wg.gui.components.advanced.DashLine;
import net.wg.gui.components.assets.ArrowSeparator;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.fortifications.cmp.build.impl.ModernizationCmp;
import net.wg.gui.lobby.fortifications.data.BuildingModernizationVO;
import net.wg.infrastructure.base.meta.IFortModernizationWindowMeta;
import net.wg.infrastructure.base.meta.impl.FortModernizationWindowMeta;

import scaleform.clik.events.ButtonEvent;

public class FortModernizationWindow extends FortModernizationWindowMeta implements IFortModernizationWindowMeta {

    private static const HORIZONTAL_PADDING:int = 5;

    public var dashLine:DashLine = null;

    public var conditionIcon:TextField = null;

    public var buildingBefore:ModernizationCmp = null;

    public var buildingAfter:ModernizationCmp = null;

    public var conditions:TextField = null;

    public var costLabel:TextField = null;

    public var costValue:TextField = null;

    public var applyButton:ISoundButtonEx = null;

    public var cancelButton:ISoundButtonEx = null;

    public var separator:ArrowSeparator = null;

    private var _model:BuildingModernizationVO = null;

    public function FortModernizationWindow() {
        super();
        isModal = false;
        isCentered = true;
        canDrag = true;
    }

    override public function onWindowCloseS():void {
        super.onWindowCloseS();
    }

    override protected function setData(param1:BuildingModernizationVO):void {
        this._model = param1;
        this.conditions.htmlText = this._model.condition;
        this.costLabel.htmlText = this._model.costUpgrade;
        this.costValue.htmlText = this._model.costValue;
        this.conditionIcon.htmlText = this._model.conditionIcon;
        this.applyButton.enabled = this._model.canUpgrade;
        this.applyButton.mouseChildren = this.applyButton.mouseEnabled = true;
        this.applyButton.tooltip = this._model.btnToolTip;
        this.buildingBefore.setData(this._model.beforeUpgradeData);
        this.buildingBefore.applyGlowFilter();
        this.buildingAfter.setData(this._model.afterUpgradeData);
        this.buildingAfter.applyGlowFilter();
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        if (this._model && this._model.canUpgrade && this.applyButton.enabled) {
            setFocus(InteractiveObject(this.applyButton));
        }
        else {
            setFocus(InteractiveObject(this.cancelButton));
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.applyButton.mouseEnabledOnDisabled = true;
        this.applyButton.addEventListener(ButtonEvent.CLICK, this.onApplyButtonClickHandler);
        this.cancelButton.addEventListener(ButtonEvent.CLICK, this.onCancelButtonClickHandler);
        var _loc1_:int = this.costLabel.x + HORIZONTAL_PADDING;
        this.dashLine.width = this.costValue.x + this.costValue.width - _loc1_ - HORIZONTAL_PADDING >> 0;
        this.dashLine.x = _loc1_;
        this.buildingAfter.orderInfo.setDescriptionLinkCallback(this.showDetails);
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.useBottomBtns = true;
    }

    override protected function onDispose():void {
        this.applyButton.removeEventListener(ButtonEvent.CLICK, this.onApplyButtonClickHandler);
        this.applyButton.dispose();
        this.applyButton = null;
        this.cancelButton.removeEventListener(ButtonEvent.CLICK, this.onCancelButtonClickHandler);
        this.cancelButton.dispose();
        this.cancelButton = null;
        this.buildingBefore.dispose();
        this.buildingBefore = null;
        this.buildingAfter.dispose();
        this.buildingAfter = null;
        this._model = null;
        this.conditions = null;
        this.costLabel = null;
        this.costValue = null;
        this.conditionIcon = null;
        this.separator.dispose();
        this.separator = null;
        super.onDispose();
    }

    public function as_applyButtonLbl(param1:String):void {
        this.applyButton.label = param1;
    }

    public function as_cancelButton(param1:String):void {
        this.cancelButton.label = param1;
    }

    public function as_windowTitle(param1:String):void {
        window.title = param1;
    }

    private function showDetails():void {
        openOrderDetailsWindowS();
    }

    private function onApplyButtonClickHandler(param1:ButtonEvent):void {
        if (this._model.canUpgrade) {
            App.eventLogManager.logUIEvent(param1, this._model.intBuildingID);
            applyActionS();
        }
    }

    private function onCancelButtonClickHandler(param1:ButtonEvent):void {
        App.eventLogManager.logUIEvent(param1, this._model.intBuildingID);
        this.onWindowCloseS();
    }
}
}
