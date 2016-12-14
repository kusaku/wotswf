package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.christmas.data.ChristmasFiltersVO;
import net.wg.gui.lobby.christmas.data.MainViewStaticDataVO;
import net.wg.gui.lobby.christmas.data.ProgressBarVO;
import net.wg.gui.lobby.christmas.data.slots.SlotVO;
import net.wg.gui.lobby.christmas.data.slots.SlotsDataClassVO;
import net.wg.gui.lobby.components.data.InfoMessageVO;
import net.wg.infrastructure.base.AbstractView;
import net.wg.infrastructure.exceptions.AbstractException;

public class ChristmasMainViewMeta extends AbstractView {

    public var installItem:Function;

    public var moveItem:Function;

    public var uninstallItem:Function;

    public var showConversion:Function;

    public var switchOffNewItem:Function;

    public var applyRankFilter:Function;

    public var applyTypeFilter:Function;

    public var onChangeTab:Function;

    public var onEmptyListBtnClick:Function;

    public var closeWindow:Function;

    public var showRules:Function;

    public var switchCamera:Function;

    public var convertItems:Function;

    public var cancelConversion:Function;

    public var onConversionAnimationComplete:Function;

    private var _christmasFiltersVO:ChristmasFiltersVO;

    private var _christmasFiltersVO1:ChristmasFiltersVO;

    private var _infoMessageVO:InfoMessageVO;

    private var _mainViewStaticDataVO:MainViewStaticDataVO;

    private var _progressBarVO:ProgressBarVO;

    private var _slotVO:SlotVO;

    private var _slotsDataClassVO:SlotsDataClassVO;

    public function ChristmasMainViewMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._christmasFiltersVO) {
            this._christmasFiltersVO.dispose();
            this._christmasFiltersVO = null;
        }
        if (this._christmasFiltersVO1) {
            this._christmasFiltersVO1.dispose();
            this._christmasFiltersVO1 = null;
        }
        if (this._infoMessageVO) {
            this._infoMessageVO.dispose();
            this._infoMessageVO = null;
        }
        if (this._mainViewStaticDataVO) {
            this._mainViewStaticDataVO.dispose();
            this._mainViewStaticDataVO = null;
        }
        if (this._progressBarVO) {
            this._progressBarVO.dispose();
            this._progressBarVO = null;
        }
        if (this._slotVO) {
            this._slotVO.dispose();
            this._slotVO = null;
        }
        if (this._slotsDataClassVO) {
            this._slotsDataClassVO.dispose();
            this._slotsDataClassVO = null;
        }
        super.onDispose();
    }

    public function installItemS(param1:int, param2:int):void {
        App.utils.asserter.assertNotNull(this.installItem, "installItem" + Errors.CANT_NULL);
        this.installItem(param1, param2);
    }

    public function moveItemS(param1:int, param2:int):void {
        App.utils.asserter.assertNotNull(this.moveItem, "moveItem" + Errors.CANT_NULL);
        this.moveItem(param1, param2);
    }

    public function uninstallItemS(param1:int):void {
        App.utils.asserter.assertNotNull(this.uninstallItem, "uninstallItem" + Errors.CANT_NULL);
        this.uninstallItem(param1);
    }

    public function showConversionS():void {
        App.utils.asserter.assertNotNull(this.showConversion, "showConversion" + Errors.CANT_NULL);
        this.showConversion();
    }

    public function switchOffNewItemS(param1:int):void {
        App.utils.asserter.assertNotNull(this.switchOffNewItem, "switchOffNewItem" + Errors.CANT_NULL);
        this.switchOffNewItem(param1);
    }

    public function applyRankFilterS(param1:int):void {
        App.utils.asserter.assertNotNull(this.applyRankFilter, "applyRankFilter" + Errors.CANT_NULL);
        this.applyRankFilter(param1);
    }

    public function applyTypeFilterS(param1:int):void {
        App.utils.asserter.assertNotNull(this.applyTypeFilter, "applyTypeFilter" + Errors.CANT_NULL);
        this.applyTypeFilter(param1);
    }

    public function onChangeTabS(param1:String):void {
        App.utils.asserter.assertNotNull(this.onChangeTab, "onChangeTab" + Errors.CANT_NULL);
        this.onChangeTab(param1);
    }

    public function onEmptyListBtnClickS():void {
        App.utils.asserter.assertNotNull(this.onEmptyListBtnClick, "onEmptyListBtnClick" + Errors.CANT_NULL);
        this.onEmptyListBtnClick();
    }

    public function closeWindowS():void {
        App.utils.asserter.assertNotNull(this.closeWindow, "closeWindow" + Errors.CANT_NULL);
        this.closeWindow();
    }

    public function showRulesS():void {
        App.utils.asserter.assertNotNull(this.showRules, "showRules" + Errors.CANT_NULL);
        this.showRules();
    }

    public function switchCameraS():void {
        App.utils.asserter.assertNotNull(this.switchCamera, "switchCamera" + Errors.CANT_NULL);
        this.switchCamera();
    }

    public function convertItemsS():void {
        App.utils.asserter.assertNotNull(this.convertItems, "convertItems" + Errors.CANT_NULL);
        this.convertItems();
    }

    public function cancelConversionS():void {
        App.utils.asserter.assertNotNull(this.cancelConversion, "cancelConversion" + Errors.CANT_NULL);
        this.cancelConversion();
    }

    public function onConversionAnimationCompleteS():void {
        App.utils.asserter.assertNotNull(this.onConversionAnimationComplete, "onConversionAnimationComplete" + Errors.CANT_NULL);
        this.onConversionAnimationComplete();
    }

    public final function as_setStaticData(param1:Object):void {
        var _loc2_:MainViewStaticDataVO = this._mainViewStaticDataVO;
        this._mainViewStaticDataVO = new MainViewStaticDataVO(param1);
        this.setStaticData(this._mainViewStaticDataVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setFilters(param1:Object, param2:Object):void {
        var _loc3_:ChristmasFiltersVO = this._christmasFiltersVO;
        this._christmasFiltersVO = new ChristmasFiltersVO(param1);
        var _loc4_:ChristmasFiltersVO = this._christmasFiltersVO1;
        this._christmasFiltersVO1 = new ChristmasFiltersVO(param2);
        this.setFilters(this._christmasFiltersVO, this._christmasFiltersVO1);
        if (_loc3_) {
            _loc3_.dispose();
        }
        if (_loc4_) {
            _loc4_.dispose();
        }
    }

    public final function as_setProgress(param1:Object):void {
        var _loc2_:ProgressBarVO = this._progressBarVO;
        this._progressBarVO = new ProgressBarVO(param1);
        this.setProgress(this._progressBarVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setSlotsData(param1:Object):void {
        var _loc2_:SlotsDataClassVO = this._slotsDataClassVO;
        this._slotsDataClassVO = new SlotsDataClassVO(param1);
        this.setSlotsData(this._slotsDataClassVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_updateSlot(param1:Object):void {
        var _loc2_:SlotVO = this._slotVO;
        this._slotVO = new SlotVO(param1);
        this.updateSlot(this._slotVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setEmptyListData(param1:Boolean, param2:Object):void {
        var _loc3_:InfoMessageVO = this._infoMessageVO;
        this._infoMessageVO = new InfoMessageVO(param2);
        this.setEmptyListData(param1, this._infoMessageVO);
        if (_loc3_) {
            _loc3_.dispose();
        }
    }

    protected function setStaticData(param1:MainViewStaticDataVO):void {
        var _loc2_:String = "as_setStaticData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setFilters(param1:ChristmasFiltersVO, param2:ChristmasFiltersVO):void {
        var _loc3_:String = "as_setFilters" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc3_);
        throw new AbstractException(_loc3_);
    }

    protected function setProgress(param1:ProgressBarVO):void {
        var _loc2_:String = "as_setProgress" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setSlotsData(param1:SlotsDataClassVO):void {
        var _loc2_:String = "as_setSlotsData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function updateSlot(param1:SlotVO):void {
        var _loc2_:String = "as_updateSlot" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setEmptyListData(param1:Boolean, param2:InfoMessageVO):void {
        var _loc3_:String = "as_setEmptyListData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc3_);
        throw new AbstractException(_loc3_);
    }
}
}
