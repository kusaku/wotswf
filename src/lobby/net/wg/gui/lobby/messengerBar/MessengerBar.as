package net.wg.gui.lobby.messengerBar {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.EventPhase;
import flash.events.MouseEvent;
import flash.geom.Point;

import net.wg.data.Aliases;
import net.wg.data.constants.Directions;
import net.wg.data.constants.Errors;
import net.wg.data.constants.Linkages;
import net.wg.data.constants.generated.CONTACTS_ALIASES;
import net.wg.data.constants.generated.VEHICLE_COMPARE_CONSTANTS;
import net.wg.gui.components.controls.IconTextBigButton;
import net.wg.gui.events.MessengerBarEvent;
import net.wg.gui.lobby.messengerBar.carousel.ChannelCarousel;
import net.wg.gui.lobby.vehicleCompare.controls.VehicleCompareAnim;
import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareAnimVO;
import net.wg.infrastructure.base.meta.IMessengerBarMeta;
import net.wg.infrastructure.base.meta.impl.MessengerBarMeta;
import net.wg.infrastructure.interfaces.IAbstractWindowView;
import net.wg.infrastructure.interfaces.IDAAPIModule;
import net.wg.infrastructure.interfaces.IManagedContent;
import net.wg.utils.helpLayout.HelpLayoutVO;
import net.wg.utils.helpLayout.IHelpLayoutComponent;

import scaleform.clik.constants.ConstrainMode;
import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.utils.Constraints;

public class MessengerBar extends MessengerBarMeta implements IMessengerBarMeta, IDAAPIModule, IHelpLayoutComponent {

    private static const BAR_HEIGHT:int = 45;

    private static const LAYOUT_INVALID:String = "layoutInv";

    private static const INV_VEHICLE_CMP_VISIBLE:String = "InvVehicleCmpVisible";

    private static const UNDERSCORE:String = "_";

    public var channelCarousel:ChannelCarousel;

    public var notificationListBtn:NotificationListButton;

    public var channelButton:IconTextBigButton;

    public var contactsListBtn:ButtonWithCounter;

    public var vehicleCompareCartBtn:ButtonWithCounter;

    public var bg:Sprite;

    public var mouseBlocker:Sprite;

    public var fakeChnlBtn:MovieClip;

    public var animPlacer:Sprite;

    private var _anim:VehicleCompareAnim;

    private var _stageDimensions:Point;

    private var _notificationListHelpLayoutId:String = "";

    private var _contactsChannelButtonHelpLayoutId:String = "";

    private var _channelCarouselHelpLayoutId:String = "";

    private var _paddingLeft:uint = 0;

    private var _paddingRight:uint = 0;

    private var _paddingBottom:uint = 0;

    private var _paddingTop:uint = 0;

    private var _vehicleCmpBtnVisible:Boolean = false;

    public function MessengerBar() {
        this._stageDimensions = new Point();
        super();
    }

    override protected function preInitialize():void {
        super.preInitialize();
        constraints = new Constraints(this, ConstrainMode.REFLOW);
    }

    override protected function onPopulate():void {
        super.onPopulate();
        registerFlashComponentS(this.notificationListBtn, Aliases.NOTIFICATION_LIST_BUTTON);
        registerFlashComponentS(this.contactsListBtn, Aliases.CONTACTS_LIST_BUTTON);
        registerFlashComponentS(this.vehicleCompareCartBtn, Aliases.VEHICLE_COMPARE_CART_BUTTON);
        registerFlashComponentS(this.channelCarousel, Aliases.CHANNEL_CAROUSEL);
        this.channelButton.addEventListener(ButtonEvent.CLICK, this.onChannelButtonClickHandler);
        this.contactsListBtn.addEventListener(ButtonEvent.CLICK, this.onContactsButtonClickHandler);
        this.vehicleCompareCartBtn.addEventListener(ButtonEvent.CLICK, this.onVehicleCmpBtnClickHandler);
        var _loc1_:Stage = App.stage;
        _loc1_.addEventListener(MessengerBarEvent.PIN_CHANNELS_WINDOW, this.onStagePinChannelsWindowHandler);
    }

    override protected function onDispose():void {
        this.fakeChnlBtn.removeEventListener(MouseEvent.ROLL_OVER, this.onFakeChnlBtnRollOverHandler);
        this.fakeChnlBtn.removeEventListener(MouseEvent.ROLL_OUT, this.onFakeChnlBtnRollOutHandler);
        this.fakeChnlBtn.removeEventListener(MouseEvent.CLICK, this.onFakeChnlBtnClickHandler);
        this.fakeChnlBtn = null;
        this.channelButton.removeEventListener(ButtonEvent.CLICK, this.onChannelButtonClickHandler);
        this.contactsListBtn.removeEventListener(ButtonEvent.CLICK, this.onContactsButtonClickHandler);
        this.vehicleCompareCartBtn.removeEventListener(ButtonEvent.CLICK, this.onVehicleCmpBtnClickHandler);
        var _loc1_:Stage = App.stage;
        _loc1_.removeEventListener(MessengerBarEvent.PIN_CHANNELS_WINDOW, this.onStagePinChannelsWindowHandler);
        this.channelCarousel = null;
        this.notificationListBtn = null;
        this.channelButton.dispose();
        this.channelButton = null;
        this.contactsListBtn = null;
        this.vehicleCompareCartBtn = null;
        this._stageDimensions = null;
        this._notificationListHelpLayoutId = null;
        this._contactsChannelButtonHelpLayoutId = null;
        this._channelCarouselHelpLayoutId = null;
        this.bg = null;
        this.mouseBlocker = null;
        if (this._anim) {
            this._anim.dispose();
            this._anim = null;
        }
        this.animPlacer = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.bg.visible = false;
        constraints.addElement(this.notificationListBtn.name, this.notificationListBtn, Constraints.RIGHT);
        constraints.addElement(this.channelButton.name, this.channelButton, Constraints.LEFT);
        constraints.addElement(this.fakeChnlBtn.name, this.fakeChnlBtn, Constraints.LEFT);
        constraints.addElement(this.contactsListBtn.name, this.contactsListBtn, Constraints.LEFT);
        constraints.addElement(this.vehicleCompareCartBtn.name, this.vehicleCompareCartBtn, Constraints.RIGHT);
        constraints.addElement(this.animPlacer.name, this.animPlacer, Constraints.RIGHT);
        this.animPlacer.mouseEnabled = false;
        this.animPlacer.mouseChildren = false;
        this.channelButton.enabled = !App.globalVarsMgr.isInRoamingS();
        this.channelButton.tooltip = TOOLTIPS.LOBY_MESSENGER_CHANNELS_BUTTON;
        this.fakeChnlBtn.visible = App.globalVarsMgr.isInRoamingS();
        this.fakeChnlBtn.addEventListener(MouseEvent.ROLL_OVER, this.onFakeChnlBtnRollOverHandler);
        this.fakeChnlBtn.addEventListener(MouseEvent.ROLL_OUT, this.onFakeChnlBtnRollOutHandler);
        this.fakeChnlBtn.addEventListener(MouseEvent.CLICK, this.onFakeChnlBtnClickHandler);
        this.fakeChnlBtn.x = this.channelButton.x;
        this.fakeChnlBtn.width = this.channelButton.width;
        this.fakeChnlBtn.height = this.channelButton.height;
        App.utils.helpLayout.registerComponent(this);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(LAYOUT_INVALID)) {
            y = this._stageDimensions.y - this.height - this.paddingBottom;
            x = this.paddingLeft;
            width = this._stageDimensions.x - this.paddingLeft - this.paddingRight;
            this.mouseBlocker.x = this.bg.x = -this.paddingLeft;
            this.mouseBlocker.width = this.bg.width = this._stageDimensions.x;
        }
        if (isInvalid(InvalidationType.SIZE)) {
            constraints.update(_width, _height);
            this.channelCarousel.x = !!this.channelButton ? Number(this.channelButton.x + this.channelButton.width) : !!this.channelButton ? Number(this.channelButton.x + this.channelButton.width) : Number(0);
            this.updateChannelCarouselWidth();
        }
        if (isInvalid(INV_VEHICLE_CMP_VISIBLE)) {
            this.vehicleCompareCartBtn.visible = this._vehicleCmpBtnVisible;
            this.updateChannelCarouselWidth();
        }
    }

    override protected function setInitData(param1:MessegerBarInitVO):void {
        this.channelButton.htmlIconStr = param1.channelsHtmlIcon;
        this.contactsListBtn.icon = param1.contactsHtmlIcon;
        this.contactsListBtn.tooltip = param1.contactsTooltip;
        this.vehicleCompareCartBtn.icon = param1.vehicleCompareHtmlIcon;
        this.vehicleCompareCartBtn.tooltip = param1.vehicleCompareTooltip;
    }

    override protected function showAddVehicleCompareAnim(param1:VehicleCompareAnimVO):void {
        this.createAnimIfNeed();
        this._anim.gotoAndStop(0);
        this._anim.visible = true;
        this._anim.setData(param1);
        this._anim.x = -this._anim.width >> 1;
        this.animPlacer.visible = true;
        this._anim.play();
    }

    public function as_openVehicleCompareCartPopover(param1:Boolean):void {
        if (param1) {
            this.showVehicleCmpPopover();
        }
        else if (this.vehicleCompareCartBtn == App.popoverMgr.popoverCaller.getTargetButton()) {
            App.popoverMgr.hide();
        }
    }

    public function as_setVehicleCompareCartButtonVisible(param1:Boolean):void {
        if (this._vehicleCmpBtnVisible != param1) {
            this._vehicleCmpBtnVisible = param1;
            invalidate(INV_VEHICLE_CMP_VISIBLE);
        }
    }

    public function getLayoutProperties():Vector.<HelpLayoutVO> {
        if (!this._notificationListHelpLayoutId) {
            this._notificationListHelpLayoutId = name + UNDERSCORE + Math.random();
        }
        if (!this._contactsChannelButtonHelpLayoutId) {
            this._contactsChannelButtonHelpLayoutId = name + UNDERSCORE + Math.random();
        }
        if (!this._channelCarouselHelpLayoutId) {
            this._channelCarouselHelpLayoutId = name + UNDERSCORE + Math.random();
        }
        var _loc1_:int = 7;
        var _loc2_:HelpLayoutVO = new HelpLayoutVO();
        _loc2_.x = this.notificationListBtn.x + _loc1_;
        _loc2_.y = this.notificationListBtn.y;
        _loc2_.width = this.notificationListBtn.width;
        _loc2_.height = this.notificationListBtn.height;
        _loc2_.extensibilityDirection = Directions.LEFT;
        _loc2_.message = LOBBY_HELP.CHAT_SERVICE_CHANNEL;
        _loc2_.id = this._notificationListHelpLayoutId;
        _loc2_.scope = this;
        var _loc3_:int = 1;
        var _loc4_:int = -2;
        var _loc5_:HelpLayoutVO = new HelpLayoutVO();
        _loc5_.x = this.contactsListBtn.x + _loc3_;
        _loc5_.y = this.contactsListBtn.y;
        _loc5_.width = this.channelButton.x + this.channelButton.width - this.contactsListBtn.x - (_loc3_ << 1);
        _loc5_.height = this.contactsListBtn.height + _loc4_;
        _loc5_.extensibilityDirection = Directions.LEFT;
        _loc5_.message = LOBBY_HELP.CHAT_CONTACTS_CHANNEL;
        _loc5_.id = this._contactsChannelButtonHelpLayoutId;
        _loc5_.scope = this;
        var _loc6_:int = 3;
        var _loc7_:int = 3;
        var _loc8_:int = -20;
        var _loc9_:int = -5;
        var _loc10_:HelpLayoutVO = new HelpLayoutVO();
        _loc10_.x = this.channelCarousel.x + _loc6_;
        _loc10_.y = this.channelCarousel.y + _loc7_;
        _loc10_.width = this.channelCarousel.width + _loc8_;
        _loc10_.height = this.channelCarousel.height + _loc9_;
        _loc10_.extensibilityDirection = Directions.LEFT;
        _loc10_.message = LOBBY_HELP.CHANNELCAROUSEL_CHANNELS;
        _loc10_.id = this._channelCarouselHelpLayoutId;
        _loc10_.scope = this;
        return new <HelpLayoutVO>[_loc2_, _loc5_, _loc10_];
    }

    public function updateStage(param1:Number, param2:Number):void {
        this._stageDimensions.x = param1;
        this._stageDimensions.y = param2;
        invalidate(LAYOUT_INVALID);
    }

    private function updateChannelCarouselWidth():void {
        var _loc1_:DisplayObject = !!this.vehicleCompareCartBtn.visible ? this.vehicleCompareCartBtn : this.notificationListBtn;
        this.channelCarousel.width = _loc1_.x - this.channelCarousel.x - 1;
    }

    private function handlePinWindow(param1:MessengerBarEvent, param2:DisplayObject):void {
        if (param1.eventPhase != EventPhase.BUBBLING_PHASE) {
            return;
        }
        var _loc3_:IAbstractWindowView = param1.target as IAbstractWindowView;
        App.utils.asserter.assertNotNull(_loc3_, "view" + Errors.CANT_NULL);
        var _loc4_:IManagedContent = _loc3_.window;
        var _loc5_:Point = localToGlobal(new Point(param2.x + WindowOffsetsInBar.WINDOW_LEFT_OFFSET, -_loc4_.height));
        _loc4_.x = _loc5_.x;
        _loc4_.y = _loc5_.y;
    }

    private function showVehicleCmpPopover():void {
        App.popoverMgr.show(this.vehicleCompareCartBtn, VEHICLE_COMPARE_CONSTANTS.VEHICLE_COMPARE_CART_POPOVER);
    }

    private function createAnimIfNeed():void {
        if (this._anim == null) {
            this._anim = App.utils.classFactory.getComponent(Linkages.VEHICLE_COMPARE_ANIM, VehicleCompareAnim);
            this._anim.addFrameScript(this._anim.totalFrames - 1, this.onAnimLastFlameCallback);
            this.animPlacer.addChild(this._anim);
        }
    }

    private function onAnimLastFlameCallback():void {
        this.animPlacer.visible = false;
    }

    override public function get height():Number {
        return BAR_HEIGHT;
    }

    public function get paddingLeft():uint {
        return this._paddingLeft;
    }

    public function set paddingLeft(param1:uint):void {
        this._paddingLeft = param1;
        invalidate(LAYOUT_INVALID);
    }

    public function get paddingRight():uint {
        return this._paddingRight;
    }

    public function set paddingRight(param1:uint):void {
        this._paddingRight = param1;
        invalidate(LAYOUT_INVALID);
    }

    public function get paddingBottom():uint {
        return this._paddingBottom;
    }

    public function set paddingBottom(param1:uint):void {
        this._paddingBottom = param1;
        invalidate(LAYOUT_INVALID);
    }

    public function get paddingTop():uint {
        return this._paddingTop;
    }

    public function set paddingTop(param1:uint):void {
        this._paddingTop = param1;
        invalidate(LAYOUT_INVALID);
    }

    private function onChannelButtonClickHandler(param1:ButtonEvent):void {
        channelButtonClickS();
    }

    private function onContactsButtonClickHandler(param1:ButtonEvent):void {
        App.popoverMgr.show(this.contactsListBtn, CONTACTS_ALIASES.CONTACTS_POPOVER);
    }

    private function onVehicleCmpBtnClickHandler(param1:ButtonEvent):void {
        this.showVehicleCmpPopover();
    }

    private function onStagePinChannelsWindowHandler(param1:MessengerBarEvent):void {
        this.handlePinWindow(param1, this.channelButton);
    }

    private function onFakeChnlBtnRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.show(TOOLTIPS.LOBY_MESSENGER_CHANNEL_BUTTON_INROAMING);
    }

    private function onFakeChnlBtnRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onFakeChnlBtnClickHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }
}
}
