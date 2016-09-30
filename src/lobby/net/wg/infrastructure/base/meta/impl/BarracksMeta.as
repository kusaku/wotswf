package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.barracks.data.BarracksTankmenVO;
import net.wg.infrastructure.base.AbstractView;
import net.wg.infrastructure.exceptions.AbstractException;

public class BarracksMeta extends AbstractView {

    public var invalidateTanksList:Function;

    public var setFilter:Function;

    public var onShowRecruitWindowClick:Function;

    public var actTankman:Function;

    public var buyBerths:Function;

    public var closeBarracks:Function;

    public var setTankmenFilter:Function;

    public var openPersonalCase:Function;

    private var _barracksTankmenVO:BarracksTankmenVO;

    public function BarracksMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._barracksTankmenVO) {
            this._barracksTankmenVO.dispose();
            this._barracksTankmenVO = null;
        }
        super.onDispose();
    }

    public function invalidateTanksListS():void {
        App.utils.asserter.assertNotNull(this.invalidateTanksList, "invalidateTanksList" + Errors.CANT_NULL);
        this.invalidateTanksList();
    }

    public function setFilterS(param1:Number, param2:String, param3:String, param4:String, param5:String):void {
        App.utils.asserter.assertNotNull(this.setFilter, "setFilter" + Errors.CANT_NULL);
        this.setFilter(param1, param2, param3, param4, param5);
    }

    public function onShowRecruitWindowClickS(param1:Object, param2:Boolean):void {
        App.utils.asserter.assertNotNull(this.onShowRecruitWindowClick, "onShowRecruitWindowClick" + Errors.CANT_NULL);
        this.onShowRecruitWindowClick(param1, param2);
    }

    public function actTankmanS(param1:String):void {
        App.utils.asserter.assertNotNull(this.actTankman, "actTankman" + Errors.CANT_NULL);
        this.actTankman(param1);
    }

    public function buyBerthsS():void {
        App.utils.asserter.assertNotNull(this.buyBerths, "buyBerths" + Errors.CANT_NULL);
        this.buyBerths();
    }

    public function closeBarracksS():void {
        App.utils.asserter.assertNotNull(this.closeBarracks, "closeBarracks" + Errors.CANT_NULL);
        this.closeBarracks();
    }

    public function setTankmenFilterS():void {
        App.utils.asserter.assertNotNull(this.setTankmenFilter, "setTankmenFilter" + Errors.CANT_NULL);
        this.setTankmenFilter();
    }

    public function openPersonalCaseS(param1:String, param2:uint):void {
        App.utils.asserter.assertNotNull(this.openPersonalCase, "openPersonalCase" + Errors.CANT_NULL);
        this.openPersonalCase(param1, param2);
    }

    public function as_setTankmen(param1:Object):void {
        if (this._barracksTankmenVO) {
            this._barracksTankmenVO.dispose();
        }
        this._barracksTankmenVO = new BarracksTankmenVO(param1);
        this.setTankmen(this._barracksTankmenVO);
    }

    protected function setTankmen(param1:BarracksTankmenVO):void {
        var _loc2_:String = "as_setTankmen" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
