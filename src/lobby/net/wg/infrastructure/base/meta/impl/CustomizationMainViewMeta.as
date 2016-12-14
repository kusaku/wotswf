package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.vehicleCustomization.data.BottomPanelVO;
import net.wg.gui.lobby.vehicleCustomization.data.CustomizationBottomPanelInitVO;
import net.wg.gui.lobby.vehicleCustomization.data.CustomizationHeaderVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CarouselDataVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CarouselInitVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselFilterVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationSlotUpdateVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationSlotsPanelVO;
import net.wg.gui.lobby.vehicleCustomization.data.panels.CustomizationTotalBonusPanelVO;
import net.wg.infrastructure.base.AbstractView;
import net.wg.infrastructure.exceptions.AbstractException;

public class CustomizationMainViewMeta extends AbstractView {

    public var showBuyWindow:Function;

    public var closeWindow:Function;

    public var installCustomizationElement:Function;

    public var goToTask:Function;

    public var removeFromShoppingBasket:Function;

    public var changeCarouselFilter:Function;

    public var setDurationType:Function;

    public var showPurchased:Function;

    public var removeSlot:Function;

    public var revertSlot:Function;

    public var showGroup:Function;

    public var backToSelectorGroup:Function;

    private var _bottomPanelVO:BottomPanelVO;

    private var _carouselDataVO:CarouselDataVO;

    private var _carouselInitVO:CarouselInitVO;

    private var _customizationBottomPanelInitVO:CustomizationBottomPanelInitVO;

    private var _customizationCarouselFilterVO:CustomizationCarouselFilterVO;

    private var _customizationHeaderVO:CustomizationHeaderVO;

    private var _customizationSlotsPanelVO:CustomizationSlotsPanelVO;

    private var _customizationTotalBonusPanelVO:CustomizationTotalBonusPanelVO;

    public function CustomizationMainViewMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._bottomPanelVO) {
            this._bottomPanelVO.dispose();
            this._bottomPanelVO = null;
        }
        if (this._carouselDataVO) {
            this._carouselDataVO.dispose();
            this._carouselDataVO = null;
        }
        if (this._carouselInitVO) {
            this._carouselInitVO.dispose();
            this._carouselInitVO = null;
        }
        if (this._customizationBottomPanelInitVO) {
            this._customizationBottomPanelInitVO.dispose();
            this._customizationBottomPanelInitVO = null;
        }
        if (this._customizationCarouselFilterVO) {
            this._customizationCarouselFilterVO.dispose();
            this._customizationCarouselFilterVO = null;
        }
        if (this._customizationHeaderVO) {
            this._customizationHeaderVO.dispose();
            this._customizationHeaderVO = null;
        }
        if (this._customizationSlotsPanelVO) {
            this._customizationSlotsPanelVO.dispose();
            this._customizationSlotsPanelVO = null;
        }
        if (this._customizationTotalBonusPanelVO) {
            this._customizationTotalBonusPanelVO.dispose();
            this._customizationTotalBonusPanelVO = null;
        }
        super.onDispose();
    }

    public function showBuyWindowS():void {
        App.utils.asserter.assertNotNull(this.showBuyWindow, "showBuyWindow" + Errors.CANT_NULL);
        this.showBuyWindow();
    }

    public function closeWindowS():void {
        App.utils.asserter.assertNotNull(this.closeWindow, "closeWindow" + Errors.CANT_NULL);
        this.closeWindow();
    }

    public function installCustomizationElementS(param1:int):void {
        App.utils.asserter.assertNotNull(this.installCustomizationElement, "installCustomizationElement" + Errors.CANT_NULL);
        this.installCustomizationElement(param1);
    }

    public function goToTaskS(param1:int):void {
        App.utils.asserter.assertNotNull(this.goToTask, "goToTask" + Errors.CANT_NULL);
        this.goToTask(param1);
    }

    public function removeFromShoppingBasketS(param1:int, param2:int, param3:int):void {
        App.utils.asserter.assertNotNull(this.removeFromShoppingBasket, "removeFromShoppingBasket" + Errors.CANT_NULL);
        this.removeFromShoppingBasket(param1, param2, param3);
    }

    public function changeCarouselFilterS():void {
        App.utils.asserter.assertNotNull(this.changeCarouselFilter, "changeCarouselFilter" + Errors.CANT_NULL);
        this.changeCarouselFilter();
    }

    public function setDurationTypeS(param1:int):void {
        App.utils.asserter.assertNotNull(this.setDurationType, "setDurationType" + Errors.CANT_NULL);
        this.setDurationType(param1);
    }

    public function showPurchasedS(param1:Boolean):void {
        App.utils.asserter.assertNotNull(this.showPurchased, "showPurchased" + Errors.CANT_NULL);
        this.showPurchased(param1);
    }

    public function removeSlotS(param1:int, param2:int):void {
        App.utils.asserter.assertNotNull(this.removeSlot, "removeSlot" + Errors.CANT_NULL);
        this.removeSlot(param1, param2);
    }

    public function revertSlotS(param1:int, param2:int):void {
        App.utils.asserter.assertNotNull(this.revertSlot, "revertSlot" + Errors.CANT_NULL);
        this.revertSlot(param1, param2);
    }

    public function showGroupS(param1:int, param2:int):void {
        App.utils.asserter.assertNotNull(this.showGroup, "showGroup" + Errors.CANT_NULL);
        this.showGroup(param1, param2);
    }

    public function backToSelectorGroupS():void {
        App.utils.asserter.assertNotNull(this.backToSelectorGroup, "backToSelectorGroup" + Errors.CANT_NULL);
        this.backToSelectorGroup();
    }

    public final function as_setHeaderData(param1:Object):void {
        var _loc2_:CustomizationHeaderVO = this._customizationHeaderVO;
        this._customizationHeaderVO = new CustomizationHeaderVO(param1);
        this.setHeaderData(this._customizationHeaderVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setBonusPanelData(param1:Object):void {
        var _loc2_:CustomizationTotalBonusPanelVO = this._customizationTotalBonusPanelVO;
        this._customizationTotalBonusPanelVO = new CustomizationTotalBonusPanelVO(param1);
        this.setBonusPanelData(this._customizationTotalBonusPanelVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setCarouselData(param1:Object):void {
        var _loc2_:CarouselDataVO = this._carouselDataVO;
        this._carouselDataVO = new CarouselDataVO(param1);
        this.setCarouselData(this._carouselDataVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setCarouselInit(param1:Object):void {
        var _loc2_:CarouselInitVO = this._carouselInitVO;
        this._carouselInitVO = new CarouselInitVO(param1);
        this.setCarouselInit(this._carouselInitVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setCarouselFilterData(param1:Object):void {
        var _loc2_:CustomizationCarouselFilterVO = this._customizationCarouselFilterVO;
        this._customizationCarouselFilterVO = new CustomizationCarouselFilterVO(param1);
        this.setCarouselFilterData(this._customizationCarouselFilterVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setBottomPanelHeader(param1:Object):void {
        var _loc2_:BottomPanelVO = this._bottomPanelVO;
        this._bottomPanelVO = new BottomPanelVO(param1);
        this.setBottomPanelHeader(this._bottomPanelVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setSlotsPanelData(param1:Object):void {
        var _loc2_:CustomizationSlotsPanelVO = this._customizationSlotsPanelVO;
        this._customizationSlotsPanelVO = new CustomizationSlotsPanelVO(param1);
        this.setSlotsPanelData(this._customizationSlotsPanelVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_updateSlot(param1:Object):void {
        this.updateSlot(new CustomizationSlotUpdateVO(param1));
    }

    public final function as_setBottomPanelInitData(param1:Object):void {
        var _loc2_:CustomizationBottomPanelInitVO = this._customizationBottomPanelInitVO;
        this._customizationBottomPanelInitVO = new CustomizationBottomPanelInitVO(param1);
        this.setBottomPanelInitData(this._customizationBottomPanelInitVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setHeaderData(param1:CustomizationHeaderVO):void {
        var _loc2_:String = "as_setHeaderData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setBonusPanelData(param1:CustomizationTotalBonusPanelVO):void {
        var _loc2_:String = "as_setBonusPanelData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setCarouselData(param1:CarouselDataVO):void {
        var _loc2_:String = "as_setCarouselData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setCarouselInit(param1:CarouselInitVO):void {
        var _loc2_:String = "as_setCarouselInit" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setCarouselFilterData(param1:CustomizationCarouselFilterVO):void {
        var _loc2_:String = "as_setCarouselFilterData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setBottomPanelHeader(param1:BottomPanelVO):void {
        var _loc2_:String = "as_setBottomPanelHeader" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setSlotsPanelData(param1:CustomizationSlotsPanelVO):void {
        var _loc2_:String = "as_setSlotsPanelData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function updateSlot(param1:CustomizationSlotUpdateVO):void {
        var _loc2_:String = "as_updateSlot" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setBottomPanelInitData(param1:CustomizationBottomPanelInitVO):void {
        var _loc2_:String = "as_setBottomPanelInitData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
