package net.wg.gui.lobby.tankman {
import net.wg.data.constants.IconsTypes;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.gfx.Extensions;

public class PersonalCaseDocsModel implements IDisposable {

    private static const templateS:Array = ["a", "b", "c", "d", "a", "b", "c", "d", "a1", "b2", "c3", "d4", "a5", "b6", "c7", "d8", "az", "xb", "cc", "fd", "ga", "tb", "jc", "dg"];

    public var firstNames:Array;

    public var lastNames:Array;

    public var icons:Array;

    public var userGold:Number = 0;

    public var userCredits:Number = 0;

    public var priceOfGold:Number = 0;

    public var priceOfCredits:Number = 0;

    public var useOnlyGold:Boolean = false;

    public var currentTankmanFirstName:String = null;

    public var currentTankmanLastName:String = null;

    public var currentTankmanIcon:String = null;

    public var originalIconFile:String = null;

    public var actionPriceDataGoldVo:ActionPriceVO = null;

    public var actionPriceDataCreditsVo:ActionPriceVO = null;

    public var fistNameMaxChars:uint = 0;

    public var lastNameMaxChars:uint = 0;

    public function PersonalCaseDocsModel(param1:Object) {
        this.firstNames = [];
        this.lastNames = [];
        this.icons = [];
        super();
        if (!Extensions.isScaleform) {
            this.createTestNames(param1.firstnames);
            this.createTestNames(param1.lastnames);
        }
        this.firstNames = param1.firstnames;
        this.lastNames = param1.lastnames;
        if (param1.action) {
            this.actionPriceDataGoldVo = new ActionPriceVO(param1.action);
            this.actionPriceDataGoldVo.ico = IconsTypes.GOLD;
            this.actionPriceDataCreditsVo = new ActionPriceVO(param1.action);
            this.actionPriceDataCreditsVo.ico = IconsTypes.CREDITS;
        }
        this.calculateMaxChars(this.firstNames, this, "firstNames");
        this.calculateMaxChars(this.lastNames, this, "lastNames");
        this.icons = param1.icons;
        this.userCredits = param1.money[0];
        this.userGold = param1.money[1];
        if (param1.passportChangeCost is Array) {
            this.priceOfGold = param1.passportChangeCost[0];
            this.priceOfCredits = param1.passportChangeCost[1];
        }
        else if (param1.passportChangeCost is int) {
            this.priceOfGold = param1.passportChangeCost;
            this.useOnlyGold = true;
        }
        if (!Extensions.isScaleform) {
            this.currentTankmanFirstName = param1.firstnames[0].value;
            this.currentTankmanLastName = param1.lastnames[0].value;
        }
    }

    public function dispose():void {
        this.firstNames.splice(0);
        this.firstNames = null;
        this.lastNames.splice(0);
        this.lastNames = null;
        this.icons.splice(0);
        this.icons = null;
        if (this.actionPriceDataGoldVo) {
            this.actionPriceDataGoldVo.dispose();
            this.actionPriceDataGoldVo = null;
        }
        if (this.actionPriceDataCreditsVo) {
            this.actionPriceDataCreditsVo.dispose();
            this.actionPriceDataCreditsVo = null;
        }
    }

    private function calculateMaxChars(param1:Array, param2:PersonalCaseDocsModel, param3:String):void {
        var _loc6_:uint = 0;
        var _loc4_:uint = param1.length;
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_) {
            _loc6_ = param1[_loc5_]["value"].length;
            if (param3 == "firstNames" && _loc6_ > param2.fistNameMaxChars) {
                param2.fistNameMaxChars = _loc6_;
            }
            else if (param3 == "lastNames" && _loc6_ > param2.lastNameMaxChars) {
                param2.lastNameMaxChars = _loc6_;
            }
            _loc5_++;
        }
    }

    private function createTestNames(param1:Array):void {
        var _loc3_:Object = null;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        var _loc2_:int = 0;
        while (_loc2_ < param1.length) {
            _loc3_ = param1[_loc2_];
            _loc3_.value = "";
            _loc4_ = Math.random() * 6 + 4;
            _loc5_ = 0;
            while (_loc5_ < _loc4_) {
                _loc6_ = Math.random() * templateS.length;
                _loc3_.value = _loc3_.value + templateS[_loc6_];
                _loc5_++;
            }
            _loc2_++;
        }
    }
}
}
