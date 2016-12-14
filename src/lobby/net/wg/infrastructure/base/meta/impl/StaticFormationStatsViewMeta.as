package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStatsVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStatsViewVO;
import net.wg.infrastructure.base.BaseDAAPIComponent;
import net.wg.infrastructure.exceptions.AbstractException;

public class StaticFormationStatsViewMeta extends BaseDAAPIComponent {

    public var selectSeason:Function;

    private var _staticFormationStatsVO:StaticFormationStatsVO;

    private var _staticFormationStatsViewVO:StaticFormationStatsViewVO;

    public function StaticFormationStatsViewMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._staticFormationStatsVO) {
            this._staticFormationStatsVO.dispose();
            this._staticFormationStatsVO = null;
        }
        if (this._staticFormationStatsViewVO) {
            this._staticFormationStatsViewVO.dispose();
            this._staticFormationStatsViewVO = null;
        }
        super.onDispose();
    }

    public function selectSeasonS(param1:int):void {
        App.utils.asserter.assertNotNull(this.selectSeason, "selectSeason" + Errors.CANT_NULL);
        this.selectSeason(param1);
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:StaticFormationStatsViewVO = this._staticFormationStatsViewVO;
        this._staticFormationStatsViewVO = new StaticFormationStatsViewVO(param1);
        this.setData(this._staticFormationStatsViewVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setStats(param1:Object):void {
        var _loc2_:StaticFormationStatsVO = this._staticFormationStatsVO;
        this._staticFormationStatsVO = new StaticFormationStatsVO(param1);
        this.setStats(this._staticFormationStatsVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:StaticFormationStatsViewVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setStats(param1:StaticFormationStatsVO):void {
        var _loc2_:String = "as_setStats" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
