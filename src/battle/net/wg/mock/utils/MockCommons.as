package net.wg.mock.utils {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.text.TextField;

import net.wg.data.constants.KeyProps;
import net.wg.infrastructure.interfaces.IUserProps;
import net.wg.utils.ICommons;

public class MockCommons implements ICommons {

    public function MockCommons() {
        super();
    }

    public function addBlankLines(param1:String, param2:TextField, param3:Vector.<TextField>):void {
    }

    public function addMultipleHandlers(param1:Vector.<IEventDispatcher>, param2:String, param3:Function):void {
    }

    public function cutBitmapFromBitmapData(param1:BitmapData, param2:Rectangle):Bitmap {
        return null;
    }

    public function formatPlayerName(param1:TextField, param2:IUserProps):Boolean {
        return false;
    }

    public function getFullPlayerName(param1:IUserProps):String {
        return "";
    }

    public function getUserProps(param1:String, param2:String = null, param3:String = null, param4:int = 0, param5:Array = null):IUserProps {
        return null;
    }

    public function initTabIndex(param1:Vector.<InteractiveObject>):void {
    }

    public function keyToString(param1:Number):KeyProps {
        return null;
    }

    public function moveDsiplObjToEndOfText(param1:DisplayObject, param2:TextField, param3:int = 0, param4:int = 0):void {
    }

    public function releaseReferences(param1:Object, param2:Boolean = true):void {
    }

    public function removeMultipleHandlers(param1:Vector.<IEventDispatcher>, param2:String, param3:Function):void {
    }

    public function rgbToArgb(param1:uint, param2:Number):uint {
        return 0;
    }

    public function setColorTransformMultipliers(param1:DisplayObject, param2:Number = 1, param3:Number = 1, param4:Number = 1, param5:Number = 1):void {
    }

    public function setGlowFilter(param1:DisplayObject, param2:Number):void {
    }

    public function setSaturation(param1:Sprite, param2:Number):void {
    }

    public function setShadowFilter(param1:DisplayObject, param2:uint):void {
    }

    public function setShadowFilterWithParams(param1:DisplayObject, param2:Number = 4.0, param3:Number = 45, param4:uint = 0, param5:Number = 1.0, param6:Number = 4.0, param7:Number = 4.0, param8:Number = 1.0, param9:int = 1, param10:Boolean = false, param11:Boolean = false, param12:Boolean = false):void {
    }

    public function truncateTextFieldText(param1:TextField, param2:String, param3:Boolean = true):String {
        return "";
    }

    public function updateChildrenMouseEnabled(param1:DisplayObjectContainer, param2:Boolean):void {
    }

    public function updateTextFieldSize(param1:TextField, param2:Boolean = true, param3:Boolean = true):void {
    }

    public function isLeftButton(param1:MouseEvent):Boolean {
        return false;
    }

    public function isRightButton(param1:MouseEvent):Boolean {
        return false;
    }
}
}
