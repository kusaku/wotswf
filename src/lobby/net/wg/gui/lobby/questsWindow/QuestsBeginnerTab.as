package net.wg.gui.lobby.questsWindow {
import flash.display.InteractiveObject;
import flash.display.MovieClip;

import net.wg.data.constants.Errors;
import net.wg.data.constants.generated.QUESTS_ALIASES;
import net.wg.gui.components.advanced.ViewStack;
import net.wg.gui.components.controls.ScrollBar;
import net.wg.gui.components.controls.ScrollingListEx;
import net.wg.gui.events.ListEventEx;
import net.wg.gui.events.ViewStackEvent;
import net.wg.gui.lobby.questsWindow.components.TextFieldMessageComponent;
import net.wg.gui.lobby.questsWindow.components.interfaces.IComplexViewStackItem;
import net.wg.gui.lobby.questsWindow.data.QuestRendererVO;
import net.wg.gui.lobby.questsWindow.data.QuestsDataVO;
import net.wg.infrastructure.events.FocusChainChangeEvent;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.interfaces.IDAAPIModule;
import net.wg.infrastructure.interfaces.IFocusChainContainer;
import net.wg.infrastructure.interfaces.IViewStackContent;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.events.ListEvent;
import scaleform.clik.interfaces.IDataProvider;

public class QuestsBeginnerTab extends QuestsBaseTab implements IComplexViewStackItem {

    public var questsList:ScrollingListEx;

    public var scrollBar:ScrollBar;

    public var questBG:MovieClip;

    public var listHidingBG:MovieClip;

    public var detailsViewStack:ViewStack;

    public var noItemsSelected:TextFieldMessageComponent;

    private var _componentForFocus:InteractiveObject;

    private var _model:QuestsDataVO;

    public function QuestsBeginnerTab() {
        super();
    }

    override public function as_setSelectedQuest(param1:String):void {
        var _loc5_:int = 0;
        App.utils.asserter.assert(StringUtils.isNotEmpty(param1), "questID" + Errors.CANT_EMPTY + " received: " + param1);
        var _loc2_:IDataProvider = this.questsList.dataProvider;
        var _loc3_:Number = _loc2_.length;
        var _loc4_:QuestRendererVO = null;
        _loc5_ = 0;
        while (_loc5_ < _loc3_) {
            _loc4_ = _loc2_[_loc5_];
            if (_loc4_.questID == param1) {
                if (this.questsList.selectedIndex == _loc5_) {
                    this.questsList.scrollToIndex(_loc5_);
                }
                else {
                    this.questsList.selectedIndex = _loc5_;
                }
                break;
            }
            _loc5_++;
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.noItemsSelected.text = QUESTS.QUESTS_TABS_NOSELECTED_TEXT;
        this.listHidingBG.mouseEnabled = false;
        this.listHidingBG.mouseChildren = false;
        this.questsList.setSelectionNavigator(new QuestsTasksNavigator());
        this.questsList.addEventListener(ListEvent.INDEX_CHANGE, this.onQuestListIndexChangeHandler);
        this.questsList.addEventListener(ListEventEx.ITEM_CLICK, this.onQuestListItemClickHandler);
        this.detailsViewStack.addEventListener(ViewStackEvent.VIEW_CHANGED, this.onDetailsViewChangedHandler);
        this.detailsViewStack.cache = true;
        this.setDetailsView(false);
    }

    override protected function setQuestsData(param1:QuestsDataVO):void {
        var _loc2_:Boolean = false;
        this._model = param1;
        _loc2_ = this._model.hasQuests();
        if (_loc2_) {
            this.questsList.dataProvider = this._model.quests;
        }
        this.questsList.visible = _loc2_;
        this.questBG.visible = _loc2_;
        this.listHidingBG.visible = _loc2_;
        if (!_loc2_) {
            this.scrollBar.visible = false;
        }
    }

    override protected function onDispose():void {
        this.detailsViewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED, this.onDetailsViewChangedHandler);
        this.questsList.removeEventListener(ListEvent.INDEX_CHANGE, this.onQuestListIndexChangeHandler);
        this.questsList.removeEventListener(ListEventEx.ITEM_CLICK, this.onQuestListItemClickHandler);
        this.questsList.dispose();
        this.questsList = null;
        this.scrollBar.dispose();
        this.scrollBar = null;
        this.detailsViewStack.dispose();
        this.detailsViewStack = null;
        this.noItemsSelected.dispose();
        this.noItemsSelected = null;
        this.questBG = null;
        this.listHidingBG = null;
        this._componentForFocus = null;
        this._model = null;
        super.onDispose();
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return this._componentForFocus;
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc1_:Vector.<InteractiveObject> = new <InteractiveObject>[this.questsList];
        var _loc2_:IFocusChainContainer = this.detailsViewStack.currentView as IFocusChainContainer;
        if (_loc2_ != null) {
            _loc1_ = _loc1_.concat(_loc2_.getFocusChain());
        }
        return _loc1_;
    }

    public function update(param1:Object):void {
    }

    private function setDetailsView(param1:Boolean):void {
        this.detailsViewStack.visible = param1;
        this.noItemsSelected.visible = !param1;
    }

    private function showDetails():void {
        var _loc1_:QuestRendererVO = this.selectedQuestRendererVO;
        var _loc2_:String = _loc1_.detailsLinkage;
        App.utils.asserter.assertNotNull(QUESTS_ALIASES.BEGINNER_DETAILS_LINKAGES.indexOf(_loc2_) >= 0, "Wrong quest details linkage.");
        this.detailsViewStack.show(_loc2_);
    }

    private function get selectedQuestRendererVO():QuestRendererVO {
        return QuestRendererVO(this.questsList.getSelectedVO());
    }

    private function onDetailsViewChangedHandler(param1:ViewStackEvent):void {
        var _loc2_:QuestRendererVO = this.selectedQuestRendererVO;
        var _loc3_:String = _loc2_.detailsPyAlias;
        var _loc4_:String = _loc2_.questID;
        App.utils.asserter.assertNotNull(QUESTS_ALIASES.BEGINNER_DETAILS_PY_ALIASES.indexOf(_loc3_) >= 0, "Wrong quest details py alias");
        App.utils.asserter.assertNotNull(_loc4_, "Quest ID" + Errors.CANT_EMPTY);
        var _loc5_:IViewStackContent = param1.view;
        if (!isFlashComponentRegisteredS(_loc3_)) {
            registerFlashComponentS(IDAAPIModule(_loc5_), _loc3_);
        }
        _loc5_.update(_loc4_);
        this.setDetailsView(true);
    }

    private function onQuestListItemClickHandler(param1:ListEventEx):void {
        if (param1.index == this.questsList.selectedIndex) {
            this.questsList.selectedIndex = -1;
        }
    }

    private function onQuestListIndexChangeHandler(param1:ListEvent):void {
        if (param1.index == -1) {
            this.setDetailsView(false);
        }
        else {
            this.showDetails();
            this._componentForFocus = InteractiveObject(param1.target);
            dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS, this));
            dispatchEvent(new FocusChainChangeEvent(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE));
        }
    }
}
}
