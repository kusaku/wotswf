package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.cyberSport.vo.CSIntroViewStaticTeamVO;
import net.wg.gui.cyberSport.vo.CSIntroViewTextsVO;
import net.wg.gui.rally.views.intro.BaseRallyIntroView;
import net.wg.infrastructure.exceptions.AbstractException;

public class CyberSportIntroMeta extends BaseRallyIntroView {

    public var requestVehicleSelection:Function;

    public var startAutoMatching:Function;

    public var showSelectorPopup:Function;

    public var showStaticTeamProfile:Function;

    public var cancelWaitingTeamRequest:Function;

    public var showStaticTeamStaff:Function;

    public var joinClubUnit:Function;

    private var _cSIntroViewTextsVO:CSIntroViewTextsVO;

    private var _cSIntroViewStaticTeamVO:CSIntroViewStaticTeamVO;

    public function CyberSportIntroMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._cSIntroViewTextsVO) {
            this._cSIntroViewTextsVO.dispose();
            this._cSIntroViewTextsVO = null;
        }
        if (this._cSIntroViewStaticTeamVO) {
            this._cSIntroViewStaticTeamVO.dispose();
            this._cSIntroViewStaticTeamVO = null;
        }
        super.onDispose();
    }

    public function requestVehicleSelectionS():void {
        App.utils.asserter.assertNotNull(this.requestVehicleSelection, "requestVehicleSelection" + Errors.CANT_NULL);
        this.requestVehicleSelection();
    }

    public function startAutoMatchingS():void {
        App.utils.asserter.assertNotNull(this.startAutoMatching, "startAutoMatching" + Errors.CANT_NULL);
        this.startAutoMatching();
    }

    public function showSelectorPopupS():void {
        App.utils.asserter.assertNotNull(this.showSelectorPopup, "showSelectorPopup" + Errors.CANT_NULL);
        this.showSelectorPopup();
    }

    public function showStaticTeamProfileS():void {
        App.utils.asserter.assertNotNull(this.showStaticTeamProfile, "showStaticTeamProfile" + Errors.CANT_NULL);
        this.showStaticTeamProfile();
    }

    public function cancelWaitingTeamRequestS():void {
        App.utils.asserter.assertNotNull(this.cancelWaitingTeamRequest, "cancelWaitingTeamRequest" + Errors.CANT_NULL);
        this.cancelWaitingTeamRequest();
    }

    public function showStaticTeamStaffS():void {
        App.utils.asserter.assertNotNull(this.showStaticTeamStaff, "showStaticTeamStaff" + Errors.CANT_NULL);
        this.showStaticTeamStaff();
    }

    public function joinClubUnitS():void {
        App.utils.asserter.assertNotNull(this.joinClubUnit, "joinClubUnit" + Errors.CANT_NULL);
        this.joinClubUnit();
    }

    public function as_setTexts(param1:Object):void {
        if (this._cSIntroViewTextsVO) {
            this._cSIntroViewTextsVO.dispose();
        }
        this._cSIntroViewTextsVO = new CSIntroViewTextsVO(param1);
        this.setTexts(this._cSIntroViewTextsVO);
    }

    public function as_setStaticTeamData(param1:Object):void {
        if (this._cSIntroViewStaticTeamVO) {
            this._cSIntroViewStaticTeamVO.dispose();
        }
        this._cSIntroViewStaticTeamVO = new CSIntroViewStaticTeamVO(param1);
        this.setStaticTeamData(this._cSIntroViewStaticTeamVO);
    }

    protected function setTexts(param1:CSIntroViewTextsVO):void {
        var _loc2_:String = "as_setTexts" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setStaticTeamData(param1:CSIntroViewStaticTeamVO):void {
        var _loc2_:String = "as_setStaticTeamData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
