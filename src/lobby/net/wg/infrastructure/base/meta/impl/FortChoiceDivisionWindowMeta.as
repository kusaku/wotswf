package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.FortChoiceDivisionVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortChoiceDivisionWindowMeta extends AbstractWindowView {

    public var selectedDivision:Function;

    public var changedDivision:Function;

    private var _fortChoiceDivisionVO:FortChoiceDivisionVO;

    public function FortChoiceDivisionWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._fortChoiceDivisionVO) {
            this._fortChoiceDivisionVO.dispose();
            this._fortChoiceDivisionVO = null;
        }
        super.onDispose();
    }

    public function selectedDivisionS(param1:int):void {
        App.utils.asserter.assertNotNull(this.selectedDivision, "selectedDivision" + Errors.CANT_NULL);
        this.selectedDivision(param1);
    }

    public function changedDivisionS(param1:int):void {
        App.utils.asserter.assertNotNull(this.changedDivision, "changedDivision" + Errors.CANT_NULL);
        this.changedDivision(param1);
    }

    public function as_setData(param1:Object):void {
        if (this._fortChoiceDivisionVO) {
            this._fortChoiceDivisionVO.dispose();
        }
        this._fortChoiceDivisionVO = new FortChoiceDivisionVO(param1);
        this.setData(this._fortChoiceDivisionVO);
    }

    protected function setData(param1:FortChoiceDivisionVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
