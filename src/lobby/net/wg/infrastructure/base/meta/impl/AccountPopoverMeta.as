package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.header.vo.AccountClanPopoverBlockVO;
import net.wg.gui.lobby.header.vo.AccountPopoverBlockVO;
import net.wg.gui.lobby.header.vo.AccountPopoverMainVO;
import net.wg.gui.lobby.header.vo.AccountPopoverReferralBlockVO;
import net.wg.infrastructure.base.SmartPopOverView;
import net.wg.infrastructure.exceptions.AbstractException;

public class AccountPopoverMeta extends SmartPopOverView {

    public var openBoostersWindow:Function;

    public var openClanResearch:Function;

    public var openRequestWindow:Function;

    public var openInviteWindow:Function;

    public var openClanStatistic:Function;

    public var openCrewStatistic:Function;

    public var openReferralManagement:Function;

    private var _accountClanPopoverBlockVO:AccountClanPopoverBlockVO;

    private var _accountPopoverBlockVO:AccountPopoverBlockVO;

    private var _accountPopoverMainVO:AccountPopoverMainVO;

    private var _accountPopoverReferralBlockVO:AccountPopoverReferralBlockVO;

    public function AccountPopoverMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._accountClanPopoverBlockVO) {
            this._accountClanPopoverBlockVO.dispose();
            this._accountClanPopoverBlockVO = null;
        }
        if (this._accountPopoverBlockVO) {
            this._accountPopoverBlockVO.dispose();
            this._accountPopoverBlockVO = null;
        }
        if (this._accountPopoverMainVO) {
            this._accountPopoverMainVO.dispose();
            this._accountPopoverMainVO = null;
        }
        if (this._accountPopoverReferralBlockVO) {
            this._accountPopoverReferralBlockVO.dispose();
            this._accountPopoverReferralBlockVO = null;
        }
        super.onDispose();
    }

    public function openBoostersWindowS(param1:String):void {
        App.utils.asserter.assertNotNull(this.openBoostersWindow, "openBoostersWindow" + Errors.CANT_NULL);
        this.openBoostersWindow(param1);
    }

    public function openClanResearchS():void {
        App.utils.asserter.assertNotNull(this.openClanResearch, "openClanResearch" + Errors.CANT_NULL);
        this.openClanResearch();
    }

    public function openRequestWindowS():void {
        App.utils.asserter.assertNotNull(this.openRequestWindow, "openRequestWindow" + Errors.CANT_NULL);
        this.openRequestWindow();
    }

    public function openInviteWindowS():void {
        App.utils.asserter.assertNotNull(this.openInviteWindow, "openInviteWindow" + Errors.CANT_NULL);
        this.openInviteWindow();
    }

    public function openClanStatisticS():void {
        App.utils.asserter.assertNotNull(this.openClanStatistic, "openClanStatistic" + Errors.CANT_NULL);
        this.openClanStatistic();
    }

    public function openCrewStatisticS():void {
        App.utils.asserter.assertNotNull(this.openCrewStatistic, "openCrewStatistic" + Errors.CANT_NULL);
        this.openCrewStatistic();
    }

    public function openReferralManagementS():void {
        App.utils.asserter.assertNotNull(this.openReferralManagement, "openReferralManagement" + Errors.CANT_NULL);
        this.openReferralManagement();
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:AccountPopoverMainVO = this._accountPopoverMainVO;
        this._accountPopoverMainVO = new AccountPopoverMainVO(param1);
        this.setData(this._accountPopoverMainVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setClanData(param1:Object):void {
        var _loc2_:AccountClanPopoverBlockVO = this._accountClanPopoverBlockVO;
        this._accountClanPopoverBlockVO = new AccountClanPopoverBlockVO(param1);
        this.setClanData(this._accountClanPopoverBlockVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setCrewData(param1:Object):void {
        var _loc2_:AccountPopoverBlockVO = this._accountPopoverBlockVO;
        this._accountPopoverBlockVO = new AccountPopoverBlockVO(param1);
        this.setCrewData(this._accountPopoverBlockVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setReferralData(param1:Object):void {
        var _loc2_:AccountPopoverReferralBlockVO = this._accountPopoverReferralBlockVO;
        this._accountPopoverReferralBlockVO = new AccountPopoverReferralBlockVO(param1);
        this.setReferralData(this._accountPopoverReferralBlockVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:AccountPopoverMainVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setClanData(param1:AccountClanPopoverBlockVO):void {
        var _loc2_:String = "as_setClanData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setCrewData(param1:AccountPopoverBlockVO):void {
        var _loc2_:String = "as_setCrewData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setReferralData(param1:AccountPopoverReferralBlockVO):void {
        var _loc2_:String = "as_setReferralData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
