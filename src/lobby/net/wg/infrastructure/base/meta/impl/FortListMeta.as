package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.components.advanced.vo.NormalSortingTableHeaderVO;
import net.wg.gui.lobby.fortifications.data.FortRegulationInfoVO;
import net.wg.gui.rally.views.list.BaseRallyListView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortListMeta extends BaseRallyListView {

    public var changeDivisionIndex:Function;

    private var _fortRegulationInfoVO:FortRegulationInfoVO;

    private var _normalSortingTableHeaderVO:NormalSortingTableHeaderVO;

    public function FortListMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._fortRegulationInfoVO) {
            this._fortRegulationInfoVO.dispose();
            this._fortRegulationInfoVO = null;
        }
        if (this._normalSortingTableHeaderVO) {
            this._normalSortingTableHeaderVO.dispose();
            this._normalSortingTableHeaderVO = null;
        }
        super.onDispose();
    }

    public function changeDivisionIndexS(param1:int):void {
        App.utils.asserter.assertNotNull(this.changeDivisionIndex, "changeDivisionIndex" + Errors.CANT_NULL);
        this.changeDivisionIndex(param1);
    }

    public final function as_setRegulationInfo(param1:Object):void {
        var _loc2_:FortRegulationInfoVO = this._fortRegulationInfoVO;
        this._fortRegulationInfoVO = new FortRegulationInfoVO(param1);
        this.setRegulationInfo(this._fortRegulationInfoVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setTableHeader(param1:Object):void {
        var _loc2_:NormalSortingTableHeaderVO = this._normalSortingTableHeaderVO;
        this._normalSortingTableHeaderVO = new NormalSortingTableHeaderVO(param1);
        this.setTableHeader(this._normalSortingTableHeaderVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setRegulationInfo(param1:FortRegulationInfoVO):void {
        var _loc2_:String = "as_setRegulationInfo" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setTableHeader(param1:NormalSortingTableHeaderVO):void {
        var _loc2_:String = "as_setTableHeader" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
