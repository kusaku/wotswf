package net.wg.gui.lobby.fortifications.windows {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.text.TextField;

import net.wg.data.constants.generated.FITTING_TYPES;
import net.wg.gui.components.advanced.ExtraModuleIcon;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.fortifications.data.orderInfo.FortOrderInfoTitleVO;
import net.wg.gui.lobby.fortifications.data.orderInfo.FortOrderInfoWindowVO;
import net.wg.gui.lobby.fortifications.orderInfo.ConsumablesOrderInfoCmp;
import net.wg.infrastructure.base.meta.IFortOrderInfoWindowMeta;
import net.wg.infrastructure.base.meta.impl.FortOrderInfoWindowMeta;

import scaleform.clik.events.ButtonEvent;
import scaleform.clik.utils.Padding;
import scaleform.gfx.TextFieldEx;

public class FortOrderInfoWindow extends FortOrderInfoWindowMeta implements IFortOrderInfoWindowMeta {

    private static const UPDATE_VIEW_SIZE:String = "updateViewSize";

    private static const WINDOW_WIDTH_OFFSET:int = 3;

    private static const DESCRIPTION_BODY_Y_OFFSET:int = -2;

    private static const CLOSE_BTN_Y_OFFSET:int = 13;

    private static const DESCRIPTION_TITLE_Y_OFFSET:int = 80;

    public var closeButton:ISoundButtonEx = null;

    public var moduleIcon:ExtraModuleIcon = null;

    public var orderTitle:TextField = null;

    public var orderLevel:TextField = null;

    public var orderDescriptionTitle:TextField = null;

    public var orderDescriptionBody:TextField = null;

    public var paramsPanel:ConsumablesOrderInfoCmp = null;

    public var panelTitle:TextField = null;

    public var vsBg:MovieClip = null;

    public function FortOrderInfoWindow() {
        super();
        isCentered = true;
        TextFieldEx.setVerticalAlign(this.orderTitle, TextFieldEx.VALIGN_CENTER);
        TextFieldEx.setVerticalAlign(this.orderLevel, TextFieldEx.VALIGN_CENTER);
    }

    override protected function onDispose():void {
        App.utils.scheduler.cancelTask(this.updateWindowSize);
        this.paramsPanel.removeEventListener(Event.RESIZE, this.onParamsPanelResizeHandler);
        this.paramsPanel.dispose();
        this.paramsPanel = null;
        this.closeButton.removeEventListener(ButtonEvent.CLICK, this.onCloseButtonClickHandler);
        this.closeButton.dispose();
        this.closeButton = null;
        this.moduleIcon.dispose();
        this.moduleIcon = null;
        this.orderTitle = null;
        this.orderLevel = null;
        this.orderDescriptionTitle = null;
        this.orderDescriptionBody = null;
        this.panelTitle = null;
        this.vsBg = null;
        super.onDispose();
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.paramsPanel.addEventListener(Event.RESIZE, this.onParamsPanelResizeHandler);
        window.useBottomBtns = true;
        DisplayObject(window).visible = false;
    }

    override protected function configUI():void {
        super.configUI();
        this.closeButton.addEventListener(ButtonEvent.CLICK, this.onCloseButtonClickHandler);
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(InteractiveObject(this.closeButton));
    }

    override protected function setWindowData(param1:FortOrderInfoWindowVO):void {
        window.title = param1.windowTitle;
        this.closeButton.label = param1.btnLbl;
        this.panelTitle.htmlText = param1.panelTitle;
        this.orderDescriptionBody.htmlText = param1.orderDescrBody;
        this.orderDescriptionTitle.htmlText = param1.orderDescrTitle;
    }

    override protected function setDynProperties(param1:FortOrderInfoTitleVO):void {
        this.moduleIcon.setValuesWithType(FITTING_TYPES.ORDER, param1.orderIcon, param1.level);
        this.orderTitle.htmlText = param1.orderTitle;
        this.orderLevel.htmlText = param1.orderLevel;
        this.paramsPanel.setData(param1.orderParams);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(UPDATE_VIEW_SIZE)) {
            this.updateLayouts();
            App.utils.scheduler.scheduleOnNextFrame(this.updateWindowSize);
        }
    }

    private function updateWindowSize():void {
        var _loc1_:int = this.vsBg.width + WINDOW_WIDTH_OFFSET;
        var _loc2_:int = this.vsBg.height + Padding(window.contentPadding).top;
        window.updateSize(_loc1_, _loc2_, true);
        window.validateNow();
        if (!DisplayObject(window).visible) {
            DisplayObject(window).visible = true;
        }
    }

    private function updateLayouts():void {
        var _loc1_:int = this.paramsPanel.y + this.paramsPanel.getElementHeight();
        this.orderDescriptionTitle.y = _loc1_ + DESCRIPTION_TITLE_Y_OFFSET;
        this.orderDescriptionBody.y = this.orderDescriptionTitle.y + this.orderDescriptionTitle.height + DESCRIPTION_BODY_Y_OFFSET ^ 0;
        this.vsBg.height = this.orderDescriptionBody.y + this.orderDescriptionBody.height ^ 0;
        this.closeButton.y = this.vsBg.height + CLOSE_BTN_Y_OFFSET;
    }

    private function onCloseButtonClickHandler(param1:ButtonEvent):void {
        onWindowCloseS();
    }

    private function onParamsPanelResizeHandler(param1:Event):void {
        invalidate(UPDATE_VIEW_SIZE);
    }
}
}
