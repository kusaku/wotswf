package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.components.advanced.vo.ComplexProgressIndicatorVO;
import net.wg.gui.lobby.referralSystem.ReferralsTableRendererVO;
import net.wg.gui.lobby.referralSystem.data.AwardDataDataVO;
import net.wg.gui.lobby.window.RefManagementWindowVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

import scaleform.clik.data.DataProvider;

public class ReferralManagementWindowMeta extends AbstractWindowView {

    public var onInvitesManagementLinkClick:Function;

    public var inviteIntoSquad:Function;

    private var _awardDataDataVO:AwardDataDataVO;

    private var _complexProgressIndicatorVO:ComplexProgressIndicatorVO;

    private var _dataProviderReferralsTableRendererVO:DataProvider;

    private var _refManagementWindowVO:RefManagementWindowVO;

    public function ReferralManagementWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        var _loc1_:ReferralsTableRendererVO = null;
        if (this._awardDataDataVO) {
            this._awardDataDataVO.dispose();
            this._awardDataDataVO = null;
        }
        if (this._complexProgressIndicatorVO) {
            this._complexProgressIndicatorVO.dispose();
            this._complexProgressIndicatorVO = null;
        }
        if (this._dataProviderReferralsTableRendererVO) {
            for each(_loc1_ in this._dataProviderReferralsTableRendererVO) {
                _loc1_.dispose();
            }
            this._dataProviderReferralsTableRendererVO.cleanUp();
            this._dataProviderReferralsTableRendererVO = null;
        }
        if (this._refManagementWindowVO) {
            this._refManagementWindowVO.dispose();
            this._refManagementWindowVO = null;
        }
        super.onDispose();
    }

    public function onInvitesManagementLinkClickS():void {
        App.utils.asserter.assertNotNull(this.onInvitesManagementLinkClick, "onInvitesManagementLinkClick" + Errors.CANT_NULL);
        this.onInvitesManagementLinkClick();
    }

    public function inviteIntoSquadS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.inviteIntoSquad, "inviteIntoSquad" + Errors.CANT_NULL);
        this.inviteIntoSquad(param1);
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:RefManagementWindowVO = this._refManagementWindowVO;
        this._refManagementWindowVO = new RefManagementWindowVO(param1);
        this.setData(this._refManagementWindowVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setTableData(param1:Array):void {
        var _loc5_:ReferralsTableRendererVO = null;
        var _loc2_:DataProvider = this._dataProviderReferralsTableRendererVO;
        this._dataProviderReferralsTableRendererVO = new DataProvider();
        var _loc3_:uint = param1.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            this._dataProviderReferralsTableRendererVO[_loc4_] = new ReferralsTableRendererVO(param1[_loc4_]);
            _loc4_++;
        }
        this.setTableData(this._dataProviderReferralsTableRendererVO);
        if (_loc2_) {
            for each(_loc5_ in _loc2_) {
                _loc5_.dispose();
            }
            _loc2_.cleanUp();
        }
    }

    public final function as_setAwardDataData(param1:Object):void {
        var _loc2_:AwardDataDataVO = this._awardDataDataVO;
        this._awardDataDataVO = new AwardDataDataVO(param1);
        this.setAwardDataData(this._awardDataDataVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setProgressData(param1:Object):void {
        var _loc2_:ComplexProgressIndicatorVO = this._complexProgressIndicatorVO;
        this._complexProgressIndicatorVO = new ComplexProgressIndicatorVO(param1);
        this.setProgressData(this._complexProgressIndicatorVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:RefManagementWindowVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setTableData(param1:DataProvider):void {
        var _loc2_:String = "as_setTableData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setAwardDataData(param1:AwardDataDataVO):void {
        var _loc2_:String = "as_setAwardDataData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setProgressData(param1:ComplexProgressIndicatorVO):void {
        var _loc2_:String = "as_setProgressData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
