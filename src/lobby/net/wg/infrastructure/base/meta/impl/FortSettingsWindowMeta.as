package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.settings.FortSettingsActivatedViewVO;
import net.wg.gui.lobby.fortifications.data.settings.FortSettingsClanInfoVO;
import net.wg.gui.lobby.fortifications.data.settings.FortSettingsNotActivatedViewVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortSettingsWindowMeta extends AbstractWindowView {

    public var activateDefencePeriod:Function;

    public var disableDefencePeriod:Function;

    public var cancelDisableDefencePeriod:Function;

    private var _fortSettingsActivatedViewVO:FortSettingsActivatedViewVO;

    private var _fortSettingsClanInfoVO:FortSettingsClanInfoVO;

    private var _fortSettingsNotActivatedViewVO:FortSettingsNotActivatedViewVO;

    public function FortSettingsWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._fortSettingsActivatedViewVO) {
            this._fortSettingsActivatedViewVO.dispose();
            this._fortSettingsActivatedViewVO = null;
        }
        if (this._fortSettingsClanInfoVO) {
            this._fortSettingsClanInfoVO.dispose();
            this._fortSettingsClanInfoVO = null;
        }
        if (this._fortSettingsNotActivatedViewVO) {
            this._fortSettingsNotActivatedViewVO.dispose();
            this._fortSettingsNotActivatedViewVO = null;
        }
        super.onDispose();
    }

    public function activateDefencePeriodS():void {
        App.utils.asserter.assertNotNull(this.activateDefencePeriod, "activateDefencePeriod" + Errors.CANT_NULL);
        this.activateDefencePeriod();
    }

    public function disableDefencePeriodS():void {
        App.utils.asserter.assertNotNull(this.disableDefencePeriod, "disableDefencePeriod" + Errors.CANT_NULL);
        this.disableDefencePeriod();
    }

    public function cancelDisableDefencePeriodS():void {
        App.utils.asserter.assertNotNull(this.cancelDisableDefencePeriod, "cancelDisableDefencePeriod" + Errors.CANT_NULL);
        this.cancelDisableDefencePeriod();
    }

    public final function as_setFortClanInfo(param1:Object):void {
        var _loc2_:FortSettingsClanInfoVO = this._fortSettingsClanInfoVO;
        this._fortSettingsClanInfoVO = new FortSettingsClanInfoVO(param1);
        this.setFortClanInfo(this._fortSettingsClanInfoVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setDataForActivated(param1:Object):void {
        var _loc2_:FortSettingsActivatedViewVO = this._fortSettingsActivatedViewVO;
        this._fortSettingsActivatedViewVO = new FortSettingsActivatedViewVO(param1);
        this.setDataForActivated(this._fortSettingsActivatedViewVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setDataForNotActivated(param1:Object):void {
        var _loc2_:FortSettingsNotActivatedViewVO = this._fortSettingsNotActivatedViewVO;
        this._fortSettingsNotActivatedViewVO = new FortSettingsNotActivatedViewVO(param1);
        this.setDataForNotActivated(this._fortSettingsNotActivatedViewVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setFortClanInfo(param1:FortSettingsClanInfoVO):void {
        var _loc2_:String = "as_setFortClanInfo" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setDataForActivated(param1:FortSettingsActivatedViewVO):void {
        var _loc2_:String = "as_setDataForActivated" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setDataForNotActivated(param1:FortSettingsNotActivatedViewVO):void {
        var _loc2_:String = "as_setDataForNotActivated" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
