package net.wg.gui.lobby.store {
import flash.display.Sprite;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

import net.wg.data.constants.generated.STORE_CONSTANTS;
import net.wg.gui.components.advanced.ButtonBarEx;
import net.wg.gui.components.advanced.ViewStack;
import net.wg.gui.components.controls.CloseButton;
import net.wg.gui.components.controls.TextFieldShort;
import net.wg.gui.lobby.store.data.ButtonBarVO;
import net.wg.gui.lobby.store.data.StoreViewInitVO;
import net.wg.infrastructure.base.meta.IStoreViewMeta;
import net.wg.infrastructure.base.meta.impl.StoreViewMeta;
import net.wg.infrastructure.interfaces.IDAAPIModule;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.IndexEvent;
import scaleform.clik.events.InputEvent;

public class StoreView extends StoreViewMeta implements IStoreViewMeta {

    public var title:TextFieldShort;

    public var closeBtn:CloseButton;

    public var buttonBar:ButtonBarEx;

    public var line:Sprite;

    public var viewStack:ViewStack;

    private var _shopIsRegistred:Boolean = false;

    private var _inventoryIsRegistred:Boolean = false;

    public function StoreView() {
        super();
    }

    override public function updateStage(param1:Number, param2:Number):void {
        super.updateStage(param1, param2);
        x = param1 - width >> 1;
        y = param2 - height >> 1;
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.viewStack.cache = true;
        this.buttonBar.addEventListener(IndexEvent.INDEX_CHANGE, this.onButtonBarIndexChangeHandler);
        this.closeBtn.addEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
        App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE, KeyboardEvent.KEY_DOWN, this.onEscapeKeyDownHandler, true);
        this.title.label = MENU.HEADERBUTTONS_SHOP;
        this.title.toolTip = MENU.HEADERBUTTONS_SHOP;
    }

    override protected function init(param1:StoreViewInitVO):void {
        this.buttonBar.dataProvider = new DataProvider(param1.buttonBarData);
        this.buttonBar.selectedIndex = param1.currentViewIdx;
    }

    override protected function onDispose():void {
        App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE, KeyboardEvent.KEY_DOWN);
        this.title.dispose();
        this.title = null;
        this.closeBtn.removeEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
        this.closeBtn.dispose();
        this.closeBtn = null;
        this.buttonBar.removeEventListener(IndexEvent.INDEX_CHANGE, this.onButtonBarIndexChangeHandler);
        this.buttonBar.dispose();
        this.buttonBar = null;
        this.line = null;
        this.viewStack.dispose();
        this.viewStack = null;
        super.onDispose();
    }

    public function as_showStorePage(param1:String):void {
        this.viewStack.show(param1);
    }

    private function onEscapeKeyDownHandler(param1:InputEvent):void {
        onCloseS();
    }

    private function onCloseBtnClickHandler(param1:ButtonEvent):void {
        onCloseS();
    }

    private function onButtonBarIndexChangeHandler(param1:IndexEvent):void {
        var _loc2_:ButtonBarVO = ButtonBarVO(this.buttonBar.dataProvider.requestItemAt(param1.index));
        var _loc3_:String = _loc2_.id;
        this.viewStack.show(_loc2_.linkage);
        var _loc4_:IDAAPIModule = IDAAPIModule(this.viewStack.currentView);
        if (_loc3_ == STORE_CONSTANTS.SHOP && !this._shopIsRegistred) {
            registerFlashComponentS(_loc4_, _loc3_);
            this._shopIsRegistred = true;
        }
        else if (_loc3_ == STORE_CONSTANTS.INVENTORY && !this._inventoryIsRegistred) {
            registerFlashComponentS(_loc4_, _loc3_);
            this._inventoryIsRegistred = true;
        }
        onTabChangeS(_loc3_);
    }
}
}
