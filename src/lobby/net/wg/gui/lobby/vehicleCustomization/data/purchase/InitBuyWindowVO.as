package net.wg.gui.lobby.vehicleCustomization.data.purchase {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.components.controls.NormalSortingBtnVO;

public class InitBuyWindowVO extends DAAPIDataClass {

    private static const TABLE_HEADER:String = "tableHeader";

    public var windowTitle:String = "";

    public var btnBuyLabel:String = "";

    public var btnCancelLabel:String = "";

    public var imgGold:String = "";

    public var imgCredits:String = "";

    public var buyDisabledTooltip:String = "";

    public var defaultSortIndex:int = -1;

    private var _tableHeader:Vector.<NormalSortingBtnVO> = null;

    public function InitBuyWindowVO(param1:Object) {
        super(param1);
    }

    override protected function onDispose():void {
        var _loc1_:NormalSortingBtnVO = null;
        for each(_loc1_ in this._tableHeader) {
            _loc1_.dispose();
        }
        this._tableHeader.splice(0, this._tableHeader.length);
        this._tableHeader = null;
        super.onDispose();
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        if (param1 == TABLE_HEADER) {
            this._tableHeader = new Vector.<NormalSortingBtnVO>();
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, "tableHeaderData" + Errors.CANT_NULL);
            for each(_loc4_ in _loc3_) {
                this._tableHeader.push(new NormalSortingBtnVO(_loc4_));
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    public function get tableHeader():Vector.<NormalSortingBtnVO> {
        return this._tableHeader;
    }
}
}
