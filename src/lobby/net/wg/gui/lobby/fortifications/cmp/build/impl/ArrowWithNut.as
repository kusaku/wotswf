package net.wg.gui.lobby.fortifications.cmp.build.impl {
import flash.display.DisplayObject;

import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.fortBase.IArrowWithNut;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IUIComponentEx;
import net.wg.utils.ITweenAnimator;

import scaleform.clik.events.InputEvent;

public class ArrowWithNut extends UIComponentEx implements IArrowWithNut {

    public var nutMc:UILoaderAlt;

    private var _content:IUIComponentEx;

    private var _isExport:Boolean = true;

    private var _nutMcStartY:Number = 0;

    private var _animator:ITweenAnimator;

    public function ArrowWithNut() {
        super();
        this._animator = App.utils.tweenAnimator;
    }

    override protected function onDispose():void {
        this._content.dispose();
        this._content = null;
        this.nutMc.dispose();
        this.nutMc = null;
        this.removeAllAnims();
        this._animator = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.nutMc.source = RES_ICONS.MAPS_ICONS_LIBRARY_FORTIFICATION_NUT;
        this._nutMcStartY = this.nutMc.y;
        this.visible = false;
    }

    public function hide():void {
        this.removeAllAnims();
        var _loc1_:DisplayObject = DisplayObject(this.content);
        if (this._isExport) {
            this._animator.addMoveDownAnim(this.nutMc, this._nutMcStartY, null);
            this._animator.addMoveDownAnim(_loc1_, 0, null);
        }
        else {
            this._animator.addMoveUpAnim(this.nutMc, this._nutMcStartY, null);
            this._animator.addMoveUpAnim(_loc1_, 0, null);
        }
        this._animator.addFadeOutAnim(this.nutMc, null);
        this._animator.addFadeOutAnim(_loc1_, this);
    }

    public function onComplete():void {
        this.visible = false;
    }

    public function show():void {
        this.visible = true;
        this.removeAllAnims();
        var _loc1_:DisplayObject = DisplayObject(this.content);
        if (this._isExport) {
            this._animator.addMoveUpAnim(this.nutMc, this._nutMcStartY, null);
            this._animator.addMoveUpAnim(_loc1_, 0, null);
        }
        else {
            this._animator.addMoveDownAnim(this.nutMc, this._nutMcStartY, null);
            this._animator.addMoveDownAnim(_loc1_, 0, null);
        }
        this._animator.addFadeInAnim(this.nutMc, null);
        this._animator.addFadeInAnim(_loc1_, null);
    }

    private function removeAllAnims():void {
        this._animator.removeAnims(this.nutMc);
        this._animator.removeAnims(DisplayObject(this.content));
    }

    public function get isExport():Boolean {
        return this._isExport;
    }

    public function set isExport(param1:Boolean):void {
        this._isExport = param1;
    }

    public function get isShowed():Boolean {
        return this.nutMc.visible && this.nutMc.alpha == 1;
    }

    public function get isHidden():Boolean {
        return !this.nutMc.visible;
    }

    public function get content():IUIComponentEx {
        return this._content;
    }

    public function set content(param1:IUIComponentEx):void {
        this._content = param1;
    }

    override public function handleInput(param1:InputEvent):void {
        super.handleInput(param1);
    }
}
}
