package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationUnitViewHeaderVO;
import net.wg.gui.rally.views.room.BaseRallyRoomViewWithWaiting;
import net.wg.infrastructure.exceptions.AbstractException;

public class StaticFormationUnitMeta extends BaseRallyRoomViewWithWaiting {

    public var toggleStatusRequest:Function;

    public var setRankedMode:Function;

    public var showTeamCard:Function;

    private var _staticFormationUnitViewHeaderVO:StaticFormationUnitViewHeaderVO;

    public function StaticFormationUnitMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._staticFormationUnitViewHeaderVO) {
            this._staticFormationUnitViewHeaderVO.dispose();
            this._staticFormationUnitViewHeaderVO = null;
        }
        super.onDispose();
    }

    public function toggleStatusRequestS():void {
        App.utils.asserter.assertNotNull(this.toggleStatusRequest, "toggleStatusRequest" + Errors.CANT_NULL);
        this.toggleStatusRequest();
    }

    public function setRankedModeS(param1:Boolean):void {
        App.utils.asserter.assertNotNull(this.setRankedMode, "setRankedMode" + Errors.CANT_NULL);
        this.setRankedMode(param1);
    }

    public function showTeamCardS():void {
        App.utils.asserter.assertNotNull(this.showTeamCard, "showTeamCard" + Errors.CANT_NULL);
        this.showTeamCard();
    }

    public final function as_setHeaderData(param1:Object):void {
        var _loc2_:StaticFormationUnitViewHeaderVO = this._staticFormationUnitViewHeaderVO;
        this._staticFormationUnitViewHeaderVO = new StaticFormationUnitViewHeaderVO(param1);
        this.setHeaderData(this._staticFormationUnitViewHeaderVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setHeaderData(param1:StaticFormationUnitViewHeaderVO):void {
        var _loc2_:String = "as_setHeaderData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
