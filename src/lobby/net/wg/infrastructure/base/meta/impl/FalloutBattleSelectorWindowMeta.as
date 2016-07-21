package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fallout.data.FalloutBattleSelectorTooltipVO;
import net.wg.gui.lobby.fallout.data.SelectorWindowBtnStatesVO;
import net.wg.gui.lobby.fallout.data.SelectorWindowStaticDataVO;
import net.wg.gui.lobby.messengerBar.PrebattleChannelCarouselItem;
import net.wg.infrastructure.exceptions.AbstractException;

public class FalloutBattleSelectorWindowMeta extends PrebattleChannelCarouselItem {

    public var onDominationBtnClick:Function;

    public var onMultiteamBtnClick:Function;

    public var onSelectCheckBoxAutoSquad:Function;

    public var getClientID:Function;

    private var _falloutBattleSelectorTooltipVO:FalloutBattleSelectorTooltipVO;

    private var _selectorWindowStaticDataVO:SelectorWindowStaticDataVO;

    private var _selectorWindowBtnStatesVO:SelectorWindowBtnStatesVO;

    public function FalloutBattleSelectorWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._falloutBattleSelectorTooltipVO) {
            this._falloutBattleSelectorTooltipVO.dispose();
            this._falloutBattleSelectorTooltipVO = null;
        }
        if (this._selectorWindowStaticDataVO) {
            this._selectorWindowStaticDataVO.dispose();
            this._selectorWindowStaticDataVO = null;
        }
        if (this._selectorWindowBtnStatesVO) {
            this._selectorWindowBtnStatesVO.dispose();
            this._selectorWindowBtnStatesVO = null;
        }
        super.onDispose();
    }

    public function onDominationBtnClickS():void {
        App.utils.asserter.assertNotNull(this.onDominationBtnClick, "onDominationBtnClick" + Errors.CANT_NULL);
        this.onDominationBtnClick();
    }

    public function onMultiteamBtnClickS():void {
        App.utils.asserter.assertNotNull(this.onMultiteamBtnClick, "onMultiteamBtnClick" + Errors.CANT_NULL);
        this.onMultiteamBtnClick();
    }

    public function onSelectCheckBoxAutoSquadS(param1:Boolean):void {
        App.utils.asserter.assertNotNull(this.onSelectCheckBoxAutoSquad, "onSelectCheckBoxAutoSquad" + Errors.CANT_NULL);
        this.onSelectCheckBoxAutoSquad(param1);
    }

    public function getClientIDS():Number {
        App.utils.asserter.assertNotNull(this.getClientID, "getClientID" + Errors.CANT_NULL);
        return this.getClientID();
    }

    public function as_setInitData(param1:Object):void {
        if (this._selectorWindowStaticDataVO) {
            this._selectorWindowStaticDataVO.dispose();
        }
        this._selectorWindowStaticDataVO = new SelectorWindowStaticDataVO(param1);
        this.setInitData(this._selectorWindowStaticDataVO);
    }

    public function as_setBtnStates(param1:Object):void {
        if (this._selectorWindowBtnStatesVO) {
            this._selectorWindowBtnStatesVO.dispose();
        }
        this._selectorWindowBtnStatesVO = new SelectorWindowBtnStatesVO(param1);
        this.setBtnStates(this._selectorWindowBtnStatesVO);
    }

    public function as_setTooltips(param1:Object):void {
        if (this._falloutBattleSelectorTooltipVO) {
            this._falloutBattleSelectorTooltipVO.dispose();
        }
        this._falloutBattleSelectorTooltipVO = new FalloutBattleSelectorTooltipVO(param1);
        this.setTooltips(this._falloutBattleSelectorTooltipVO);
    }

    protected function setInitData(param1:SelectorWindowStaticDataVO):void {
        var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setBtnStates(param1:SelectorWindowBtnStatesVO):void {
        var _loc2_:String = "as_setBtnStates" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setTooltips(param1:FalloutBattleSelectorTooltipVO):void {
        var _loc2_:String = "as_setTooltips" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
