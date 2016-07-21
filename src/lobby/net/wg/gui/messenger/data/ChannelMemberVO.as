package net.wg.gui.messenger.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class ChannelMemberVO extends DAAPIDataClass {

    private var _dbID:Number;

    private var _userName:String = "";

    private var _isOnline:Boolean = true;

    private var _state:Number;

    private var _isPlayerSpeaking:Boolean = false;

    private var _tags:Array;

    private var _color:uint;

    public function ChannelMemberVO(param1:Object) {
        super(param1);
    }

    public function get dbID():Number {
        return this._dbID;
    }

    public function set dbID(param1:Number):void {
        this._dbID = param1;
    }

    public function get userName():String {
        return this._userName;
    }

    public function set userName(param1:String):void {
        this._userName = param1;
    }

    public function get tags():Array {
        return this._tags;
    }

    public function set tags(param1:Array):void {
        this._tags = param1;
    }

    public function get state():Number {
        return this._state;
    }

    public function set state(param1:Number):void {
        this._state = param1;
    }

    public function get isPlayerSpeaking():Boolean {
        return this._isPlayerSpeaking;
    }

    public function set isPlayerSpeaking(param1:Boolean):void {
        this._isPlayerSpeaking = param1;
    }

    public function get color():uint {
        return this._color;
    }

    public function set color(param1:uint):void {
        this._color = param1;
    }

    public function get isOnline():Boolean {
        return this._isOnline;
    }

    public function set isOnline(param1:Boolean):void {
        this._isOnline = param1;
    }
}
}
