package net.wg.gui.components.crosshairPanel {
import net.wg.infrastructure.interfaces.entity.IDisplayable;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public interface ICrosshair extends IDisposable, IDisplayable {

    function setHealth(param1:Number):void;

    function setDistance(param1:String):void;

    function clearDistance(param1:Boolean):void;

    function setDistanceVisibility(param1:Boolean):void;

    function updateAmmoState(param1:String):void;

    function setZoom(param1:String):void;

    function updatePlayerInfo(param1:String):void;

    function setAmmoStock(param1:Number, param2:Number, param3:Boolean, param4:String, param5:Boolean = false):void;

    function setClipsParam(param1:Number, param2:Number):void;

    function setNetType(param1:Number):void;

    function setCenterType(param1:Number):void;

    function setComponentsAlpha(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number):void;

    function setInfo(param1:Number, param2:String, param3:String, param4:Boolean, param5:Boolean, param6:String, param7:String, param8:Number, param9:Number, param10:String, param11:Number, param12:Number, param13:Boolean, param14:String, param15:Boolean = false):void;

    function setReloadingState(param1:String):void;

    function setReloadingAsPercent(param1:Number):void;

    function setReloadingTime(param1:Number):void;

    function showReloadingTimeField(param1:Boolean):void;
}
}
