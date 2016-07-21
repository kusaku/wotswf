package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.components.advanced.vo.NormalSortingTableHeaderVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortIntelligenceWindowMeta extends AbstractWindowView {

    public var requestClanFortInfo:Function;

    private var _normalSortingTableHeaderVO:NormalSortingTableHeaderVO;

    public function FortIntelligenceWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._normalSortingTableHeaderVO) {
            this._normalSortingTableHeaderVO.dispose();
            this._normalSortingTableHeaderVO = null;
        }
        super.onDispose();
    }

    public function requestClanFortInfoS(param1:int):void {
        App.utils.asserter.assertNotNull(this.requestClanFortInfo, "requestClanFortInfo" + Errors.CANT_NULL);
        this.requestClanFortInfo(param1);
    }

    public function as_setTableHeader(param1:Object):void {
        if (this._normalSortingTableHeaderVO) {
            this._normalSortingTableHeaderVO.dispose();
        }
        this._normalSortingTableHeaderVO = new NormalSortingTableHeaderVO(param1);
        this.setTableHeader(this._normalSortingTableHeaderVO);
    }

    protected function setTableHeader(param1:NormalSortingTableHeaderVO):void {
        var _loc2_:String = "as_setTableHeader" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
