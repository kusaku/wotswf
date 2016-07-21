package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractView;

public class BarracksMeta extends AbstractView {

    public var invalidateTanksList:Function;

    public var setFilter:Function;

    public var onShowRecruitWindowClick:Function;

    public var unloadTankman:Function;

    public var dismissTankman:Function;

    public var buyBerths:Function;

    public var closeBarracks:Function;

    public var setTankmenFilter:Function;

    public var openPersonalCase:Function;

    public function BarracksMeta() {
        super();
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

    public function unloadTankmanS(param1:String):void {
        App.utils.asserter.assertNotNull(this.unloadTankman, "unloadTankman" + Errors.CANT_NULL);
        this.unloadTankman(param1);
    }

    public function dismissTankmanS(param1:String):void {
        App.utils.asserter.assertNotNull(this.dismissTankman, "dismissTankman" + Errors.CANT_NULL);
        this.dismissTankman(param1);
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
}
}
