package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.BaseDAAPIModule;

public class GlobalVarsMgrMeta extends BaseDAAPIModule {

    public var isDevelopment:Function;

    public var isShowLangaugeBar:Function;

    public var isShowServerStats:Function;

    public var isChina:Function;

    public var isKorea:Function;

    public var isTutorialRunning:Function;

    public var isRoamingEnabled:Function;

    public var isInRoaming:Function;

    public var isFreeXpToTankman:Function;

    public var getLocaleOverride:Function;

    public var isFortificationAvailable:Function;

    public var isShowTicker:Function;

    public var isRentalsEnabled:Function;

    public var isPotapovQuestEnabled:Function;

    public var isLoginLoadedAtFirstTime:Function;

    public function GlobalVarsMgrMeta() {
        super();
    }

    public function isDevelopmentS():Boolean {
        App.utils.asserter.assertNotNull(this.isDevelopment, "isDevelopment" + Errors.CANT_NULL);
        return this.isDevelopment();
    }

    public function isShowLangaugeBarS():Boolean {
        App.utils.asserter.assertNotNull(this.isShowLangaugeBar, "isShowLangaugeBar" + Errors.CANT_NULL);
        return this.isShowLangaugeBar();
    }

    public function isShowServerStatsS():Boolean {
        App.utils.asserter.assertNotNull(this.isShowServerStats, "isShowServerStats" + Errors.CANT_NULL);
        return this.isShowServerStats();
    }

    public function isChinaS():Boolean {
        App.utils.asserter.assertNotNull(this.isChina, "isChina" + Errors.CANT_NULL);
        return this.isChina();
    }

    public function isKoreaS():Boolean {
        App.utils.asserter.assertNotNull(this.isKorea, "isKorea" + Errors.CANT_NULL);
        return this.isKorea();
    }

    public function isTutorialRunningS(param1:String):Boolean {
        App.utils.asserter.assertNotNull(this.isTutorialRunning, "isTutorialRunning" + Errors.CANT_NULL);
        return this.isTutorialRunning(param1);
    }

    public function isRoamingEnabledS():Boolean {
        App.utils.asserter.assertNotNull(this.isRoamingEnabled, "isRoamingEnabled" + Errors.CANT_NULL);
        return this.isRoamingEnabled();
    }

    public function isInRoamingS():Boolean {
        App.utils.asserter.assertNotNull(this.isInRoaming, "isInRoaming" + Errors.CANT_NULL);
        return this.isInRoaming();
    }

    public function isFreeXpToTankmanS():Boolean {
        App.utils.asserter.assertNotNull(this.isFreeXpToTankman, "isFreeXpToTankman" + Errors.CANT_NULL);
        return this.isFreeXpToTankman();
    }

    public function getLocaleOverrideS():String {
        App.utils.asserter.assertNotNull(this.getLocaleOverride, "getLocaleOverride" + Errors.CANT_NULL);
        return this.getLocaleOverride();
    }

    public function isFortificationAvailableS():Boolean {
        App.utils.asserter.assertNotNull(this.isFortificationAvailable, "isFortificationAvailable" + Errors.CANT_NULL);
        return this.isFortificationAvailable();
    }

    public function isShowTickerS():Boolean {
        App.utils.asserter.assertNotNull(this.isShowTicker, "isShowTicker" + Errors.CANT_NULL);
        return this.isShowTicker();
    }

    public function isRentalsEnabledS():Boolean {
        App.utils.asserter.assertNotNull(this.isRentalsEnabled, "isRentalsEnabled" + Errors.CANT_NULL);
        return this.isRentalsEnabled();
    }

    public function isPotapovQuestEnabledS():Boolean {
        App.utils.asserter.assertNotNull(this.isPotapovQuestEnabled, "isPotapovQuestEnabled" + Errors.CANT_NULL);
        return this.isPotapovQuestEnabled();
    }

    public function isLoginLoadedAtFirstTimeS():Boolean {
        App.utils.asserter.assertNotNull(this.isLoginLoadedAtFirstTime, "isLoginLoadedAtFirstTime" + Errors.CANT_NULL);
        return this.isLoginLoadedAtFirstTime();
    }
}
}
