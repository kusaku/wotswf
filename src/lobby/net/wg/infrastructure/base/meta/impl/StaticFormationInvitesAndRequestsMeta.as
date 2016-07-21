package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.cyberSport.staticFormation.data.InvitesAndRequestsVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class StaticFormationInvitesAndRequestsMeta extends AbstractWindowView {

    public var setDescription:Function;

    public var setShowOnlyInvites:Function;

    public var resolvePlayerRequest:Function;

    private var _invitesAndRequestsVO:InvitesAndRequestsVO;

    public function StaticFormationInvitesAndRequestsMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._invitesAndRequestsVO) {
            this._invitesAndRequestsVO.dispose();
            this._invitesAndRequestsVO = null;
        }
        super.onDispose();
    }

    public function setDescriptionS(param1:String):void {
        App.utils.asserter.assertNotNull(this.setDescription, "setDescription" + Errors.CANT_NULL);
        this.setDescription(param1);
    }

    public function setShowOnlyInvitesS(param1:Boolean):void {
        App.utils.asserter.assertNotNull(this.setShowOnlyInvites, "setShowOnlyInvites" + Errors.CANT_NULL);
        this.setShowOnlyInvites(param1);
    }

    public function resolvePlayerRequestS(param1:int, param2:Boolean):void {
        App.utils.asserter.assertNotNull(this.resolvePlayerRequest, "resolvePlayerRequest" + Errors.CANT_NULL);
        this.resolvePlayerRequest(param1, param2);
    }

    public function as_setStaticData(param1:Object):void {
        if (this._invitesAndRequestsVO) {
            this._invitesAndRequestsVO.dispose();
        }
        this._invitesAndRequestsVO = new InvitesAndRequestsVO(param1);
        this.setStaticData(this._invitesAndRequestsVO);
    }

    protected function setStaticData(param1:InvitesAndRequestsVO):void {
        var _loc2_:String = "as_setStaticData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
