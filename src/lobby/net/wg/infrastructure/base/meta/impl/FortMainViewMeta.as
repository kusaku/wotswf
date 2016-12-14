package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.BattleNotifiersDataVO;
import net.wg.gui.lobby.fortifications.data.FortModeStateVO;
import net.wg.gui.lobby.fortifications.data.FortificationVO;
import net.wg.infrastructure.base.BaseDAAPIComponent;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortMainViewMeta extends BaseDAAPIComponent {

    public var onClanProfileClick:Function;

    public var onStatsClick:Function;

    public var onClanClick:Function;

    public var onCalendarClick:Function;

    public var onSettingClick:Function;

    public var onCreateDirectionClick:Function;

    public var onEnterBuildDirectionClick:Function;

    public var onLeaveBuildDirectionClick:Function;

    public var onEnterTransportingClick:Function;

    public var onLeaveTransportingClick:Function;

    public var onIntelligenceClick:Function;

    public var onSortieClick:Function;

    public var onFirstTransportingStep:Function;

    public var onNextTransportingStep:Function;

    public var onViewReady:Function;

    public var onSelectOrderSelector:Function;

    private var _battleNotifiersDataVO:BattleNotifiersDataVO;

    private var _fortModeStateVO:FortModeStateVO;

    private var _fortificationVO:FortificationVO;

    public function FortMainViewMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._battleNotifiersDataVO) {
            this._battleNotifiersDataVO.dispose();
            this._battleNotifiersDataVO = null;
        }
        if (this._fortModeStateVO) {
            this._fortModeStateVO.dispose();
            this._fortModeStateVO = null;
        }
        if (this._fortificationVO) {
            this._fortificationVO.dispose();
            this._fortificationVO = null;
        }
        super.onDispose();
    }

    public function onClanProfileClickS():void {
        App.utils.asserter.assertNotNull(this.onClanProfileClick, "onClanProfileClick" + Errors.CANT_NULL);
        this.onClanProfileClick();
    }

    public function onStatsClickS():void {
        App.utils.asserter.assertNotNull(this.onStatsClick, "onStatsClick" + Errors.CANT_NULL);
        this.onStatsClick();
    }

    public function onClanClickS():void {
        App.utils.asserter.assertNotNull(this.onClanClick, "onClanClick" + Errors.CANT_NULL);
        this.onClanClick();
    }

    public function onCalendarClickS():void {
        App.utils.asserter.assertNotNull(this.onCalendarClick, "onCalendarClick" + Errors.CANT_NULL);
        this.onCalendarClick();
    }

    public function onSettingClickS():void {
        App.utils.asserter.assertNotNull(this.onSettingClick, "onSettingClick" + Errors.CANT_NULL);
        this.onSettingClick();
    }

    public function onCreateDirectionClickS(param1:uint):void {
        App.utils.asserter.assertNotNull(this.onCreateDirectionClick, "onCreateDirectionClick" + Errors.CANT_NULL);
        this.onCreateDirectionClick(param1);
    }

    public function onEnterBuildDirectionClickS():void {
        App.utils.asserter.assertNotNull(this.onEnterBuildDirectionClick, "onEnterBuildDirectionClick" + Errors.CANT_NULL);
        this.onEnterBuildDirectionClick();
    }

    public function onLeaveBuildDirectionClickS():void {
        App.utils.asserter.assertNotNull(this.onLeaveBuildDirectionClick, "onLeaveBuildDirectionClick" + Errors.CANT_NULL);
        this.onLeaveBuildDirectionClick();
    }

    public function onEnterTransportingClickS():void {
        App.utils.asserter.assertNotNull(this.onEnterTransportingClick, "onEnterTransportingClick" + Errors.CANT_NULL);
        this.onEnterTransportingClick();
    }

    public function onLeaveTransportingClickS():void {
        App.utils.asserter.assertNotNull(this.onLeaveTransportingClick, "onLeaveTransportingClick" + Errors.CANT_NULL);
        this.onLeaveTransportingClick();
    }

    public function onIntelligenceClickS():void {
        App.utils.asserter.assertNotNull(this.onIntelligenceClick, "onIntelligenceClick" + Errors.CANT_NULL);
        this.onIntelligenceClick();
    }

    public function onSortieClickS():void {
        App.utils.asserter.assertNotNull(this.onSortieClick, "onSortieClick" + Errors.CANT_NULL);
        this.onSortieClick();
    }

    public function onFirstTransportingStepS():void {
        App.utils.asserter.assertNotNull(this.onFirstTransportingStep, "onFirstTransportingStep" + Errors.CANT_NULL);
        this.onFirstTransportingStep();
    }

    public function onNextTransportingStepS():void {
        App.utils.asserter.assertNotNull(this.onNextTransportingStep, "onNextTransportingStep" + Errors.CANT_NULL);
        this.onNextTransportingStep();
    }

    public function onViewReadyS():void {
        App.utils.asserter.assertNotNull(this.onViewReady, "onViewReady" + Errors.CANT_NULL);
        this.onViewReady();
    }

    public function onSelectOrderSelectorS(param1:Boolean):void {
        App.utils.asserter.assertNotNull(this.onSelectOrderSelector, "onSelectOrderSelector" + Errors.CANT_NULL);
        this.onSelectOrderSelector(param1);
    }

    public final function as_switchMode(param1:Object):void {
        var _loc2_:FortModeStateVO = this._fortModeStateVO;
        this._fortModeStateVO = new FortModeStateVO(param1);
        this.switchMode(this._fortModeStateVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setMainData(param1:Object):void {
        var _loc2_:FortificationVO = this._fortificationVO;
        this._fortificationVO = new FortificationVO(param1);
        this.setMainData(this._fortificationVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setBattlesDirectionData(param1:Object):void {
        var _loc2_:BattleNotifiersDataVO = this._battleNotifiersDataVO;
        this._battleNotifiersDataVO = new BattleNotifiersDataVO(param1);
        this.setBattlesDirectionData(this._battleNotifiersDataVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function switchMode(param1:FortModeStateVO):void {
        var _loc2_:String = "as_switchMode" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setMainData(param1:FortificationVO):void {
        var _loc2_:String = "as_setMainData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setBattlesDirectionData(param1:BattleNotifiersDataVO):void {
        var _loc2_:String = "as_setBattlesDirectionData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
