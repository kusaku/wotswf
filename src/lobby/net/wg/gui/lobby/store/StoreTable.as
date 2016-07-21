package net.wg.gui.lobby.store {
import flash.text.TextField;

import net.wg.data.VO.StoreTableVO;
import net.wg.data.constants.Errors;
import net.wg.data.constants.generated.FITTING_TYPES;
import net.wg.gui.lobby.store.interfaces.IStoreTable;
import net.wg.infrastructure.base.meta.impl.StoreTableMeta;
import net.wg.infrastructure.exceptions.ArgumentException;
import net.wg.infrastructure.exceptions.NullPointerException;

import scaleform.clik.interfaces.IListItemRenderer;

public class StoreTable extends StoreTableMeta implements IStoreTable {

    private static const INVALID_TABLE:String = "invalidTable";

    public var header:TableHeader = null;

    public var list:StoreList = null;

    public var headerTitle:TextField = null;

    private var _tableVO:StoreTableVO = null;

    private var _tableDP:StoreTableDataProvider = null;

    private var _type:String = null;

    private var _vehicleRendererLinkage:String = null;

    private var _moduleRendererLinkage:String = null;

    public function StoreTable() {
        super();
        this._tableDP = new StoreTableDataProvider();
    }

    private static function assertNotNull(param1:Object, param2:String):void {
        if (App.instance) {
            App.utils.asserter.assert(param1 != null, param2 + Errors.CANT_NULL, NullPointerException);
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.list.dataProvider = this._tableDP;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALID_TABLE) && this._tableVO) {
            this.updateTable();
        }
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this._tableVO = new StoreTableVO();
        if (this._type) {
            invalidate(INVALID_TABLE);
        }
    }

    override protected function onDispose():void {
        this.header.dispose();
        this.header = null;
        this.list.dispose();
        this.list = null;
        this.headerTitle = null;
        this._tableVO = null;
        this._type = null;
        this._vehicleRendererLinkage = null;
        this._moduleRendererLinkage = null;
        this._tableDP.cleanUp();
        this._tableDP = null;
        super.onDispose();
    }

    public function as_getTableDataProvider():Object {
        return this._tableDP;
    }

    public function as_scrollToFirst(param1:Number, param2:String, param3:String):void {
    }

    public function as_setCredits(param1:Number):void {
        StoreTable.assertNotNull(this._tableVO, "_tableVO");
        this._tableVO.credits = param1;
    }

    public function as_setGold(param1:Number):void {
        StoreTable.assertNotNull(this._tableVO, "_tableVO");
        this._tableVO.gold = param1;
    }

    public function as_setTableType(param1:String):void {
        StoreTable.assertNotNull(param1, "TableType");
        this._type = param1;
        invalidate(INVALID_TABLE);
    }

    public function setModuleRendererLinkage(param1:String):void {
        StoreTable.assertNotNull(param1, "linkage");
        this._moduleRendererLinkage = param1;
    }

    public function setVehicleRendererLinkage(param1:String):void {
        StoreTable.assertNotNull(param1, "linkage");
        this._vehicleRendererLinkage = param1;
    }

    public function updateHeaderCountTitle(param1:String):void {
        this.header.headerInfo.countField.text = param1;
    }

    private function updateTable():void {
        StoreTable.assertNotNull(this._type, "_type");
        StoreTable.assertNotNull(this._moduleRendererLinkage, "moduleRendererLinkage");
        StoreTable.assertNotNull(this._vehicleRendererLinkage, "vehicleRendererLinkage");
        this.list.scrollToIndex(0);
        this.setupRendererType(this._type);
        this.setupDataProvider(this._type);
    }

    private function setupRendererType(param1:String):void {
        var rendererName:String = null;
        var classRef:Class = null;
        var type:String = param1;
        rendererName = this._moduleRendererLinkage;
        if (type == FITTING_TYPES.VEHICLE) {
            rendererName = this._vehicleRendererLinkage;
        }
        this.detectRendererHeight(rendererName);
        try {
            classRef = App.utils.classFactory.getClass(rendererName);
            if (this.list.itemRenderer != classRef) {
                this.list.itemRendererName = rendererName;
            }
            return;
        }
        catch (error:ReferenceError) {
            throw new ArgumentException(Errors.BAD_LINKAGE + rendererName, error.errorID);
        }
    }

    private function setupDataProvider(param1:String):void {
        this._tableDP.type = param1;
        this._tableDP.tableVO = this._tableVO;
        refreshStoreTableDataProviderS();
        if (App.instance) {
            this.headerTitle.text = App.utils.locale.makeString(MENU.SHOP_TABLE_FIND) + " " + this._tableDP.length.toString();
        }
        else {
            this.headerTitle.text = MENU.SHOP_TABLE_FIND + " " + this._tableDP.length.toString();
        }
    }

    private function detectRendererHeight(param1:String):void {
        var _loc2_:IListItemRenderer = null;
        if (App.instance) {
            _loc2_ = App.utils.classFactory.getComponent(param1, IListItemRenderer);
            this.list.rowHeight = _loc2_.height;
        }
    }
}
}
