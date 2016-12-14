package net.wg.infrastructure.base.meta.impl {
import net.wg.data.VO.ReferralReferrerIntroVO;
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class ReferralReferrerIntroWindowMeta extends AbstractWindowView {

    public var onClickApplyButton:Function;

    public var onClickHrefLink:Function;

    private var _referralReferrerIntroVO:ReferralReferrerIntroVO;

    public function ReferralReferrerIntroWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._referralReferrerIntroVO) {
            this._referralReferrerIntroVO.dispose();
            this._referralReferrerIntroVO = null;
        }
        super.onDispose();
    }

    public function onClickApplyButtonS():void {
        App.utils.asserter.assertNotNull(this.onClickApplyButton, "onClickApplyButton" + Errors.CANT_NULL);
        this.onClickApplyButton();
    }

    public function onClickHrefLinkS():void {
        App.utils.asserter.assertNotNull(this.onClickHrefLink, "onClickHrefLink" + Errors.CANT_NULL);
        this.onClickHrefLink();
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:ReferralReferrerIntroVO = this._referralReferrerIntroVO;
        this._referralReferrerIntroVO = new ReferralReferrerIntroVO(param1);
        this.setData(this._referralReferrerIntroVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:ReferralReferrerIntroVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
