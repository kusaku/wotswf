package net.wg.gui.lobby.fortifications.cmp.drctn.impl {
import flash.display.BlendMode;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

import net.wg.gui.lobby.fortifications.data.ConnectedDirectionsVO;
import net.wg.infrastructure.base.UIComponentEx;

public class ConnectedDirctns extends UIComponentEx {

    public var leftDirection:DirectionCmp;

    public var rightDirection:DirectionCmp;

    public var connectionIcon:AnimatedIcon;

    public var connectionRoad:Sprite;

    public var connectionAnimation:MovieClip;

    private var _model:ConnectedDirectionsVO;

    private var _isConnectedDirectionVisible:Boolean = true;

    public function ConnectedDirctns() {
        super();
        this.connectionAnimation.blendMode = BlendMode.ADD;
        this.connectionAnimation.visible = false;
    }

    override protected function configUI():void {
        super.configUI();
        this.leftDirection.layout = DirectionCmp.LAYOUT_LEFT_RIGHT;
        this.leftDirection.disableLowLevelBuildings = true;
        this.rightDirection.layout = DirectionCmp.LAYOUT_RIGHT_LEFT;
        this.rightDirection.disableLowLevelBuildings = true;
        this.connectionIcon.addEventListener(MouseEvent.ROLL_OVER, this.onConnectionIconRollOverHandler);
        this.connectionIcon.addEventListener(MouseEvent.ROLL_OUT, this.onConnectionIconRollOutHandler);
    }

    override protected function onDispose():void {
        this.connectionIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onConnectionIconRollOverHandler);
        this.connectionIcon.removeEventListener(MouseEvent.ROLL_OUT, this.onConnectionIconRollOutHandler);
        this.connectionIcon.dispose();
        this.connectionIcon = null;
        this.leftDirection.dispose();
        this.leftDirection = null;
        this.rightDirection.dispose();
        this.rightDirection = null;
        this.connectionRoad = null;
        this.connectionAnimation = null;
        this._model = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:* = false;
        var _loc2_:Boolean = false;
        super.draw();
        if (this._model) {
            _loc1_ = this._model.leftDirection != null;
            this.leftDirection.visible = _loc1_;
            if (_loc1_) {
                this.leftDirection.setData(this._model.leftDirection);
            }
            _loc2_ = this._isConnectedDirectionVisible && this._model.rightDirection != null;
            this.rightDirection.visible = _loc2_;
            this.rightDirection.setData(this._model.rightDirection);
            this.connectionIcon.iconSource = this._model.connectionIcon;
        }
        else {
            this.leftDirection.visible = false;
            this.rightDirection.visible = false;
        }
    }

    public function setData(param1:ConnectedDirectionsVO):void {
        this._model = param1;
        invalidateData();
    }

    public function showHideConnectedDirection(param1:Boolean):void {
        this._isConnectedDirectionVisible = param1;
        this.rightDirection.visible = param1;
        this.connectionRoad.visible = param1;
        this.connectionIcon.visible = param1;
    }

    public function showHideConnectionAnimation(param1:Boolean):void {
        if (param1) {
            this.connectionAnimation.gotoAndPlay(0);
            this.connectionAnimation.visible = true;
            this.connectionIcon.playFadeIn();
        }
        else {
            this.connectionAnimation.visible = false;
            this.connectionIcon.visible = false;
        }
    }

    private function onConnectionIconRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onConnectionIconRollOverHandler(param1:MouseEvent):void {
        if (this._model) {
            App.toolTipMgr.showComplex(this._model.connectionIconTooltip);
        }
    }
}
}
