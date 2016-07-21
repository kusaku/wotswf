package net.wg.gui.cyberSport.controls {
import flash.events.Event;
import flash.events.MouseEvent;

import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.DropDownImageText;
import net.wg.gui.cyberSport.controls.events.VehicleSelectorFilterEvent;
import net.wg.gui.cyberSport.vo.VehicleSelectorFilterVO;
import net.wg.utils.INations;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.core.UIComponent;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ListEvent;

public class VehicleSelectorFilter extends UIComponent {

    public static const MODE_USER_VEHICLES:String = "userVehicles";

    public static const MODE_ALL_VEHICLES:String = "allVehicles";

    private static const NATION_FILTER_ALL:int = -1;

    private static const INVALID_MODE:String = "invalidMode";

    private static const VEHICLE_TYPE_POS:int = 57;

    private static const MAIN_CB_POS:int = 117;

    private static const MIN_LEVELS_TO_HIDE_DD:int = 2;

    public var levelDD:DropDownImageText;

    public var nationDD:DropDownImageText;

    public var vehicleTypeDD:DropDownImageText;

    public var mainCheckBox:CheckBox;

    public var compatibleOnlyCheckBox:CheckBox;

    private var _model:VehicleSelectorFilterVO;

    private var _mode:String = "allVehicles";

    private var _changeHandlersInited:Boolean = false;

    public function VehicleSelectorFilter() {
        super();
    }

    private static function onControllOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    override protected function configUI():void {
        super.configUI();
        this.compatibleOnlyCheckBox.label = CYBERSPORT.WINDOW_VEHICLESELECTOR_FILTERS_MATCHES;
        this.initFilters();
    }

    override protected function draw():void {
        super.draw();
        if (this._mode && isInvalid(INVALID_MODE)) {
            gotoAndStop(this._mode);
        }
        if (this._model && isInvalid(InvalidationType.DATA)) {
            this.vehicleTypeDD.dataProvider = new DataProvider(this._model.vehicleTypesDP);
            this.vehicleTypeDD.selectedIndex = 0;
            this.levelDD.dataProvider = new DataProvider(this._model.levelsDP);
            this.levelDD.selectedIndex = 0;
            this.selectNation(this._model.nation);
            this.selectVehicleType(this._model.vehicleType);
            this.selectLevel(this._model.level);
            if (this._mode == MODE_USER_VEHICLES) {
                this.mainCheckBox.selected = this._model.isMain;
            }
            this.compatibleOnlyCheckBox.selected = this._model.compatibleOnly;
            if (!this._changeHandlersInited) {
                this.initChangeHandlers();
                this._changeHandlersInited = true;
                this.onFiltersChangedHandler();
            }
            if (this._model.levelsDP.length <= MIN_LEVELS_TO_HIDE_DD) {
                this.levelDD.visible = false;
                this.nationDD.x = 0;
                this.vehicleTypeDD.x = VEHICLE_TYPE_POS;
                this.mainCheckBox.x = MAIN_CB_POS;
            }
        }
    }

    override protected function onDispose():void {
        this.nationDD.removeEventListener(ListEvent.INDEX_CHANGE, this.onFiltersChangedHandler);
        this.vehicleTypeDD.removeEventListener(ListEvent.INDEX_CHANGE, this.onFiltersChangedHandler);
        this.levelDD.removeEventListener(ListEvent.INDEX_CHANGE, this.onFiltersChangedHandler);
        this.mainCheckBox.removeEventListener(Event.SELECT, this.onFiltersChangedHandler);
        this.compatibleOnlyCheckBox.removeEventListener(Event.SELECT, this.onFiltersChangedHandler);
        this.nationDD.removeEventListener(MouseEvent.ROLL_OVER, this.onControllOverHandler);
        this.vehicleTypeDD.removeEventListener(MouseEvent.ROLL_OVER, this.onControllOverHandler);
        this.levelDD.removeEventListener(MouseEvent.ROLL_OVER, this.onControllOverHandler);
        this.mainCheckBox.removeEventListener(MouseEvent.ROLL_OVER, this.onControllOverHandler);
        this.nationDD.removeEventListener(MouseEvent.ROLL_OUT, onControllOutHandler);
        this.vehicleTypeDD.removeEventListener(MouseEvent.ROLL_OUT, onControllOutHandler);
        this.levelDD.removeEventListener(MouseEvent.ROLL_OUT, onControllOutHandler);
        this.mainCheckBox.removeEventListener(MouseEvent.ROLL_OUT, onControllOutHandler);
        this.nationDD.removeEventListener(MouseEvent.CLICK, onControllOutHandler);
        this.vehicleTypeDD.removeEventListener(MouseEvent.CLICK, onControllOutHandler);
        this.levelDD.removeEventListener(MouseEvent.CLICK, onControllOutHandler);
        this.mainCheckBox.removeEventListener(MouseEvent.CLICK, onControllOutHandler);
        this.nationDD.dispose();
        this.vehicleTypeDD.dispose();
        this.levelDD.dispose();
        this.mainCheckBox.dispose();
        this.compatibleOnlyCheckBox.dispose();
        this.levelDD = null;
        this.nationDD = null;
        this.vehicleTypeDD = null;
        this.mainCheckBox = null;
        this.compatibleOnlyCheckBox = null;
        this._model = null;
        super.onDispose();
    }

    public function setData(param1:VehicleSelectorFilterVO):void {
        this._model = param1;
        invalidate(InvalidationType.DATA);
    }

    private function initChangeHandlers():void {
        this.nationDD.addEventListener(ListEvent.INDEX_CHANGE, this.onFiltersChangedHandler);
        this.vehicleTypeDD.addEventListener(ListEvent.INDEX_CHANGE, this.onFiltersChangedHandler);
        this.levelDD.addEventListener(ListEvent.INDEX_CHANGE, this.onFiltersChangedHandler);
        this.mainCheckBox.addEventListener(Event.SELECT, this.onFiltersChangedHandler);
        this.compatibleOnlyCheckBox.addEventListener(Event.SELECT, this.onFiltersChangedHandler);
        this.nationDD.addEventListener(MouseEvent.ROLL_OVER, this.onControllOverHandler);
        this.vehicleTypeDD.addEventListener(MouseEvent.ROLL_OVER, this.onControllOverHandler);
        this.levelDD.addEventListener(MouseEvent.ROLL_OVER, this.onControllOverHandler);
        this.mainCheckBox.addEventListener(MouseEvent.ROLL_OVER, this.onControllOverHandler);
        this.nationDD.addEventListener(MouseEvent.ROLL_OUT, onControllOutHandler);
        this.vehicleTypeDD.addEventListener(MouseEvent.ROLL_OUT, onControllOutHandler);
        this.levelDD.addEventListener(MouseEvent.ROLL_OUT, onControllOutHandler);
        this.mainCheckBox.addEventListener(MouseEvent.ROLL_OUT, onControllOutHandler);
        this.nationDD.addEventListener(MouseEvent.CLICK, onControllOutHandler);
        this.vehicleTypeDD.addEventListener(MouseEvent.CLICK, onControllOutHandler);
        this.levelDD.addEventListener(MouseEvent.CLICK, onControllOutHandler);
        this.mainCheckBox.addEventListener(MouseEvent.CLICK, onControllOutHandler);
    }

    private function selectNation(param1:int):void {
        var _loc2_:Object = null;
        for each(_loc2_ in this.nationDD.dataProvider) {
            if (_loc2_.data == param1) {
                this.nationDD.selectedIndex = this.nationDD.dataProvider.indexOf(_loc2_);
                return;
            }
        }
    }

    private function selectVehicleType(param1:String):void {
        var _loc2_:Object = null;
        for each(_loc2_ in this.vehicleTypeDD.dataProvider) {
            if (_loc2_.data == param1) {
                this.vehicleTypeDD.selectedIndex = this.vehicleTypeDD.dataProvider.indexOf(_loc2_);
                return;
            }
        }
    }

    private function selectLevel(param1:int):void {
        var _loc2_:Object = null;
        for each(_loc2_ in this.levelDD.dataProvider) {
            if (_loc2_.data == param1) {
                this.levelDD.selectedIndex = this.levelDD.dataProvider.indexOf(_loc2_);
                return;
            }
        }
    }

    private function initFilters():void {
        var _loc1_:INations = App.utils.nations;
        var _loc2_:Array = _loc1_.getNationsData();
        var _loc3_:Array = [{
            "label": MENU.NATIONS_ALL,
            "data": NATION_FILTER_ALL,
            "icon": RES_ICONS.MAPS_ICONS_FILTERS_NATIONS_ALL
        }];
        var _loc4_:int = _loc2_.length;
        var _loc5_:uint = 0;
        while (_loc5_ < _loc4_) {
            _loc2_[_loc5_]["icon"] = "../maps/icons/filters/nations/" + _loc1_.getNationName(_loc2_[_loc5_]["data"]) + ".png";
            _loc3_.push(_loc2_[_loc5_]);
            _loc5_++;
        }
        this.nationDD.dataProvider = new DataProvider(_loc3_);
        this.nationDD.selectedIndex = 0;
    }

    public function get mode():String {
        return this._mode;
    }

    public function set mode(param1:String):void {
        this._mode = param1;
        invalidate(INVALID_MODE);
    }

    private function onFiltersChangedHandler(param1:Event = null):void {
        App.toolTipMgr.hide();
        var _loc2_:Object = this.nationDD.dataProvider.requestItemAt(this.nationDD.selectedIndex);
        var _loc3_:Object = this.vehicleTypeDD.dataProvider.requestItemAt(this.vehicleTypeDD.selectedIndex);
        var _loc4_:Object = this.levelDD.dataProvider.requestItemAt(this.levelDD.selectedIndex);
        var _loc5_:VehicleSelectorFilterEvent = new VehicleSelectorFilterEvent(VehicleSelectorFilterEvent.CHANGE, true);
        _loc5_.nation = !!_loc2_ ? int(_loc2_.data) : -1;
        _loc5_.vehicleType = !!_loc3_ ? _loc3_.data : null;
        _loc5_.level = !!_loc4_ ? int(_loc4_.data) : -1;
        _loc5_.isMain = this.mainCheckBox.selected;
        _loc5_.compatibleOnly = this.compatibleOnlyCheckBox.selected;
        dispatchEvent(_loc5_);
    }

    private function onControllOverHandler(param1:MouseEvent):void {
        switch (param1.target) {
            case this.nationDD:
                App.toolTipMgr.show(TOOLTIPS.VEHICLESELECTOR_FILTER_NATION);
                break;
            case this.vehicleTypeDD:
                App.toolTipMgr.show(TOOLTIPS.VEHICLESELECTOR_FILTER_VEHTYPE);
                break;
            case this.levelDD:
                App.toolTipMgr.show(TOOLTIPS.VEHICLESELECTOR_FILTER_VEHLVL);
                break;
            case this.mainCheckBox:
                App.toolTipMgr.show(TOOLTIPS.VEHICLESELECTOR_FILTER_MAINVEHICLE);
        }
    }
}
}
