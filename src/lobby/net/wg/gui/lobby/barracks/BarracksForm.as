package net.wg.gui.lobby.barracks {
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.RolesState;
import net.wg.data.constants.VehicleTypes;
import net.wg.data.constants.generated.BARRACKS_CONSTANTS;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.advanced.ButtonBarEx;
import net.wg.gui.components.controls.CloseButton;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.ScrollBar;
import net.wg.gui.components.controls.TextFieldShort;
import net.wg.gui.components.controls.TileList;
import net.wg.gui.events.CrewEvent;
import net.wg.gui.lobby.barracks.data.BarracksTankmenVO;
import net.wg.gui.lobby.components.InfoMessageComponent;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.exceptions.TypeCastException;
import net.wg.infrastructure.managers.ITooltipMgr;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.controls.ButtonBar;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.IndexEvent;
import scaleform.clik.events.ListEvent;

public class BarracksForm extends UIComponentEx {

    private static const INVALIDATE_TANKMEN_FILTER:String = "TankmenFilter";

    private static const DEFAULT_LOCATION:int = 3;

    private static const EMPTY_STR:String = "";

    public var tankmenCountTF:TextField = null;

    public var placesCountTF:TextField = null;

    public var roleTF:TextField = null;

    public var tankTypeTF:TextField = null;

    public var locationTF:TextField = null;

    public var nationTF:TextField = null;

    public var titleBtn:TextFieldShort = null;

    public var scrollBar:ScrollBar = null;

    public var tankmenTileList:TileList = null;

    public var noTankmenCmp:InfoMessageComponent;

    public var tank:DropdownMenu = null;

    public var nationDDM:DropdownMenu = null;

    public var roleButtonBar:ButtonBarEx = null;

    public var tankTypeButtonBar:ButtonBarEx = null;

    public var locationButtonBar:ButtonBarEx = null;

    public var closeButton:CloseButton = null;

    private var _nation:Number = 0;

    private var _role:String = "";

    private var _tankType:String = "";

    private var _location:String = "";

    private var _nationID:String = "";

    private var _tankmenData:BarracksTankmenVO = null;

    private var _toolTipMgr:ITooltipMgr = null;

    private var _programmaticUpdate:Boolean = false;

    private var _tankSelectedIndex:int = 0;

    public function BarracksForm() {
        super();
        this._toolTipMgr = App.toolTipMgr;
    }

    override protected function configUI():void {
        super.configUI();
        this.tank.addEventListener(ListEvent.INDEX_CHANGE, this.onTankIndexChangeHandler);
        this.roleTF.text = MENU.BARRACKS_MENU_ROLEFILTER_TEXTFIELD;
        this.roleButtonBar.dataProvider = new DataProvider([{
            "label": MENU.BARRACKS_MENU_ROLEFILTER_ALL,
            "data": RolesState.ALL
        }, {
            "label": MENU.BARRACKS_MENU_ROLEFILTER_COMMANDER,
            "data": RolesState.COMANDER
        }, {
            "label": MENU.BARRACKS_MENU_ROLEFILTER_GUNNER,
            "data": RolesState.GUNNER
        }, {
            "label": MENU.BARRACKS_MENU_ROLEFILTER_DRIVER,
            "data": RolesState.DRIVER
        }, {
            "label": MENU.BARRACKS_MENU_ROLEFILTER_RADIOMAN,
            "data": RolesState.RADIOMAN
        }, {
            "label": MENU.BARRACKS_MENU_ROLEFILTER_LOADER,
            "data": RolesState.LOADER
        }]);
        this.tankTypeTF.text = MENU.BARRACKS_MENU_TANKTYPEFILTER_TEXTFIELD;
        this.tankTypeButtonBar.dataProvider = new DataProvider([{
            "label": DIALOGS.RECRUITWINDOW_VEHICLECLASSDROPDOWN_ALL,
            "data": VehicleTypes.ALL
        }, {
            "label": DIALOGS.RECRUITWINDOW_VEHICLECLASSDROPDOWN_LIGHTTANK,
            "data": VehicleTypes.LIGHT_TANK
        }, {
            "label": DIALOGS.RECRUITWINDOW_VEHICLECLASSDROPDOWN_MEDIUMTANK,
            "data": VehicleTypes.MEDIUM_TANK
        }, {
            "label": DIALOGS.RECRUITWINDOW_VEHICLECLASSDROPDOWN_HEAVYTANK,
            "data": VehicleTypes.HEAVY_TANK
        }, {
            "label": DIALOGS.RECRUITWINDOW_VEHICLECLASSDROPDOWN_AT_SPG,
            "data": VehicleTypes.AT_SPG
        }, {
            "label": DIALOGS.RECRUITWINDOW_VEHICLECLASSDROPDOWN_SPG,
            "data": VehicleTypes.SPG
        }]);
        this.locationTF.text = MENU.BARRACKS_MENU_LOCATIONFILTER_TEXTFIELD;
        this.locationButtonBar.dataProvider = new DataProvider([{
            "label": EMPTY_STR,
            "data": EMPTY_STR
        }, {
            "label": MENU.BARRACKS_MENU_LOCATIONFILTER_TANKS,
            "data": BARRACKS_CONSTANTS.LOCATION_FILTER_TANKS
        }, {
            "label": MENU.BARRACKS_MENU_LOCATIONFILTER_BARRACKS,
            "data": BARRACKS_CONSTANTS.LOCATION_FILTER_BARRACKS
        }, {
            "label": MENU.BARRACKS_MENU_LOCATIONFILTER_BARRACKSANDTANKS,
            "data": BARRACKS_CONSTANTS.LOCATION_FILTER_BARRACKS_AND_TANKS
        }, {
            "label": MENU.BARRACKS_MENU_LOCATIONFILTER_DISMISSED,
            "data": BARRACKS_CONSTANTS.LOCATION_FILTER_DISMISSED
        }]);
        this.tankmenTileList.addEventListener(ListEvent.ITEM_ROLL_OVER, this.onTankmenTileListItemRollOverHandler);
        this.tankmenTileList.addEventListener(ListEvent.ITEM_ROLL_OUT, this.onTankmenTileListItemRollOutHandler);
        this.tankmenTileList.addEventListener(ListEvent.ITEM_PRESS, this.onTankmenTileListItemPressHandler);
    }

    override protected function onDispose():void {
        this.hideTooltip();
        this.tankmenTileList.removeEventListener(ListEvent.ITEM_ROLL_OVER, this.onTankmenTileListItemRollOverHandler);
        this.tankmenTileList.removeEventListener(ListEvent.ITEM_ROLL_OUT, this.onTankmenTileListItemRollOutHandler);
        this.tankmenTileList.removeEventListener(ListEvent.ITEM_PRESS, this.onTankmenTileListItemPressHandler);
        this.roleButtonBar.removeEventListener(IndexEvent.INDEX_CHANGE, this.onRoleButtonBarIndexChangeHandler);
        this.tankTypeButtonBar.removeEventListener(IndexEvent.INDEX_CHANGE, this.onTankTypeButtonBarIndexChangeHandler);
        this.tank.removeEventListener(ListEvent.INDEX_CHANGE, this.onTankIndexChangeHandler);
        this.locationButtonBar.removeEventListener(IndexEvent.INDEX_CHANGE, this.onLocationButtonBarIndexChangeHandler);
        this.nationDDM.removeEventListener(ListEvent.INDEX_CHANGE, this.onNationDDMIndexChangeHandler);
        this.removePlacesCountTfListeners();
        this.roleButtonBar.dispose();
        this.tankTypeButtonBar.dispose();
        this.locationButtonBar.dispose();
        this.tankmenTileList.dispose();
        this.nationDDM.dispose();
        this.tank.dispose();
        this.scrollBar.dispose();
        this.titleBtn.dispose();
        this.closeButton.dispose();
        this.noTankmenCmp.dispose();
        this.scrollBar = null;
        this.titleBtn = null;
        this.tankmenTileList = null;
        this.tank = null;
        this.nationDDM = null;
        this.roleButtonBar = null;
        this.tankTypeButtonBar = null;
        this.locationButtonBar = null;
        this.closeButton = null;
        this.noTankmenCmp = null;
        this.roleTF = null;
        this.tankTypeTF = null;
        this.locationTF = null;
        this.nationTF = null;
        this.tankmenCountTF = null;
        this.placesCountTF = null;
        this._nation = 0;
        this._role = null;
        this._tankType = null;
        this._location = null;
        this._nationID = null;
        this._tankmenData = null;
        this._toolTipMgr = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:Number = NaN;
        var _loc2_:int = 0;
        var _loc3_:Number = NaN;
        var _loc4_:int = 0;
        var _loc5_:Number = NaN;
        super.draw();
        if (isInvalid(INVALIDATE_TANKMEN_FILTER)) {
            this.updateSelectedIndex(this.nationDDM, this._nation);
            this.updateSelectedIndex(this.roleButtonBar, this._role);
            this.updateSelectedIndex(this.tankTypeButtonBar, this._tankType);
            this.onInvalidateTanksList();
            if (this._nationID) {
                this.locationButtonBar.selectedIndex = 0;
                _loc1_ = 0;
                _loc2_ = this.tank.dataProvider.length;
                _loc3_ = 0;
                while (_loc3_ < _loc2_) {
                    if (this.tank.dataProvider[_loc3_].data.typeID == this._location && this.tank.dataProvider[_loc3_].data.nationID == this._nationID) {
                        _loc1_ = _loc3_;
                        break;
                    }
                    _loc3_++;
                }
                this.tank.selectedIndex = _loc1_;
            }
            else {
                _loc1_ = DEFAULT_LOCATION;
                _loc4_ = this.locationButtonBar.dataProvider.length;
                _loc5_ = 1;
                while (_loc5_ < _loc4_) {
                    if (this.locationButtonBar.dataProvider[_loc5_].data == this._location) {
                        _loc1_ = _loc5_;
                        break;
                    }
                    _loc5_++;
                }
                this.locationButtonBar.selectedIndex = _loc1_;
            }
            if (!this.roleButtonBar.hasEventListener(IndexEvent.INDEX_CHANGE)) {
                this.roleButtonBar.addEventListener(IndexEvent.INDEX_CHANGE, this.onRoleButtonBarIndexChangeHandler);
            }
            if (!this.tankTypeButtonBar.hasEventListener(IndexEvent.INDEX_CHANGE)) {
                this.tankTypeButtonBar.addEventListener(IndexEvent.INDEX_CHANGE, this.onTankTypeButtonBarIndexChangeHandler);
            }
            if (!this.tank.hasEventListener(IndexEvent.INDEX_CHANGE)) {
                this.locationButtonBar.addEventListener(IndexEvent.INDEX_CHANGE, this.onLocationButtonBarIndexChangeHandler);
            }
            if (!this.nationDDM.hasEventListener(ListEvent.INDEX_CHANGE)) {
                this.nationDDM.addEventListener(ListEvent.INDEX_CHANGE, this.onNationDDMIndexChangeHandler);
            }
            this.checkFilters();
        }
    }

    public function setTankmenFilter(param1:Number, param2:String, param3:String, param4:String, param5:String):void {
        this._nation = param1;
        this._role = param2;
        this._tankType = param3;
        this._location = param4;
        this._nationID = param5;
        invalidate(INVALIDATE_TANKMEN_FILTER);
    }

    public function updateTanksList(param1:DataProvider):void {
        this._programmaticUpdate = true;
        this.tank.dataProvider = param1;
        if (param1.length > 0) {
            this.tank.selectedIndex = 0;
            this.locationButtonBar.dataProvider[0].data = this.tank.dataProvider[this.tank.selectedIndex].data;
        }
        else {
            this.tank.selectedIndex = -1;
            this.locationButtonBar.dataProvider[0].data = EMPTY_STR;
        }
        this.tank.validateNow();
        this.tank.enabled = param1.length > 0;
        this._tankSelectedIndex = this.tank.selectedIndex;
        this._programmaticUpdate = false;
    }

    public function onPopulate():void {
        this.nationDDM.dataProvider = new DataProvider([{
            "label": MENU.NATIONS_ALL,
            "data": -1
        }].concat(App.utils.nations.getNationsData()));
    }

    public function setTankmen(param1:BarracksTankmenVO):void {
        this._tankmenData = param1;
        this.tankmenCountTF.htmlText = param1.tankmenCount;
        if (this.tankmenTileList.dataProvider != null) {
            this.tankmenTileList.dataProvider.cleanUp();
        }
        this.tankmenTileList.dataProvider = new DataProvider(param1.tankmenData);
        this.tankmenTileList.validateNow();
        this.tankmenTileList.selectedIndex = -1;
        this.placesCountTF.htmlText = param1.placesCount;
        if (StringUtils.isNotEmpty(this._tankmenData.placesCountTooltip)) {
            this.placesCountTF.addEventListener(MouseEvent.ROLL_OVER, this.onPlacesCountTfRollOverHandler);
            this.placesCountTF.addEventListener(MouseEvent.ROLL_OUT, this.onPlacesCountTfRollOutHandler);
        }
        else {
            this.removePlacesCountTfListeners();
        }
        this.noTankmenCmp.visible = param1.hasNoInfoData;
        if (param1.hasNoInfoData) {
            this.noTankmenCmp.setData(param1.noInfoData);
            this.noTankmenCmp.x = this.tankmenTileList.x + (this.tankmenTileList.width - this.noTankmenCmp.width >> 1) | 0;
            this.noTankmenCmp.y = this.tankmenTileList.y + (this.tankmenTileList.height - this.noTankmenCmp.height >> 1) | 0;
        }
    }

    private function updateSelectedIndex(param1:Object, param2:Object):void {
        var _loc5_:Boolean = false;
        if (App.instance) {
            _loc5_ = param1 is ButtonBar || param1 is DropdownMenu;
            App.utils.asserter.assert(_loc5_, "object in ... must be ButtonBar or DropdownMenu", TypeCastException);
        }
        var _loc3_:int = param1.dataProvider.length;
        param1.selectedIndex = 0;
        var _loc4_:Number = 0;
        while (_loc4_ < _loc3_) {
            if (param1.dataProvider[_loc4_].data == param2) {
                param1.selectedIndex = _loc4_;
                return;
            }
            _loc4_++;
        }
    }

    private function checkFilters():void {
        var _loc1_:Number = this.nationDDM.dataProvider[this.nationDDM.selectedIndex].data;
        var _loc2_:String = this.roleButtonBar.dataProvider[this.roleButtonBar.selectedIndex].data;
        var _loc3_:String = this.tankTypeButtonBar.dataProvider[this.tankTypeButtonBar.selectedIndex].data;
        var _loc4_:Object = this.locationButtonBar.dataProvider[this.locationButtonBar.selectedIndex].data;
        var _loc5_:String = null;
        var _loc6_:String = null;
        if (_loc4_ is String || _loc4_ == null) {
            _loc6_ = _loc4_.toString();
        }
        else {
            _loc6_ = _loc4_.typeID;
            _loc5_ = _loc4_.nationID;
        }
        var _loc7_:Object = {
            "nation": _loc1_,
            "role": _loc2_,
            "tankType": _loc3_,
            "location": _loc6_,
            "nationID": _loc5_
        };
        dispatchEvent(new CrewEvent(CrewEvent.ON_CHANGE_BARRACKS_FILTER, _loc7_));
    }

    private function onInvalidateTanksList():void {
        dispatchEvent(new CrewEvent(CrewEvent.ON_INVALID_TANK_LIST));
    }

    private function removePlacesCountTfListeners():void {
        this.placesCountTF.removeEventListener(MouseEvent.ROLL_OVER, this.onPlacesCountTfRollOverHandler);
        this.placesCountTF.removeEventListener(MouseEvent.ROLL_OUT, this.onPlacesCountTfRollOutHandler);
    }

    private function deepCheckFilters():void {
        this.checkFilters();
        this.onInvalidateTanksList();
        this.checkFilters();
    }

    private function hideTooltip():void {
        this._toolTipMgr.hide();
    }

    private function showComplexTooltip(param1:String):void {
        this._toolTipMgr.showComplex(param1);
    }

    private function onRoleButtonBarIndexChangeHandler(param1:Event):void {
        this.checkFilters();
    }

    private function onLocationButtonBarIndexChangeHandler(param1:Event):void {
        this.checkFilters();
    }

    private function onTankTypeButtonBarIndexChangeHandler(param1:Event):void {
        this.deepCheckFilters();
    }

    private function onNationDDMIndexChangeHandler(param1:Event):void {
        this.deepCheckFilters();
    }

    private function onTankIndexChangeHandler(param1:Event):void {
        if (!this._programmaticUpdate) {
            if (this.locationButtonBar.selectedIndex == 0) {
                if (this.tank.selectedIndex < 0) {
                    this.locationButtonBar.selectedIndex = this.locationButtonBar.dataProvider.length - 1;
                }
            }
            else if (this.tank.selectedIndex >= 0 && this._tankSelectedIndex >= 0) {
                this.locationButtonBar.selectedIndex = 0;
            }
            if (this.tank.dataProvider.length > 0) {
                this.locationButtonBar.dataProvider[0].data = this.tank.dataProvider[this.tank.selectedIndex].data;
            }
            else {
                this.locationButtonBar.dataProvider[0].data = "";
            }
            this.checkFilters();
        }
    }

    private function onTankmenTileListItemRollOverHandler(param1:ListEvent):void {
        this.hideTooltip();
        if (param1.itemData.empty) {
            this.showComplexTooltip(TOOLTIPS.BARRACKS_ITEM_EMPTY);
        }
        else if (param1.itemData.buy) {
            this.showComplexTooltip(TOOLTIPS.BARRACKS_ITEM_BUY);
        }
        else {
            this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TANKMAN, null, param1.itemData.tankmanID, false);
        }
    }

    private function onTankmenTileListItemRollOutHandler(param1:ListEvent):void {
        this.hideTooltip();
    }

    private function onTankmenTileListItemPressHandler(param1:ListEvent):void {
        this.hideTooltip();
    }

    private function onPlacesCountTfRollOverHandler(param1:MouseEvent):void {
        this.showComplexTooltip(this._tankmenData.placesCountTooltip);
    }

    private function onPlacesCountTfRollOutHandler(param1:MouseEvent):void {
        this.hideTooltip();
    }
}
}
