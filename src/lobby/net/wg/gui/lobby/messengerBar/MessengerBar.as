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
import net.wg.data.constants.generated.CONTACTS_ALIASES;
import net.wg.gui.components.controls.IconTextBigButton;
import net.wg.gui.events.MessengerBarEvent;
import net.wg.gui.lobby.messengerBar.carousel.ChannelCarousel;
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

    private static const LAYOUT_INVALID:String = "layoutInv";

    public var channelCarousel:ChannelCarousel;

    public var notificationListBtn:NotificationListButton;

    public var channelButton:IconTextBigButton;

    public var contactsListBtn:ContactsListButton;

    public var bg:Sprite;

    public var mouseBlocker:Sprite;

    public var fakeChnlBtn:MovieClip;

    private var _stageDimensions:Point;

    private var _paddingLeft:uint = 0;

    private var _paddingRight:uint = 0;

    private var _paddingBottom:uint = 0;

    private var _notificationListHelpLayoutId:String = "";

    private var _contactsChannelButtonHelpLayoutId:String = "";

    private var _channelCarouselHelpLayoutId:String = "";

    private var _paddingTop:uint = 0;

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
        registerFlashComponentS(this.channelCarousel, Aliases.CHANNEL_CAROUSEL);
        this.channelButton.addEventListener(ButtonEvent.CLICK, this.onChannelButtonClickHandler);
        this.contactsListBtn.addEventListener(ButtonEvent.CLICK, this.onContactsButtonClickHandler);
        var _loc1_:Stage = App.stage;
        _loc1_.addEventListener(MessengerBarEvent.PIN_CHANNELS_WINDOW, this.onPinChannelsWindowHandler);
    }

    override protected function onDispose():void {
        this.fakeChnlBtn.removeEventListener(MouseEvent.ROLL_OVER, this.onShowInRoamingTooltipHandler);
        this.fakeChnlBtn.removeEventListener(MouseEvent.ROLL_OUT, this.onHideInRoamingTooltipHandler);
        this.fakeChnlBtn.removeEventListener(MouseEvent.CLICK, this.onHideInRoamingTooltipHandler);
        this.fakeChnlBtn = null;
        this.channelButton.removeEventListener(ButtonEvent.CLICK, this.onChannelButtonClickHandler);
        this.contactsListBtn.removeEventListener(ButtonEvent.CLICK, this.onContactsButtonClickHandler);
        var _loc1_:Stage = App.stage;
        _loc1_.removeEventListener(MessengerBarEvent.PIN_CHANNELS_WINDOW, this.onPinChannelsWindowHandler);
        this.channelCarousel = null;
        this.notificationListBtn = null;
        this.channelButton.dispose();
        this.channelButton = null;
        this.contactsListBtn = null;
        this._stageDimensions = null;
        this._notificationListHelpLayoutId = null;
        this._contactsChannelButtonHelpLayoutId = null;
        this._channelCarouselHelpLayoutId = null;
        this.bg = null;
        this.mouseBlocker = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.bg.visible = false;
        constraints.addElement(this.notificationListBtn.name, this.notificationListBtn, Constraints.RIGHT);
        constraints.addElement(this.channelButton.name, this.channelButton, Constraints.LEFT);
        constraints.addElement(this.fakeChnlBtn.name, this.fakeChnlBtn, Constraints.LEFT);
        constraints.addElement(this.contactsListBtn.name, this.contactsListBtn, Constraints.LEFT);
        this.channelButton.enabled = !App.globalVarsMgr.isInRoamingS();
        this.channelButton.tooltip = TOOLTIPS.LOBY_MESSENGER_CHANNELS_BUTTON;
        this.fakeChnlBtn.visible = App.globalVarsMgr.isInRoamingS();
        this.fakeChnlBtn.addEventListener(MouseEvent.ROLL_OVER, this.onShowInRoamingTooltipHandler);
        this.fakeChnlBtn.addEventListener(MouseEvent.ROLL_OUT, this.onHideInRoamingTooltipHandler);
        this.fakeChnlBtn.addEventListener(MouseEvent.CLICK, this.onHideInRoamingTooltipHandler);
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
            this.channelCarousel.width = this.notificationListBtn.x - this.channelCarousel.x - 1;
        }
    }

    public function as_setInitData(param1:Object):void {
        this.channelButton.htmlIconStr = param1.channelsHtmlIcon;
        this.contactsListBtn.contactsButton.htmlIconStr = param1.contactsHtmlIcon;
    }

    public function getLayoutProperties():Vector.<HelpLayoutVO> {
        if (!this._notificationListHelpLayoutId) {
            this._notificationListHelpLayoutId = name + "_" + Math.random();
        }
        if (!this._contactsChannelButtonHelpLayoutId) {
            this._contactsChannelButtonHelpLayoutId = name + "_" + Math.random();
        }
        if (!this._channelCarouselHelpLayoutId) {
            this._channelCarouselHelpLayoutId = name + "_" + Math.random();
        }
        var _loc1_:HelpLayoutVO = new HelpLayoutVO();
        _loc1_.x = this.notificationListBtn.x;
        _loc1_.y = this.notificationListBtn.y;
        _loc1_.width = this.notificationListBtn.width;
        _loc1_.height = this.notificationListBtn.height;
        _loc1_.extensibilityDirection = Directions.LEFT;
        _loc1_.message = LOBBY_HELP.CHAT_SERVICE_CHANNEL;
        _loc1_.id = this._notificationListHelpLayoutId;
        _loc1_.scope = this;
        var _loc2_:int = 1;
        var _loc3_:int = -2;
        var _loc4_:HelpLayoutVO = new HelpLayoutVO();
        _loc4_.x = this.contactsListBtn.x + _loc2_;
        _loc4_.y = this.contactsListBtn.y;
        _loc4_.width = this.channelButton.x + this.channelButton.width - this.contactsListBtn.x - (_loc2_ << 1);
        _loc4_.height = this.contactsListBtn.height + _loc3_;
        _loc4_.extensibilityDirection = Directions.LEFT;
        _loc4_.message = LOBBY_HELP.CHAT_CONTACTS_CHANNEL;
        _loc4_.id = this._contactsChannelButtonHelpLayoutId;
        _loc4_.scope = this;
        var _loc5_:int = 3;
        var _loc6_:int = 3;
        var _loc7_:int = -20;
        var _loc8_:int = -5;
        var _loc9_:HelpLayoutVO = new HelpLayoutVO();
        _loc9_.x = this.channelCarousel.x + _loc5_;
        _loc9_.y = this.channelCarousel.y + _loc6_;
        _loc9_.width = this.channelCarousel.width + _loc7_;
        _loc9_.height = this.channelCarousel.height + _loc8_;
        _loc9_.extensibilityDirection = Directions.LEFT;
        _loc9_.message = LOBBY_HELP.CHANNELCAROUSEL_CHANNELS;
        _loc9_.id = this._channelCarouselHelpLayoutId;
        _loc9_.scope = this;
        return new <HelpLayoutVO>[_loc1_, _loc4_, _loc9_];
    }

    public function updateStage(param1:Number, param2:Number):void {
        this._stageDimensions.x = param1;
        this._stageDimensions.y = param2;
        invalidate(LAYOUT_INVALID);
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

    private function onPinChannelsWindowHandler(param1:MessengerBarEvent):void {
        this.handlePinWindow(param1, this.channelButton);
    }

    private function onShowInRoamingTooltipHandler(param1:MouseEvent):void {
        App.toolTipMgr.show(TOOLTIPS.LOBY_MESSENGER_CHANNEL_BUTTON_INROAMING);
    }

    private function onHideInRoamingTooltipHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }
}
}
