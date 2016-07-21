package net.wg.gui.lobby.fortifications {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.ui.Keyboard;

import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
import net.wg.gui.components.windows.Window;
import net.wg.gui.cyberSport.interfaces.IChannelComponentHolder;
import net.wg.gui.lobby.fortifications.battleRoom.FortIntroView;
import net.wg.gui.lobby.fortifications.battleRoom.FortListView;
import net.wg.gui.rally.events.RallyViewsEvent;
import net.wg.infrastructure.base.meta.IAbstractRallyViewMeta;
import net.wg.infrastructure.base.meta.IFortBattleRoomWindowMeta;
import net.wg.infrastructure.base.meta.impl.FortBattleRoomWindowMeta;
import net.wg.infrastructure.events.FocusChainChangeEvent;
import net.wg.infrastructure.interfaces.IFocusChainContainer;
import net.wg.infrastructure.interfaces.entity.IFocusContainer;

import scaleform.clik.constants.InputValue;
import scaleform.clik.events.InputEvent;
import scaleform.clik.ui.InputDetails;

public class FortBattleRoomWindow extends FortBattleRoomWindowMeta implements IFortBattleRoomWindowMeta, IFocusChainContainer {

    private static const FOCUS_CHAIN:String = "focusChain";

    private var _focusChain:Vector.<InteractiveObject>;

    public function FortBattleRoomWindow() {
        this._focusChain = new Vector.<InteractiveObject>();
        super();
        _deferredDispose = true;
        isSourceTracked = true;
        showWindowBgForm = true;
        canMinimize = true;
    }

    override public function onWindowMinimizeS():void {
        super.onWindowMinimizeS();
    }

    override protected function getWindowTitle():String {
        return FORTIFICATIONS.SORTIE_INTROVIEW_TITLE;
    }

    override protected function updateFocus():void {
        var _loc1_:IAbstractRallyViewMeta = getCurrentView();
        var _loc2_:IChannelComponentHolder = _loc1_ as IChannelComponentHolder;
        if (autoSearch.visible) {
            autoSearchUpdateFocus();
        }
        else if (_loc2_ && isChatFocusNeeded()) {
            setFocus(_loc2_.getChannelComponent().messageInput);
            resetChatFocusRequirement();
        }
        else if (_loc1_ is FortListView) {
            setFocus(FortListView(getCurrentView()).rallyTable);
        }
        else if (_loc1_ is FortIntroView) {
            setFocus(FortIntroView(getCurrentView()).getComponentForFocus());
        }
        else if (lastFocusedElement) {
            setFocus(lastFocusedElement);
        }
    }

    override protected function onPopulate():void {
        super.onPopulate();
        addEventListener(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE, this.onFocusChainChangeHandler);
    }

    override protected function onBeforeDispose():void {
        removeEventListener(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE, this.onFocusChainChangeHandler);
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        this._focusChain.splice(0, this._focusChain.length);
        this._focusChain = null;
        super.onDispose();
    }

    override protected function registerCurrentView(param1:MovieClip, param2:String):void {
        super.registerCurrentView(param1, param2);
        invalidate(FOCUS_CHAIN);
    }

    override protected function draw():void {
        if (isInvalid(FOCUS_CHAIN)) {
            this.refreshFocusChain();
        }
        super.draw();
    }

    override protected function onViewLoadRequest(param1:*):void {
        super.onViewLoadRequest(param1);
        if (!param1) {
            return;
        }
        if (param1.alias == FORTIFICATION_ALIASES.FORT_BATTLE_ROOM_LIST_VIEW_UI) {
            if (param1.itemId) {
                onJoinClanBattleS(param1.itemId, param1.slotIndex, param1.peripheryID);
            }
            else {
                onBrowseRalliesS();
            }
        }
        else if (param1.alias == FORTIFICATION_ALIASES.FORT_BATTLE_ROOM_VIEW_UI) {
            if (param1.itemId) {
                onJoinRallyS(param1.itemId, param1.slotIndex, param1.peripheryID);
            }
            else {
                onCreateRallyS();
            }
        }
        else if (param1.alias == FORTIFICATION_ALIASES.FORT_CLAN_BATTLE_LIST_VIEW_UI) {
            onBrowseClanBattlesS();
        }
        else if (param1.alias == FORTIFICATION_ALIASES.FORT_CLAN_BATTLE_ROOM_VIEW_UI) {
            if (param1.itemId) {
                onJoinClanBattleS(param1.itemId, param1.slotIndex, param1.peripheryID);
            }
        }
        else if (param1.alias == RallyViewsEvent.CREATE_CLAN_BATTLE_ROOM) {
            onCreatedBattleRoomS(param1.itemId, param1.peripheryID);
        }
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc1_:Vector.<InteractiveObject> = IFocusChainContainer(this.currentView).getFocusChain();
        _loc1_.push(window.getCloseBtn());
        _loc1_.push(Window(window).minimizeBtn);
        return _loc1_;
    }

    private function refreshFocusChain():void {
        var _loc1_:int = this._focusChain.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            this._focusChain[_loc2_].tabIndex = -1;
            _loc2_++;
        }
        this._focusChain.splice(0, this._focusChain.length);
        if (currentView.as_getPyAlias() == FORTIFICATION_ALIASES.FORT_CLAN_BATTLE_LIST_VIEW_PY) {
            setFocus(IFocusContainer(getCurrentView()).getComponentForFocus());
            this._focusChain = this.getFocusChain();
            App.utils.commons.initTabIndex(this._focusChain);
        }
    }

    override public function handleInput(param1:InputEvent):void {
        if (param1.handled) {
            return;
        }
        var _loc2_:InputDetails = param1.details;
        if (_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN) {
            if (autoSearch.visible) {
                autoSearch.handleInput(param1);
            }
            else if (window.getCloseBtn().enabled) {
                param1.handled = true;
                onWindowCloseS();
            }
        }
    }

    private function onFocusChainChangeHandler(param1:FocusChainChangeEvent):void {
        invalidate(FOCUS_CHAIN);
    }
}
}
