package net.wg.gui.lobby.fortifications.windows {
import flash.display.InteractiveObject;
import flash.events.Event;
import flash.text.TextField;

import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.fortifications.cmp.clan.impl.ClanInfoCmp;
import net.wg.gui.lobby.fortifications.cmp.drctn.impl.DirectionRadioRenderer;
import net.wg.gui.lobby.fortifications.data.ClanInfoVO;
import net.wg.gui.lobby.fortifications.data.ConnectedDirectionsVO;
import net.wg.infrastructure.base.meta.IFortDeclarationOfWarWindowMeta;
import net.wg.infrastructure.base.meta.impl.FortDeclarationOfWarWindowMeta;

import scaleform.clik.events.ButtonEvent;
import scaleform.clik.utils.Padding;

public class FortDeclarationOfWarWindow extends FortDeclarationOfWarWindowMeta implements IFortDeclarationOfWarWindowMeta {

    private static const WINDOW_BOTTOM_PADDING:int = 12;

    public var titleTF:TextField;

    public var descriptionTF:TextField;

    public var myClanInfo:ClanInfoCmp;

    public var enemyClanInfo:ClanInfoCmp;

    public var direction0:DirectionRadioRenderer;

    public var direction1:DirectionRadioRenderer;

    public var direction2:DirectionRadioRenderer;

    public var direction3:DirectionRadioRenderer;

    public var submitButton:ISoundButtonEx;

    public var cancelButton:ISoundButtonEx;

    private var _allRenderers:Vector.<DirectionRadioRenderer>;

    private var _selectedRenderer:DirectionRadioRenderer;

    public function FortDeclarationOfWarWindow() {
        super();
        isModal = true;
        isCentered = true;
        canDrag = false;
        this._allRenderers = new <DirectionRadioRenderer>[this.direction0, this.direction1, this.direction2, this.direction3];
    }

    override protected function configUI():void {
        super.configUI();
        this.enemyClanInfo.isMyClan = false;
        this.submitButton.label = FORTIFICATIONS.FORTDECLARATIONOFWARWINDOW_BUTTON_SUBMIT;
        this.cancelButton.label = FORTIFICATIONS.FORTDECLARATIONOFWARWINDOW_BUTTON_CANCEL;
        this.submitButton.addEventListener(ButtonEvent.CLICK, this.onSubmitButtonClickHandler);
        this.cancelButton.addEventListener(ButtonEvent.CLICK, this.onCancelButtonClickHandler);
        this.setupRenderers();
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.useBottomBtns = true;
        window.title = FORTIFICATIONS.FORTDECLARATIONOFWARWINDOW_TITLE;
        var _loc1_:Padding = Padding(window.contentPadding);
        _loc1_.bottom = WINDOW_BOTTOM_PADDING;
        window.contentPadding = _loc1_;
    }

    override protected function onDispose():void {
        this.submitButton.removeEventListener(ButtonEvent.CLICK, this.onSubmitButtonClickHandler);
        this.submitButton.dispose();
        this.submitButton = null;
        this.cancelButton.removeEventListener(ButtonEvent.CLICK, this.onCancelButtonClickHandler);
        this.cancelButton.dispose();
        this.cancelButton = null;
        this.myClanInfo.dispose();
        this.myClanInfo = null;
        this.enemyClanInfo.dispose();
        this.enemyClanInfo = null;
        this.titleTF = null;
        this.descriptionTF = null;
        this._selectedRenderer = null;
        this.disposeRenderers();
        super.onDispose();
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(InteractiveObject(this.submitButton));
    }

    public function as_selectDirection(param1:int):void {
        var _loc2_:DirectionRadioRenderer = null;
        this.submitButton.enabled = param1 != -1;
        for each(_loc2_ in this._allRenderers) {
            if (_loc2_.model && _loc2_.model.leftDirection.uid == param1) {
                this.selectDirection(_loc2_);
                return;
            }
        }
    }

    override protected function setDirections(param1:Vector.<ConnectedDirectionsVO>):void {
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

    override protected function setupClans(param1:ClanInfoVO, param2:ClanInfoVO):void {
        this.myClanInfo.model = param1;
        this.enemyClanInfo.model = param2;
    }

    public function as_setupHeader(param1:String, param2:String):void {
        this.titleTF.htmlText = param1;
        this.descriptionTF.htmlText = param2;
    }

    private function selectDirection(param1:DirectionRadioRenderer):void {
        if (this._selectedRenderer == param1) {
            return;
        }
        if (this._selectedRenderer) {
            this._selectedRenderer.selected = false;
        }
        this._selectedRenderer = param1;
        this._selectedRenderer.selected = true;
    }

    private function setupRenderers():void {
        var _loc1_:DirectionRadioRenderer = null;
        for each(_loc1_ in this._allRenderers) {
            _loc1_.addEventListener(Event.SELECT, this.onRendererSelectHandler);
        }
    }

    private function disposeRenderers():void {
        var _loc1_:DirectionRadioRenderer = null;
        for each(_loc1_ in this._allRenderers) {
            _loc1_.removeEventListener(Event.SELECT, this.onRendererSelectHandler);
            _loc1_.dispose();
        }
        this._allRenderers.splice(0, this._allRenderers.length);
        this._allRenderers = null;
        this.direction0 = null;
        this.direction1 = null;
        this.direction2 = null;
        this.direction3 = null;
    }

    private function onRendererSelectHandler(param1:Event):void {
        this.selectDirection(DirectionRadioRenderer(param1.currentTarget));
        onDirectionSelectedS();
    }

    private function onCancelButtonClickHandler(param1:ButtonEvent):void {
        onWindowCloseS();
    }

    private function onSubmitButtonClickHandler(param1:ButtonEvent):void {
        assertNotNull(this._selectedRenderer, "_selectedRenderer");
        assertNotNull(this._selectedRenderer.model, "_selectedRenderer.model");
        assertNotNull(this._selectedRenderer.model.leftDirection, "_selectedRenderer.model.leftDirection");
        var _loc2_:int = this._selectedRenderer.model.leftDirection.uid;
        onDirectonChosenS(_loc2_);
    }
}
}
