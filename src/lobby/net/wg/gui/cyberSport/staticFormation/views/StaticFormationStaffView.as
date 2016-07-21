package net.wg.gui.cyberSport.staticFormation.views {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.Linkages;
import net.wg.data.constants.SortingInfo;
import net.wg.gui.components.common.SeparatorAsset;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.SortableTable;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStaffViewHeaderVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStaffViewStaffVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStaffViewStaticHeaderVO;
import net.wg.gui.cyberSport.staticFormation.events.FormationStaffEvent;
import net.wg.gui.lobby.fortifications.utils.impl.FortCommonUtils;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.base.meta.IStaticFormationStaffViewMeta;
import net.wg.infrastructure.base.meta.impl.StaticFormationStaffViewMeta;
import net.wg.infrastructure.interfaces.IPopOverCaller;
import net.wg.infrastructure.interfaces.IViewStackContent;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;

public class StaticFormationStaffView extends StaticFormationStaffViewMeta implements IStaticFormationStaffViewMeta, IViewStackContent, IPopOverCaller {

    private static const DEFAULT_SORT_VALUE:String = "appointmentSortValue";

    private static const MIDDLE_COLUMN_WIDTH:int = 70;

    private static const NAME_COLUMN_WIDTH:int = 173;

    private static const POST_COLUMN_WIDTH:int = 126;

    private static const JOIN_DATE_COLUMN_WIDTH:int = 122;

    private static const LAST_COLUMN_WIDTH:int = 40;

    private static const CHECK_BOX_DEFAULT_COLOR:Number = 9868935;

    private static const CHECK_BOX_ALERT_COLOR:Number = 15626240;

    public var lblTitle:TextField = null;

    public var lblDescription:TextField = null;

    public var lblStaffed:TextField = null;

    public var btnInvite:SoundButtonEx = null;

    public var btnRecruitment:SoundButtonEx = null;

    public var btnRemove:SoundButtonEx = null;

    public var cbOpened:CheckBox = null;

    public var staffTable:SortableTable = null;

    public var tableSeparator:SeparatorAsset = null;

    public var arrow:UIComponentEx = null;

    private var _lblStaffedTooltip:String = "";

    private var _btnRecruitmentDefX:Number = NaN;

    public function StaticFormationStaffView() {
        super();
        this.tableSeparator.setCenterAsset(Linkages.SEPARATOR_UI);
        this.arrow.visible = false;
    }

    override protected function configUI():void {
        super.configUI();
        this.btnInvite.mouseEnabledOnDisabled = true;
        this.cbOpened.addEventListener(Event.SELECT, this.onCbOpenedSelectHandler);
        this.btnInvite.addEventListener(ButtonEvent.PRESS, this.onBtnInvitePressHandler);
        this.btnRecruitment.addEventListener(ButtonEvent.PRESS, this.onBtnRecruitmentPressHandler);
        this.btnRemove.addEventListener(MouseEvent.CLICK, this.onBtnRemoveClickHandler);
        this.staffTable.addEventListener(FormationStaffEvent.PROMOTE_MEMBER, this.onStaffTablePromoteMemberHandler);
        this.staffTable.addEventListener(FormationStaffEvent.DEMOTE_MEMBER, this.onStaffTableDemoteMemberHandler);
        this.staffTable.addEventListener(FormationStaffEvent.REMOVE_MEMBER, this.onStaffTableRemoveMemberHandler);
        this.staffTable.sortByField(DEFAULT_SORT_VALUE, SortingInfo.ASCENDING_SORT);
        this.lblStaffed.addEventListener(MouseEvent.MOUSE_OVER, this.onLblStaffedMouseOverHandler);
        this.lblStaffed.addEventListener(MouseEvent.MOUSE_OUT, this.onLblStaffedMouseOutHandler);
        this._btnRecruitmentDefX = this.btnRecruitment.x;
    }

    override protected function onDispose():void {
        this.staffTable.removeEventListener(FormationStaffEvent.PROMOTE_MEMBER, this.onStaffTablePromoteMemberHandler);
        this.staffTable.removeEventListener(FormationStaffEvent.DEMOTE_MEMBER, this.onStaffTableDemoteMemberHandler);
        this.staffTable.removeEventListener(FormationStaffEvent.REMOVE_MEMBER, this.onStaffTableRemoveMemberHandler);
        this.cbOpened.removeEventListener(Event.SELECT, this.onCbOpenedSelectHandler);
        this.btnInvite.removeEventListener(ButtonEvent.PRESS, this.onBtnInvitePressHandler);
        this.btnRecruitment.removeEventListener(ButtonEvent.PRESS, this.onBtnRecruitmentPressHandler);
        this.btnRemove.removeEventListener(MouseEvent.CLICK, this.onBtnRemoveClickHandler);
        this.lblStaffed.removeEventListener(MouseEvent.MOUSE_OVER, this.onLblStaffedMouseOverHandler);
        this.lblStaffed.removeEventListener(MouseEvent.MOUSE_OUT, this.onLblStaffedMouseOutHandler);
        this.btnInvite.dispose();
        this.btnRecruitment.dispose();
        this.cbOpened.dispose();
        this.staffTable.dispose();
        this.tableSeparator.dispose();
        this.arrow.dispose();
        this.lblTitle = null;
        this.lblDescription = null;
        this.btnInvite = null;
        this.btnRecruitment = null;
        this.cbOpened = null;
        this.staffTable = null;
        this.tableSeparator = null;
        this.arrow = null;
        super.onDispose();
    }

    override protected function setStaticHeaderData(param1:StaticFormationStaffViewStaticHeaderVO):void {
        this.lblTitle.htmlText = param1.lblTitleText;
        this.lblDescription.htmlText = param1.lblDescriptionText;
        this.lblStaffed.htmlText = param1.lblStaffedText;
        this._lblStaffedTooltip = param1.lblStaffedTooltip;
        this.btnRecruitment.label = param1.btnRecruitmentText;
        this.btnRecruitment.tooltip = param1.btnRecruitmentTooltip;
        this.btnInvite.label = param1.btnInviteText;
        this.btnRemove.label = param1.btnRemoveText;
        this.btnRemove.tooltip = param1.btnRemoveTooltip;
        this.cbOpened.label = param1.cbOpenedText;
        this.staffTable.headerDP = new DataProvider(App.utils.data.vectorToArray(param1.tableHeader));
    }

    override protected function updateHeaderData(param1:StaticFormationStaffViewHeaderVO):void {
        this.cbOpened.removeEventListener(Event.SELECT, this.onCbOpenedSelectHandler);
        this.cbOpened.visible = param1.cbOpenedVisible;
        this.lblDescription.visible = param1.lblDescriptionVisible;
        this.btnRemove.visible = param1.btnRemoveVisible;
        this.btnInvite.tooltip = param1.btnInviteTooltip;
        this.btnInvite.visible = param1.btnInviteVisible;
        this.btnInvite.enabled = param1.btnInviteEnable;
        this.lblStaffed.visible = param1.lblStaffedVisible;
        this.btnRecruitment.visible = param1.btnRecruitmentVisible;
        this.setArrowAnimation(param1.showInviteBtnAnimation);
        this.cbOpened.selected = !param1.isRecruitmentOpened;
        if (this.cbOpened.selected && param1.isCheckBoxPressed) {
            this.cbOpened.textColor = CHECK_BOX_ALERT_COLOR;
        }
        else {
            this.cbOpened.textColor = CHECK_BOX_DEFAULT_COLOR;
        }
        this.btnRecruitment.x = !!this.btnInvite.visible ? Number(this._btnRecruitmentDefX) : Number(this.btnInvite.x);
        this.cbOpened.addEventListener(Event.SELECT, this.onCbOpenedSelectHandler);
    }

    override protected function updateStaffData(param1:StaticFormationStaffViewStaffVO):void {
        this.staffTable.listSelectedIndex = -1;
        this.staffTable.listDP.cleanUp();
        var _loc2_:Boolean = param1 != null && param1.hasMembers();
        if (_loc2_) {
            this.staffTable.listDP = new DataProvider(param1.members);
        }
        else {
            this.staffTable.listDP = new DataProvider([]);
        }
        this.staffTable.validateNow();
    }

    public function as_setRecruitmentAvailability(param1:Boolean):void {
        this.cbOpened.enabled = param1;
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return this;
    }

    public function getHitArea():DisplayObject {
        return this.btnRecruitment;
    }

    public function getTargetButton():DisplayObject {
        return this.btnRecruitment;
    }

    public function update(param1:Object):void {
    }

    private function setArrowAnimation(param1:Boolean):void {
        this.arrow.visible = param1;
        FortCommonUtils.instance.updateTutorialArrow(param1, this.arrow);
    }

    private function onStaffTablePromoteMemberHandler(param1:FormationStaffEvent):void {
        assignOfficerS(param1.memberId, param1.userName);
    }

    private function onStaffTableDemoteMemberHandler(param1:FormationStaffEvent):void {
        assignPrivateS(param1.memberId, param1.userName);
    }

    private function onStaffTableRemoveMemberHandler(param1:FormationStaffEvent):void {
        removeMemberS(param1.memberId, param1.userName);
    }

    private function onCbOpenedSelectHandler(param1:Event):void {
        if (this.cbOpened.textColor != CHECK_BOX_DEFAULT_COLOR) {
            this.cbOpened.textColor = CHECK_BOX_DEFAULT_COLOR;
            this.cbOpened.invalidateState();
        }
        setRecruitmentOpenedS(!this.cbOpened.selected);
    }

    private function onBtnInvitePressHandler(param1:ButtonEvent):void {
        this.setArrowAnimation(false);
        showInviteWindowS();
    }

    private function onBtnRecruitmentPressHandler(param1:ButtonEvent):void {
        showRecriutmentWindowS();
    }

    private function onBtnRemoveClickHandler(param1:MouseEvent):void {
        removeMeS();
    }

    private function onLblStaffedMouseOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(this._lblStaffedTooltip);
    }

    private function onLblStaffedMouseOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }
}
}
