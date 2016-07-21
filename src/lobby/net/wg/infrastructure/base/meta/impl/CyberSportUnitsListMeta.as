package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.components.advanced.vo.DummyVO;
import net.wg.gui.cyberSport.vo.NavigationBlockVO;
import net.wg.gui.cyberSport.vo.UnitListViewHeaderVO;
import net.wg.gui.rally.views.list.BaseRallyListView;
import net.wg.infrastructure.exceptions.AbstractException;

public class CyberSportUnitsListMeta extends BaseRallyListView {

    public var getTeamData:Function;

    public var refreshTeams:Function;

    public var filterVehicles:Function;

    public var setTeamFilters:Function;

    public var loadPrevious:Function;

    public var loadNext:Function;

    public var showRallyProfile:Function;

    public var searchTeams:Function;

    private var _unitListViewHeaderVO:UnitListViewHeaderVO;

    private var _dummyVO:DummyVO;

    private var _navigationBlockVO:NavigationBlockVO;

    public function CyberSportUnitsListMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._unitListViewHeaderVO) {
            this._unitListViewHeaderVO.dispose();
            this._unitListViewHeaderVO = null;
        }
        if (this._dummyVO) {
            this._dummyVO.dispose();
            this._dummyVO = null;
        }
        if (this._navigationBlockVO) {
            this._navigationBlockVO.dispose();
            this._navigationBlockVO = null;
        }
        super.onDispose();
    }

    public function getTeamDataS(param1:int):Object {
        App.utils.asserter.assertNotNull(this.getTeamData, "getTeamData" + Errors.CANT_NULL);
        return this.getTeamData(param1);
    }

    public function refreshTeamsS():void {
        App.utils.asserter.assertNotNull(this.refreshTeams, "refreshTeams" + Errors.CANT_NULL);
        this.refreshTeams();
    }

    public function filterVehiclesS():void {
        App.utils.asserter.assertNotNull(this.filterVehicles, "filterVehicles" + Errors.CANT_NULL);
        this.filterVehicles();
    }

    public function setTeamFiltersS(param1:Boolean):void {
        App.utils.asserter.assertNotNull(this.setTeamFilters, "setTeamFilters" + Errors.CANT_NULL);
        this.setTeamFilters(param1);
    }

    public function loadPreviousS():void {
        App.utils.asserter.assertNotNull(this.loadPrevious, "loadPrevious" + Errors.CANT_NULL);
        this.loadPrevious();
    }

    public function loadNextS():void {
        App.utils.asserter.assertNotNull(this.loadNext, "loadNext" + Errors.CANT_NULL);
        this.loadNext();
    }

    public function showRallyProfileS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.showRallyProfile, "showRallyProfile" + Errors.CANT_NULL);
        this.showRallyProfile(param1);
    }

    public function searchTeamsS(param1:String):void {
        App.utils.asserter.assertNotNull(this.searchTeams, "searchTeams" + Errors.CANT_NULL);
        this.searchTeams(param1);
    }

    public function as_setDummy(param1:Object):void {
        if (this._dummyVO) {
            this._dummyVO.dispose();
        }
        this._dummyVO = new DummyVO(param1);
        this.setDummy(this._dummyVO);
    }

    public function as_setHeader(param1:Object):void {
        if (this._unitListViewHeaderVO) {
            this._unitListViewHeaderVO.dispose();
        }
        this._unitListViewHeaderVO = new UnitListViewHeaderVO(param1);
        this.setHeader(this._unitListViewHeaderVO);
    }

    public function as_updateNavigationBlock(param1:Object):void {
        if (this._navigationBlockVO) {
            this._navigationBlockVO.dispose();
        }
        this._navigationBlockVO = new NavigationBlockVO(param1);
        this.updateNavigationBlock(this._navigationBlockVO);
    }

    protected function setDummy(param1:DummyVO):void {
        var _loc2_:String = "as_setDummy" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setHeader(param1:UnitListViewHeaderVO):void {
        var _loc2_:String = "as_setHeader" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function updateNavigationBlock(param1:NavigationBlockVO):void {
        var _loc2_:String = "as_updateNavigationBlock" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
