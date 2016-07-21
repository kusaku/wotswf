package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.components.advanced.vo.DummyVO;
import net.wg.infrastructure.base.BaseDAAPIComponent;
import net.wg.infrastructure.exceptions.AbstractException;

public class ClanInvitesViewWithTableMeta extends BaseDAAPIComponent {

    public var showMore:Function;

    public var refreshTable:Function;

    private var _dummyVO:DummyVO;

    public function ClanInvitesViewWithTableMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._dummyVO) {
            this._dummyVO.dispose();
            this._dummyVO = null;
        }
        super.onDispose();
    }

    public function showMoreS():void {
        App.utils.asserter.assertNotNull(this.showMore, "showMore" + Errors.CANT_NULL);
        this.showMore();
    }

    public function refreshTableS():void {
        App.utils.asserter.assertNotNull(this.refreshTable, "refreshTable" + Errors.CANT_NULL);
        this.refreshTable();
    }

    public function as_showDummy(param1:Object):void {
        if (this._dummyVO) {
            this._dummyVO.dispose();
        }
        this._dummyVO = new DummyVO(param1);
        this.showDummy(this._dummyVO);
    }

    protected function showDummy(param1:DummyVO):void {
        var _loc2_:String = "as_showDummy" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
