package net.wg.gui.cyberSport.views.unit {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.rally.BaseRallyMainWindow;
import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
import net.wg.gui.rally.interfaces.IRallyVO;
import net.wg.gui.rally.views.list.SimpleRallyDetailsSection;
import net.wg.gui.rally.vo.RallyShortVO;
import net.wg.infrastructure.interfaces.IUserProps;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.clik.constants.InvalidationType;

public class JoinUnitSection extends SimpleRallyDetailsSection {

    public var headerRatingTF:TextField = null;

    public var freezeIcon:MovieClip = null;

    public var restrictionIcon:MovieClip = null;

    public var joinUnitButton:SoundButtonEx = null;

    public var slot0:SimpleSlotRenderer = null;

    public var slot1:SimpleSlotRenderer = null;

    public var slot2:SimpleSlotRenderer = null;

    public var slot3:SimpleSlotRenderer = null;

    public var slot4:SimpleSlotRenderer = null;

    public var slot5:SimpleSlotRenderer = null;

    public var slot6:SimpleSlotRenderer = null;

    public var cs_lips:Sprite = null;

    public var cs_battleIcon:Sprite = null;

    private var _slots:Vector.<IRallySimpleSlotRenderer>;

    public function JoinUnitSection() {
        super();
        noRallyScreen.update(CYBERSPORT.WINDOW_UNITLISTVIEW_NOUNITSELECTED);
        joinButton = this.joinUnitButton;
        this.headerRatingTF.autoSize = TextFieldAutoSize.LEFT;
    }

    override protected function setChangedVisibilityItems():void {
        super.setChangedVisibilityItems();
        addItemsToChangedVisibilityList(this.cs_lips, this.cs_battleIcon, this.headerRatingTF, this.freezeIcon, this.restrictionIcon);
    }

    override protected function getSlots():Vector.<IRallySimpleSlotRenderer> {
        if (this._slots == null) {
            this._slots = this.createSlots();
        }
        return this._slots;
    }

    override protected function configUI():void {
        joinButton = this.joinUnitButton;
        super.configUI();
        this.cs_lips.mouseChildren = this.cs_lips.mouseEnabled = false;
        headerTF.text = CYBERSPORT.WINDOW_UNITLISTVIEW_SELECTEDTEAM;
        rallyInfoTF.htmlText = BaseRallyMainWindow.getTeamHeader(CYBERSPORT.WINDOW_UNIT_TEAMMEMBERS, model);
        vehiclesInfoTF.text = CYBERSPORT.WINDOW_UNITLISTVIEW_VEHICLES;
        joinInfoTF.text = CYBERSPORT.WINDOW_UNITLISTVIEW_ENTERTEXT_COMMON;
        joinButton.label = CYBERSPORT.WINDOW_UNITLISTVIEW_ENTERBTN_COMMON;
        this.freezeIcon.addEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
        this.freezeIcon.addEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.restrictionIcon.addEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
        this.restrictionIcon.addEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        userInfoTextLoadingController.setControlledUserRatingTextField(this.headerRatingTF);
        userInfoTextLoadingController.clearUserRating();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            if (model != null && model.isAvailable()) {
                this.freezeIcon.visible = this.unitModel.isFreezed;
                this.restrictionIcon.visible = this.unitModel.hasRestrictions;
            }
            rallyInfoTF.htmlText = BaseRallyMainWindow.getTeamHeader(CYBERSPORT.WINDOW_UNIT_TEAMMEMBERS, model);
        }
    }

    override protected function updateTitle(param1:IRallyVO):void {
        super.updateTitle(param1);
        if (this.unitModel && this.unitModel.commander) {
            userInfoTextLoadingController.setUserRatingHtmlText(this.unitModel.commander.rating);
        }
        else {
            userInfoTextLoadingController.clearUserRating();
        }
    }

    override protected function updateDescription(param1:IRallyVO):void {
        super.updateDescription(param1);
        var _loc2_:IUserProps = App.utils.commons.getUserProps(param1.description, null, null, 0);
        App.utils.commons.formatPlayerName(descriptionTF, _loc2_);
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        this.freezeIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
        this.freezeIcon.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.restrictionIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
        this.restrictionIcon.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        for each(_loc1_ in this._slots) {
            _loc1_.dispose();
            _loc1_ = null;
        }
        this._slots = null;
        this.headerRatingTF = null;
        this.freezeIcon = null;
        this.restrictionIcon = null;
        this.cs_lips = null;
        this.cs_battleIcon = null;
        super.onDispose();
    }

    override protected function onControlRollOver(param1:Object):void {
        switch (param1) {
            case this.freezeIcon:
                App.toolTipMgr.showComplex(TOOLTIPS.SETTINGSICON_FREEZED);
                break;
            case this.restrictionIcon:
                App.toolTipMgr.showComplex(TOOLTIPS.SETTINGSICON_CONDITIONS);
                break;
            case joinButton:
                App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNITLIST_JOIN);
                break;
            case headerTF:
                App.toolTipMgr.show(this.unitModel.commander.getToolTip());
                break;
            case descriptionTF:
                if (descriptionTF.text) {
                    App.toolTipMgr.show(model.description);
                }
        }
    }

    private function createSlots():Vector.<IRallySimpleSlotRenderer> {
        var _loc2_:SimpleSlotRenderer = null;
        var _loc1_:Vector.<IRallySimpleSlotRenderer> = new <IRallySimpleSlotRenderer>[this.slot0, this.slot1, this.slot2, this.slot3, this.slot4, this.slot5, this.slot6];
        var _loc3_:UnitSlotHelper = new UnitSlotHelper();
        for each(_loc2_ in _loc1_) {
            _loc2_.helper = _loc3_;
        }
        return _loc1_;
    }

    public function get unitModel():RallyShortVO {
        return model as RallyShortVO;
    }

    private function onControlRollOverHandler(param1:MouseEvent):void {
        this.onControlRollOver(param1.currentTarget);
    }

    private function onControlRollOutHandler(param1:MouseEvent):void {
        onControlRollOut(param1.currentTarget);
    }
}
}
