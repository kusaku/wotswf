package net.wg.gui.lobby.tankman {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.gui.components.controls.AlertIco;
import net.wg.gui.components.controls.RadioButton;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.tankman.vo.RoleChangeItemVO;
import net.wg.infrastructure.interfaces.ISpriteEx;

public class RoleChangeItem extends Sprite implements ISpriteEx {

    private static var ALERT_OFFSET_X:int = 10;

    private static var ALPHA_DISABLED:Number = 0.5;

    private static var ALPHA_ENABLED:Number = 1;

    public var radioButton:RadioButton;

    public var roleIcon:UILoaderAlt;

    public var roleName:TextField;

    public var alert:AlertIco;

    public var disabledTipBox:Sprite;

    private var _tooltip:String = "";

    private var _alertHeader:String = "";

    private var _alertBody:String = "";

    private var _roleId:String;

    public function RoleChangeItem() {
        super();
        this.disabledTipBox.addEventListener(MouseEvent.ROLL_OVER, this.onHitboxRollOver);
        this.disabledTipBox.addEventListener(MouseEvent.ROLL_OUT, this.onHitboxRollOut);
        this.alert.addEventListener(MouseEvent.ROLL_OVER, this.onAlertRollOver);
        this.alert.addEventListener(MouseEvent.ROLL_OUT, this.onAlertRollOut);
    }

    public function dispose():void {
        this.disabledTipBox.removeEventListener(MouseEvent.ROLL_OVER, this.onHitboxRollOver);
        this.disabledTipBox.removeEventListener(MouseEvent.ROLL_OUT, this.onHitboxRollOut);
        this.alert.removeEventListener(MouseEvent.ROLL_OVER, this.onAlertRollOver);
        this.alert.removeEventListener(MouseEvent.ROLL_OUT, this.onAlertRollOut);
        this.roleIcon.dispose();
        this.roleIcon = null;
        this.roleName = null;
        this.radioButton.dispose();
        this.radioButton = null;
        this.alert.dispose();
        this.alert = null;
        this.disabledTipBox = null;
    }

    public function update(param1:Object):void {
        var _loc2_:RoleChangeItemVO = RoleChangeItemVO(param1);
        this._roleId = _loc2_.id;
        this.roleName.text = _loc2_.name;
        this.roleIcon.source = _loc2_.icon;
        this.alert.visible = _loc2_.warningHeader.length > 0;
        if (this.alert.visible) {
            this.alert.x = this.roleName.x + this.roleName.textWidth + ALERT_OFFSET_X;
            this.disabledTipBox.width = this.alert.x - this.disabledTipBox.x;
            this.radioButton.width = this.alert.x - this.radioButton.x;
        }
        else {
            this.radioButton.width = this.roleName.x + this.roleName.textWidth;
        }
        this._alertHeader = _loc2_.warningHeader;
        this._alertBody = _loc2_.warningBody;
        this.enabled = _loc2_.available;
    }

    public function get roleId():String {
        return this._roleId;
    }

    public function get selected():Boolean {
        return this.radioButton.selected;
    }

    public function set selected(param1:Boolean):void {
        this.radioButton.selected = param1;
    }

    public function get enabled():Boolean {
        return this.radioButton.enabled;
    }

    public function set enabled(param1:Boolean):void {
        this.radioButton.enabled = param1;
        this._tooltip = !!param1 ? "" : TOOLTIPS.ROLECHANGE_CURRENTROLEWARNING;
        this.roleIcon.alpha = !!param1 ? Number(ALPHA_ENABLED) : Number(ALPHA_DISABLED);
        this.roleName.alpha = !!param1 ? Number(1) : Number(0.5);
        this.disabledTipBox.mouseEnabled = !param1;
        this.disabledTipBox.visible = !param1;
    }

    private function onAlertRollOut(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onAlertRollOver(param1:MouseEvent):void {
        var _loc2_:String = null;
        if (this._alertHeader.length > 0) {
            _loc2_ = App.toolTipMgr.getNewFormatter().addHeader(this._alertHeader).addBody(this._alertBody).make();
            App.toolTipMgr.showComplex(_loc2_);
        }
    }

    private function onHitboxRollOut(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onHitboxRollOver(param1:MouseEvent):void {
        if (this._tooltip.length > 0) {
            App.toolTipMgr.showComplex(this._tooltip);
        }
    }
}
}
