package net.wg.gui.lobby.barracks {
import flash.events.Event;
import flash.text.TextField;

import net.wg.data.constants.RolesState;
import net.wg.data.constants.VehicleTypes;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.advanced.ButtonBarEx;
import net.wg.gui.components.controls.CloseButton;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.ScrollBar;
import net.wg.gui.components.controls.TextFieldShort;
import net.wg.gui.components.controls.TileList;
import net.wg.gui.events.CrewEvent;
import net.wg.infrastructure.exceptions.TypeCastException;

import scaleform.clik.controls.ButtonBar;
import scaleform.clik.core.UIComponent;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.IndexEvent;
import scaleform.clik.events.ListEvent;

public class BarracksForm extends UIComponent {

    private static const INVALIDATE_TANKMEN_FILTER:String = "TankmenFilter";

    private static const LOCATION_FILTER_TANKS:String = "tanks";

    private static const LOCATION_FILTER_BARRACKS:String = "barracks";

    private static const LOCATION_FILTER_ALL:String = "None";

    public var tankmenCountTF:TextField = null;

    public var placesCountTF:TextField = null;

    public var roleTF:TextField = null;

    public var tankTypeTF:TextField = null;

    public var locationTF:TextField = null;

    public var nationTF:TextField = null;

    public var titleBtn:TextFieldShort = null;

    public var scrollBar:ScrollBar = null;

    public var tankmenTileList:TileList = null;

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

    public function BarracksForm() {
        super();
    }

    private static function showTooltipHandler(param1:ListEvent):void {
        App.toolTipMgr.hide();
        if (param1.itemData.empty) {
            App.toolTipMgr.showComplex(TOOLTIPS.BARRACKS_ITEM_EMPTY);
        }
        else if (param1.itemData.buy) {
            App.toolTipMgr.showComplex(TOOLTIPS.BARRACKS_ITEM_BUY);
        }
        else {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TANKMAN, null, param1.itemData.tankmanID, false);
        }
    }

    private static function hideTooltipHandler(param1:ListEvent):void {
        App.toolTipMgr.hide();
    }

    override protected function configUI():void {
        super.configUI();
        this.tank.addEventListener(ListEvent.INDEX_CHANGE, this.onFilterTankChangeHandler);
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
            "label": "",
            "data": ""
        }, {
            "label": MENU.BARRACKS_MENU_LOCATIONFILTER_TANKS,
            "data": LOCATION_FILTER_TANKS
        }, {
            "label": MENU.BARRACKS_MENU_LOCATIONFILTER_BARRACKS,
            "data": LOCATION_FILTER_BARRACKS
        }, {
            "label": MENU.BARRACKS_MENU_LOCATIONFILTER_ALL,
            "data": LOCATION_FILTER_ALL
        }]);
        this.tankmenTileList.addEventListener(ListEvent.ITEM_ROLL_OVER, showTooltipHandler);
        this.tankmenTileList.addEventListener(ListEvent.ITEM_ROLL_OUT, hideTooltipHandler);
        this.tankmenTileList.addEventListener(ListEvent.ITEM_PRESS, hideTooltipHandler);
    }

    override protected function onDispose():void {
        App.toolTipMgr.hide();
        this.tankmenTileList.removeEventListener(ListEvent.ITEM_ROLL_OVER, showTooltipHandler);
        this.tankmenTileList.removeEventListener(ListEvent.ITEM_ROLL_OUT, hideTooltipHandler);
        this.tankmenTileList.removeEventListener(ListEvent.ITEM_PRESS, hideTooltipHandler);
        this.roleButtonBar.removeEventListener(IndexEvent.INDEX_CHANGE, this.onFilterChangeHandler);
        this.tankTypeButtonBar.removeEventListener(IndexEvent.INDEX_CHANGE, this.tankListInvalidateHandler);
        this.tank.removeEventListener(ListEvent.INDEX_CHANGE, this.onFilterTankChangeHandler);
        this.locationButtonBar.removeEventListener(IndexEvent.INDEX_CHANGE, this.onFilterChangeHandler);
        this.nationDDM.removeEventListener(ListEvent.INDEX_CHANGE, this.tankListInvalidateHandler);
        this.roleButtonBar.dispose();
        this.tankTypeButtonBar.dispose();
        this.locationButtonBar.dispose();
        this.tankmenTileList.dispose();
        this.nationDDM.dispose();
        this.tank.dispose();
        this.scrollBar.dispose();
        this.titleBtn.dispose();
        this.closeButton.dispose();
        this.scrollBar = null;
        this.titleBtn = null;
        this.tankmenTileList = null;
        this.tank = null;
        this.nationDDM = null;
        this.roleButtonBar = null;
        this.tankTypeButtonBar = null;
        this.locationButtonBar = null;
        this.closeButton = null;
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
                _loc1_ = 3;
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
                this.roleButtonBar.addEventListener(IndexEvent.INDEX_CHANGE, this.onFilterChangeHandler);
            }
            if (!this.tankTypeButtonBar.hasEventListener(IndexEvent.INDEX_CHANGE)) {
                this.tankTypeButtonBar.addEventListener(IndexEvent.INDEX_CHANGE, this.tankListInvalidateHandler);
            }
            if (!this.tank.hasEventListener(IndexEvent.INDEX_CHANGE)) {
                this.locationButtonBar.addEventListener(IndexEvent.INDEX_CHANGE, this.onFilterChangeHandler);
            }
            if (!this.nationDDM.hasEventListener(ListEvent.INDEX_CHANGE)) {
                this.nationDDM.addEventListener(ListEvent.INDEX_CHANGE, this.tankListInvalidateHandler);
            }
            this.checkFilters();
        }
    }

    public function as_setTankmen(param1:Number, param2:Number, param3:Number, param4:Number, param5:Array):void {
        this.tankmenCountTF.text = MENU.BARRACKS_TANKMENCOUNT;
        this.tankmenCountTF.replaceText(this.tankmenCountTF.text.indexOf("{"), this.tankmenCountTF.text.indexOf("}") + 1, param2.toString());
        this.tankmenCountTF.replaceText(this.tankmenCountTF.text.indexOf("{"), this.tankmenCountTF.text.indexOf("}") + 1, param1.toString());
        this.tankmenTileList.dataProvider = new DataProvider(param5);
        this.tankmenTileList.validateNow();
        this.tankmenTileList.selectedIndex = -1;
        this.placesCountTF.text = MENU.BARRACKS_PLACESCOUNT;
        this.placesCountTF.replaceText(this.placesCountTF.text.indexOf("{"), this.placesCountTF.text.indexOf("}") + 1, String(Math.max(param3 - param4, 0)));
        this.placesCountTF.replaceText(this.placesCountTF.text.indexOf("{"), this.placesCountTF.text.indexOf("}") + 1, String(param3));
    }

    public function as_setTankmenFilter(param1:Number, param2:String, param3:String, param4:String, param5:String):void {
        this._nation = param1;
        this._role = param2;
        this._tankType = param3;
        this._location = param4;
        this._nationID = param5;
        invalidate(INVALIDATE_TANKMEN_FILTER);
    }

    public function as_updateTanksList(param1:Array):void {
        this.tank.dataProvider = new DataProvider(param1);
        if (param1.length > 0) {
            this.tank.selectedIndex = 0;
            this.locationButtonBar.dataProvider[0].data = this.tank.dataProvider[this.tank.selectedIndex].data;
        }
        else {
            this.tank.selectedIndex = -1;
            this.locationButtonBar.dataProvider[0].data = "";
        }
        this.tank.validateNow();
        this.tank.enabled = param1.length > 0;
    }

    public function onPopulate():void {
        this.nationDDM.dataProvider = new DataProvider([{
            "label": MENU.NATIONS_ALL,
            "data": -1
        }].concat(App.utils.nations.getNationsData()));
    }

    private function updateSelectedIndex(param1:Object, param2:Object):void {
        var _loc5_:Boolean = false;
        var _loc6_:String = null;
        if (App.instance) {
            _loc5_ = param1 is ButtonBar || param1 is DropdownMenu;
            _loc6_ = "object in ... must be ButtonBar or DropdownMenu";
            App.utils.asserter.assert(_loc5_, _loc6_, TypeCastException);
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

    private function onFilterChangeHandler(param1:Event):void {
        this.checkFilters();
    }

    private function tankListInvalidateHandler(param1:Event):void {
        this.checkFilters();
        this.onInvalidateTanksList();
        this.checkFilters();
    }

    private function onFilterTankChangeHandler(param1:Event):void {
        this.locationButtonBar.selectedIndex = 0;
        if (this.tank.dataProvider.length > 0) {
            this.locationButtonBar.dataProvider[0].data = this.tank.dataProvider[this.tank.selectedIndex].data;
        }
        else {
            this.locationButtonBar.dataProvider[0].data = "";
        }
        this.checkFilters();
    }
}
}
