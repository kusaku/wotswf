package net.wg.gui.lobby.fortifications.data.battleResults {
import net.wg.data.constants.Errors;
import net.wg.gui.components.advanced.vo.NormalSortingTableHeaderVO;
import net.wg.gui.lobby.battleResults.data.BattleResultsMedalsListVO;

import scaleform.clik.data.DataProvider;
import scaleform.clik.interfaces.IDataProvider;

public class BattleResultsVO extends NormalSortingTableHeaderVO {

    private static const BATTLES:String = "battles";

    private static const ACHIEVEMENTS_LEFT:String = "achievementsLeft";

    private static const ACHIEVEMENTS_RIGHT:String = "achievementsRight";

    public var windowTitle:String = "";

    public var resultText:String = "";

    public var descriptionStartText:String = "";

    public var descriptionEndText:String = "";

    public var journalText:String = "";

    public var defResReceivedText:String = "";

    public var byClanText:String = "";

    public var byPlayerText:String = "";

    public var battleResult:String = "";

    public var clanResText:String = "";

    public var playerResText:String = "";

    public var showByPlayerInfo:Boolean = false;

    private var _battles:DataProvider;

    private var _achievementsLeft:DataProvider;

    private var _achievementsRight:DataProvider;

    public function BattleResultsVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Array = null;
        var _loc5_:Array = null;
        if (param1 == BATTLES) {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, Errors.INVALID_TYPE + BATTLES);
            this._battles = new DataProvider(_loc3_);
            return false;
        }
        if (param1 == ACHIEVEMENTS_LEFT) {
            _loc4_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc4_, Errors.INVALID_TYPE + ACHIEVEMENTS_LEFT);
            this.fillAchievementsLeft(_loc4_);
            return false;
        }
        if (param1 == ACHIEVEMENTS_RIGHT) {
            _loc5_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc5_, Errors.INVALID_TYPE + ACHIEVEMENTS_RIGHT);
            this.fillAchievementsRight(_loc5_);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        this._battles.cleanUp();
        this._battles = null;
        this.clearDataProvider(this._achievementsLeft);
        this._achievementsLeft = null;
        this.clearDataProvider(this._achievementsRight);
        this._achievementsRight = null;
        super.onDispose();
    }

    private function clearDataProvider(param1:DataProvider):void {
        var _loc2_:int = 0;
        var _loc3_:int = param1.length;
        _loc2_ = 0;
        while (_loc2_ < _loc3_) {
            param1[_loc2_].dispose();
            _loc2_++;
        }
        param1.cleanUp();
    }

    private function fillAchievementsRight(param1:Array):void {
        if (param1) {
            this._achievementsRight = new DataProvider();
            this.fillAchievements(this.achievementsRight, param1);
        }
    }

    private function fillAchievementsLeft(param1:Array):void {
        if (param1) {
            this._achievementsLeft = new DataProvider();
            this.fillAchievements(this.achievementsLeft, param1);
        }
    }

    private function fillAchievements(param1:Array, param2:Array):void {
        var _loc3_:uint = 0;
        var _loc4_:int = 0;
        if (param1) {
            _loc3_ = param2.length;
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                param1.push(new BattleResultsMedalsListVO(param2[_loc4_]));
                _loc4_++;
            }
        }
    }

    public function get battles():IDataProvider {
        return this._battles;
    }

    public function get achievementsLeft():DataProvider {
        return this._achievementsLeft;
    }

    public function get achievementsRight():DataProvider {
        return this._achievementsRight;
    }
}
}
