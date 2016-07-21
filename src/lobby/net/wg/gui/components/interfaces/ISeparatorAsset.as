package net.wg.gui.components.interfaces {
import net.wg.infrastructure.interfaces.ISprite;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public interface ISeparatorAsset extends IDisposable, ISprite {

    function setCenterAsset(param1:String):void;

    function setSideAsset(param1:String):void;

    function setType(param1:String):void;

    function setMode(param1:String):void;

    function clearAssets():void;

    function setWidth(param1:Number):void;

    function get actualWidth():Number;
}
}
