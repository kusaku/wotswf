package net.wg.infrastructure.base.meta.impl {
import net.wg.data.VO.RefSysReferralsIntroVO;
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class ReferralReferralsIntroWindowMeta extends AbstractWindowView {

    public var onClickApplyBtn:Function;

    private var _refSysReferralsIntroVO:RefSysReferralsIntroVO;

    public function ReferralReferralsIntroWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._refSysReferralsIntroVO) {
            this._refSysReferralsIntroVO.dispose();
            this._refSysReferralsIntroVO = null;
        }
        super.onDispose();
    }

    public function onClickApplyBtnS():void {
        App.utils.asserter.assertNotNull(this.onClickApplyBtn, "onClickApplyBtn" + Errors.CANT_NULL);
        this.onClickApplyBtn();
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:RefSysReferralsIntroVO = this._refSysReferralsIntroVO;
        this._refSysReferralsIntroVO = new RefSysReferralsIntroVO(param1);
        this.setData(this._refSysReferralsIntroVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:RefSysReferralsIntroVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
