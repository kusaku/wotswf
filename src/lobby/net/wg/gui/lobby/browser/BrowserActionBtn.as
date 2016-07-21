package net.wg.gui.lobby.browser {
import flash.display.MovieClip;
import flash.events.MouseEvent;

import net.wg.gui.components.controls.SoundButtonEx;

import scaleform.clik.core.UIComponent;
import scaleform.clik.events.ButtonEvent;

public class BrowserActionBtn extends UIComponent {

    public static const ACTION_LOADING:String = "loading";

    public static const ACTION_RELOAD:String = "reload";

    public var btn:SoundButtonEx;

    public var icon:MovieClip;

    public var stopIcon:MovieClip;

    private var _isMouseOver:Boolean = false;

    private var _action:String = "loading";

    public function BrowserActionBtn() {
        super();
    }

    override protected function onDispose():void {
        this.btn.removeEventListener(ButtonEvent.CLICK, this.onBtnClick);
        this.btn.removeEventListener(MouseEvent.ROLL_OVER, this.onBtnRollOver);
        this.btn.removeEventListener(MouseEvent.ROLL_OUT, this.onBtnRollOut);
        this.btn.dispose();
        this.btn = null;
        this.icon = null;
        this.stopIcon = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.icon.mouseEnabled = false;
        this.icon.mouseChildren = false;
        this.stopIcon.mouseEnabled = false;
        this.stopIcon.mouseChildren = false;
        this.action = "reload";
        this.showStopIcon(false);
        this.btn.label = "";
        this.btn.addEventListener(ButtonEvent.CLICK, this.onBtnClick);
        this.btn.addEventListener(MouseEvent.ROLL_OVER, this.onBtnRollOver);
        this.btn.addEventListener(MouseEvent.ROLL_OUT, this.onBtnRollOut);
    }

    private function showStopIcon(param1:Boolean):void {
        this.stopIcon.visible = param1;
        this.icon.visible = !param1;
    }

    public function get action():String {
        return this._action;
    }

    public function set action(param1:String):void {
        this._action = param1;
        gotoAndStop(this.action);
        this.icon.mouseEnabled = false;
        this.icon.mouseChildren = false;
        if (this.action == ACTION_RELOAD) {
            this.showStopIcon(false);
        }
        else if (this._isMouseOver) {
            this.showStopIcon(true);
        }
    }

    public function get isMouseOver():Boolean {
        return this._isMouseOver;
    }

    private function onBtnClick(param1:ButtonEvent):void {
        dispatchEvent(new BrowserEvent(this.action == ACTION_LOADING ? BrowserEvent.ACTION_LOADING : BrowserEvent.ACTION_RELOAD));
    }

    private function onBtnRollOver(param1:MouseEvent):void {
        this.showStopIcon(this.action == ACTION_LOADING);
        this._isMouseOver = true;
    }

    private function onBtnRollOut(param1:MouseEvent):void {
        this.showStopIcon(false);
        this._isMouseOver = false;
    }
}
}
