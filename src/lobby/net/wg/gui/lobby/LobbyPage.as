package net.wg.gui.lobby {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

import net.wg.data.Aliases;
import net.wg.data.constants.ContainerTypes;
import net.wg.data.constants.Cursors;
import net.wg.data.constants.DragType;
import net.wg.data.constants.Linkages;
import net.wg.gui.components.common.ticker.Ticker;
import net.wg.gui.events.LobbyEvent;
import net.wg.gui.lobby.header.LobbyHeader;
import net.wg.gui.lobby.messengerBar.MessengerBar;
import net.wg.gui.lobby.settings.config.ControlsFactory;
import net.wg.gui.notification.NotificationPopUpViewer;
import net.wg.gui.notification.ServiceMessagePopUp;
import net.wg.infrastructure.base.meta.ILobbyPageMeta;
import net.wg.infrastructure.base.meta.impl.LobbyPageMeta;
import net.wg.infrastructure.interfaces.IManagedContainer;
import net.wg.infrastructure.interfaces.entity.IDraggable;

import scaleform.clik.constants.ConstrainMode;
import scaleform.clik.constants.InvalidationType;
import scaleform.clik.utils.Constraints;

public class LobbyPage extends LobbyPageMeta implements IDraggable, ILobbyPageMeta {

    private static const TOP_SUB_VIEW_POSITION:Number = 53;

    public var vehicleHitArea:MovieClip = null;

    public var subViewContainer:IManagedContainer = null;

    public var header:LobbyHeader;

    public var messagePopupTemplate:ServiceMessagePopUp;

    public var notificationPopupViewer:NotificationPopUpViewer;

    public var messengerBar:MessengerBar;

    public var ticker:Ticker;

    public var tickerBg:Sprite;

    private var _dragOffsetX:Number = 0;

    private var _dragOffsetY:Number = 0;

    private var _tickerHeight:Number = 0;

    private var _resetDragParams:Boolean;

    public function LobbyPage() {
        super();
    }

    override public function getSubContainer():IManagedContainer {
        return this.subViewContainer;
    }

    override public function updateStage(param1:Number, param2:Number):void {
        var _loc3_:Number = NaN;
        _originalWidth = param1;
        _originalHeight = param2;
        setSize(param1, param2);
        this.ticker.y = this._tickerHeight - this.ticker.height >> 1;
        this.ticker.x = param1 - this.ticker.width >> 1;
        this.tickerBg.width = _originalWidth;
        this.vehicleHitArea.y = TOP_SUB_VIEW_POSITION + this._tickerHeight;
        this.vehicleHitArea.width = param1;
        this.vehicleHitArea.height = param2 - this.vehicleHitArea.y;
        this.messengerBar.updateStage(param1, param2);
        this.header.y = this._tickerHeight;
        if (this.subViewContainer) {
            this.subViewContainer.y = TOP_SUB_VIEW_POSITION + this._tickerHeight;
            _loc3_ = param2 - this.subViewContainer.y - this.messengerBar.height - this.messengerBar.paddingBottom + this.messengerBar.paddingTop;
            this.subViewContainer.updateStage(param1, _loc3_);
        }
        this.header.width = param1;
        if (this.notificationPopupViewer) {
            this.notificationPopupViewer.updateStage(param1, param2);
        }
    }

    override protected function configUI():void {
        super.configUI();
        App.stage.addEventListener(LobbyEvent.REGISTER_DRAGGING, this.onRegisterDraggingHandler);
        App.stage.addEventListener(LobbyEvent.UNREGISTER_DRAGGING, this.onUnregisterDraggingHandler);
        constraints = new Constraints(this, ConstrainMode.COUNTER_SCALE);
        this.ticker.isTickerVisible = App.globalVarsMgr.isShowTickerS();
        this.updateStage(App.appWidth, App.appHeight);
        this.messagePopupTemplate.dispose();
        this.messagePopupTemplate.parent.removeChild(this.messagePopupTemplate);
        this.messagePopupTemplate = null;
        this.vehicleHitArea.addEventListener(MouseEvent.ROLL_OVER, this.onVehicleHitAreaRollOverHandler);
        this.vehicleHitArea.addEventListener(MouseEvent.ROLL_OUT, this.onVehicleHitAreaRollOutHandler);
    }

    override protected function onSetModalFocus(param1:InteractiveObject):void {
        if (param1 == null) {
            setFocus(this.header.mainMenuButtonBar);
        }
        super.onSetModalFocus(param1);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            constraints.update(width, height);
        }
    }

    override protected function onPopulate():void {
        super.onPopulate();
        var _loc1_:Boolean = App.globalVarsMgr.isShowTickerS();
        this._tickerHeight = !!_loc1_ ? Number(this.ticker.tickerHeight) : Number(0);
        this.tickerBg.height = this._tickerHeight;
        this.tickerBg.visible = _loc1_;
        registerFlashComponentS(this.header, Aliases.LOBBY_HEADER);
        registerFlashComponentS(this.ticker, Aliases.TICKER);
        if (!this.notificationPopupViewer) {
            this.notificationPopupViewer = new NotificationPopUpViewer(App.utils.classFactory.getClass(Linkages.SERVICE_MESSAGES_POPUP));
            addChild(this.notificationPopupViewer);
            registerFlashComponentS(this.notificationPopupViewer, Aliases.SYSTEM_MESSAGES);
        }
        registerFlashComponentS(this.messengerBar, Aliases.MESSENGER_BAR);
        this.subViewContainer.manageSize = false;
        this.subViewContainer.type = ContainerTypes.SUBVIEW;
    }

    override protected function onDispose():void {
        App.stage.removeEventListener(LobbyEvent.REGISTER_DRAGGING, this.onRegisterDraggingHandler);
        App.stage.removeEventListener(LobbyEvent.UNREGISTER_DRAGGING, this.onUnregisterDraggingHandler);
        removeChild(this.notificationPopupViewer);
        this.vehicleHitArea.hit.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onHitAreaMouseWheelHandler);
        this.vehicleHitArea.removeEventListener(MouseEvent.ROLL_OVER, this.onVehicleHitAreaRollOverHandler);
        this.vehicleHitArea.removeEventListener(MouseEvent.ROLL_OUT, this.onVehicleHitAreaRollOutHandler);
        this.vehicleHitArea = null;
        this.subViewContainer = null;
        if (this.messagePopupTemplate) {
            this.messagePopupTemplate.dispose();
            this.messagePopupTemplate = null;
        }
        this.header = null;
        this.notificationPopupViewer = null;
        this.messengerBar = null;
        this.ticker = null;
        this.tickerBg = null;
        ControlsFactory.instance.dispose();
        super.onDispose();
    }

    public function as_closeHelpLayout():void {
        var _loc1_:InteractiveObject = InteractiveObject(this.subViewContainer.getTopmostView());
        if (_loc1_) {
            setFocus(_loc1_);
        }
    }

    public function as_showHelpLayout():void {
    }

    public function getDragType():String {
        return DragType.SOFT;
    }

    public function getHitArea():InteractiveObject {
        if (this.vehicleHitArea == null) {
            DebugUtils.LOG_WARNING("vehicleHitArea is null!");
            return this;
        }
        return this.vehicleHitArea.hit;
    }

    public function onDragging(param1:Number, param2:Number):void {
        var _loc3_:Number = !!this._resetDragParams ? Number(0) : Number(-(this._dragOffsetX - stage.mouseX));
        var _loc4_:Number = !!this._resetDragParams ? Number(0) : Number(-(this._dragOffsetY - stage.mouseY));
        this._resetDragParams = false;
        this._dragOffsetX = stage.mouseX;
        this._dragOffsetY = stage.mouseY;
        moveSpaceS(_loc3_, _loc4_, 0);
    }

    public function onEndDrag():void {
    }

    public function onStartDrag():void {
        this._dragOffsetX = stage.mouseX;
        this._dragOffsetY = stage.mouseY;
    }

    private function registerDraging():void {
        this.vehicleHitArea.hit.addEventListener(MouseEvent.MOUSE_WHEEL, this.onHitAreaMouseWheelHandler);
        App.cursor.registerDragging(this, Cursors.ROTATE);
    }

    private function unregisterDragging():void {
        this.vehicleHitArea.hit.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onHitAreaMouseWheelHandler);
        App.cursor.unRegisterDragging(this);
    }

    private function onVehicleHitAreaRollOverHandler(param1:MouseEvent):void {
        notifyCursorOver3dSceneS(true);
    }

    private function onVehicleHitAreaRollOutHandler(param1:MouseEvent):void {
        this._resetDragParams = true;
        notifyCursorOver3dSceneS(false);
    }

    private function onHitAreaMouseWheelHandler(param1:MouseEvent):void {
        moveSpaceS(0, 0, param1.delta * 200);
    }

    private function onRegisterDraggingHandler(param1:LobbyEvent):void {
        this.registerDraging();
    }

    private function onUnregisterDraggingHandler(param1:LobbyEvent):void {
        this.unregisterDragging();
    }
}
}
