package net.wg.gui.battle.views.ribbonsPanel {
import flash.display.MovieClip;
import flash.utils.getQualifiedClassName;

import net.wg.gui.battle.views.ribbonsPanel.VO.RibbonVO;
import net.wg.gui.battle.views.ribbonsPanel.containers.Icons;
import net.wg.gui.battle.views.ribbonsPanel.containers.Ribbon;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class RibbonsAnimation extends MovieClip implements IDisposable {

    private static const SHOW_LBL:String = "show";

    private static const STATIC_LBL:String = "static";

    private static const HIDE_LBL:String = "hide";

    private static const CHANGE_LBL:String = "change";

    private static const STATIC_END_FRAME:int = 80;

    private static const CHANGE_END_FRAME:int = 100;

    private static const HIDE_END_FRAME:int = 126;

    public var ribbon:Ribbon = null;

    public var ribbon2:Ribbon = null;

    public var iconsSpr:Icons = null;

    public var icons2Spr:Icons = null;

    public var titleAnimation:RibbonTitleAnimation = null;

    public var titleAnimation2:RibbonTitleAnimation = null;

    private var _currentType:String;

    private var _isRunning:Boolean;

    private var _isDisposed:Boolean = false;

    private var _showCompleteCallBackFunction:Function;

    private var _hideRibbonCallBackFunction:Function;

    public function RibbonsAnimation() {
        super();
        this.iconsSpr = this.ribbon.ribbonsIcons;
        this.icons2Spr = this.ribbon2.ribbonsIcons;
        this.titleAnimation = this.ribbon.ribbonTitleAnimation;
        this.titleAnimation2 = this.ribbon2.ribbonTitleAnimation;
        addFrameScript(STATIC_END_FRAME, this.fadeOutRibbonAnimation);
        addFrameScript(CHANGE_END_FRAME, this.changeRibbons);
        addFrameScript(HIDE_END_FRAME, this.endRibbonAnimation);
        this.reset();
    }

    public function addSCallBackFunctions(param1:Function, param2:Function):void {
        this._showCompleteCallBackFunction = param1;
        this._hideRibbonCallBackFunction = param2;
    }

    public function reset():void {
        this._currentType = null;
        this.ribbon.visible = false;
        this.ribbon2.visible = false;
        this._isRunning = false;
        this.titleAnimation.reset();
        this.titleAnimation2.reset();
    }

    public function show(param1:RibbonVO):void {
        this._isRunning = true;
        this._currentType = param1.type;
        this.iconsSpr.showIcon(this._currentType);
        this.titleAnimation.setData(param1.title, param1.count);
        this.ribbon.visible = true;
        gotoAndPlay(SHOW_LBL);
    }

    public function hide():void {
        this._isRunning = true;
        gotoAndPlay(HIDE_LBL);
    }

    public function change(param1:RibbonVO):void {
        this._isRunning = true;
        this._currentType = param1.type;
        this.ribbon2.visible = true;
        this.icons2Spr.showIcon(param1.type);
        this.titleAnimation2.setData(param1.title, param1.count);
        gotoAndPlay(CHANGE_LBL);
    }

    public function incCount(param1:int):void {
        this._isRunning = true;
        this.titleAnimation.incCount(param1);
        gotoAndPlay(STATIC_LBL);
    }

    private function fadeOutRibbonAnimation():void {
        if (this._isRunning) {
            this._showCompleteCallBackFunction();
        }
    }

    private function changeRibbons():void {
        if (this._isRunning) {
            this.setRibbon(this.iconsSpr, this._currentType, this.titleAnimation2.title, this.titleAnimation2.count);
            gotoAndPlay(STATIC_LBL);
        }
    }

    private function endRibbonAnimation():void {
        if (this._isRunning) {
            this.reset();
            this._hideRibbonCallBackFunction();
        }
    }

    private function setRibbon(param1:Icons, param2:String, param3:String, param4:int):void {
        param1.showIcon(param2);
        this.titleAnimation.setData(param3, param4);
        this.ribbon.visible = true;
        this.ribbon2.visible = false;
    }

    public function get currentType():String {
        return this._currentType;
    }

    public function get isRunning():Boolean {
        return this._isRunning;
    }

    public function dispose():void {
        if (this._isDisposed && App.instance) {
            App.utils.asserter.assert(false, "(" + getQualifiedClassName(this) + ") already disposed!");
        }
        this._isDisposed = true;
        this.ribbon.dispose();
        this.ribbon = null;
        this.ribbon2.dispose();
        this.ribbon2 = null;
        this.iconsSpr = null;
        this.icons2Spr = null;
        this.titleAnimation = null;
        this.titleAnimation2 = null;
        this._showCompleteCallBackFunction = null;
        this._hideRibbonCallBackFunction = null;
    }
}
}
