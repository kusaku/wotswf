package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.FortWaitingVO;
import net.wg.gui.lobby.fortifications.data.FortificationVO;
import net.wg.infrastructure.base.AbstractView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortificationsViewMeta extends AbstractView {

    public var onFortCreateClick:Function;

    public var onDirectionCreateClick:Function;

    public var onEscapePress:Function;

    private var _fortificationVO:FortificationVO;

    private var _fortWaitingVO:FortWaitingVO;

    public function FortificationsViewMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._fortificationVO) {
            this._fortificationVO.dispose();
            this._fortificationVO = null;
        }
        if (this._fortWaitingVO) {
            this._fortWaitingVO.dispose();
            this._fortWaitingVO = null;
        }
        super.onDispose();
    }

    public function onFortCreateClickS():void {
        App.utils.asserter.assertNotNull(this.onFortCreateClick, "onFortCreateClick" + Errors.CANT_NULL);
        this.onFortCreateClick();
    }

    public function onDirectionCreateClickS():void {
        App.utils.asserter.assertNotNull(this.onDirectionCreateClick, "onDirectionCreateClick" + Errors.CANT_NULL);
        this.onDirectionCreateClick();
    }

    public function onEscapePressS():void {
        App.utils.asserter.assertNotNull(this.onEscapePress, "onEscapePress" + Errors.CANT_NULL);
        this.onEscapePress();
    }

    public function as_setCommonData(param1:Object):void {
        if (this._fortificationVO) {
            this._fortificationVO.dispose();
        }
        this._fortificationVO = new FortificationVO(param1);
        this.setCommonData(this._fortificationVO);
    }

    public function as_waitingData(param1:Object):void {
        if (this._fortWaitingVO) {
            this._fortWaitingVO.dispose();
        }
        this._fortWaitingVO = new FortWaitingVO(param1);
        this.waitingData(this._fortWaitingVO);
    }

    protected function setCommonData(param1:FortificationVO):void {
        var _loc2_:String = "as_setCommonData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function waitingData(param1:FortWaitingVO):void {
        var _loc2_:String = "as_waitingData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
