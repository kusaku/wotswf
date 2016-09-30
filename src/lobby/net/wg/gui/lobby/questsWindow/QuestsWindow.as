package net.wg.gui.lobby.questsWindow {
import flash.display.InteractiveObject;
import flash.display.Sprite;

import net.wg.data.constants.generated.QUESTS_ALIASES;
import net.wg.gui.components.advanced.ButtonBarEx;
import net.wg.gui.components.advanced.ViewStack;
import net.wg.gui.data.TabsVO;
import net.wg.gui.events.ViewStackEvent;
import net.wg.gui.lobby.quests.views.QuestsPersonalWelcomeView;
import net.wg.gui.lobby.questsWindow.components.interfaces.IQuestsWindow;
import net.wg.infrastructure.base.meta.impl.QuestsWindowMeta;
import net.wg.infrastructure.events.FocusChainChangeEvent;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.interfaces.IDAAPIModule;
import net.wg.infrastructure.interfaces.IFocusChainContainer;
import net.wg.infrastructure.interfaces.IViewStackContent;
import net.wg.infrastructure.interfaces.entity.IFocusContainer;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.IndexEvent;

public class QuestsWindow extends QuestsWindowMeta implements IQuestsWindow {

    private static const FOCUS_CHAIN:String = "focusChain";

    private static const TABS_DP_DATA_FIELD:String = "id";

    public var tabs_mc:ButtonBarEx;

    public var view_mc:ViewStack;

    public var line:Sprite;

    private var _currentViewAlias:String = null;

    private var _focusList:Vector.<InteractiveObject>;

    private var _pyAlias:String;

    public function QuestsWindow() {
        this._focusList = new Vector.<InteractiveObject>();
        super();
        showWindowBgForm = false;
        isCentered = true;
    }

    override protected function configUI():void {
        super.configUI();
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(this);
    }

    override protected function onSetModalFocus(param1:InteractiveObject):void {
        super.onSetModalFocus(param1);
        setFocus(this);
    }

    override protected function onLeaveModalFocus():void {
        super.onLeaveModalFocus();
        if (stage != null) {
            setFocus(this);
        }
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.title = QUESTS.QUESTS_TITLE;
        this.tabs_mc.addEventListener(IndexEvent.INDEX_CHANGE, this.onTabsIndexChangeHandler);
        this.view_mc.addEventListener(ViewStackEvent.VIEW_CHANGED, this.onViewChangedHandler);
        this.view_mc.addEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onRequestFocusHandler);
        addEventListener(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE, this.onFocusChainChangeHandler);
    }

    override protected function onDispose():void {
        App.utils.scheduler.cancelTask(this.setFocusView);
        this.tabs_mc.removeEventListener(IndexEvent.INDEX_CHANGE, this.onTabsIndexChangeHandler);
        this.view_mc.removeEventListener(ViewStackEvent.VIEW_CHANGED, this.onViewChangedHandler);
        this.view_mc.removeEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onRequestFocusHandler);
        this.tabs_mc.dispose();
        this.tabs_mc = null;
        this.view_mc.dispose();
        this.view_mc = null;
        this.line = null;
        App.toolTipMgr.hide();
        removeEventListener(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE, this.onFocusChainChangeHandler);
        this._focusList.splice(0, this._focusList.length);
        this._focusList = null;
        super.onDispose();
    }

    override protected function draw():void {
        if (isInvalid(FOCUS_CHAIN)) {
            this.initFocusChain();
        }
        super.draw();
    }

    override protected function init(param1:TabsVO):void {
        if (this.tabs_mc.dataProvider != null) {
            this.tabs_mc.dataProvider.cleanUp();
        }
        this.tabs_mc.dataProvider = new DataProvider(param1.tabs);
    }

    public function as_loadView(param1:String, param2:String):void {
        this._pyAlias = param2;
        this.view_mc.show(param1);
    }

    public function as_selectTab(param1:String):void {
        this.tabs_mc.selectedIndex = QuestWindowUtils.instance.getDPItemIndex(this.tabs_mc.dataProvider, param1, TABS_DP_DATA_FIELD);
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
        if (this._currentViewAlias == QUESTS_ALIASES.PERSONAL_WELCOME_VIEW_ALIAS) {
            _loc1_.push(QuestsPersonalWelcomeView(this.view_mc.currentView).successBtn);
        }
        _loc1_.push(window.getCloseBtn());
        _loc1_.push(this.tabs_mc);
        if (this.view_mc.currentView is IFocusChainContainer) {
            _loc1_ = _loc1_.concat(IFocusChainContainer(this.view_mc.currentView).getFocusChain());
        }
        return _loc1_;
    }

    private function setFocusView(param1:IViewStackContent):void {
        setFocus(IFocusContainer(param1).getComponentForFocus());
    }

    private function invalidateFocusChain():void {
        invalidate(FOCUS_CHAIN);
    }

    private function initFocusChain():void {
        this.clearTabIndexes();
        this._focusList.splice(0, this._focusList.length);
        if (this._currentViewAlias == QUESTS_ALIASES.COMMON_QUESTS_VIEW_ALIAS) {
            this.setFocusView(IViewStackContent(this.view_mc.currentView));
        }
        else {
            this._focusList = this.getFocusChain();
            App.utils.commons.initTabIndex(this._focusList);
            if (this._currentViewAlias == QUESTS_ALIASES.PERSONAL_WELCOME_VIEW_ALIAS) {
                App.utils.scheduler.scheduleOnNextFrame(this.setFocusView, IViewStackContent(this.view_mc.currentView));
            }
        }
    }

    private function clearTabIndexes():void {
        var _loc3_:InteractiveObject = null;
        var _loc1_:int = this._focusList.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            _loc3_ = this._focusList[_loc2_];
            _loc3_.tabIndex = -1;
            _loc2_++;
        }
    }

    private function onTabsIndexChangeHandler(param1:IndexEvent):void {
        var _loc2_:Object = this.tabs_mc.dataProvider.requestItemAt(this.tabs_mc.selectedIndex);
        onTabSelectedS(_loc2_.id);
    }

    private function onViewChangedHandler(param1:ViewStackEvent):void {
        App.toolTipMgr.hide();
        if (this._currentViewAlias != null) {
            unregisterComponent(this._currentViewAlias);
        }
        this._currentViewAlias = this._pyAlias;
        registerFlashComponentS(IDAAPIModule(param1.view), this._currentViewAlias);
        setFocus(this);
        this.invalidateFocusChain();
    }

    private function onRequestFocusHandler(param1:FocusRequestEvent):void {
        setFocus(param1.focusContainer.getComponentForFocus());
    }

    private function onFocusChainChangeHandler(param1:FocusChainChangeEvent):void {
        this.invalidateFocusChain();
    }
}
}
