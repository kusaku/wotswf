package net.wg.gui.lobby.fortifications.cmp.build.impl {
import flash.display.MovieClip;
import flash.filters.GlowFilter;
import flash.text.TextField;

import net.wg.gui.lobby.fortifications.cmp.build.IBuildingIndicatorsCmp;
import net.wg.gui.lobby.fortifications.data.ModernizationCmpVO;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class ModernizationCmp extends MovieClip implements IDisposable {

    private static const GLOW_COLOR:uint = 12273152;

    public var buildingIcon:BuildingTexture = null;

    public var buildingLevel:MovieClip = null;

    public var buildingIndicators:IBuildingIndicatorsCmp = null;

    public var orderInfo:OrderInfoCmp = null;

    public var titleText:TextField = null;

    public function ModernizationCmp() {
        super();
    }

    private static function getGlowFilter(param1:Number):Array {
        var _loc2_:Array = [];
        var _loc3_:Number = 1;
        var _loc4_:Number = 30;
        var _loc5_:Number = 30;
        var _loc6_:Number = 0.3;
        var _loc7_:Number = 3;
        var _loc8_:Boolean = false;
        var _loc9_:Boolean = false;
        var _loc10_:GlowFilter = new GlowFilter(param1, _loc3_, _loc4_, _loc5_, _loc6_, _loc7_, _loc8_, _loc9_);
        _loc2_.push(_loc10_);
        return _loc2_;
    }

    public function applyGlowFilter():void {
        this.buildingIcon.filters = getGlowFilter(GLOW_COLOR);
    }

    public function dispose():void {
        this.buildingIcon.dispose();
        this.buildingIcon = null;
        this.buildingLevel = null;
        this.buildingIndicators.dispose();
        this.buildingIndicators = null;
        this.orderInfo.dispose();
        this.orderInfo = null;
        this.titleText = null;
    }

    public function setData(param1:ModernizationCmpVO):void {
        this.buildingIndicators.setData(param1.buildingIndicators);
        this.buildingIndicators.showToolTips(true);
        this.orderInfo.setData(param1.defResInfo);
        this.buildingLevel.gotoAndStop(param1.buildingLevel);
        this.buildingIcon.setState(param1.buildingIcon);
        this.titleText.htmlText = param1.titleText;
    }
}
}
