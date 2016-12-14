package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.BuildingCardPopoverVO;
import net.wg.infrastructure.base.SmartPopOverView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortBuildingCardPopoverMeta extends SmartPopOverView {

    public var openUpgradeWindow:Function;

    public var openAssignedPlayersWindow:Function;

    public var openDemountBuildingWindow:Function;

    public var openDirectionControlWindow:Function;

    public var openBuyOrderWindow:Function;

    private var _buildingCardPopoverVO:BuildingCardPopoverVO;

    public function FortBuildingCardPopoverMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._buildingCardPopoverVO) {
            this._buildingCardPopoverVO.dispose();
            this._buildingCardPopoverVO = null;
        }
        super.onDispose();
    }

    public function openUpgradeWindowS(param1:Object):void {
        App.utils.asserter.assertNotNull(this.openUpgradeWindow, "openUpgradeWindow" + Errors.CANT_NULL);
        this.openUpgradeWindow(param1);
    }

    public function openAssignedPlayersWindowS(param1:Object):void {
        App.utils.asserter.assertNotNull(this.openAssignedPlayersWindow, "openAssignedPlayersWindow" + Errors.CANT_NULL);
        this.openAssignedPlayersWindow(param1);
    }

    public function openDemountBuildingWindowS(param1:String):void {
        App.utils.asserter.assertNotNull(this.openDemountBuildingWindow, "openDemountBuildingWindow" + Errors.CANT_NULL);
        this.openDemountBuildingWindow(param1);
    }

    public function openDirectionControlWindowS():void {
        App.utils.asserter.assertNotNull(this.openDirectionControlWindow, "openDirectionControlWindow" + Errors.CANT_NULL);
        this.openDirectionControlWindow();
    }

    public function openBuyOrderWindowS():void {
        App.utils.asserter.assertNotNull(this.openBuyOrderWindow, "openBuyOrderWindow" + Errors.CANT_NULL);
        this.openBuyOrderWindow();
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:BuildingCardPopoverVO = this._buildingCardPopoverVO;
        this._buildingCardPopoverVO = new BuildingCardPopoverVO(param1);
        this.setData(this._buildingCardPopoverVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:BuildingCardPopoverVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
