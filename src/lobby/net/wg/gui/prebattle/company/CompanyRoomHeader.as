package net.wg.gui.prebattle.company {
import flash.display.InteractiveObject;
import flash.text.TextField;

import net.wg.data.constants.VehicleTypes;
import net.wg.gui.prebattle.company.VO.CompanyHeaderClassLimitsVO;
import net.wg.gui.prebattle.company.VO.CompanyRoomHeaderVO;
import net.wg.gui.prebattle.company.interfaces.ICompanyRoomHeader;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IDAAPIDataClass;

public class CompanyRoomHeader extends UIComponentEx implements ICompanyRoomHeader {

    public var limitsLabel:TextField = null;

    public var heavyLevelField:TextField = null;

    public var mediumLevelField:TextField = null;

    public var lightLevelField:TextField = null;

    public var atspgLevelField:TextField = null;

    public var spgLevelField:TextField = null;

    public var sumLevelLimitField:TextField = null;

    public function CompanyRoomHeader() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.limitsLabel.text = PREBATTLE.LABELS_COMPANY_LIMITS;
    }

    override protected function onDispose():void {
        this.limitsLabel = null;
        this.heavyLevelField = null;
        this.mediumLevelField = null;
        this.lightLevelField = null;
        this.atspgLevelField = null;
        this.spgLevelField = null;
        this.sumLevelLimitField = null;
        super.onDispose();
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return this;
    }

    public function update(param1:Object):void {
        var _loc6_:CompanyHeaderClassLimitsVO = null;
        var _loc7_:String = null;
        var _loc2_:CompanyRoomHeaderVO = CompanyRoomHeaderVO(param1);
        var _loc3_:Vector.<IDAAPIDataClass> = _loc2_.vehiclesType;
        var _loc4_:int = _loc3_.length;
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_) {
            _loc6_ = CompanyHeaderClassLimitsVO(_loc3_[_loc5_]);
            _loc7_ = _loc6_.vehClass;
            if (_loc7_ == VehicleTypes.HEAVY_TANK) {
                this.heavyLevelField.htmlText = _loc6_.limit;
            }
            else if (_loc7_ == VehicleTypes.MEDIUM_TANK) {
                this.mediumLevelField.htmlText = _loc6_.limit;
            }
            else if (_loc7_ == VehicleTypes.LIGHT_TANK) {
                this.lightLevelField.htmlText = _loc6_.limit;
            }
            else if (_loc7_ == VehicleTypes.AT_SPG) {
                this.atspgLevelField.htmlText = _loc6_.limit;
            }
            else if (_loc7_ == VehicleTypes.SPG) {
                this.spgLevelField.htmlText = _loc6_.limit;
            }
            _loc5_++;
        }
        this.sumLevelLimitField.htmlText = _loc2_.minMax;
    }
}
}
