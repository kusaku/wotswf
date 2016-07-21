package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.components.advanced.vo.ComplexProgressIndicatorVO;
import net.wg.gui.lobby.referralSystem.data.AwardDataDataVO;
import net.wg.gui.lobby.window.RefManagementWindowVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class ReferralManagementWindowMeta extends AbstractWindowView {

    public var onInvitesManagementLinkClick:Function;

    public var inviteIntoSquad:Function;

    private var _awardDataDataVO:AwardDataDataVO;

    private var _refManagementWindowVO:RefManagementWindowVO;

    private var _complexProgressIndicatorVO:ComplexProgressIndicatorVO;

    public function ReferralManagementWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._awardDataDataVO) {
            this._awardDataDataVO.dispose();
            this._awardDataDataVO = null;
        }
        if (this._refManagementWindowVO) {
            this._refManagementWindowVO.dispose();
            this._refManagementWindowVO = null;
        }
        if (this._complexProgressIndicatorVO) {
            this._complexProgressIndicatorVO.dispose();
            this._complexProgressIndicatorVO = null;
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

    public function as_setData(param1:Object):void {
        if (this._refManagementWindowVO) {
            this._refManagementWindowVO.dispose();
        }
        this._refManagementWindowVO = new RefManagementWindowVO(param1);
        this.setData(this._refManagementWindowVO);
    }

    public function as_setAwardDataData(param1:Object):void {
        if (this._awardDataDataVO) {
            this._awardDataDataVO.dispose();
        }
        this._awardDataDataVO = new AwardDataDataVO(param1);
        this.setAwardDataData(this._awardDataDataVO);
    }

    public function as_setProgressData(param1:Object):void {
        if (this._complexProgressIndicatorVO) {
            this._complexProgressIndicatorVO.dispose();
        }
        this._complexProgressIndicatorVO = new ComplexProgressIndicatorVO(param1);
        this.setProgressData(this._complexProgressIndicatorVO);
    }

    protected function setData(param1:RefManagementWindowVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
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
