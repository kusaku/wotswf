package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.quests.data.QuestSlotsDataVO;
import net.wg.gui.lobby.quests.data.QuestsSeasonsViewVO;
import net.wg.gui.lobby.quests.data.SeasonsDataVO;
import net.wg.infrastructure.base.BaseDAAPIComponent;
import net.wg.infrastructure.exceptions.AbstractException;

public class QuestsSeasonsViewMeta extends BaseDAAPIComponent {

    public var onShowAwardsClick:Function;

    public var onTileClick:Function;

    public var onSlotClick:Function;

    private var _questSlotsDataVO:QuestSlotsDataVO;

    private var _seasonsDataVO:SeasonsDataVO;

    private var _questsSeasonsViewVO:QuestsSeasonsViewVO;

    public function QuestsSeasonsViewMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._questSlotsDataVO) {
            this._questSlotsDataVO.dispose();
            this._questSlotsDataVO = null;
        }
        if (this._seasonsDataVO) {
            this._seasonsDataVO.dispose();
            this._seasonsDataVO = null;
        }
        if (this._questsSeasonsViewVO) {
            this._questsSeasonsViewVO.dispose();
            this._questsSeasonsViewVO = null;
        }
        super.onDispose();
    }

    public function onShowAwardsClickS():void {
        App.utils.asserter.assertNotNull(this.onShowAwardsClick, "onShowAwardsClick" + Errors.CANT_NULL);
        this.onShowAwardsClick();
    }

    public function onTileClickS(param1:int):void {
        App.utils.asserter.assertNotNull(this.onTileClick, "onTileClick" + Errors.CANT_NULL);
        this.onTileClick(param1);
    }

    public function onSlotClickS(param1:int):void {
        App.utils.asserter.assertNotNull(this.onSlotClick, "onSlotClick" + Errors.CANT_NULL);
        this.onSlotClick(param1);
    }

    public function as_setData(param1:Object):void {
        if (this._questsSeasonsViewVO) {
            this._questsSeasonsViewVO.dispose();
        }
        this._questsSeasonsViewVO = new QuestsSeasonsViewVO(param1);
        this.setData(this._questsSeasonsViewVO);
    }

    public function as_setSeasonsData(param1:Object):void {
        if (this._seasonsDataVO) {
            this._seasonsDataVO.dispose();
        }
        this._seasonsDataVO = new SeasonsDataVO(param1);
        this.setSeasonsData(this._seasonsDataVO);
    }

    public function as_setSlotsData(param1:Object):void {
        if (this._questSlotsDataVO) {
            this._questSlotsDataVO.dispose();
        }
        this._questSlotsDataVO = new QuestSlotsDataVO(param1);
        this.setSlotsData(this._questSlotsDataVO);
    }

    protected function setData(param1:QuestsSeasonsViewVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setSeasonsData(param1:SeasonsDataVO):void {
        var _loc2_:String = "as_setSeasonsData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setSlotsData(param1:QuestSlotsDataVO):void {
        var _loc2_:String = "as_setSlotsData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
