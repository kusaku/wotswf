package net.wg.gui.battle.views.minimap {
import net.wg.data.constants.Errors;
import net.wg.gui.battle.views.minimap.components.entries.interfaces.IVehicleMinimapEntry;
import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.utils.IAssertable;

public class MinimapEntryController implements IDisposable {

    private static var _instance:MinimapEntryController = null;

    private var _vehicleEntries:Vector.<IVehicleMinimapEntry> = null;

    private var _vehicleLabelsEntries:Vector.<IVehicleMinimapEntry> = null;

    private var _isDisposed:Boolean = false;

    private var _asserter:IAssertable;

    private var _lastHighlightedEntry:IVehicleMinimapEntry = null;

    private var _isShowVehicleNamesTurnedOn:Boolean = false;

    public function MinimapEntryController(param1:PrivateClass) {
        var _loc2_:IAssertable = null;
        this._asserter = App.utils.asserter;
        super();
        if (_instance) {
            _loc2_ = App.utils.asserter;
            _loc2_.assertNotNull(_instance, "MinimapEntryController singleton... use get instance()");
        }
        this._vehicleEntries = new Vector.<IVehicleMinimapEntry>();
        this._vehicleLabelsEntries = new Vector.<IVehicleMinimapEntry>();
        _instance = this;
    }

    public static function get instance():MinimapEntryController {
        if (_instance == null) {
            _instance = new MinimapEntryController(new PrivateClass());
        }
        return _instance;
    }

    public function registerVehicleEntry(param1:IVehicleMinimapEntry):void {
        this.verifyIsDisposed();
        this._vehicleEntries.push(param1);
    }

    public function registerVehicleLabelEntry(param1:IVehicleMinimapEntry):void {
        this.verifyIsDisposed();
        this._vehicleLabelsEntries.push(param1);
        if (this._isShowVehicleNamesTurnedOn) {
            param1.showVehicleName();
        }
        else {
            param1.hideVehicleName();
        }
    }

    public function unregisterVehicleEntry(param1:IVehicleMinimapEntry):void {
        this.verifyIsDisposed();
        this._vehicleEntries.splice(this._vehicleEntries.indexOf(param1), 1);
    }

    public function highlight(param1:Number):void {
        var _loc2_:IVehicleMinimapEntry = null;
        for each(_loc2_ in this._vehicleEntries) {
            if (_loc2_.vehicleID == param1) {
                this._lastHighlightedEntry = _loc2_;
                _loc2_.highlight();
                return;
            }
        }
    }

    public function unhighlight():void {
        if (this._lastHighlightedEntry) {
            this._lastHighlightedEntry.unhighlight();
            this._lastHighlightedEntry = null;
        }
    }

    public function showVehiclesName():void {
        var _loc1_:IVehicleMinimapEntry = null;
        this._isShowVehicleNamesTurnedOn = true;
        for each(_loc1_ in this._vehicleLabelsEntries) {
            _loc1_.showVehicleName();
        }
    }

    public function hideVehiclesName():void {
        var _loc1_:IVehicleMinimapEntry = null;
        this._isShowVehicleNamesTurnedOn = false;
        for each(_loc1_ in this._vehicleLabelsEntries) {
            _loc1_.hideVehicleName();
        }
    }

    private function verifyIsDisposed():void {
        this._asserter.assert(!this._isDisposed, "MinimapEntryController " + Errors.ALREADY_DISPOSED);
    }

    public function dispose():void {
        this.verifyIsDisposed();
        this._isDisposed = true;
        this._asserter = null;
        this._vehicleEntries.splice(0, this._vehicleEntries.length);
        this._vehicleEntries = null;
        this._vehicleLabelsEntries.splice(0, this._vehicleLabelsEntries.length);
        this._vehicleLabelsEntries = null;
        this._lastHighlightedEntry = null;
    }
}
}

class PrivateClass {

    function PrivateClass() {
        super();
    }
}
