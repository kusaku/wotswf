package net.wg.infrastructure.base.meta.impl {
import net.wg.data.VO.ShopSubFilterData;
import net.wg.data.VO.generated.ShopNationFilterData;
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.store.data.FiltersDataVO;
import net.wg.infrastructure.base.BaseDAAPIComponent;
import net.wg.infrastructure.exceptions.AbstractException;

public class StoreComponentMeta extends BaseDAAPIComponent {

    public var requestTableData:Function;

    public var requestFilterData:Function;

    public var onShowInfo:Function;

    public var getName:Function;

    public var onAddVehToCompare:Function;

    private var _shopSubFilterData:ShopSubFilterData;

    private var _filtersDataVO:FiltersDataVO;

    private var _shopNationFilterData:ShopNationFilterData;

    public function StoreComponentMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._shopSubFilterData) {
            this._shopSubFilterData.dispose();
            this._shopSubFilterData = null;
        }
        if (this._filtersDataVO) {
            this._filtersDataVO.dispose();
            this._filtersDataVO = null;
        }
        if (this._shopNationFilterData) {
            this._shopNationFilterData.dispose();
            this._shopNationFilterData = null;
        }
        super.onDispose();
    }

    public function requestTableDataS(param1:Number, param2:String, param3:Object):void {
        App.utils.asserter.assertNotNull(this.requestTableData, "requestTableData" + Errors.CANT_NULL);
        this.requestTableData(param1, param2, param3);
    }

    public function requestFilterDataS(param1:String):void {
        App.utils.asserter.assertNotNull(this.requestFilterData, "requestFilterData" + Errors.CANT_NULL);
        this.requestFilterData(param1);
    }

    public function onShowInfoS(param1:String):void {
        App.utils.asserter.assertNotNull(this.onShowInfo, "onShowInfo" + Errors.CANT_NULL);
        this.onShowInfo(param1);
    }

    public function getNameS():String {
        App.utils.asserter.assertNotNull(this.getName, "getName" + Errors.CANT_NULL);
        return this.getName();
    }

    public function onAddVehToCompareS(param1:String):void {
        App.utils.asserter.assertNotNull(this.onAddVehToCompare, "onAddVehToCompare" + Errors.CANT_NULL);
        this.onAddVehToCompare(param1);
    }

    public function as_setFilterType(param1:Object):void {
        if (this._shopNationFilterData) {
            this._shopNationFilterData.dispose();
        }
        this._shopNationFilterData = new ShopNationFilterData(param1);
        this.setFilterType(this._shopNationFilterData);
    }

    public function as_setSubFilter(param1:Object):void {
        if (this._shopSubFilterData) {
            this._shopSubFilterData.dispose();
        }
        this._shopSubFilterData = new ShopSubFilterData(param1);
        this.setSubFilter(this._shopSubFilterData);
    }

    public function as_setFilterOptions(param1:Object):void {
        if (this._filtersDataVO) {
            this._filtersDataVO.dispose();
        }
        this._filtersDataVO = new FiltersDataVO(param1);
        this.setFilterOptions(this._filtersDataVO);
    }

    protected function setFilterType(param1:ShopNationFilterData):void {
        var _loc2_:String = "as_setFilterType" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setSubFilter(param1:ShopSubFilterData):void {
        var _loc2_:String = "as_setSubFilter" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setFilterOptions(param1:FiltersDataVO):void {
        var _loc2_:String = "as_setFilterOptions" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
