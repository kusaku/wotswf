package net.wg.gui.lobby.battleResults.components {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.ScrollingListEx;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.components.controls.UserNameField;
import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
import net.wg.gui.lobby.battleResults.data.VehicleItemVO;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.interfaces.IUserProps;
import net.wg.infrastructure.interfaces.entity.IFocusContainer;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ListEvent;

public class TeamMemberStatsView extends UIComponentEx implements IFocusContainer {

    private static const STATS_DY:int = 48;

    private static const INVALIDATE_CLOSE_BTN:String = "invalidateCloseBtn";

    public var list:ScrollingListEx = null;

    public var tankIcon:UILoaderAlt = null;

    public var tankFlag:MovieClip = null;

    public var playerNameLbl:UserNameField = null;

    public var vehicleName:TextField = null;

    public var vehicleStateLbl:TextField = null;

    public var vehicleStats:VehicleDetails = null;

    public var closeBtn:SoundButtonEx = null;

    public var myArea:MovieClip = null;

    public var deadBg:MovieClip = null;

    public var medalBg:MovieClip = null;

    public var selectVehicleTitle:TextField;

    public var selectVehicleDropdown:DropdownMenu;

    public var achievements:MedalsList = null;

    private var _initialStatsY:Number = 0;

    private var _initialCloseBtnY:Number = 0;

    private var _dataDirty:Boolean = false;

    private var _toolTip:String = null;

    private var _selectedVehicleIndex:int = 0;

    private var _data:TeamMemberItemVO = null;

    private var _isCloseBtnVisible:Boolean;

    public function TeamMemberStatsView() {
        super();
        var _loc1_:Number = scaleX;
        var _loc2_:Number = scaleY;
        scaleX = 1;
        scaleY = 1;
        this.initTargetScale(_loc1_, _loc2_);
    }

    override protected function configUI():void {
        super.configUI();
        this.selectVehicleTitle.text = BATTLE_RESULTS.SELECTVEHICLE;
        this._initialStatsY = this.vehicleStats.y;
        this._initialCloseBtnY = this.closeBtn.y;
        this.closeBtn.addEventListener(ButtonEvent.CLICK, this.onCloseButtonClickHandler);
        this.selectVehicleDropdown.addEventListener(ListEvent.INDEX_CHANGE, this.onSelectVehicleDropdownIndexChangeHandler);
    }

    override protected function onDispose():void {
        this.closeBtn.removeEventListener(ButtonEvent.CLICK, this.onCloseButtonClickHandler);
        this.closeBtn.dispose();
        this.closeBtn = null;
        this.vehicleStateLbl.removeEventListener(MouseEvent.ROLL_OVER, this.onVehicleLabelRollOverHandler);
        this.vehicleStateLbl.removeEventListener(MouseEvent.ROLL_OUT, this.onVehicleLabelRollOutHandler);
        this.vehicleStateLbl = null;
        this.selectVehicleTitle = null;
        this.selectVehicleDropdown.removeEventListener(ListEvent.INDEX_CHANGE, this.onSelectVehicleDropdownIndexChangeHandler);
        this.selectVehicleDropdown.dispose();
        this.selectVehicleDropdown = null;
        this.list = null;
        this.tankIcon.dispose();
        this.tankIcon = null;
        this.tankFlag = null;
        this.playerNameLbl.dispose();
        this.playerNameLbl = null;
        this.vehicleName = null;
        this.vehicleStats.dispose();
        this.vehicleStats = null;
        this.myArea = null;
        this.deadBg = null;
        this.medalBg = null;
        this.achievements.dispose();
        this.achievements = null;
        this._data = null;
        this._toolTip = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:IUserProps = null;
        var _loc2_:Boolean = false;
        super.draw();
        if (this._dataDirty) {
            this.vehicleStats.state = VehicleDetails.STATE_WIDE;
            this.vehicleStats.y = this._initialStatsY;
            this.closeBtn.y = this._initialCloseBtnY;
            this.achievements.visible = false;
            if (this.data) {
                this.initVehicleSelection(this.data);
                this.playerNameLbl.userVO = this.data.userVO;
                this.vehicleName.htmlText = this.data.vehicleFullName;
                this.vehicleStateLbl.text = this.data.vehicleStateStr;
                if (this.data.isPrematureLeave || this.data.killerID <= 0) {
                    this.vehicleStateLbl.text = this.data.vehicleStateStr;
                }
                else if (this.data.killerID > 0) {
                    _loc1_ = App.utils.commons.getUserProps(this.data.killerNameStr, this.data.killerClanNameStr, this.data.killerRegionNameStr);
                    _loc1_.prefix = this.data.vehicleStatePrefixStr;
                    _loc1_.suffix = this.data.vehicleStateSuffixStr;
                    _loc2_ = App.utils.commons.formatPlayerName(this.vehicleStateLbl, _loc1_);
                    if (_loc2_) {
                        this.vehicleStateLbl.addEventListener(MouseEvent.ROLL_OVER, this.onVehicleLabelRollOverHandler);
                        this.vehicleStateLbl.addEventListener(MouseEvent.ROLL_OUT, this.onVehicleLabelRollOutHandler);
                        this._toolTip = _loc1_.prefix + this.data.killerFullNameStr + _loc1_.suffix;
                    }
                    App.utils.commons.formatPlayerName(this.vehicleStateLbl, _loc1_);
                }
                this.applyVehicleData();
                this.deadBg.visible = this.data.deathReason > -1;
                this.medalBg.visible = this.data.medalsCount > 0;
                if (this.data.medalsCount > 0) {
                    this.vehicleStats.y = this.vehicleStats.y + STATS_DY;
                    this.closeBtn.y = this._initialCloseBtnY;
                    this.achievements.visible = true;
                    this.achievements.dataProvider = new DataProvider(this.data.achievements);
                    this.achievements.validateNow();
                }
            }
            else {
                this.tankIcon.source = "";
                this.tankFlag.visible = false;
                this.playerNameLbl.userVO = null;
                this.vehicleName.text = "";
                this.vehicleStateLbl.text = "";
                this.vehicleStats.data = null;
                this.deadBg.visible = false;
                this.medalBg.visible = false;
            }
            this._dataDirty = false;
        }
        if (isInvalid(INVALIDATE_CLOSE_BTN)) {
            this.closeBtn.visible = this._isCloseBtnVisible;
        }
    }

    public function getComponentForFocus():InteractiveObject {
        return this.list;
    }

    public function setVehicleIdxInGarageDropdown(param1:int):void {
        if (this._selectedVehicleIndex == param1) {
            return;
        }
        this._selectedVehicleIndex = param1;
        if (this.selectVehicleDropdown.dataProvider != null) {
            this.selectVehicleDropdown.selectedIndex = this._selectedVehicleIndex;
        }
    }

    public function invalidateMedalsListData():void {
        this.achievements.invalidateData();
    }

    private function initTargetScale(param1:Number, param2:Number):void {
        hitArea.scaleX = param1;
        hitArea.scaleY = param2;
        this.deadBg.scaleX = param1;
        this.medalBg.scaleX = param1;
        this.closeBtn.x = this.closeBtn.x * param1 | 0;
        this.vehicleStats.x = this.vehicleStats.x * param1 | 0;
    }

    private function initVehicleSelection(param1:TeamMemberItemVO):void {
        var _loc2_:Array = param1.vehicles;
        var _loc3_:* = _loc2_.length > 1;
        this.selectVehicleTitle.visible = _loc3_;
        this.selectVehicleDropdown.visible = _loc3_;
        this.vehicleStateLbl.visible = !_loc3_;
        this.vehicleName.visible = !_loc3_;
        if (_loc3_) {
            this.selectVehicleDropdown.dataProvider = new DataProvider(_loc2_);
            this.selectVehicleDropdown.selectedIndex = this._selectedVehicleIndex;
        }
    }

    private function applyVehicleData():void {
        this.vehicleStats.data = this._data.statValues[this._selectedVehicleIndex];
        var _loc1_:VehicleItemVO = VehicleItemVO(this._data.vehicles[this._selectedVehicleIndex]);
        this.tankIcon.source = _loc1_.icon;
        var _loc2_:String = _loc1_.flag;
        this.tankFlag.visible = _loc2_.length > 0;
        if (_loc2_ != null) {
            this.tankFlag.gotoAndStop(_loc2_);
        }
    }

    public function get data():TeamMemberItemVO {
        return this._data;
    }

    public function set data(param1:TeamMemberItemVO):void {
        this._data = param1;
        this._dataDirty = true;
        invalidate();
    }

    public function get isCloseBtnVisible():Boolean {
        return this._isCloseBtnVisible;
    }

    public function set isCloseBtnVisible(param1:Boolean):void {
        if (this._isCloseBtnVisible == param1) {
            return;
        }
        this._isCloseBtnVisible = param1;
        invalidate(INVALIDATE_CLOSE_BTN);
    }

    private function onVehicleLabelRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.show(this._toolTip);
    }

    private function onVehicleLabelRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onSelectVehicleDropdownIndexChangeHandler(param1:ListEvent):void {
        this._selectedVehicleIndex = param1.index;
        if (this._data != null) {
            this.applyVehicleData();
        }
    }

    private function onCloseButtonClickHandler(param1:ButtonEvent):void {
        this.list.selectedIndex = -1;
        dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS, this));
    }
}
}
