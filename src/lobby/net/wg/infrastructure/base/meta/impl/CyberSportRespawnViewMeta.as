package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.cyberSport.vo.AutoSearchVO;
import net.wg.infrastructure.base.AbstractView;
import net.wg.infrastructure.exceptions.AbstractException;

public class CyberSportRespawnViewMeta extends AbstractView {

    private var _autoSearchVO:AutoSearchVO;

    public function CyberSportRespawnViewMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._autoSearchVO) {
            this._autoSearchVO.dispose();
            this._autoSearchVO = null;
        }
        super.onDispose();
    }

    public final function as_changeAutoSearchState(param1:Object):void {
        var _loc2_:AutoSearchVO = this._autoSearchVO;
        this._autoSearchVO = new AutoSearchVO(param1);
        this.changeAutoSearchState(this._autoSearchVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function changeAutoSearchState(param1:AutoSearchVO):void {
        var _loc2_:String = "as_changeAutoSearchState" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
