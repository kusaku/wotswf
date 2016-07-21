package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.data.VersionMessageVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class LobbyMenuMeta extends AbstractWindowView {

    public var settingsClick:Function;

    public var cancelClick:Function;

    public var refuseTraining:Function;

    public var logoffClick:Function;

    public var quitClick:Function;

    public var versionInfoClick:Function;

    private var _versionMessageVO:VersionMessageVO;

    public function LobbyMenuMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._versionMessageVO) {
            this._versionMessageVO.dispose();
            this._versionMessageVO = null;
        }
        super.onDispose();
    }

    public function settingsClickS():void {
        App.utils.asserter.assertNotNull(this.settingsClick, "settingsClick" + Errors.CANT_NULL);
        this.settingsClick();
    }

    public function cancelClickS():void {
        App.utils.asserter.assertNotNull(this.cancelClick, "cancelClick" + Errors.CANT_NULL);
        this.cancelClick();
    }

    public function refuseTrainingS():void {
        App.utils.asserter.assertNotNull(this.refuseTraining, "refuseTraining" + Errors.CANT_NULL);
        this.refuseTraining();
    }

    public function logoffClickS():void {
        App.utils.asserter.assertNotNull(this.logoffClick, "logoffClick" + Errors.CANT_NULL);
        this.logoffClick();
    }

    public function quitClickS():void {
        App.utils.asserter.assertNotNull(this.quitClick, "quitClick" + Errors.CANT_NULL);
        this.quitClick();
    }

    public function versionInfoClickS():void {
        App.utils.asserter.assertNotNull(this.versionInfoClick, "versionInfoClick" + Errors.CANT_NULL);
        this.versionInfoClick();
    }

    public function as_setVersionMessage(param1:Object):void {
        if (this._versionMessageVO) {
            this._versionMessageVO.dispose();
        }
        this._versionMessageVO = new VersionMessageVO(param1);
        this.setVersionMessage(this._versionMessageVO);
    }

    protected function setVersionMessage(param1:VersionMessageVO):void {
        var _loc2_:String = "as_setVersionMessage" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
