package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.quests.data.ChainProgressVO;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestTaskDetailsVO;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestTileVO;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestsTileChainsViewVO;
import net.wg.infrastructure.base.BaseDAAPIComponent;
import net.wg.infrastructure.exceptions.AbstractException;

public class QuestsTileChainsViewMeta extends BaseDAAPIComponent {

    public var getTileData:Function;

    public var getChainProgress:Function;

    public var getTaskDetails:Function;

    public var selectTask:Function;

    public var refuseTask:Function;

    public var gotoBack:Function;

    public var showAwardVehicleInfo:Function;

    public var showAwardVehicleInHangar:Function;

    private var _questsTileChainsViewVO:QuestsTileChainsViewVO;

    private var _questTaskDetailsVO:QuestTaskDetailsVO;

    private var _chainProgressVO:ChainProgressVO;

    private var _questTileVO:QuestTileVO;

    public function QuestsTileChainsViewMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._questsTileChainsViewVO) {
            this._questsTileChainsViewVO.dispose();
            this._questsTileChainsViewVO = null;
        }
        if (this._questTaskDetailsVO) {
            this._questTaskDetailsVO.dispose();
            this._questTaskDetailsVO = null;
        }
        if (this._chainProgressVO) {
            this._chainProgressVO.dispose();
            this._chainProgressVO = null;
        }
        if (this._questTileVO) {
            this._questTileVO.dispose();
            this._questTileVO = null;
        }
        super.onDispose();
    }

    public function getTileDataS(param1:int, param2:int):void {
        App.utils.asserter.assertNotNull(this.getTileData, "getTileData" + Errors.CANT_NULL);
        this.getTileData(param1, param2);
    }

    public function getChainProgressS():void {
        App.utils.asserter.assertNotNull(this.getChainProgress, "getChainProgress" + Errors.CANT_NULL);
        this.getChainProgress();
    }

    public function getTaskDetailsS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.getTaskDetails, "getTaskDetails" + Errors.CANT_NULL);
        this.getTaskDetails(param1);
    }

    public function selectTaskS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.selectTask, "selectTask" + Errors.CANT_NULL);
        this.selectTask(param1);
    }

    public function refuseTaskS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.refuseTask, "refuseTask" + Errors.CANT_NULL);
        this.refuseTask(param1);
    }

    public function gotoBackS():void {
        App.utils.asserter.assertNotNull(this.gotoBack, "gotoBack" + Errors.CANT_NULL);
        this.gotoBack();
    }

    public function showAwardVehicleInfoS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.showAwardVehicleInfo, "showAwardVehicleInfo" + Errors.CANT_NULL);
        this.showAwardVehicleInfo(param1);
    }

    public function showAwardVehicleInHangarS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.showAwardVehicleInHangar, "showAwardVehicleInHangar" + Errors.CANT_NULL);
        this.showAwardVehicleInHangar(param1);
    }

    public function as_setHeaderData(param1:Object):void {
        if (this._questsTileChainsViewVO) {
            this._questsTileChainsViewVO.dispose();
        }
        this._questsTileChainsViewVO = new QuestsTileChainsViewVO(param1);
        this.setHeaderData(this._questsTileChainsViewVO);
    }

    public function as_updateTileData(param1:Object):void {
        if (this._questTileVO) {
            this._questTileVO.dispose();
        }
        this._questTileVO = new QuestTileVO(param1);
        this.updateTileData(this._questTileVO);
    }

    public function as_updateChainProgress(param1:Object):void {
        if (this._chainProgressVO) {
            this._chainProgressVO.dispose();
        }
        this._chainProgressVO = new ChainProgressVO(param1);
        this.updateChainProgress(this._chainProgressVO);
    }

    public function as_updateTaskDetails(param1:Object):void {
        if (this._questTaskDetailsVO) {
            this._questTaskDetailsVO.dispose();
        }
        this._questTaskDetailsVO = new QuestTaskDetailsVO(param1);
        this.updateTaskDetails(this._questTaskDetailsVO);
    }

    protected function setHeaderData(param1:QuestsTileChainsViewVO):void {
        var _loc2_:String = "as_setHeaderData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function updateTileData(param1:QuestTileVO):void {
        var _loc2_:String = "as_updateTileData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function updateChainProgress(param1:ChainProgressVO):void {
        var _loc2_:String = "as_updateChainProgress" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function updateTaskDetails(param1:QuestTaskDetailsVO):void {
        var _loc2_:String = "as_updateTaskDetails" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
