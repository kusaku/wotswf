package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.FortClanListWindowVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortClanListWindowMeta extends AbstractWindowView {

    private var _fortClanListWindowVO:FortClanListWindowVO;

    public function FortClanListWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._fortClanListWindowVO) {
            this._fortClanListWindowVO.dispose();
            this._fortClanListWindowVO = null;
        }
        super.onDispose();
    }

    public function as_setData(param1:Object):void {
        if (this._fortClanListWindowVO) {
            this._fortClanListWindowVO.dispose();
        }
        this._fortClanListWindowVO = new FortClanListWindowVO(param1);
        this.setData(this._fortClanListWindowVO);
    }

    protected function setData(param1:FortClanListWindowVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
