package net.wg.gui.lobby.techtree.interfaces {
import flash.geom.Point;

import net.wg.gui.lobby.techtree.data.vo.NodeData;
import net.wg.gui.lobby.techtree.math.MatrixPosition;
import net.wg.infrastructure.interfaces.IUIComponentEx;
import net.wg.infrastructure.interfaces.entity.ISoundable;

import scaleform.clik.interfaces.IListItemRenderer;

public interface IRenderer extends IListItemRenderer, ISoundable, IUIComponentEx {

    function setup(param1:uint, param2:NodeData, param3:uint = 0, param4:MatrixPosition = null):void;

    function validateNowEx():void;

    function getEntityType():uint;

    function getID():Number;

    function getItemName():String;

    function getItemType():String;

    function getGraphicsName():String;

    function getLevel():int;

    function getIconPath():String;

    function isFake():Boolean;

    function getEarnedXP():Number;

    function getNamedLabel(param1:String):String;

    function getNamedValue(param1:String):Number;

    function getDisplayInfo():Object;

    function getInX():Number;

    function getOutX():Number;

    function getY():Number;

    function getRatioY():Number;

    function setPosition(param1:Point):void;

    function getActualWidth():Number;

    function getColorIdx(param1:Number = -1):Number;

    function getColorIdxEx(param1:IRenderer):Number;

    function isNext2Unlock():Boolean;

    function isUnlocked():Boolean;

    function isElite():Boolean;

    function isPremium():Boolean;

    function inInventory():Boolean;

    function isWasInBattle():Boolean;

    function isVehicleCanBeChanged():Boolean;

    function isAvailable4Unlock():Boolean;

    function isAvailable4Buy():Boolean;

    function isAvailable4Sell():Boolean;

    function isRented():Boolean;

    function isActionEnabled():Boolean;

    function isButtonVisible():Boolean;

    function isSelected():Boolean;

    function invalidateNodeState(param1:Number):void;

    function get matrixPosition():MatrixPosition;

    function get container():INodesContainer;

    function set container(param1:INodesContainer):void;
}
}
