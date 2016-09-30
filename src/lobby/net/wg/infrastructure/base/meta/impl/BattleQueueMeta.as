package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.battlequeue.BattleQueueListDataVO;
import net.wg.gui.lobby.battlequeue.BattleQueueTypeInfoVO;
import net.wg.infrastructure.base.AbstractView;
import net.wg.infrastructure.exceptions.AbstractException;

public class BattleQueueMeta extends AbstractView {

    public var startClick:Function;

    public var exitClick:Function;

    public var onEscape:Function;

    private var _battleQueueListDataVO:BattleQueueListDataVO;

    private var _battleQueueTypeInfoVO:BattleQueueTypeInfoVO;

    public function BattleQueueMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._battleQueueListDataVO) {
            this._battleQueueListDataVO.dispose();
            this._battleQueueListDataVO = null;
        }
        if (this._battleQueueTypeInfoVO) {
            this._battleQueueTypeInfoVO.dispose();
            this._battleQueueTypeInfoVO = null;
        }
        super.onDispose();
    }

    public function startClickS():void {
        App.utils.asserter.assertNotNull(this.startClick, "startClick" + Errors.CANT_NULL);
        this.startClick();
    }

    public function exitClickS():void {
        App.utils.asserter.assertNotNull(this.exitClick, "exitClick" + Errors.CANT_NULL);
        this.exitClick();
    }

    public function onEscapeS():void {
        App.utils.asserter.assertNotNull(this.onEscape, "onEscape" + Errors.CANT_NULL);
        this.onEscape();
    }

    public function as_setTypeInfo(param1:Object):void {
        if (this._battleQueueTypeInfoVO) {
            this._battleQueueTypeInfoVO.dispose();
        }
        this._battleQueueTypeInfoVO = new BattleQueueTypeInfoVO(param1);
        this.setTypeInfo(this._battleQueueTypeInfoVO);
    }

    public function as_setListByType(param1:Object):void {
        if (this._battleQueueListDataVO) {
            this._battleQueueListDataVO.dispose();
        }
        this._battleQueueListDataVO = new BattleQueueListDataVO(param1);
        this.setListByType(this._battleQueueListDataVO);
    }

    protected function setTypeInfo(param1:BattleQueueTypeInfoVO):void {
        var _loc2_:String = "as_setTypeInfo" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setListByType(param1:BattleQueueListDataVO):void {
        var _loc2_:String = "as_setListByType" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
