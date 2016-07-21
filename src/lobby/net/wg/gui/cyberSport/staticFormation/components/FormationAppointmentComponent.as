package net.wg.gui.cyberSport.staticFormation.components {
import flash.events.MouseEvent;

import net.wg.data.constants.generated.FORMATION_MEMBER_TYPE;
import net.wg.gui.components.controls.ButtonIconBlack;
import net.wg.gui.components.controls.ButtonIconTransparent;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.cyberSport.staticFormation.data.FormationAppointmentVO;
import net.wg.gui.cyberSport.staticFormation.events.FormationAppointmentEvent;

import scaleform.clik.core.UIComponent;
import scaleform.clik.events.ButtonEvent;

public class FormationAppointmentComponent extends UIComponent {

    public var promoteBtn:ButtonIconBlack;

    public var demoteBtn:ButtonIconTransparent;

    public var officerIconLoader:UILoaderAlt;

    public var ownerIconLoader:UILoaderAlt;

    private var _data:FormationAppointmentVO;

    public function FormationAppointmentComponent() {
        super();
        this.clearView();
    }

    override protected function configUI():void {
        super.configUI();
        this.promoteBtn.addEventListener(ButtonEvent.PRESS, this.onPromoteButtonPress);
        this.demoteBtn.addEventListener(ButtonEvent.PRESS, this.onDemoteButtonPress);
        this.ownerIconLoader.addEventListener(MouseEvent.ROLL_OVER, this.onControlRoolOver);
        this.ownerIconLoader.addEventListener(MouseEvent.ROLL_OUT, this.onControlRoolOut);
        this.officerIconLoader.addEventListener(MouseEvent.ROLL_OVER, this.onControlRoolOver);
        this.officerIconLoader.addEventListener(MouseEvent.ROLL_OUT, this.onControlRoolOut);
    }

    public function setData(param1:FormationAppointmentVO):void {
        this._data = param1;
        this.clearView();
        if (this._data != null) {
            this.setView();
        }
    }

    private function setView():void {
        switch (this._data.memberType) {
            case FORMATION_MEMBER_TYPE.OFFICER:
                this.demoteBtn.tooltip = this._data.demoteBtnTooltip;
                this.demoteBtn.iconSource = this._data.demoteBtnIcon;
                this.demoteBtn.visible = this._data.canDemoted;
                this.officerIconLoader.source = this._data.officerIcon;
                this.officerIconLoader.visible = true;
                break;
            case FORMATION_MEMBER_TYPE.SOLDIER:
                this.promoteBtn.tooltip = this._data.promoteBtnTooltip;
                this.promoteBtn.iconSource = this._data.promoteBtnIcon;
                this.promoteBtn.visible = this._data.canPromoted;
                break;
            case FORMATION_MEMBER_TYPE.OWNER:
                this.ownerIconLoader.source = this._data.ownerIcon;
                this.ownerIconLoader.visible = true;
                break;
            case FORMATION_MEMBER_TYPE.INVITEE:
                break;
            default:
                App.utils.asserter.assert(false, "Unknown member type: " + this._data.memberType);
        }
        this.layout();
    }

    private function layout():void {
        var _loc1_:Number = NaN;
        var _loc2_:Number = NaN;
        var _loc3_:Number = NaN;
        if (this._data != null) {
            if (this._data.memberType == FORMATION_MEMBER_TYPE.OFFICER) {
                if (this.demoteBtn.visible) {
                    _loc1_ = 0;
                    _loc1_ = _loc1_ + this.demoteBtn.width;
                    _loc1_ = _loc1_ + this.officerIconLoader.originalWidth;
                    _loc2_ = (width - _loc1_) / 3;
                    _loc3_ = _loc2_;
                    this.officerIconLoader.x = Math.round(_loc3_);
                    _loc3_ = _loc3_ + (this.officerIconLoader.originalWidth + _loc2_);
                    this.demoteBtn.x = Math.round(_loc3_);
                }
                else {
                    this.officerIconLoader.x = (width - this.officerIconLoader.originalWidth) * 0.5;
                }
            }
            else if (this._data.memberType == FORMATION_MEMBER_TYPE.OWNER) {
                if (this.ownerIconLoader.visible) {
                    this.ownerIconLoader.x = (width - this.ownerIconLoader.originalWidth) * 0.5;
                }
            }
        }
    }

    private function clearView():void {
        this.promoteBtn.visible = false;
        this.demoteBtn.visible = false;
        this.officerIconLoader.visible = false;
        this.ownerIconLoader.visible = false;
    }

    private function onPromoteButtonPress(param1:ButtonEvent):void {
        dispatchEvent(new FormationAppointmentEvent(FormationAppointmentEvent.PROMOTE_BUTTON_PRESS));
    }

    private function onDemoteButtonPress(param1:ButtonEvent):void {
        dispatchEvent(new FormationAppointmentEvent(FormationAppointmentEvent.DEMOTE_BUTTON_PRESS));
    }

    private function onControlRoolOver(param1:MouseEvent):void {
        switch (param1.currentTarget) {
            case this.ownerIconLoader:
                App.toolTipMgr.showComplex(this._data.ownerIconTooltip);
                break;
            case this.officerIconLoader:
                App.toolTipMgr.showComplex(this._data.officerIconTooltip);
        }
    }

    private function onControlRoolOut(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    override protected function onDispose():void {
        this.promoteBtn.removeEventListener(ButtonEvent.PRESS, this.onPromoteButtonPress);
        this.demoteBtn.removeEventListener(ButtonEvent.PRESS, this.onDemoteButtonPress);
        this.ownerIconLoader.removeEventListener(MouseEvent.ROLL_OVER, this.onControlRoolOver);
        this.ownerIconLoader.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRoolOut);
        this.officerIconLoader.removeEventListener(MouseEvent.ROLL_OVER, this.onControlRoolOver);
        this.officerIconLoader.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRoolOut);
        this.promoteBtn.dispose();
        this.demoteBtn.dispose();
        this.officerIconLoader.dispose();
        this.ownerIconLoader.dispose();
        this.promoteBtn = null;
        this.demoteBtn = null;
        this.officerIconLoader = null;
        this.ownerIconLoader = null;
        this._data = null;
        super.onDispose();
    }
}
}
