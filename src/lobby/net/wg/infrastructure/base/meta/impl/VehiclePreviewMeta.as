package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewInfoPanelVO;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewPriceDataVO;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewStaticDataVO;
import net.wg.infrastructure.base.AbstractView;
import net.wg.infrastructure.exceptions.AbstractException;

public class VehiclePreviewMeta extends AbstractView {

    public var closeView:Function;

    public var onBackClick:Function;

    public var onBuyOrResearchClick:Function;

    public var onOpenInfoTab:Function;

    public var onCompareClick:Function;

    private var _vehPreviewInfoPanelVO:VehPreviewInfoPanelVO;

    private var _vehPreviewPriceDataVO:VehPreviewPriceDataVO;

    private var _vehPreviewStaticDataVO:VehPreviewStaticDataVO;

    public function VehiclePreviewMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._vehPreviewInfoPanelVO) {
            this._vehPreviewInfoPanelVO.dispose();
            this._vehPreviewInfoPanelVO = null;
        }
        if (this._vehPreviewPriceDataVO) {
            this._vehPreviewPriceDataVO.dispose();
            this._vehPreviewPriceDataVO = null;
        }
        if (this._vehPreviewStaticDataVO) {
            this._vehPreviewStaticDataVO.dispose();
            this._vehPreviewStaticDataVO = null;
        }
        super.onDispose();
    }

    public function closeViewS():void {
        App.utils.asserter.assertNotNull(this.closeView, "closeView" + Errors.CANT_NULL);
        this.closeView();
    }

    public function onBackClickS():void {
        App.utils.asserter.assertNotNull(this.onBackClick, "onBackClick" + Errors.CANT_NULL);
        this.onBackClick();
    }

    public function onBuyOrResearchClickS():void {
        App.utils.asserter.assertNotNull(this.onBuyOrResearchClick, "onBuyOrResearchClick" + Errors.CANT_NULL);
        this.onBuyOrResearchClick();
    }

    public function onOpenInfoTabS(param1:int):void {
        App.utils.asserter.assertNotNull(this.onOpenInfoTab, "onOpenInfoTab" + Errors.CANT_NULL);
        this.onOpenInfoTab(param1);
    }

    public function onCompareClickS():void {
        App.utils.asserter.assertNotNull(this.onCompareClick, "onCompareClick" + Errors.CANT_NULL);
        this.onCompareClick();
    }

    public final function as_setStaticData(param1:Object):void {
        var _loc2_:VehPreviewStaticDataVO = this._vehPreviewStaticDataVO;
        this._vehPreviewStaticDataVO = new VehPreviewStaticDataVO(param1);
        this.setStaticData(this._vehPreviewStaticDataVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_updateInfoData(param1:Object):void {
        var _loc2_:VehPreviewInfoPanelVO = this._vehPreviewInfoPanelVO;
        this._vehPreviewInfoPanelVO = new VehPreviewInfoPanelVO(param1);
        this.updateInfoData(this._vehPreviewInfoPanelVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_updatePrice(param1:Object):void {
        var _loc2_:VehPreviewPriceDataVO = this._vehPreviewPriceDataVO;
        this._vehPreviewPriceDataVO = new VehPreviewPriceDataVO(param1);
        this.updatePrice(this._vehPreviewPriceDataVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setStaticData(param1:VehPreviewStaticDataVO):void {
        var _loc2_:String = "as_setStaticData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function updateInfoData(param1:VehPreviewInfoPanelVO):void {
        var _loc2_:String = "as_updateInfoData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function updatePrice(param1:VehPreviewPriceDataVO):void {
        var _loc2_:String = "as_updatePrice" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
