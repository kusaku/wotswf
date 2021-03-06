package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.components.carousels.ScrollCarousel;
import net.wg.gui.lobby.christmas.data.ChristmasButtonVO;
import net.wg.gui.lobby.hangar.tcarousel.data.TankCarouselFilterInitVO;
import net.wg.gui.lobby.hangar.tcarousel.data.TankCarouselFilterSelectedVO;
import net.wg.infrastructure.exceptions.AbstractException;

public class TankCarouselMeta extends ScrollCarousel {

    public var selectVehicle:Function;

    public var buyTank:Function;

    public var buySlot:Function;

    public var setFilter:Function;

    public var resetFilters:Function;

    public var updateHotFilters:Function;

    public var onChristmasBtnClick:Function;

    private var _christmasButtonVO:ChristmasButtonVO;

    private var _tankCarouselFilterInitVO:TankCarouselFilterInitVO;

    private var _tankCarouselFilterSelectedVO:TankCarouselFilterSelectedVO;

    public function TankCarouselMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._christmasButtonVO) {
            this._christmasButtonVO.dispose();
            this._christmasButtonVO = null;
        }
        if (this._tankCarouselFilterInitVO) {
            this._tankCarouselFilterInitVO.dispose();
            this._tankCarouselFilterInitVO = null;
        }
        if (this._tankCarouselFilterSelectedVO) {
            this._tankCarouselFilterSelectedVO.dispose();
            this._tankCarouselFilterSelectedVO = null;
        }
        super.onDispose();
    }

    public function selectVehicleS(param1:int):void {
        App.utils.asserter.assertNotNull(this.selectVehicle, "selectVehicle" + Errors.CANT_NULL);
        this.selectVehicle(param1);
    }

    public function buyTankS():void {
        App.utils.asserter.assertNotNull(this.buyTank, "buyTank" + Errors.CANT_NULL);
        this.buyTank();
    }

    public function buySlotS():void {
        App.utils.asserter.assertNotNull(this.buySlot, "buySlot" + Errors.CANT_NULL);
        this.buySlot();
    }

    public function setFilterS(param1:int):void {
        App.utils.asserter.assertNotNull(this.setFilter, "setFilter" + Errors.CANT_NULL);
        this.setFilter(param1);
    }

    public function resetFiltersS():void {
        App.utils.asserter.assertNotNull(this.resetFilters, "resetFilters" + Errors.CANT_NULL);
        this.resetFilters();
    }

    public function updateHotFiltersS():void {
        App.utils.asserter.assertNotNull(this.updateHotFilters, "updateHotFilters" + Errors.CANT_NULL);
        this.updateHotFilters();
    }

    public function onChristmasBtnClickS():void {
        App.utils.asserter.assertNotNull(this.onChristmasBtnClick, "onChristmasBtnClick" + Errors.CANT_NULL);
        this.onChristmasBtnClick();
    }

    public final function as_setCarouselFilter(param1:Object):void {
        var _loc2_:TankCarouselFilterSelectedVO = this._tankCarouselFilterSelectedVO;
        this._tankCarouselFilterSelectedVO = new TankCarouselFilterSelectedVO(param1);
        this.setCarouselFilter(this._tankCarouselFilterSelectedVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_initCarouselFilter(param1:Object):void {
        var _loc2_:TankCarouselFilterInitVO = this._tankCarouselFilterInitVO;
        this._tankCarouselFilterInitVO = new TankCarouselFilterInitVO(param1);
        this.initCarouselFilter(this._tankCarouselFilterInitVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setChristmasBtnData(param1:Object):void {
        var _loc2_:ChristmasButtonVO = this._christmasButtonVO;
        this._christmasButtonVO = new ChristmasButtonVO(param1);
        this.setChristmasBtnData(this._christmasButtonVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setCarouselFilter(param1:TankCarouselFilterSelectedVO):void {
        var _loc2_:String = "as_setCarouselFilter" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function initCarouselFilter(param1:TankCarouselFilterInitVO):void {
        var _loc2_:String = "as_initCarouselFilter" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setChristmasBtnData(param1:ChristmasButtonVO):void {
        var _loc2_:String = "as_setChristmasBtnData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
