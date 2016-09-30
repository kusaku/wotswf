package net.wg.gui.lobby.training {
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.text.TextField;

import net.wg.data.VO.TrainingRoomRendererVO;
import net.wg.data.constants.Cursors;
import net.wg.data.constants.UserTags;
import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.components.controls.UserNameField;
import net.wg.gui.components.controls.VoiceWave;
import net.wg.infrastructure.interfaces.entity.IDropItem;
import net.wg.infrastructure.managers.ITooltipMgr;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.ListItemRenderer;
import scaleform.clik.data.ListData;
import scaleform.clik.utils.Constraints;

public class TrainingPlayerItemRenderer extends ListItemRenderer implements IDropItem {

    private static const GOLD_COLOR:Number = 16761699;

    private static const NAME_COLOR:Number = 13224374;

    private static const VEHICLE_COLOR:Number = 8092009;

    public var nameField:UserNameField;

    public var vehicleField:TextField;

    public var vehicleLevelField:TextField;

    public var stateField:TextField;

    public var iconLoader:UILoaderAlt;

    public var voiceWave:VoiceWave;

    private var _defColorTrans:ColorTransform;

    private var _isMouseOver:Boolean = false;

    private var _tooltipMgr:ITooltipMgr;

    public function TrainingPlayerItemRenderer() {
        super();
        this._tooltipMgr = App.toolTipMgr;
    }

    override public function setListData(param1:ListData):void {
        index = param1.index;
        this.selected = param1.selected;
    }

    override protected function configUI():void {
        super.configUI();
        if (!constraintsDisabled) {
            constraints.addElement(this.vehicleField.name, this.vehicleField, Constraints.LEFT);
            constraints.addElement(this.vehicleLevelField.name, this.vehicleLevelField, Constraints.LEFT);
            constraints.addElement(this.stateField.name, this.stateField, Constraints.RIGHT);
        }
        this._defColorTrans = this.iconLoader.transform.colorTransform;
        this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
        selectable = false;
        addEventListener(MouseEvent.MOUSE_DOWN, this.hideToolTip, false, 0, true);
        addEventListener(MouseEvent.ROLL_OUT, this.hideToolTip, false, 0, true);
        addEventListener(MouseEvent.ROLL_OVER, this.showToolTip, false, 0, true);
    }

    override protected function onDispose():void {
        removeEventListener(MouseEvent.MOUSE_DOWN, this.hideToolTip, false);
        removeEventListener(MouseEvent.ROLL_OUT, this.hideToolTip, false);
        removeEventListener(MouseEvent.ROLL_OVER, this.showToolTip, false);
        this._tooltipMgr = null;
        this.vehicleField = null;
        this.vehicleLevelField = null;
        this.stateField = null;
        this._defColorTrans = null;
        if (this.nameField) {
            this.nameField.dispose();
            this.nameField = null;
        }
        if (this.iconLoader) {
            this.iconLoader.dispose();
            this.iconLoader = null;
        }
        if (this.voiceWave) {
            this.voiceWave.dispose();
            this.voiceWave = null;
        }
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:TrainingRoomRendererVO = null;
        var _loc2_:String = null;
        var _loc3_:Array = null;
        var _loc4_:Point = null;
        super.draw();
        if (_baseDisposed) {
            return;
        }
        if (isInvalid(InvalidationType.DATA)) {
            if (data) {
                _loc1_ = TrainingRoomRendererVO(data);
                _loc2_ = _loc1_.icon;
                this.iconLoader.visible = _loc2_ != "";
                if (this.iconLoader.source != _loc2_ && _loc2_) {
                    this.iconLoader.source = _loc2_;
                }
                _loc3_ = _loc1_.tags;
                this.vehicleField.htmlText = _loc1_.vShortName;
                this.stateField.text = _loc1_.stateString;
                this.vehicleLevelField.text = String(_loc1_.vLevel);
                enabled = true;
                if (UserTags.isCurrentPlayer(_loc3_)) {
                    this.nameField.textColor = GOLD_COLOR;
                    this.vehicleField.textColor = GOLD_COLOR;
                    this.iconLoader.transform.colorTransform = App.colorSchemeMgr.getTransform(TrainingConstants.VEHICLE_YELLOW_COLOR_SCHEME_ALIAS);
                }
                else {
                    this.nameField.textColor = NAME_COLOR;
                    this.vehicleField.textColor = VEHICLE_COLOR;
                    this.iconLoader.transform.colorTransform = this._defColorTrans;
                }
                this.speak(_loc1_.isPlayerSpeaking, true);
                if (this.voiceWave) {
                    this.voiceWave.setMuted(UserTags.isMuted(_loc3_));
                }
                this.nameField.userVO = _loc1_;
                _loc4_ = new Point(mouseX, mouseY);
                _loc4_ = this.localToGlobal(_loc4_);
                if (this.hitTestPoint(_loc4_.x, _loc4_.y, true) && this._isMouseOver) {
                    this._tooltipMgr.show(TrainingRoomRendererVO(data).fullName);
                }
            }
            else {
                if (this.nameField) {
                    this.nameField.userVO = null;
                }
                if (this.vehicleField) {
                    this.vehicleField.text = "";
                }
                if (this.vehicleLevelField) {
                    this.vehicleLevelField.text = "";
                }
                if (this.stateField) {
                    this.stateField.text = "";
                }
                if (this.iconLoader) {
                    this.iconLoader.visible = false;
                }
                enabled = false;
                this.speak(false, true);
                if (this.voiceWave) {
                    this.voiceWave.setMuted(false);
                }
            }
        }
        if (isInvalid(InvalidationType.SIZE)) {
            if (!preventAutosizing) {
                alignForAutoSize();
                setActualSize(_width, _height);
            }
            if (!constraintsDisabled) {
                if (constraints) {
                    constraints.update(_width, _height);
                }
            }
        }
    }

    public function speak(param1:Boolean, param2:Boolean):void {
        if (param1) {
            param2 = false;
        }
        if (this.voiceWave) {
            this.voiceWave.setSpeaking(param1, param2);
        }
    }

    override public function set selected(param1:Boolean):void {
        if (_selectable) {
            super.selected = param1;
        }
    }

    public function get getCursorType():String {
        return Cursors.DRAG_OPEN;
    }

    override protected function handleMouseRelease(param1:MouseEvent):void {
        if (App.utils.commons.isRightButton(param1) && data) {
            this._tooltipMgr.hide();
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.PREBATTLE_USER, this, data);
        }
        super.handleMouseRelease(param1);
    }

    private function showToolTip(param1:MouseEvent):void {
        this._isMouseOver = true;
        if (data) {
            this._tooltipMgr.show(TrainingRoomRendererVO(data).fullName);
        }
    }

    private function hideToolTip(param1:MouseEvent):void {
        if (param1.type == MouseEvent.ROLL_OUT) {
            this._isMouseOver = false;
        }
        this._tooltipMgr.hide();
    }
}
}
