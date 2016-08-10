package net.wg.gui.rally.controls {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.VO.ExtendedUserVO;
import net.wg.data.constants.Errors;
import net.wg.data.constants.UserTags;
import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.gui.components.advanced.IndicationOfStatus;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.helpers.UserInfoTextLoadingController;
import net.wg.gui.cyberSport.controls.interfaces.IVehicleButton;
import net.wg.gui.interfaces.IButtonIconTextTransparent;
import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
import net.wg.gui.rally.controls.interfaces.ISlotRendererHelper;
import net.wg.gui.rally.events.RallyViewsEvent;
import net.wg.gui.rally.interfaces.IRallySlotVO;
import net.wg.infrastructure.interfaces.IUserProps;

import scaleform.clik.core.UIComponent;
import scaleform.clik.events.ButtonEvent;

public class RallySimpleSlotRenderer extends UIComponent implements IRallySimpleSlotRenderer {

    private static const UPDATE_SLOT_DATA:String = "updateSlotData";

    public static const STATUSES:Array = [IndicationOfStatus.STATUS_NORMAL, IndicationOfStatus.STATUS_CANCELED, IndicationOfStatus.STATUS_READY, IndicationOfStatus.STATUS_IN_BATTLE, IndicationOfStatus.STATUS_LOCKED];

    public var orderNo:TextField = null;

    public var slotLabel:TextField = null;

    public var takePlaceBtn:IButtonIconTextTransparent = null;

    public var takePlaceFirstTimeBtn:SoundButtonEx = null;

    public var vehicleBtn:IVehicleButton = null;

    public var contextMenuArea:Sprite = null;

    public var statusIndicator:IndicationOfStatus = null;

    public var commander:MovieClip = null;

    private var _userInfoTextLoadingController:UserInfoTextLoadingController = null;

    private var _index:int = 0;

    private var _slotData:IRallySlotVO = null;

    private var _helper:ISlotRendererHelper = null;

    public function RallySimpleSlotRenderer() {
        super();
        this._userInfoTextLoadingController = new UserInfoTextLoadingController();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(UPDATE_SLOT_DATA)) {
            if (this._slotData != null) {
                App.utils.asserter.assertNotNull(this.vehicleBtn, "\"vehicleBtn\" in " + name + Errors.CANT_NULL);
                this.updateComponents();
            }
            else {
                this.initControlsState();
            }
        }
    }

    override protected function configUI():void {
        super.configUI();
        if (this.orderNo != null) {
            this.orderNo.text = (this._index + 1).toString() + ".";
        }
        if (this.vehicleBtn != null) {
            this.vehicleBtn.addEventListener(RallyViewsEvent.VEH_BTN_ROLL_OVER, this.onMedallionRollOverHandler, false, int.MAX_VALUE);
            this.vehicleBtn.addEventListener(RallyViewsEvent.VEH_BTN_ROLL_OUT, this.onMedallionRollOutHandler);
        }
        if (this.contextMenuArea != null) {
            this.contextMenuArea.buttonMode = this.contextMenuArea.useHandCursor = true;
            this.contextMenuArea.addEventListener(MouseEvent.CLICK, this.onContextMenuAreaClickHandler);
            this.contextMenuArea.visible = false;
            this.addTooltipSubscriber(this.contextMenuArea);
        }
        if (this.takePlaceBtn != null) {
            this.addTooltipSubscriber(this.takePlaceBtn);
            this.takePlaceBtn.addEventListener(ButtonEvent.CLICK, this.onTakePlaceClickHandler);
        }
        if (this.takePlaceFirstTimeBtn != null) {
            this.addTooltipSubscriber(this.takePlaceFirstTimeBtn);
            this.takePlaceFirstTimeBtn.addEventListener(ButtonEvent.CLICK, this.onTakePlaceClickHandler);
        }
        this.addTooltipSubscriber(this.slotLabel);
        this.initControlsState();
        this._userInfoTextLoadingController.setControlledUserNameTextField(this.slotLabel);
    }

    override protected function onDispose():void {
        if (this.vehicleBtn != null) {
            this.vehicleBtn.removeEventListener(RallyViewsEvent.VEH_BTN_ROLL_OVER, this.onMedallionRollOverHandler);
            this.vehicleBtn.removeEventListener(RallyViewsEvent.VEH_BTN_ROLL_OUT, this.onControlRollOutHandler);
            this.vehicleBtn.dispose();
            this.vehicleBtn = null;
        }
        if (this.takePlaceBtn != null) {
            this.removeTooltipSubscriber(this.takePlaceBtn);
            this.takePlaceBtn.removeEventListener(ButtonEvent.CLICK, this.onTakePlaceClickHandler);
            this.takePlaceBtn.dispose();
            this.takePlaceBtn = null;
        }
        if (this.takePlaceFirstTimeBtn != null) {
            this.removeTooltipSubscriber(this.takePlaceFirstTimeBtn);
            this.takePlaceFirstTimeBtn.removeEventListener(ButtonEvent.CLICK, this.onTakePlaceClickHandler);
            this.takePlaceFirstTimeBtn.dispose();
            this.takePlaceFirstTimeBtn = null;
        }
        if (this.contextMenuArea != null) {
            this.removeTooltipSubscriber(this.contextMenuArea);
            this.contextMenuArea.removeEventListener(MouseEvent.CLICK, this.onContextMenuAreaClickHandler);
            this.contextMenuArea = null;
        }
        if (this.statusIndicator != null) {
            this.statusIndicator.dispose();
            this.statusIndicator = null;
        }
        if (this._userInfoTextLoadingController != null) {
            this._userInfoTextLoadingController.dispose();
            this._userInfoTextLoadingController = null;
        }
        this.orderNo = null;
        this.removeTooltipSubscriber(this.slotLabel);
        this.slotLabel = null;
        this.commander = null;
        this._slotData = null;
        this._helper = null;
        super.onDispose();
    }

    public function cooldown(param1:Boolean):void {
    }

    public function formatPlayerName(param1:IUserProps):void {
        if (this._userInfoTextLoadingController != null) {
            this._userInfoTextLoadingController.setUserNameFromProps(param1);
            if (this._userInfoTextLoadingController.getIsUserNameLoading() && this.contextMenuArea != null) {
                this.contextMenuArea.mouseEnabled = false;
            }
        }
    }

    public function getIsUserNameLoading():Boolean {
        if (this._userInfoTextLoadingController != null) {
            return this._userInfoTextLoadingController.getIsUserNameLoading();
        }
        return true;
    }

    public function setSlotLabelHtmlText(param1:String):void {
        if (this._userInfoTextLoadingController != null) {
            this._userInfoTextLoadingController.setUserNameHtmlText(param1);
        }
    }

    public function setStatus(param1:int):String {
        var _loc2_:String = IndicationOfStatus.STATUS_NORMAL;
        if (param1 < STATUSES.length && param1) {
            _loc2_ = STATUSES[param1];
        }
        this.statusIndicator.status = _loc2_;
        return _loc2_;
    }

    public function updateComponents():void {
        this.initControlsState();
        this._helper.updateComponents(this, this._slotData);
    }

    protected function initControlsState():void {
        this._helper.initControlsState(this);
    }

    protected function addTooltipSubscriber(param1:IEventDispatcher):void {
        param1.addEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
        param1.addEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
    }

    protected function removeTooltipSubscriber(param1:IEventDispatcher):void {
        param1.removeEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
        param1.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
    }

    protected function hideTooltip():void {
        App.toolTipMgr.hide();
    }

    public function get index():int {
        return this._index;
    }

    public function set index(param1:int):void {
        this._index = param1;
    }

    public function get slotData():IRallySlotVO {
        return this._slotData;
    }

    public function set slotData(param1:IRallySlotVO):void {
        if (param1 == null && this._userInfoTextLoadingController != null) {
            this._userInfoTextLoadingController.clearUserName();
            this._userInfoTextLoadingController.clearUserRating();
        }
        this._slotData = param1;
        invalidate(UPDATE_SLOT_DATA);
        validateNow();
    }

    public function get helper():ISlotRendererHelper {
        return this._helper;
    }

    public function set helper(param1:ISlotRendererHelper):void {
        this._helper = param1;
    }

    public function get userInfoTextLoadingController():UserInfoTextLoadingController {
        return this._userInfoTextLoadingController;
    }

    protected function onContextMenuAreaClickHandler(param1:MouseEvent):void {
        if (App.utils.commons.isRightButton(param1)) {
            this.onContextMenuAreaClick(param1);
        }
    }

    protected function onContextMenuAreaClick(param1:MouseEvent):void {
        var _loc2_:ExtendedUserVO = !!this._slotData ? this._slotData.player as ExtendedUserVO : null;
        if (_loc2_ && !UserTags.isCurrentPlayer(_loc2_.tags)) {
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.BASE_USER, this, _loc2_);
        }
    }

    protected function medallionDispatchEvent(param1:RallyViewsEvent):void {
        this._helper.onControlRollOver(InteractiveObject(param1.target), this, this._slotData, param1.data);
    }

    private function onControlRollOverHandler(param1:MouseEvent):void {
        this._helper.onControlRollOver(param1.currentTarget as InteractiveObject, this, this._slotData);
    }

    private function onMedallionRollOverHandler(param1:RallyViewsEvent):void {
        this.medallionDispatchEvent(param1);
    }

    private function onMedallionRollOutHandler(param1:Event):void {
        this.hideTooltip();
    }

    private function onTakePlaceClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new RallyViewsEvent(RallyViewsEvent.ASSIGN_SLOT_REQUEST, this.index));
    }

    private function onControlRollOutHandler(param1:Event):void {
        this.hideTooltip();
    }
}
}
