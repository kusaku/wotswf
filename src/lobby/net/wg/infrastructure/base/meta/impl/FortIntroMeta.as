package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.battleRoom.IntroViewVO;
import net.wg.gui.rally.views.intro.BaseRallyIntroView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortIntroMeta extends BaseRallyIntroView {

    private var _introViewVO:IntroViewVO;

    public function FortIntroMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._introViewVO) {
            this._introViewVO.dispose();
            this._introViewVO = null;
        }
        super.onDispose();
    }

    public function as_setIntroData(param1:Object):void {
        if (this._introViewVO) {
            this._introViewVO.dispose();
        }
        this._introViewVO = new IntroViewVO(param1);
        this.setIntroData(this._introViewVO);
    }

    protected function setIntroData(param1:IntroViewVO):void {
        var _loc2_:String = "as_setIntroData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
