package net.wg.gui.lobby.vehicleCustomization.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class FiltersStateVO extends DAAPIDataClass {

    private static const BONUS_TYPES_SELECTED:String = "bonusTypeSelected";

    public var customizationTypeSelectedIndex:int = -1;

    public var purchaseTypeSelectedIndex:int = -1;

    public var enableGroupFilter:Boolean = true;

    private var _bonusTypeSelected:Vector.<Boolean> = null;

    public function FiltersStateVO(param1:Object) {
        super(param1);
    }

    override protected function onDispose():void {
        this._bonusTypeSelected.splice(0, this._bonusTypeSelected.length);
        this._bonusTypeSelected = null;
        super.onDispose();
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Boolean = false;
        if (param1 == BONUS_TYPES_SELECTED) {
            this._bonusTypeSelected = new Vector.<Boolean>();
            for each(_loc3_ in param2) {
                this._bonusTypeSelected.push(_loc3_);
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    public function get bonusTypeSelected():Vector.<Boolean> {
        return this._bonusTypeSelected;
    }
}
}
