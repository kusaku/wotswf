package net.wg.gui.cyberSport.staticFormation {
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.Errors;
import net.wg.gui.components.advanced.ContentTabBar;
import net.wg.gui.components.advanced.ViewStack;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationProfileButtonInfoVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationProfileEmblemVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationProfileWindowVO;
import net.wg.gui.cyberSport.staticFormation.interfaces.ITextClickDelegate;
import net.wg.gui.cyberSport.staticFormation.views.IStaticFormationProfileEmblem;
import net.wg.gui.events.ViewStackEvent;
import net.wg.infrastructure.base.meta.IStaticFormationProfileWindowMeta;
import net.wg.infrastructure.base.meta.impl.StaticFormationProfileWindowMeta;
import net.wg.infrastructure.interfaces.IDAAPIModule;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.IndexEvent;

public class StaticFormationProfileWindow extends StaticFormationProfileWindowMeta implements IStaticFormationProfileWindowMeta, ITextClickDelegate {

    public var viewStack:ViewStack = null;

    public var tabs:ContentTabBar = null;

    public var formationInfo:IStaticFormationProfileEmblem = null;

    public var actionButton:SoundButtonEx = null;

    public var actionBtnStatusTF:TextField = null;

    private var _model:StaticFormationProfileWindowVO = null;

    private var _btnAction:String = "";

    private var _btnActionTooltip:String = "";

    private var _dataBtnInfo:StaticFormationProfileButtonInfoVO = null;

    public function StaticFormationProfileWindow() {
        super();
        isModal = false;
        isCentered = true;
    }

    private static function onActionButtonRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private static function onActionButtonStatusTFRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.title = CYBERSPORT.STATICFORMATIONPROFILEWINDOW_TITLE;
        this.actionButton.addEventListener(ButtonEvent.CLICK, this.onClickActBtnHandler);
        this.actionButton.addEventListener(MouseEvent.ROLL_OVER, this.onActionButtonRollOverHandler);
        this.actionButton.addEventListener(MouseEvent.ROLL_OUT, onActionButtonRollOutHandler);
        this.actionBtnStatusTF.addEventListener(MouseEvent.ROLL_OVER, this.onActionButtonStatusTFRollOverHandler);
        this.actionBtnStatusTF.addEventListener(MouseEvent.ROLL_OUT, onActionButtonStatusTFRollOutHandler);
        this.formationInfo.setTextClickDelegate(this);
    }

    override protected function updateFormationInfo(param1:StaticFormationProfileEmblemVO):void {
        this.formationInfo.update(param1);
    }

    override protected function setData(param1:StaticFormationProfileWindowVO):void {
        this._model = param1;
        this.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED, this.onChangedHandler);
        this.tabs.addEventListener(IndexEvent.INDEX_CHANGE, this.onChangeIndexHandler);
        this.tabs.dataProvider = new DataProvider(this._model.stateBar);
    }

    override protected function onDispose():void {
        this.viewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED, this.onChangedHandler);
        this.viewStack.dispose();
        this.viewStack = null;
        this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE, this.onChangeIndexHandler);
        this.tabs.dispose();
        this.tabs = null;
        this.formationInfo.dispose();
        this.formationInfo = null;
        this.actionButton.removeEventListener(ButtonEvent.CLICK, this.onClickActBtnHandler);
        this.actionButton.removeEventListener(MouseEvent.ROLL_OVER, this.onActionButtonRollOverHandler);
        this.actionButton.removeEventListener(MouseEvent.ROLL_OUT, onActionButtonRollOutHandler);
        this.actionButton.dispose();
        this.actionButton = null;
        this._model = null;
        this._dataBtnInfo = null;
        this.actionBtnStatusTF.removeEventListener(MouseEvent.ROLL_OVER, this.onActionButtonStatusTFRollOverHandler);
        this.actionBtnStatusTF.removeEventListener(MouseEvent.ROLL_OUT, onActionButtonStatusTFRollOutHandler);
        this.actionBtnStatusTF = null;
        super.onDispose();
    }

    override protected function updateActionButton(param1:StaticFormationProfileButtonInfoVO):void {
        this._dataBtnInfo = param1;
        this.actionButton.label = param1.buttonLabel;
        this.actionButton.enabled = param1.enabled;
        this.actionButton.mouseEnabled = true;
        this.actionBtnStatusTF.htmlText = param1.statusLbl;
        this._btnAction = param1.action;
        this._btnActionTooltip = App.toolTipMgr.getNewFormatter().addHeader(param1.tooltipHeader).addBody(param1.tooltipBody).make();
        App.utils.commons.updateTextFieldSize(this.actionBtnStatusTF);
        if (this.actionBtnStatusTF.width > this.actionButton.width) {
            this.actionBtnStatusTF.x = Math.round(this.actionButton.x + this.actionButton.width - this.actionBtnStatusTF.width);
        }
        else {
            this.actionBtnStatusTF.x = Math.round(this.actionButton.x + (this.actionButton.width - this.actionBtnStatusTF.width >> 1));
        }
    }

    public function as_setFormationEmblem(param1:String):void {
        this.formationInfo.updateFormationEmblem(param1);
    }

    public function as_setWindowSize(param1:int, param2:int):void {
        this.width = param1;
        this.height = param2;
    }

    public function as_showView(param1:int):void {
        if (this.tabs && param1 != -1 && param1 < this.tabs.dataProvider.length) {
            this.tabs.selectedIndex = param1;
        }
    }

    public function onTextClick(param1:String):void {
        assertNotNull(param1, " onTextClick (link value) " + Errors.CANT_NULL);
        onClickHyperLinkS(param1);
    }

    private function onChangeIndexHandler(param1:IndexEvent):void {
        if (this.viewStack && this.viewStack.currentView && this.viewStack.currentLinkage) {
            unregisterComponent(this._model.stateMapView[this.viewStack.currentLinkage]);
        }
        this.viewStack.show(param1.data.view);
    }

    private function onChangedHandler(param1:ViewStackEvent):void {
        registerFlashComponentS(IDAAPIModule(param1.view), this._model.stateMapView[param1.linkage]);
    }

    private function onClickActBtnHandler(param1:ButtonEvent):void {
        actionBtnClickHandlerS(this._btnAction);
    }

    private function onActionButtonRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(this._btnActionTooltip);
    }

    private function onActionButtonStatusTFRollOverHandler(param1:MouseEvent):void {
        if (this._dataBtnInfo.isTooltipStatus) {
            App.toolTipMgr.showSpecial(this._dataBtnInfo.tooltipStatus, null);
        }
    }
}
}
