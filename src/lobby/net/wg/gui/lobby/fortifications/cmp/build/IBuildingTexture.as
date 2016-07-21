package net.wg.gui.lobby.fortifications.cmp.build {
import flash.display.MovieClip;
import flash.events.IEventDispatcher;
import flash.geom.Rectangle;

import net.wg.infrastructure.interfaces.IUIComponentEx;

public interface IBuildingTexture extends IUIComponentEx, IEventDispatcher {

    function setBuildingShapeBounds(param1:Rectangle):void;

    function getBuildingShape():MovieClip;

    function setState(param1:String):void;

    function setIconOffsets(param1:Number, param2:Number):void;
}
}
