package net.wg.gui.lobby.fortifications.cmp.buildingProcess.impl {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.gui.components.advanced.DashLine;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.lobby.fortifications.cmp.build.impl.OrderInfoCmp;
import net.wg.gui.lobby.fortifications.data.buildingProcess.BuildingProcessInfoVO;
import net.wg.gui.lobby.fortifications.popovers.impl.PopoverBuildingTexture;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.infrastructure.interfaces.entity.IFocusContainer;

import scaleform.clik.events.ButtonEvent;
import scaleform.gfx.TextFieldEx;

public class BuildingProcessInfo extends MovieClip implements IDisposable, IFocusContainer {

    public static const BUY_BUILDING:String = "buyBuilding";

    private static const DASH_LINE_PADDING:uint = 18;

    public var buildingName:TextField = null;

    public var statusMsg:TextField = null;

    public var builtMessage:TextField = null;

    public var buildingImg:PopoverBuildingTexture = null;

    public var longDescription:TextField = null;

    public var orderInfo:OrderInfoCmp = null;

    public var applyButton:SoundButtonEx = null;

    public var dashLine:DashLine = null;

    private var model:BuildingProcessInfoVO = null;

    public function BuildingProcessInfo() {
        super();
        TextFieldEx.setVerticalAlign(this.builtMessage, TextFieldEx.VALIGN_CENTER);
        this.builtMessage.mouseEnabled = false;
        this.dashLine.x = DASH_LINE_PADDING;
        this.dashLine.width = this.width - DASH_LINE_PADDING * 2;
    }

    private static function onRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    public function getComponentForFocus():InteractiveObject {
        return this.applyButton;
    }

    public function dispose():void {
        this.buildingName = null;
        this.statusMsg.removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        this.statusMsg.removeEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
        this.statusMsg = null;
        this.buildingImg.dispose();
        this.buildingImg = null;
        this.longDescription = null;
        this.orderInfo.dispose();
        this.orderInfo = null;
        this.applyButton.removeEventListener(ButtonEvent.CLICK, this.onClickHandler);
        this.applyButton.dispose();
        this.applyButton = null;
        this.dashLine.dispose();
        this.dashLine = null;
        this.model = null;
    }

    public function getBuildingId():String {
        if (!this.model) {
            return null;
        }
        return this.model.buildingID;
    }

    public function setData(param1:BuildingProcessInfoVO):void {
        this.model = param1;
        this.buildingName.htmlText = this.model.buildingName;
        this.statusMsg.htmlText = this.model.statusMsg;
        this.statusMsg.addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        this.statusMsg.addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
        this.buildingImg.setState(this.model.buildingIcon);
        this.longDescription.htmlText = this.model.longDescr;
        this.applyButton.label = this.model.buttonLabel;
        var _loc2_:Boolean = this.model.isVisibleBtn;
        this.applyButton.visible = _loc2_;
        this.applyButton.enabled = this.model.isEnableBtn;
        this.builtMessage.visible = !_loc2_;
        if (this.builtMessage.visible) {
            this.builtMessage.htmlText = this.model.buttonLabel;
            this.builtMessage.x = Math.round((this.width - this.builtMessage.width) / 2);
        }
        if (this.model.isVisibleBtn && this.model.buttonTooltip) {
            this.applyButton.tooltip = this.makeTooltipData();
            if (this.applyButton.enabled) {
                this.applyButton.addEventListener(ButtonEvent.CLICK, this.onClickHandler);
                dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS, this));
            }
        }
        this.orderInfo.setData(this.model.orderInfo);
    }

    private function makeTooltipData():String {
        var _loc1_:String = App.toolTipMgr.getNewFormatter().addHeader(this.model.buttonTooltip["header"]).addBody(this.model.buttonTooltip["body"]).make();
        return _loc1_;
    }

    private function onRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(this.model.statusIconTooltip);
    }

    private function onClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new Event(BUY_BUILDING));
    }
}
}
