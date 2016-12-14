package net.wg.gui.lobby.fortifications.windows {
import flash.display.InteractiveObject;
import flash.text.TextField;

import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.fortifications.cmp.drctn.IDirectionListRenderer;
import net.wg.gui.lobby.fortifications.data.DirectionVO;
import net.wg.gui.lobby.fortifications.events.DirectionEvent;
import net.wg.infrastructure.base.meta.IFortCreateDirectionWindowMeta;
import net.wg.infrastructure.base.meta.impl.FortCreateDirectionWindowMeta;

import scaleform.clik.events.ButtonEvent;

public class FortCreateDirectionWindow extends FortCreateDirectionWindowMeta implements IFortCreateDirectionWindowMeta {

    public var descriptionTF:TextField;

    public var titleTF:TextField;

    public var newDirectionBtn:ISoundButtonEx;

    public var direction0:IDirectionListRenderer;

    public var direction1:IDirectionListRenderer;

    public var direction2:IDirectionListRenderer;

    public var direction3:IDirectionListRenderer;

    public var direction4:IDirectionListRenderer;

    public var direction5:IDirectionListRenderer;

    private var _allRenderers:Vector.<IDirectionListRenderer>;

    public function FortCreateDirectionWindow() {
        super();
        isModal = false;
        isCentered = true;
        this._allRenderers = new <IDirectionListRenderer>[this.direction0, this.direction1, this.direction2, this.direction3, this.direction4, this.direction5];
    }

    override protected function configUI():void {
        super.configUI();
        this.titleTF.htmlText = FORTIFICATIONS.FORTDIRECTIONSWINDOW_LABEL_OPENEDDIRECTIONS;
        this.newDirectionBtn.label = FORTIFICATIONS.FORTDIRECTIONSWINDOW_BUTTON_NEWDIRECTION;
        this.newDirectionBtn.mouseEnabledOnDisabled = true;
        this.newDirectionBtn.addEventListener(ButtonEvent.CLICK, this.onNewDirectionBtnClickHandler);
        this.setupRenderers();
    }

    override protected function onDispose():void {
        this.newDirectionBtn.removeEventListener(ButtonEvent.CLICK, this.onNewDirectionBtnClickHandler);
        this.newDirectionBtn.dispose();
        this.newDirectionBtn = null;
        this.descriptionTF = null;
        this.titleTF = null;
        this.disposeRenderers();
        super.onDispose();
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(InteractiveObject(this.newDirectionBtn));
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.title = FORTIFICATIONS.FORTDIRECTIONSWINDOW_TITLE;
    }

    public function as_setDescription(param1:String):void {
        this.descriptionTF.htmlText = param1;
    }

    override protected function setDirections(param1:Vector.<DirectionVO>):void {
        var _loc2_:uint = param1.length;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            this._allRenderers[_loc3_].setData(param1[_loc3_]);
            _loc3_++;
        }
        var _loc4_:uint = this._allRenderers.length;
        while (_loc3_ < _loc4_) {
            this._allRenderers[_loc3_].setData(null);
            _loc3_++;
        }
    }

    public function as_setupButton(param1:Boolean, param2:Boolean, param3:String):void {
        this.newDirectionBtn.enabled = param1;
        this.newDirectionBtn.visible = param2;
        this.newDirectionBtn.tooltip = param3;
    }

    private function disposeRenderers():void {
        var _loc1_:IDirectionListRenderer = null;
        for each(_loc1_ in this._allRenderers) {
            _loc1_.removeEventListener(DirectionEvent.CLOSE_DIRECTION, this.onRendererCloseDirectionHandler);
            _loc1_.dispose();
        }
        this._allRenderers.splice(0, this._allRenderers.length);
        this._allRenderers = null;
        this.direction0 = null;
        this.direction1 = null;
        this.direction2 = null;
        this.direction3 = null;
        this.direction4 = null;
        this.direction5 = null;
    }

    private function setupRenderers():void {
        var _loc1_:IDirectionListRenderer = null;
        for each(_loc1_ in this._allRenderers) {
            _loc1_.addEventListener(DirectionEvent.CLOSE_DIRECTION, this.onRendererCloseDirectionHandler);
        }
    }

    private function onNewDirectionBtnClickHandler(param1:ButtonEvent):void {
        openNewDirectionS();
    }

    private function onRendererCloseDirectionHandler(param1:DirectionEvent):void {
        closeDirectionS(param1.id);
    }
}
}
