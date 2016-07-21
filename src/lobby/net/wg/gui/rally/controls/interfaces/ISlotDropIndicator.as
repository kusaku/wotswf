package net.wg.gui.rally.controls.interfaces {
import flash.display.InteractiveObject;

import net.wg.infrastructure.interfaces.ISpriteEx;
import net.wg.infrastructure.interfaces.entity.IDropItem;

public interface ISlotDropIndicator extends IDropItem, ISpriteEx {

    function get index():Number;

    function set index(param1:Number):void;

    function set isCurrentUserCommander(param1:Boolean):void;

    function set playerStatus(param1:int):void;

    function setHighlightState(param1:Boolean):void;

    function setAdditionalToolTipTarget(param1:InteractiveObject):void;

    function removeAdditionalTooltipTarget():void;
}
}
