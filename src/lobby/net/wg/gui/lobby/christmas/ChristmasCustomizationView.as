package net.wg.gui.lobby.christmas {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.ListDAAPIDataProvider;
import net.wg.data.constants.Linkages;
import net.wg.data.constants.Values;
import net.wg.gui.components.advanced.ContentTabBar;
import net.wg.gui.components.advanced.ViewStack;
import net.wg.gui.components.assets.SeparatorAsset;
import net.wg.gui.components.assets.data.SeparatorConstants;
import net.wg.gui.components.controls.ButtonIconNormal;
import net.wg.gui.data.TabDataVO;
import net.wg.gui.events.LobbyEvent;
import net.wg.gui.events.ViewStackEvent;
import net.wg.gui.lobby.christmas.data.ChristmasFiltersVO;
import net.wg.gui.lobby.christmas.data.DecorationInfoVO;
import net.wg.gui.lobby.christmas.data.DecorationVO;
import net.wg.gui.lobby.christmas.data.slots.SlotVO;
import net.wg.gui.lobby.christmas.data.slots.SlotsDataVO;
import net.wg.gui.lobby.christmas.data.slots.SlotsStaticDataVO;
import net.wg.gui.lobby.christmas.dragDrop.ChristmasDragDropController;
import net.wg.gui.lobby.christmas.dragDrop.ChristmasDropDelegate;
import net.wg.gui.lobby.christmas.event.ChristmasCustomizationEvent;
import net.wg.gui.lobby.christmas.event.ChristmasCustomizationTabEvent;
import net.wg.gui.lobby.christmas.event.ChristmasDecorationsListEvent;
import net.wg.gui.lobby.christmas.event.ChristmasDropEvent;
import net.wg.gui.lobby.christmas.event.ChristmasSlotsEvent;
import net.wg.gui.lobby.christmas.interfaces.IChristmasDropActor;
import net.wg.gui.lobby.christmas.interfaces.IChristmasSlots;
import net.wg.gui.lobby.christmas.interfaces.ICustomizationStaticDataVO;
import net.wg.gui.lobby.christmas.interfaces.ISlotsStaticDataMap;
import net.wg.gui.lobby.components.InfoMessageComponent;
import net.wg.gui.lobby.components.data.InfoMessageVO;
import net.wg.gui.lobby.components.events.FiltersEvent;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.events.FocusChainChangeEvent;
import net.wg.infrastructure.interfaces.IFocusChainContainer;
import net.wg.utils.ICommons;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.IndexEvent;
import scaleform.clik.events.InputEvent;
import scaleform.clik.interfaces.IDataProvider;

public class ChristmasCustomizationView extends UIComponentEx implements IFocusChainContainer {

    private static const SEPARATOR_PADDING:int = 9;

    private static const MIN_DECORATIONS_LIST_HEIGHT:int = 169;

    private static const EMPTY_LIST_CMP_OFFSET:int = 40;

    public var rulesLabel:TextField = null;

    public var tabs:ContentTabBar = null;

    public var slotsViewStack:ViewStack = null;

    public var decorationsList:ChristmasDecorationsList = null;

    public var conversionBtn:ButtonIconNormal = null;

    public var listSeparatorTop:SeparatorAsset = null;

    public var listSeparatorBottom:SeparatorAsset = null;

    public var background:DisplayObject = null;

    public var emptyListCmp:InfoMessageComponent = null;

    private var _dragDropController:ChristmasDragDropController;

    private var _rulesLabelTooltip:String = null;

    private var _slotsStaticDataMap:ISlotsStaticDataMap = null;

    private var _commons:ICommons;

    private var _stage:Stage;

    public function ChristmasCustomizationView() {
        this._commons = App.utils.commons;
        this._stage = App.stage;
        super();
        this._dragDropController = new ChristmasDragDropController(ChristmasDropDelegate, Linkages.CHRISTMAS_DECORATION_ITEM_UI, this.canReceive);
        this.slotsViewStack.cache = true;
        this.slotsViewStack.addEventListener(ViewStackEvent.VIEW_CHANGED, this.onSlotsViewStackViewChangedHandler);
        this.slotsViewStack.addEventListener(ViewStackEvent.NEED_UPDATE, this.onSlotsViewStackNeedUpdateHandler);
    }

    override protected function configUI():void {
        super.configUI();
        this.listSeparatorTop.setType(SeparatorConstants.MEDIUM_TYPE);
        this.listSeparatorBottom.setType(SeparatorConstants.MEDIUM_TYPE);
        this.rulesLabel.autoSize = TextFieldAutoSize.RIGHT;
        this.conversionBtn.mouseEnabledOnDisabled = true;
        this.conversionBtn.addEventListener(ButtonEvent.CLICK, this.onConversionBtnClickHandler);
        this._dragDropController.addEventListener(ChristmasDropEvent.ITEM_DROPPED, this.onDragControllerItemDroppedHandler);
        this.rulesLabel.addEventListener(MouseEvent.ROLL_OVER, this.onRulesLabelRollOverHandler);
        this.rulesLabel.addEventListener(MouseEvent.ROLL_OUT, this.onRulesLabelRollOutHandler);
        this.decorationsList.addEventListener(Event.RESIZE, this.onDecorationListResizeHandler);
        this.tabs.addEventListener(IndexEvent.INDEX_CHANGE, this.onTabsIndexChangeHandler);
        this.emptyListCmp.addEventListener(FiltersEvent.RESET_FILTERS, this.onEmptyListCmpResetFiltersHandler);
        this._stage.dispatchEvent(new LobbyEvent(LobbyEvent.REGISTER_DRAGGING));
    }

    override protected function onDispose():void {
        this._stage.dispatchEvent(new LobbyEvent(LobbyEvent.UNREGISTER_DRAGGING));
        this.rulesLabel.removeEventListener(MouseEvent.ROLL_OVER, this.onRulesLabelRollOverHandler);
        this.rulesLabel.removeEventListener(MouseEvent.ROLL_OUT, this.onRulesLabelRollOutHandler);
        this._dragDropController.removeEventListener(ChristmasDropEvent.ITEM_DROPPED, this.onDragControllerItemDroppedHandler);
        this.decorationsList.removeEventListener(Event.RESIZE, this.onDecorationListResizeHandler);
        this.slotsViewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED, this.onSlotsViewStackViewChangedHandler);
        this.slotsViewStack.removeEventListener(ViewStackEvent.NEED_UPDATE, this.onSlotsViewStackNeedUpdateHandler);
        this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE, this.onTabsIndexChangeHandler);
        this.emptyListCmp.removeEventListener(FiltersEvent.RESET_FILTERS, this.onEmptyListCmpResetFiltersHandler);
        this.conversionBtn.removeEventListener(ButtonEvent.CLICK, this.onConversionBtnClickHandler);
        this.conversionBtn.dispose();
        this.conversionBtn = null;
        this.slotsViewStack.dispose();
        this.slotsViewStack = null;
        this.decorationsList.dispose();
        this.decorationsList = null;
        this._dragDropController.dispose();
        this._dragDropController = null;
        this.listSeparatorTop.dispose();
        this.listSeparatorTop = null;
        this.listSeparatorBottom.dispose();
        this.listSeparatorBottom = null;
        this.tabs.dispose();
        this.tabs = null;
        this.emptyListCmp.dispose();
        this.emptyListCmp = null;
        this.rulesLabel = null;
        this.background = null;
        this._slotsStaticDataMap = null;
        this._commons = null;
        this._stage = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.validateViewSize();
        }
    }

    public function getDecorationsDP():Object {
        if (this.decorationsList.dataProvider != null) {
            this.decorationsList.dataProvider.cleanUp();
        }
        var _loc1_:IDataProvider = new ListDAAPIDataProvider(DecorationVO);
        this.decorationsList.dataProvider = _loc1_;
        return _loc1_;
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
        _loc1_ = _loc1_.concat(this.currentSlots.getFocusChain());
        _loc1_.push(this.conversionBtn);
        return _loc1_;
    }

    public function scrollToItem(param1:int):void {
        this.decorationsList.scrollToIndex(param1);
    }

    public function selectSlotsTab(param1:int):void {
        this.tabs.selectedIndex = param1;
    }

    public function setEmptyListData(param1:Boolean, param2:InfoMessageVO):void {
        this.emptyListCmp.visible = param1;
        if (param1) {
            this.emptyListCmp.setTextWidthMax(this.decorationsList.width - EMPTY_LIST_CMP_OFFSET);
            this.emptyListCmp.setData(param2);
            invalidateSize();
        }
    }

    public function setFilters(param1:ChristmasFiltersVO, param2:ChristmasFiltersVO):void {
        this.currentSlots.setFilters(param1, param2);
    }

    public function setSlotsData(param1:SlotsDataVO):void {
        this.currentSlots.setData(param1);
    }

    public function setStaticData(param1:ICustomizationStaticDataVO):void {
        this.rulesLabel.htmlText = param1.rulesLabelText;
        this._rulesLabelTooltip = param1.rulesLabelTooltip;
        this._slotsStaticDataMap = param1;
        this.conversionBtn.tooltip = param1.btnConversionTooltip;
        this.tabs.dataProvider = param1.tabsData.tabs;
        this.tabs.selectedIndex = param1.tabsData.selectedInd;
        this.tabs.validateNow();
    }

    public function showSlotsView(param1:String):void {
        this.slotsViewStack.show(param1);
    }

    public function updateConversionBtn(param1:Boolean, param2:String):void {
        this.conversionBtn.enabled = param1;
        this.conversionBtn.iconSource = param2;
    }

    public function updateSlot(param1:SlotVO):void {
        this.currentSlots.updateSlot(param1);
    }

    private function validateViewSize():void {
        var _loc4_:IDataProvider = null;
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        var _loc7_:int = 0;
        var _loc1_:int = this.background.width;
        this.background.height = height;
        var _loc2_:int = SEPARATOR_PADDING;
        var _loc3_:int = height - this.listSeparatorTop.y - _loc2_ * 3;
        if (_loc3_ < MIN_DECORATIONS_LIST_HEIGHT) {
            _loc2_ = _loc2_ - (MIN_DECORATIONS_LIST_HEIGHT - _loc3_) / 3;
            _loc3_ = MIN_DECORATIONS_LIST_HEIGHT;
        }
        else {
            _loc4_ = this.decorationsList.dataProvider;
            _loc5_ = _loc4_ != null ? int(_loc4_.length) : 0;
            if (_loc5_ > 0) {
                _loc6_ = this.decorationsList.getRowHeight();
                if (_loc6_ > 0) {
                    _loc7_ = (_loc3_ - MIN_DECORATIONS_LIST_HEIGHT) / _loc6_;
                    _loc3_ = MIN_DECORATIONS_LIST_HEIGHT + _loc6_ * _loc7_;
                }
            }
        }
        this.decorationsList.y = this.listSeparatorTop.y + _loc2_ | 0;
        this.decorationsList.height = _loc3_;
        this.decorationsList.invalidate(InvalidationType.SCROLL_BAR);
        if (this.emptyListCmp.visible) {
            this.emptyListCmp.x = EMPTY_LIST_CMP_OFFSET;
            this.emptyListCmp.y = this.decorationsList.y + (this.decorationsList.height - this.emptyListCmp.height >> 1);
        }
        this.listSeparatorBottom.y = this.decorationsList.y + _loc3_ + _loc2_ | 0;
        this.listSeparatorBottom.width = _loc1_;
    }

    private function canReceive(param1:IChristmasDropActor, param2:String):Boolean {
        return param1.slotType == null || param1.slotType == param2;
    }

    private function get currentSlots():IChristmasSlots {
        return IChristmasSlots(this.slotsViewStack.currentView);
    }

    override public function handleInput(param1:InputEvent):void {
        var _loc2_:IChristmasSlots = this.currentSlots;
        if (_loc2_ != null) {
            _loc2_.handleInput(param1);
        }
    }

    private function onConversionBtnClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new ChristmasCustomizationEvent(ChristmasCustomizationEvent.SHOW_CONVERSION));
    }

    private function onTabsIndexChangeHandler(param1:IndexEvent):void {
        dispatchEvent(new ChristmasCustomizationTabEvent(ChristmasCustomizationTabEvent.CHANGE_TAB, TabDataVO(param1.data).id));
    }

    private function onDecorationListResizeHandler(param1:Event):void {
        invalidateSize();
    }

    private function onSlotsViewStackViewChangedHandler(param1:ViewStackEvent):void {
        var _loc5_:SlotsStaticDataVO = null;
        var _loc2_:IChristmasSlots = IChristmasSlots(param1.view);
        var _loc3_:Vector.<IChristmasDropActor> = _loc2_.getDropActors();
        var _loc4_:Vector.<IChristmasDropActor> = _loc3_.concat();
        _loc4_.push(this.decorationsList);
        this._dragDropController.setDropActors(_loc4_);
        _loc5_ = this._slotsStaticDataMap.getSlotsStaticData(param1.linkage);
        this.rulesLabel.visible = _loc5_.isRulesVisible;
        this.tabs.visible = _loc5_.isTabsVisible;
        this.conversionBtn.visible = _loc5_.isConversionBtnVisible;
        dispatchEvent(new FocusChainChangeEvent(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE));
    }

    private function onSlotsViewStackNeedUpdateHandler(param1:ViewStackEvent):void {
        var _loc2_:IChristmasSlots = IChristmasSlots(param1.view);
        _loc2_.setStaticData(this._slotsStaticDataMap.getSlotsStaticData(param1.linkage));
    }

    private function onDragControllerItemDroppedHandler(param1:ChristmasDropEvent):void {
        var _loc4_:DecorationInfoVO = null;
        var _loc2_:IChristmasDropActor = param1.sender;
        var _loc3_:IChristmasDropActor = param1.receiver;
        if (_loc2_ == this.decorationsList) {
            _loc4_ = param1.dropInfo;
            dispatchEvent(new ChristmasDecorationsListEvent(ChristmasDecorationsListEvent.INSTALL_ITEM, _loc4_.decorationId, _loc3_.slotId));
        }
        else if (_loc3_ == this.decorationsList) {
            dispatchEvent(new ChristmasSlotsEvent(ChristmasSlotsEvent.ITEM_REMOVED, _loc2_.slotId));
        }
        else {
            dispatchEvent(new ChristmasSlotsEvent(ChristmasSlotsEvent.ITEM_MOVED, _loc3_.slotId, Values.DEFAULT_INT, _loc2_.slotId));
        }
    }

    private function onRulesLabelRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onRulesLabelRollOverHandler(param1:MouseEvent):void {
        if (StringUtils.isNotEmpty(this._rulesLabelTooltip)) {
            App.toolTipMgr.showSpecial(this._rulesLabelTooltip, null);
        }
    }

    private function onEmptyListCmpResetFiltersHandler(param1:FiltersEvent):void {
        dispatchEvent(new ChristmasCustomizationEvent(ChristmasCustomizationEvent.EMPTY_LIST_BTN_CLICK));
    }
}
}
