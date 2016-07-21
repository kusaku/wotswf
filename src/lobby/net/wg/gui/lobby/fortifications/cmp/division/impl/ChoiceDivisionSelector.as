package net.wg.gui.lobby.fortifications.cmp.division.impl {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.ComponentState;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.fortifications.data.FortChoiceDivisionSelectorVO;

import scaleform.clik.constants.InvalidationType;
import scaleform.gfx.TextFieldEx;

public class ChoiceDivisionSelector extends SoundButtonEx {

    private static const IMAGE_PADDING:int = 5;

    public var divisionName:TextField = null;

    public var divisionProfit:TextField = null;

    public var vehicleLevel:TextField = null;

    public var playerRange:TextField = null;

    public var playerRangeIcon:UILoaderAlt;

    public var playerCountHitArea:Sprite = null;

    public var border:MovieClip;

    private var _model:FortChoiceDivisionSelectorVO = null;

    public function ChoiceDivisionSelector() {
        super();
        doubleClickEnabled = true;
        preventAutosizing = true;
        constraintsDisabled = true;
        this.playerRangeIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_FORTIFICATION_HUMANS;
        this.playerRangeIcon.visible = false;
        useFocusedAsSelect = true;
        this.vehicleLevel.autoSize = TextFieldAutoSize.RIGHT;
        this.playerRange.autoSize = TextFieldAutoSize.RIGHT;
        TextFieldEx.setVerticalAlign(this.playerRange, TextFieldEx.VALIGN_CENTER);
    }

    public function setData(param1:FortChoiceDivisionSelectorVO):void {
        this._model = param1;
        this.divisionName.htmlText = param1.divisionName;
        this.divisionProfit.htmlText = param1.divisionProfit;
        this.vehicleLevel.htmlText = param1.vehicleLevel;
        this.playerRange.htmlText = param1.playerRange;
        this.updatePosition();
    }

    public function get divisionID():int {
        return this._model.divisionID;
    }

    override protected function onDispose():void {
        this.removeEventListener(MouseEvent.ROLL_OUT, this.onRollOutPlayerCountHandler);
        this.removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverPlayerCountHandler);
        this.removeEventListener(MouseEvent.MOUSE_MOVE, this.mouseMoveHandler);
        this.playerCountHitArea = null;
        this.playerRangeIcon.dispose();
        this.playerRangeIcon = null;
        this.divisionName = null;
        this.divisionProfit = null;
        this.vehicleLevel = null;
        this.playerRange = null;
        this.border = null;
        this._model = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.addEventListener(MouseEvent.ROLL_OUT, this.onRollOutPlayerCountHandler);
        this.addEventListener(MouseEvent.ROLL_OVER, this.onRollOverPlayerCountHandler);
    }

    override protected function draw():void {
        var _loc1_:String = _newFrame;
        super.draw();
        if (_loc1_ && isInvalid(InvalidationType.STATE)) {
            alpha = _loc1_ != ComponentState.DISABLED ? Number(ENABLED_ALPHA) : Number(DISABLED_ALPHA);
        }
    }

    private function updatePosition():void {
        this.vehicleLevel.x = Math.round(this.vehicleLevel.x);
        this.playerRangeIcon.x = Math.round(this.playerRange.x - this.playerRangeIcon.width + IMAGE_PADDING);
        this.playerRangeIcon.visible = true;
        this.playerCountHitArea.x = this.playerRangeIcon.x;
        this.playerCountHitArea.y = this.playerRangeIcon.y;
        this.playerCountHitArea.width = this.playerRangeIcon.width + this.playerRange.width + IMAGE_PADDING;
        this.playerCountHitArea.height = this.playerRangeIcon.height;
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        super.handleMouseRollOver(param1);
        if (!param1.buttonDown && enabled) {
            setState(ComponentState.OVER);
        }
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        super.handleMouseRollOut(param1);
        if (!param1.buttonDown && enabled) {
            setState(ComponentState.OUT);
        }
    }

    private function onRollOutPlayerCountHandler(param1:MouseEvent):void {
        this.removeEventListener(MouseEvent.MOUSE_MOVE, this.mouseMoveHandler);
        App.toolTipMgr.hide();
    }

    private function onRollOverPlayerCountHandler(param1:MouseEvent):void {
        this.addEventListener(MouseEvent.MOUSE_MOVE, this.mouseMoveHandler);
    }

    private function mouseMoveHandler(param1:MouseEvent):void {
        var _loc2_:Point = new Point(mouseX, mouseY);
        _loc2_ = localToGlobal(_loc2_);
        if (this.playerCountHitArea.hitTestPoint(_loc2_.x, _loc2_.y, true)) {
            App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_CHOICEDIVISION_PLAYERRANGE);
        }
        else {
            App.toolTipMgr.hide();
        }
    }
}
}
