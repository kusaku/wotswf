package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.FortCalendarPreviewBlockVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortCalendarWindowMeta extends AbstractWindowView {

    private var _fortCalendarPreviewBlockVO:FortCalendarPreviewBlockVO;

    public function FortCalendarWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._fortCalendarPreviewBlockVO) {
            this._fortCalendarPreviewBlockVO.dispose();
            this._fortCalendarPreviewBlockVO = null;
        }
        super.onDispose();
    }

    public final function as_updatePreviewData(param1:Object):void {
        var _loc2_:FortCalendarPreviewBlockVO = this._fortCalendarPreviewBlockVO;
        this._fortCalendarPreviewBlockVO = new FortCalendarPreviewBlockVO(param1);
        this.updatePreviewData(this._fortCalendarPreviewBlockVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function updatePreviewData(param1:FortCalendarPreviewBlockVO):void {
        var _loc2_:String = "as_updatePreviewData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
