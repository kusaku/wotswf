package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationSummaryVO;
import net.wg.infrastructure.base.BaseDAAPIComponent;
import net.wg.infrastructure.exceptions.AbstractException;

public class StaticFormationSummaryViewMeta extends BaseDAAPIComponent {

    private var _staticFormationSummaryVO:StaticFormationSummaryVO;

    public function StaticFormationSummaryViewMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._staticFormationSummaryVO) {
            this._staticFormationSummaryVO.dispose();
            this._staticFormationSummaryVO = null;
        }
        super.onDispose();
    }

    public function as_setData(param1:Object):void {
        if (this._staticFormationSummaryVO) {
            this._staticFormationSummaryVO.dispose();
        }
        this._staticFormationSummaryVO = new StaticFormationSummaryVO(param1);
        this.setData(this._staticFormationSummaryVO);
    }

    protected function setData(param1:StaticFormationSummaryVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
