package net.wg.gui.cyberSport.staticFormation.components.renderers {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.UserTags;
import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.data.constants.generated.FORMATION_MEMBER_TYPE;
import net.wg.gui.components.advanced.InviteIndicator;
import net.wg.gui.components.controls.ButtonIconTransparent;
import net.wg.gui.components.controls.Image;
import net.wg.gui.components.controls.TableRenderer;
import net.wg.gui.components.controls.helpers.UserInfoTextLoadingController;
import net.wg.gui.cyberSport.staticFormation.components.FormationAppointmentComponent;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStaffContextMenuVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStaffTableRendererVO;
import net.wg.gui.cyberSport.staticFormation.events.FormationAppointmentEvent;
import net.wg.gui.cyberSport.staticFormation.events.FormationStaffEvent;
import net.wg.infrastructure.interfaces.IUserProps;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class StaticFormationStaffTableRenderer extends TableRenderer {

    public var nameTf:TextField = null;

    public var removeMemberBtn:ButtonIconTransparent = null;

    public var appointmentCmp:FormationAppointmentComponent = null;

    public var waitingPlayerIndicator:InviteIndicator = null;

    public var ratingTf:TextField = null;

    public var battlesCountTf:TextField = null;

    public var damageCoefTf:TextField = null;

    public var avrDamageTf:TextField = null;

    public var avrAssistDamageTf:TextField = null;

    public var avrExperienceTf:TextField = null;

    public var tauntTf:TextField = null;

    public var joinDateTf:TextField = null;

    public var emptyTextTf:TextField = null;

    public var contextMenuArea:Sprite = null;

    public var statusIcon:Image = null;

    private var _userInfoTextLoadingController:UserInfoTextLoadingController = null;

    private var _rendererData:StaticFormationStaffTableRendererVO;

    public function StaticFormationStaffTableRenderer() {
        super();
        this._userInfoTextLoadingController = new UserInfoTextLoadingController();
    }

    private static function isHimself(param1:StaticFormationStaffTableRendererVO):Boolean {
        return UserTags.isCurrentPlayer(param1.userData.tags);
    }

    override public function setData(param1:Object):void {
        super.setData(param1);
        this._rendererData = param1 as StaticFormationStaffTableRendererVO;
        if (param1 != null) {
            App.utils.asserter.assertNotNull(this._rendererData, "data must be StaticFormationStaffTableRendererVO data: " + param1);
        }
        if (this._rendererData != null) {
            this.appointmentCmp.setData(this._rendererData.appointment);
            this.removeMemberBtn.iconSource = this._rendererData.removeMemberBtnIcon;
            this.removeMemberBtn.tooltip = this._rendererData.removeMemberBtnTooltip;
        }
        invalidateData();
    }

    override protected function configUI():void {
        super.configUI();
        isPassive = false;
        mouseChildren = true;
        this.emptyTextTf.htmlText = CYBERSPORT.STATICFORMATION_STAFFVIEW_STAFFTABLE_EMPTYRENDERER_TEXT;
        this.waitingPlayerIndicator.visible = false;
        this.contextMenuArea.addEventListener(MouseEvent.ROLL_OVER, this.onContextMenuAreaRollOverHandler);
        this.contextMenuArea.addEventListener(MouseEvent.ROLL_OUT, this.onContextMenuAreafRollOutHandler);
        this.contextMenuArea.addEventListener(MouseEvent.CLICK, this.onContextMenuAreaClickHandler);
        this.contextMenuArea.buttonMode = true;
        this.contextMenuArea.useHandCursor = true;
        this.removeMemberBtn.addEventListener(ButtonEvent.PRESS, this.onButtonPressHandler);
        this.appointmentCmp.addEventListener(FormationAppointmentEvent.PROMOTE_BUTTON_PRESS, this.onButtonPressHandler);
        this.appointmentCmp.addEventListener(FormationAppointmentEvent.DEMOTE_BUTTON_PRESS, this.onButtonPressHandler);
        App.utils.commons.updateChildrenMouseEnabled(this, false);
        this.removeMemberBtn.mouseEnabled = true;
        this.appointmentCmp.mouseEnabled = true;
        this.contextMenuArea.mouseEnabled = true;
        this._userInfoTextLoadingController.setControlledUserNameTextField(this.nameTf);
        this._userInfoTextLoadingController.setControlledUserRatingTextField(this.ratingTf);
    }

    override protected function draw():void {
        var _loc1_:* = false;
        var _loc2_:String = null;
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            _loc1_ = this._rendererData != null;
            this.removeMemberBtn.visible = _loc1_;
            this.appointmentCmp.visible = _loc1_;
            this.statusIcon.visible = _loc1_;
            if (this.nameTf.visible = _loc1_) {
                this.updateNameData();
            }
            else if (this._userInfoTextLoadingController != null) {
                this._userInfoTextLoadingController.setUserNameHtmlText("");
            }
            if (this._userInfoTextLoadingController != null) {
                _loc2_ = !!_loc1_ ? this._rendererData.rating : "";
                this._userInfoTextLoadingController.setUserRatingHtmlText(_loc2_);
            }
            this.battlesCountTf.htmlText = !!_loc1_ ? this._rendererData.battlesCount : "";
            this.damageCoefTf.htmlText = !!_loc1_ ? this._rendererData.damageCoef : "";
            this.avrDamageTf.htmlText = !!_loc1_ ? this._rendererData.avrDamage : "";
            this.avrAssistDamageTf.htmlText = !!_loc1_ ? this._rendererData.avrAssistDamage : "";
            this.avrExperienceTf.htmlText = !!_loc1_ ? this._rendererData.avrExperience : "";
            this.tauntTf.htmlText = !!_loc1_ ? this._rendererData.taunt : "";
            this.joinDateTf.htmlText = !!_loc1_ ? this._rendererData.joinDate : "";
            this.emptyTextTf.visible = !_loc1_;
            this.removeMemberBtn.visible = _loc1_ && this._rendererData.canRemoved;
            this.waitingPlayerIndicator.visible = _loc1_ && this._rendererData.appointment.memberType == FORMATION_MEMBER_TYPE.INVITEE;
            this.statusIcon.source = !!_loc1_ ? this._rendererData.statusIcon : "";
        }
    }

    override protected function onDispose():void {
        this.contextMenuArea.removeEventListener(MouseEvent.CLICK, this.onContextMenuAreaClickHandler);
        this.contextMenuArea.removeEventListener(MouseEvent.ROLL_OVER, this.onContextMenuAreaRollOverHandler);
        this.contextMenuArea.removeEventListener(MouseEvent.ROLL_OUT, this.onContextMenuAreafRollOutHandler);
        this.removeMemberBtn.removeEventListener(ButtonEvent.PRESS, this.onButtonPressHandler);
        this.appointmentCmp.removeEventListener(FormationAppointmentEvent.PROMOTE_BUTTON_PRESS, this.onButtonPressHandler);
        this.appointmentCmp.removeEventListener(FormationAppointmentEvent.DEMOTE_BUTTON_PRESS, this.onButtonPressHandler);
        this.removeMemberBtn.dispose();
        this.appointmentCmp.dispose();
        this.waitingPlayerIndicator.dispose();
        this.contextMenuArea = null;
        this.nameTf = null;
        this.removeMemberBtn = null;
        this.appointmentCmp = null;
        this._rendererData = null;
        this.waitingPlayerIndicator = null;
        this.battlesCountTf = null;
        this.damageCoefTf = null;
        this.avrDamageTf = null;
        this.avrAssistDamageTf = null;
        this.avrExperienceTf = null;
        this.tauntTf = null;
        this.joinDateTf = null;
        this.emptyTextTf = null;
        if (this._userInfoTextLoadingController != null) {
            this._userInfoTextLoadingController.dispose();
            this._userInfoTextLoadingController = null;
        }
        if (this.statusIcon != null) {
            this.statusIcon.dispose();
            this.statusIcon = null;
        }
        super.onDispose();
    }

    private function updateNameData():void {
        var _loc1_:IUserProps = App.utils.commons.getUserProps(this._rendererData.userData.userName, this._rendererData.userData.clanAbbrev, this._rendererData.userData.region, this._rendererData.userData.igrType, this._rendererData.userData.tags);
        var _loc2_:Boolean = isHimself(this._rendererData);
        _loc1_.rgb = this._rendererData.userData.colors[!!_loc2_ ? 0 : 1];
        this.contextMenuArea.mouseEnabled = !_loc2_;
        if (this._userInfoTextLoadingController != null) {
            this._userInfoTextLoadingController.setUserNameFromProps(_loc1_);
            if (this._userInfoTextLoadingController.getIsUserNameLoading()) {
                this.contextMenuArea.mouseEnabled = false;
            }
        }
    }

    private function getContextMenuData():StaticFormationStaffContextMenuVO {
        return new StaticFormationStaffContextMenuVO({
            "dbID": this._rendererData.userData.dbID,
            "userName": this._rendererData.userData.userName,
            "clubDbID": this._rendererData.clubDbID
        });
    }

    override public function set enabled(param1:Boolean):void {
        super.enabled = param1;
        mouseChildren = param1;
    }

    private function onContextMenuAreaRollOverHandler(param1:MouseEvent):void {
        if (this.nameTf.text != null && this.nameTf.text.length > 0) {
            App.toolTipMgr.show(this._rendererData.userData.userName);
        }
    }

    private function onContextMenuAreafRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onButtonPressHandler(param1:Event):void {
        var _loc2_:String = null;
        var _loc3_:Number = NaN;
        var _loc4_:String = null;
        switch (param1.type) {
            case ButtonEvent.PRESS:
                _loc2_ = FormationStaffEvent.REMOVE_MEMBER;
                break;
            case FormationAppointmentEvent.PROMOTE_BUTTON_PRESS:
                _loc2_ = FormationStaffEvent.PROMOTE_MEMBER;
                break;
            case FormationAppointmentEvent.DEMOTE_BUTTON_PRESS:
                _loc2_ = FormationStaffEvent.DEMOTE_MEMBER;
                break;
            default:
                return;
        }
        if (this._rendererData != null) {
            _loc3_ = this._rendererData.memberId;
            _loc4_ = this._rendererData.userData.userName;
            dispatchEvent(new FormationStaffEvent(_loc2_, _loc3_, _loc4_, true));
        }
    }

    private function onContextMenuAreaClickHandler(param1:MouseEvent):void {
        if (App.utils.commons.isRightButton(param1)) {
            if (this._rendererData != null && this._rendererData.canShowContextMenu) {
                App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.CLUB_STAFF, this, this.getContextMenuData());
            }
        }
    }
}
}
