package net.wg.gui.lobby.modulesPanel.components {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.gui.events.DeviceEvent;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.modulesPanel.data.OptionalDeviceVO;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.events.ButtonEvent;

public class OptDeviceFittingItemRenderer extends FittingListItemRenderer {

    private static const MAX_LINE_NUMBER:uint = 2;

    private static const DOTS:String = "...";

    public var removeButton:ISoundButtonEx;

    public var destroyButton:ISoundButtonEx;

    public var locked:MovieClip;

    public var descField:TextField;

    private var _optDevData:OptionalDeviceVO;

    public function OptDeviceFittingItemRenderer() {
        super();
    }

    override public function setData(param1:Object):void {
        super.setData(param1);
        this._optDevData = OptionalDeviceVO(param1);
    }

    override protected function onDispose():void {
        this.destroyButton.dispose();
        this.destroyButton = null;
        this.removeButton.dispose();
        this.removeButton = null;
        this.descField = null;
        this.locked = null;
        this._optDevData = null;
        super.onDispose();
    }

    override protected function onBeforeDispose():void {
        this.destroyButton.removeEventListener(ButtonEvent.CLICK, this.onDestroyButtonClickHandler);
        this.destroyButton.removeEventListener(MouseEvent.ROLL_OVER, this.onDestroyButtonRollOverHandler);
        this.destroyButton.removeEventListener(MouseEvent.ROLL_OUT, this.onDestroyButtonRollOutHandler);
        this.removeButton.removeEventListener(ButtonEvent.CLICK, this.onRemoveButtonClickHandler);
        this.removeButton.removeEventListener(MouseEvent.ROLL_OVER, this.onRemoveButtonRollOverHandler);
        this.removeButton.removeEventListener(MouseEvent.ROLL_OUT, this.onRemoveButtonRollOutHandler);
        super.onBeforeDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.destroyButton.focusTarget = this;
        this.destroyButton.addEventListener(ButtonEvent.CLICK, this.onDestroyButtonClickHandler);
        this.destroyButton.addEventListener(MouseEvent.ROLL_OVER, this.onDestroyButtonRollOverHandler);
        this.destroyButton.addEventListener(MouseEvent.ROLL_OUT, this.onDestroyButtonRollOutHandler);
        this.removeButton.focusTarget = this;
        this.removeButton.addEventListener(ButtonEvent.CLICK, this.onRemoveButtonClickHandler);
        this.removeButton.addEventListener(MouseEvent.ROLL_OVER, this.onRemoveButtonRollOverHandler);
        this.removeButton.addEventListener(MouseEvent.ROLL_OUT, this.onRemoveButtonRollOutHandler);
        this.locked.visible = false;
        this.locked.mouseEnabled = this.locked.mouseChildren = false;
        this.descField.mouseEnabled = false;
    }

    override protected function setup():void {
        var _loc1_:Boolean = false;
        var _loc2_:Boolean = false;
        super.setup();
        if (this._optDevData != null) {
            _loc1_ = this._optDevData.isSelected;
            _loc2_ = this._optDevData.removable;
            this.locked.visible = !_loc2_;
            this.destroyButton.visible = !_loc2_ && _loc1_;
            if (this.destroyButton.visible) {
                this.destroyButton.label = MENU.MODULEFITS_DESTROYNAME;
                this.destroyButton.validateNow();
            }
            this.removeButton.visible = _loc1_;
            if (this.removeButton.visible) {
                this.removeButton.label = MENU.MODULEFITS_REMOVENAME;
                this.removeButton.validateNow();
            }
            this.descField.visible = !_loc1_ && StringUtils.isNotEmpty(this._optDevData.desc);
            if (this.descField.visible) {
                this.setTruncatedHtmlText(this.descField, this._optDevData.desc, MAX_LINE_NUMBER);
                App.utils.commons.updateTextFieldSize(this.descField, false, true);
                layoutErrorField(this.descField);
            }
        }
    }

    private function setTruncatedHtmlText(param1:TextField, param2:String, param3:uint):void {
        var _loc4_:String = param2;
        this.descField.htmlText = _loc4_;
        while (param1.numLines > param3) {
            _loc4_ = _loc4_.substr(0, _loc4_.length - 1);
            this.descField.htmlText = _loc4_ + DOTS;
        }
    }

    private function mouseHitTest():Boolean {
        return hitTestPoint(App.stage.mouseX, App.stage.mouseY, true);
    }

    private function onDestroyButtonRollOverHandler(param1:MouseEvent):void {
        hideTooltip();
    }

    private function onDestroyButtonRollOutHandler(param1:MouseEvent):void {
        if (this.mouseHitTest()) {
            showItemTooltip();
        }
    }

    private function onRemoveButtonRollOverHandler(param1:MouseEvent):void {
        hideTooltip();
    }

    private function onRemoveButtonRollOutHandler(param1:MouseEvent):void {
        if (this.mouseHitTest()) {
            showItemTooltip();
        }
    }

    private function onDestroyButtonClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new DeviceEvent(DeviceEvent.DEVICE_DESTROY, this._optDevData.id));
    }

    private function onRemoveButtonClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new DeviceEvent(DeviceEvent.DEVICE_REMOVE, this._optDevData.id));
    }
}
}
