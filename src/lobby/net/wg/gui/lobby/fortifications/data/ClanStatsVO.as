package net.wg.gui.lobby.fortifications.data {
import net.wg.data.VO.ILditInfo;
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.lobby.profile.pages.statistics.header.StatisticsHeaderVO;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.clik.data.DataProvider;
import scaleform.clik.interfaces.IDataProvider;

public class ClanStatsVO extends DAAPIDataClass {

    private static const KEYS_CLAN_STAT_ITEM_VO:Vector.<String> = new <String>["sortieBattlesCount", "sortieWins", "sortieAvgDefres", "periodBattles", "periodWins", "periodAvgDefres"];

    private static const KEYS_GROUPEX:Vector.<String> = new <String>["sortieBattlesStats", "sortieDefresStats", "periodBattlesStats", "periodDefresStats"];

    public var clanName:String = "";

    public var sortieBattlesCount:ILditInfo;

    public var sortieWins:ILditInfo;

    public var sortieAvgDefres:ILditInfo;

    public var sortieBattlesStats:DataProvider = null;

    public var sortieDefresStats:DataProvider = null;

    public var periodBattles:ILditInfo;

    public var periodWins:ILditInfo;

    public var periodAvgDefres:ILditInfo;

    public var periodBattlesStats:DataProvider = null;

    public var periodDefresStats:DataProvider = null;

    public function ClanStatsVO(param1:Object) {
        this.sortieBattlesStats = new DataProvider();
        this.sortieDefresStats = new DataProvider();
        this.periodBattlesStats = new DataProvider();
        this.periodDefresStats = new DataProvider();
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        if (KEYS_CLAN_STAT_ITEM_VO.indexOf(param1) >= 0) {
            this[param1] = new StatisticsHeaderVO(param2);
            return false;
        }
        if (KEYS_GROUPEX.indexOf(param1) >= 0) {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, param1 + Errors.CANT_NULL);
            for each(_loc4_ in _loc3_) {
                DataProvider(this[param1]).push(new ClanStatItemVO(_loc4_));
            }
            return false;
        }
        return true;
    }

    override protected function onDispose():void {
        var _loc3_:IDataProvider = null;
        var _loc4_:IDisposable = null;
        var _loc5_:IDisposable = null;
        var _loc1_:Vector.<ILditInfo> = new <ILditInfo>[this.sortieBattlesCount, this.sortieWins, this.sortieAvgDefres, this.periodBattles, this.periodWins, this.periodAvgDefres];
        while (_loc1_.length > 0) {
            _loc4_ = _loc1_.pop();
            if (_loc4_ != null) {
                _loc4_.dispose();
            }
        }
        this.sortieBattlesCount = null;
        this.sortieWins = null;
        this.sortieAvgDefres = null;
        this.periodBattles = null;
        this.periodWins = null;
        this.periodAvgDefres = null;
        var _loc2_:Array = [this.sortieBattlesStats, this.sortieDefresStats, this.periodBattlesStats, this.periodDefresStats];
        for each(_loc3_ in _loc2_) {
            if (_loc3_) {
                for each(_loc5_ in _loc3_) {
                    _loc5_.dispose();
                }
                _loc3_.cleanUp();
            }
        }
        this.sortieBattlesStats = null;
        this.sortieDefresStats = null;
        this.periodBattlesStats = null;
        this.periodDefresStats = null;
        super.onDispose();
    }
}
}
