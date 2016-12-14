package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.FortIntelFilterVO;
import net.wg.infrastructure.base.BaseDAAPIComponent;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortIntelFilterMeta extends BaseDAAPIComponent {

    public var onTryToSearchByClanAbbr:Function;

    public var onClearClanTagSearch:Function;

    private var _fortIntelFilterVO:FortIntelFilterVO;

    public function FortIntelFilterMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._fortIntelFilterVO) {
            this._fortIntelFilterVO.dispose();
            this._fortIntelFilterVO = null;
        }
        super.onDispose();
    }

    public function onTryToSearchByClanAbbrS(param1:String, param2:int):String {
        App.utils.asserter.assertNotNull(this.onTryToSearchByClanAbbr, "onTryToSearchByClanAbbr" + Errors.CANT_NULL);
        return this.onTryToSearchByClanAbbr(param1, param2);
    }

    public function onClearClanTagSearchS():void {
        App.utils.asserter.assertNotNull(this.onClearClanTagSearch, "onClearClanTagSearch" + Errors.CANT_NULL);
        this.onClearClanTagSearch();
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:FortIntelFilterVO = this._fortIntelFilterVO;
        this._fortIntelFilterVO = new FortIntelFilterVO(param1);
        this.setData(this._fortIntelFilterVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:FortIntelFilterVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
