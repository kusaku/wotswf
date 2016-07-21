package net.wg.gui.cyberSport.views {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.Values;
import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
import net.wg.data.constants.generated.CYBER_SPORT_HELP_IDS;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.ButtonIconTextTransparent;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.cyberSport.controls.CSLadderIconButton;
import net.wg.gui.cyberSport.controls.CSVehicleButton;
import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
import net.wg.gui.cyberSport.views.events.CSShowHelpEvent;
import net.wg.gui.cyberSport.vo.CSIntroViewStaticTeamVO;
import net.wg.gui.cyberSport.vo.CSIntroViewTextsVO;
import net.wg.gui.rally.events.RallyViewsEvent;
import net.wg.gui.rally.vo.VehicleVO;
import net.wg.infrastructure.base.meta.IBaseRallyViewMeta;
import net.wg.infrastructure.base.meta.ICyberSportIntroMeta;
import net.wg.infrastructure.base.meta.impl.CyberSportIntroMeta;
import net.wg.infrastructure.managers.ITooltipFormatter;

import scaleform.clik.events.ButtonEvent;
import scaleform.gfx.TextFieldEx;

public class IntroView extends CyberSportIntroMeta implements ICyberSportIntroMeta, IBaseRallyViewMeta {

    private static const BETA_SIGN_OFFSET:int = 20;

    private static const DEFAULT_COLOR_TRANSFORM:ColorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);

    private static const DARK_COLOR_TRANSFORM:ColorTransform = new ColorTransform(0.36, 0.3, 0.3, 1, 0, 0, 0, 0);

    private static const CLUB_UNDEFINED:Number = 0;

    private static const INVALIDATION_SELECTED_VEHICLE_READY:String = "selectedVehicleReady";

    private static const INVALIDATION_SELECTED_VEHICLE_BUTTON_ENABLE:String = "selectedVehicleButtonEnable";

    private static const INVALIDATION_STATIC_TEAM_DATA:String = "staticTeamData";

    private static const INVALIDATION_BACKEND_TEXTS:String = "backendTexts";

    public var autoMatchBtn:SoundButtonEx;

    public var teamHeaderTF:TextField;

    public var teamDescriptionTF:TextField;

    public var teamDescriptionBack:MovieClip;

    public var requestWaitingTF:TextField = null;

    public var teamAdditionalBtn:ButtonIconTextTransparent = null;

    public var cancelBtn:SoundButtonEx = null;

    public var cloudsAnimation:MovieClip = null;

    public var ladderBtnIcon:CSLadderIconButton = null;

    public var clockIcon:UILoaderAlt = null;

    public var autoTitleLbl:TextField;

    public var autoDescrLbl:TextField;

    public var vehicleBtnTitleTf:TextField;

    public var selectedVehicleBtn:CSVehicleButton;

    public var warningIcon:MovieClip;

    public var betaSign:MovieClip = null;

    public var helpLabel:TextField;

    public var helpLink:SoundButtonEx;

    public var regulationsInfoLbl:TextField = null;

    private var _selectedVehicleData:VehicleVO = null;

    private var _selectedVehicleIsReady:Boolean = false;

    private var _warnTooltip:String = "";

    private var _model:CSIntroViewStaticTeamVO = null;

    private var _introViewTexts:CSIntroViewTextsVO = null;

    private var _originalCreateBtnWidth:Number = 0;

    private var _originalCreateBtnX:Number = 0;

    private var _originalCreateBtnAutoSize:String = "";

    private var _regulationsInfoTooltip:String = "";

    public function IntroView() {
        super();
        this.cloudsAnimation.stop();
    }

    override protected function setTexts(param1:CSIntroViewTextsVO):void {
        if (this._introViewTexts && this._introViewTexts.isEquals(param1)) {
            return;
        }
        this._introViewTexts = param1;
        invalidate(INVALIDATION_BACKEND_TEXTS);
    }

    override protected function setStaticTeamData(param1:CSIntroViewStaticTeamVO):void {
        if (this._model && this._model.isEquals(param1)) {
            return;
        }
        this._model = param1;
        this.ladderBtnIcon.setSource(this._model.ladderIconSource, this._model.isLadderBtnEnabled);
        invalidate(INVALIDATION_STATIC_TEAM_DATA);
        onControlRollOut();
    }

    override protected function getRallyViewAlias():String {
        if (this._model.isCanCreateBattle || this._model.isCanJoinBattle) {
            return CYBER_SPORT_ALIASES.UNIT_VIEW_UI;
        }
        return CYBER_SPORT_ALIASES.UNITS_LIST_VIEW_UI;
    }

    override protected function configUI():void {
        super.configUI();
        this.cloudsAnimation.mouseEnabled = false;
        this.cloudsAnimation.mouseChildren = false;
        TextFieldEx.setVerticalAlign(listRoomDescrLbl, TextFieldEx.VALIGN_CENTER);
        TextFieldEx.setVerticalAlign(this.teamDescriptionTF, TextFieldEx.VALIGN_CENTER);
        this.clockIcon.visible = false;
        this.clockIcon.mouseEnabled = false;
        this.clockIcon.mouseChildren = false;
        this.requestWaitingTF.mouseEnabled = false;
        this.teamDescriptionBack.visible = false;
        titleLbl.x = width - titleLbl.width >> 1;
        titleLbl.autoSize = TextFieldAutoSize.CENTER;
        this.helpLabel.text = MENU.INGAME_MENU_BUTTONS_HELP;
        this.autoMatchBtn.addEventListener(ButtonEvent.CLICK, this.onAutoSearchClick);
        this.autoMatchBtn.addEventListener(MouseEvent.ROLL_OVER, this.onControlRollOver);
        this.autoMatchBtn.addEventListener(MouseEvent.ROLL_OUT, onControlRollOut);
        this.selectedVehicleBtn.addEventListener(ButtonEvent.CLICK, this.csVehicleBtnOnClick);
        this.selectedVehicleBtn.addEventListener(MouseEvent.ROLL_OVER, this.onControlRollOver);
        this.selectedVehicleBtn.addEventListener(MouseEvent.ROLL_OUT, onControlRollOut);
        this.warningIcon.addEventListener(MouseEvent.ROLL_OVER, this.onControlRollOver);
        this.warningIcon.addEventListener(MouseEvent.ROLL_OUT, onControlRollOut);
        this.ladderBtnIcon.addEventListener(ButtonEvent.CLICK, this.onLadderBtnClickHandler);
        this.ladderBtnIcon.addEventListener(MouseEvent.ROLL_OVER, this.onControlRollOver);
        this.ladderBtnIcon.addEventListener(MouseEvent.ROLL_OUT, onControlRollOut);
        this.regulationsInfoLbl.addEventListener(MouseEvent.ROLL_OVER, this.onControlRollOver);
        this.regulationsInfoLbl.addEventListener(MouseEvent.ROLL_OUT, onControlRollOut);
        this.helpLink.addEventListener(ButtonEvent.CLICK, this.onHelpLinkClick);
        this.teamAdditionalBtn.addEventListener(ButtonEvent.CLICK, this.onTeamAdditionalBtnClickHandler);
        this.cancelBtn.addEventListener(ButtonEvent.CLICK, this.onCancelBtnClickHandler);
        this.teamDescriptionTF.addEventListener(MouseEvent.ROLL_OVER, this.onControlRollOver);
        this.teamDescriptionTF.addEventListener(MouseEvent.ROLL_OUT, onControlRollOut);
        createBtn.mouseEnabledOnDisabled = true;
        this._originalCreateBtnWidth = createBtn.width;
        this._originalCreateBtnX = createBtn.x;
        this._originalCreateBtnAutoSize = createBtn.autoSize;
    }

    override protected function draw():void {
        super.draw();
        var _loc1_:Boolean = false;
        if (isInvalid(INVALIDATION_SELECTED_VEHICLE_READY)) {
            this.updateAutoMatchEnability();
            this.updateWarningIconVisibility();
            _loc1_ = true;
        }
        if (!_loc1_ && isInvalid(INVALIDATION_SELECTED_VEHICLE_BUTTON_ENABLE)) {
            this.updateWarningIconVisibility();
        }
        if (this._introViewTexts) {
            if (isInvalid(INVALIDATION_BACKEND_TEXTS)) {
                titleLbl.htmlText = this._introViewTexts.titleLblText;
                descrLbl.htmlText = this._introViewTexts.descrLblText;
                listRoomTitleLbl.htmlText = this._introViewTexts.listRoomTitleLblText;
                listRoomDescrLbl.htmlText = this._introViewTexts.listRoomDescrLblText;
                listRoomBtn.label = this._introViewTexts.listRoomBtnLabel;
                this.autoTitleLbl.htmlText = this._introViewTexts.autoTitleLblText;
                this.autoDescrLbl.htmlText = this._introViewTexts.autoDescrLblText;
                this.vehicleBtnTitleTf.htmlText = this._introViewTexts.vehicleBtnTitleTfText;
                this.regulationsInfoLbl.htmlText = this._introViewTexts.regulationsInfoText;
                this._regulationsInfoTooltip = this._introViewTexts.regulationsInfoTooltip;
                this.betaSign.x = titleLbl.x + titleLbl.width - BETA_SIGN_OFFSET ^ 0;
            }
        }
        if (this._model) {
            if (isInvalid(INVALIDATION_STATIC_TEAM_DATA)) {
                this.teamHeaderTF.htmlText = this._model.teamHeaderText;
                this.teamDescriptionTF.htmlText = this._model.teamDescriptionText;
                this.teamDescriptionBack.visible = this._model.isTeamDescriptionBackVisible;
                createBtn.visible = this._model.isCreateBtnVisible;
                if (this._model.isCreateBtnVisible) {
                    createBtn.autoSize = this._originalCreateBtnAutoSize;
                    createBtn.label = this._model.createBtnLabel;
                    createBtn.enabled = this._model.isCreateBtnEnabled;
                    createBtn.tooltip = this._model.createBtnTooltip;
                    createBtn.validateNow();
                    if (createBtn.width < this._originalCreateBtnWidth) {
                        createBtn.autoSize = TextFieldAutoSize.NONE;
                        createBtn.width = this._originalCreateBtnWidth;
                        createBtn.x = this._originalCreateBtnX;
                    }
                }
                this.teamAdditionalBtn.visible = this._model.isTeamAdditionalBtnVisible;
                if (this._model.isTeamAdditionalBtnVisible) {
                    this.teamAdditionalBtn.label = this._model.teamAdditionalBtnLabel;
                    this.teamAdditionalBtn.tooltip = this._model.teamAdditionalBtnTooltip;
                }
                this.cancelBtn.visible = this._model.isCancelBtnVisible;
                if (this._model.isCancelBtnVisible) {
                    this.cancelBtn.label = this._model.cancelBtnLabel;
                    this.cancelBtn.tooltip = this._model.cancelBtnTooltip;
                }
                this.ladderBtnIcon.setSource(this._model.ladderIconSource, this._model.isLadderBtnEnabled);
                this.clockIcon.visible = this._model.isClockIconVisible;
                this.requestWaitingTF.visible = this._model.isRequestWaitingTextVisible;
                this.ladderBtnIcon.transform.colorTransform = !!this._model.isRequestWaitingTextVisible ? DARK_COLOR_TRANSFORM : DEFAULT_COLOR_TRANSFORM;
                if (this._model.isClockIconVisible) {
                    this.clockIcon.source = this._model.clockIconSource;
                }
                if (this._model.isRequestWaitingTextVisible) {
                    this.requestWaitingTF.htmlText = this._model.requestWaitingText;
                }
            }
        }
    }

    private function updateAutoMatchEnability():void {
        this.autoMatchBtn.enabled = this._selectedVehicleIsReady;
        this.autoMatchBtn.mouseEnabledOnDisabled = true;
    }

    private function updateWarningIconVisibility():void {
        this.warningIcon.visible = !this._selectedVehicleIsReady || !this.selectedVehicleBtn.enabled;
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.cloudsAnimation.play();
    }

    override protected function onDispose():void {
        this.cloudsAnimation.stop();
        this.autoMatchBtn.removeEventListener(ButtonEvent.CLICK, this.onAutoSearchClick);
        this.autoMatchBtn.removeEventListener(MouseEvent.ROLL_OVER, this.onControlRollOver);
        this.autoMatchBtn.removeEventListener(MouseEvent.ROLL_OUT, onControlRollOut);
        this.selectedVehicleBtn.removeEventListener(ButtonEvent.CLICK, this.csVehicleBtnOnClick);
        this.selectedVehicleBtn.removeEventListener(MouseEvent.ROLL_OVER, this.onControlRollOver);
        this.selectedVehicleBtn.removeEventListener(MouseEvent.ROLL_OUT, onControlRollOut);
        this.warningIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onControlRollOver);
        this.warningIcon.removeEventListener(MouseEvent.ROLL_OUT, onControlRollOut);
        this.ladderBtnIcon.removeEventListener(ButtonEvent.CLICK, this.onLadderBtnClickHandler);
        this.ladderBtnIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onControlRollOver);
        this.ladderBtnIcon.removeEventListener(MouseEvent.ROLL_OUT, onControlRollOut);
        this.teamAdditionalBtn.removeEventListener(ButtonEvent.CLICK, this.onTeamAdditionalBtnClickHandler);
        this.cancelBtn.removeEventListener(ButtonEvent.CLICK, this.onCancelBtnClickHandler);
        this.helpLink.removeEventListener(ButtonEvent.CLICK, this.onHelpLinkClick);
        this.regulationsInfoLbl.removeEventListener(MouseEvent.ROLL_OVER, this.onControlRollOver);
        this.regulationsInfoLbl.removeEventListener(MouseEvent.ROLL_OUT, onControlRollOut);
        this.teamDescriptionTF.removeEventListener(MouseEvent.ROLL_OVER, this.onControlRollOver);
        this.teamDescriptionTF.removeEventListener(MouseEvent.ROLL_OUT, onControlRollOut);
        this.autoMatchBtn.dispose();
        this.autoMatchBtn = null;
        this.selectedVehicleBtn.dispose();
        this.selectedVehicleBtn = null;
        this.vehicleBtnTitleTf = null;
        this.warningIcon = null;
        this._selectedVehicleData.dispose();
        this._selectedVehicleData = null;
        this.teamAdditionalBtn.dispose();
        this.teamAdditionalBtn = null;
        this.cancelBtn.dispose();
        this.cancelBtn = null;
        this.cloudsAnimation = null;
        this.ladderBtnIcon.dispose();
        this.ladderBtnIcon = null;
        this.clockIcon.dispose();
        this.clockIcon = null;
        this.teamHeaderTF = null;
        this.teamDescriptionTF = null;
        this.requestWaitingTF = null;
        this.autoTitleLbl = null;
        this.autoDescrLbl = null;
        this.teamDescriptionBack = null;
        this.helpLabel = null;
        this.helpLink.dispose();
        this.helpLink = null;
        this.betaSign = null;
        this.regulationsInfoLbl = null;
        this._model = null;
        this._introViewTexts = null;
        super.onDispose();
    }

    public function as_setNoVehicles(param1:String):void {
        this.selectedVehicleBtn.setVehicle(null);
        this._warnTooltip = param1;
        if (this.selectedVehicleBtn.enabled) {
            this.selectedVehicleBtn.enabled = false;
            invalidate(INVALIDATION_SELECTED_VEHICLE_BUTTON_ENABLE);
        }
    }

    public function as_setSelectedVehicle(param1:Object, param2:Boolean, param3:String):void {
        this._selectedVehicleData = new VehicleVO(param1);
        this._warnTooltip = param3;
        var _loc4_:Array = [];
        if (this._selectedVehicleIsReady != param2) {
            this._selectedVehicleIsReady = param2;
            _loc4_.push(INVALIDATION_SELECTED_VEHICLE_READY);
        }
        this.selectedVehicleBtn.setVehicle(this._selectedVehicleData);
        if (!this.selectedVehicleBtn.enabled) {
            this.selectedVehicleBtn.enabled = true;
            _loc4_.push(INVALIDATION_SELECTED_VEHICLE_BUTTON_ENABLE);
        }
        if (_loc4_.length > 0) {
            invalidate.apply(null, _loc4_);
        }
    }

    private function showUnitsListView():void {
        var _loc1_:Object = {
            "alias": CYBER_SPORT_ALIASES.UNITS_LIST_VIEW_UI,
            "itemId": Number.NaN,
            "peripheryID": 0,
            "slotIndex": -1,
            "isStatics": true
        };
        dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LOAD_VIEW_REQUEST, _loc1_));
    }

    private function showWarningTooltip():void {
        var _loc2_:ITooltipFormatter = null;
        var _loc1_:String = Values.EMPTY_STR;
        if (this._selectedVehicleData.state != Values.EMPTY_STR) {
            _loc2_ = App.toolTipMgr.getNewFormatter();
            _loc2_.addHeader(this._selectedVehicleData.state);
            _loc2_.addBody(TOOLTIPS.CYBERSPORT_UNIT_SLOT_VEHICLE_NOTREADY_TEMPORALLY_BODY, true);
            _loc1_ = _loc2_.make();
        }
        else {
            _loc1_ = this._warnTooltip;
        }
        App.toolTipMgr.showComplex(_loc1_);
    }

    override protected function onCreateClick(param1:ButtonEvent):void {
        if (this._model.isNeedAddPlayers) {
            showStaticTeamStaffS();
        }
        else if (this._model.isCanCreateBattle || this._model.isCanJoinBattle) {
            joinClubUnitS();
        }
        else {
            this.showUnitsListView();
        }
    }

    override protected function onControlRollOver(param1:MouseEvent):void {
        var _loc2_:String = Values.EMPTY_STR;
        var _loc3_:String = Values.EMPTY_STR;
        switch (param1.currentTarget) {
            case listRoomBtn:
                App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_INTRO_SEARCH_BTN);
                break;
            case this.selectedVehicleBtn:
                if (this.selectedVehicleBtn.enabled) {
                    App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CYBER_SPORT_SELECTED_VEHICLE, null, this._selectedVehicleData.intCD);
                }
                break;
            case this.regulationsInfoLbl:
                App.toolTipMgr.showSpecial(this._regulationsInfoTooltip, null);
                break;
            case this.teamDescriptionTF:
                if (this._model.isTeamDescriptionTooltip) {
                    App.toolTipMgr.showSpecial(this._model.teamDescriptionTooltip, null);
                }
                break;
            case this.autoMatchBtn:
                if (this._selectedVehicleIsReady) {
                    _loc2_ = CYBERSPORT.WINDOW_INTRO_AUTO_BTN_TOOLTIP_TITLE;
                    _loc3_ = !!this.autoMatchBtn.enabled ? CYBERSPORT.WINDOW_INTRO_AUTO_BTN_TOOLTIP_DESCRIPTION_ENABLED : CYBERSPORT.WINDOW_INTRO_AUTO_BTN_TOOLTIP_DESCRIPTION_DISABLED;
                    showComplexTooltip(_loc2_, _loc3_);
                }
                else {
                    this.showWarningTooltip();
                }
                break;
            case this.warningIcon:
                this.showWarningTooltip();
                break;
            case this.ladderBtnIcon:
                if (!isNaN(this._model.clubId) && this._model.clubId != CLUB_UNDEFINED) {
                    App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.LADDER, null, this._model.clubId);
                }
        }
    }

    override protected function showListRoom(param1:ButtonEvent):void {
        var _loc2_:Object = {
            "alias": CYBER_SPORT_ALIASES.UNITS_LIST_VIEW_UI,
            "itemId": Number.NaN,
            "peripheryID": 0,
            "slotIndex": -1,
            "isStatics": false
        };
        dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LOAD_VIEW_REQUEST, _loc2_));
    }

    private function onAutoSearchClick(param1:ButtonEvent):void {
        dispatchEvent(new CSComponentEvent(CSComponentEvent.SHOW_AUTO_SEARCH_VIEW, {
            "state": CYBER_SPORT_ALIASES.INTRO_VIEW_UI,
            "cmpDescr": [this._selectedVehicleData.intCD]
        }));
    }

    private function csVehicleBtnOnClick(param1:ButtonEvent):void {
        showSelectorPopupS();
    }

    private function onLadderBtnClickHandler(param1:ButtonEvent):void {
        if (this._model.isHaveTeamToShow) {
            showStaticTeamProfileS();
        }
        else {
            this.showUnitsListView();
        }
    }

    private function onTeamAdditionalBtnClickHandler(param1:ButtonEvent):void {
        this.showUnitsListView();
    }

    private function onCancelBtnClickHandler(param1:ButtonEvent):void {
        cancelWaitingTeamRequestS();
    }

    private function onHelpLinkClick(param1:ButtonEvent):void {
        dispatchEvent(new CSShowHelpEvent(CYBER_SPORT_HELP_IDS.CYBERSPORT_INTRO_HELP));
    }
}
}
