package net.wg.gui.lobby.techtree.sub {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import net.wg.data.constants.Cursors;
import net.wg.data.constants.DragType;
import net.wg.data.constants.Errors;
import net.wg.gui.components.controls.ScrollBar;
import net.wg.gui.lobby.techtree.TechTreeEvent;
import net.wg.gui.lobby.techtree.controls.TreeNodeSelector;
import net.wg.gui.lobby.techtree.data.NationVODataProvider;
import net.wg.gui.lobby.techtree.data.vo.NodeData;
import net.wg.gui.lobby.techtree.data.vo.UnlockProps;
import net.wg.gui.lobby.techtree.helpers.Distance;
import net.wg.gui.lobby.techtree.helpers.NTGraphics;
import net.wg.gui.lobby.techtree.interfaces.INationTreeDataProvider;
import net.wg.gui.lobby.techtree.interfaces.INodesContainer;
import net.wg.gui.lobby.techtree.interfaces.IRenderer;
import net.wg.gui.lobby.techtree.interfaces.ITechTreePage;
import net.wg.gui.lobby.techtree.nodes.Renderer;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.entity.IDraggable;
import net.wg.utils.IAssertable;

import scaleform.clik.constants.InvalidationType;

public class NationTree extends UIComponentEx implements INodesContainer, IDraggable {

    private static const NT_TREE_MIN_POSITION_Y:Number = 34;

    private static const TREE_NODE_SELECTOR_X_SHIFT:int = 44;

    private static const TREE_NODE_SELECTOR_Y_SHIFT:int = 2;

    private static const EMPTY_STR:String = "";

    private static const THE_CLASS:String = "The class ";

    private static const CANNOT_BE_FOUND_IN_LIBRARY:String = " cannot be found in your library. Please ensure it exists. ";

    private static const UNLOCK_PROPS_SHOULD_BE_ARRAY:String = "Unlock properties value should be an Array.";

    private static const SCROLL_BAR_KEY:String = "scrollBar";

    private static const DEF_ACTIVATE_COOLDOWN:int = 250;

    public var nodeHeight:Number = 56;

    public var nodeWidth:Number = 132;

    public var scrollStepFactor:Number = 1.0;

    public var scrollBarBottomOffset:Number = 4;

    public var scrollBarRightOffset:Number = 9;

    public var containerHeight:Number = 610;

    public var scrollBar:ScrollBar;

    public var ntGraphics:NTGraphics;

    public var background:Sprite;

    public var treeNodeSelector:TreeNodeSelector;

    private var _scrollPosition:Number = 0;

    private var _renderers:Vector.<IRenderer>;

    private var _dataProvider:INationTreeDataProvider;

    private var _drawTreeEnabled:Boolean = false;

    private var _scrollToNode:Boolean = true;

    private var _scrollToPosition:Number = -1;

    private var _positionByNation:Object;

    private var _totalWidth:Number;

    private var _isDragging:Boolean = false;

    private var _dragOffset:Number = 0;

    private var _itemRendererName:String = "";

    private var _itemRendererClass:Class = null;

    private var _view:ITechTreePage = null;

    private var _requestInCoolDown:Boolean = false;

    private var _curRend:Renderer;

    private var _asserter:IAssertable = null;

    public function NationTree() {
        super();
        this._asserter = App.utils.asserter;
        this._positionByNation = {};
    }

    override protected function onDispose():void {
        visible = false;
        App.utils.scheduler.cancelTask(this.deactivateCoolDown);
        this.removeItemRenderers();
        this.view = null;
        NodeData.setDisplayInfoClass(null);
        this.ntGraphics.dispose();
        this.ntGraphics = null;
        if (this.scrollBar != null) {
            this.scrollBar.focusTarget = null;
            this.scrollBar.removeEventListener(Event.SCROLL, this.onScrollBarScrollHandler);
            this.scrollBar.dispose();
            this.scrollBar = null;
        }
        removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheelHandler);
        if (App.cursor != null) {
            App.cursor.unRegisterDragging(this);
        }
        if (this._dataProvider != null) {
            this._dataProvider.removeEventListener(TechTreeEvent.DATA_BUILD_COMPLETE, this.onDataProviderDataBuildCompleteHandler);
            this._dataProvider.dispose();
            this._dataProvider = null;
        }
        this.background = null;
        this._renderers = null;
        this._positionByNation = null;
        this._itemRendererClass = null;
        this._view = null;
        this._curRend = null;
        this._asserter = null;
        this.treeNodeSelector.removeEventListener(MouseEvent.ROLL_OUT, this.onTreeNodeSelectorRollOutHandler);
        this.treeNodeSelector.removeEventListener(MouseEvent.CLICK, this.onTreeNodeSelectorClickHandler);
        this.treeNodeSelector.dispose();
        this.treeNodeSelector = null;
        super.onDispose();
    }

    override protected function initialize():void {
        super.initialize();
        this._dataProvider = new NationVODataProvider();
        this._dataProvider.addEventListener(TechTreeEvent.DATA_BUILD_COMPLETE, this.onDataProviderDataBuildCompleteHandler, false, 0, true);
        this._renderers = new Vector.<IRenderer>();
        if (this.ntGraphics != null) {
            this.ntGraphics.container = this;
        }
    }

    override protected function configUI():void {
        super.configUI();
        this._totalWidth = _width;
        if (this.scrollBar != null) {
            this.scrollBar.addEventListener(Event.SCROLL, this.onScrollBarScrollHandler, false, 0, true);
            this.scrollBar.focusTarget = this;
            this.scrollBar.tabEnabled = false;
        }
        addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheelHandler, false, 0, true);
        if (App.cursor != null) {
            App.cursor.registerDragging(this, Cursors.MOVE);
        }
        this.treeNodeSelector.visible = false;
        this.treeNodeSelector.addEventListener(MouseEvent.ROLL_OUT, this.onTreeNodeSelectorRollOutHandler, false, 0, true);
        this.treeNodeSelector.addEventListener(MouseEvent.CLICK, this.onTreeNodeSelectorClickHandler, false, 0, true);
    }

    override protected function draw():void {
        if (isInvalid(InvalidationType.SIZE)) {
            this.updateLayouts();
        }
        if (!this._drawTreeEnabled) {
            return;
        }
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            if (this.ntGraphics != null) {
                this.ntGraphics.mouseEnabled = false;
                this.ntGraphics.setup();
            }
            this.itemRendererName = this._dataProvider.getDisplaySettings().nodeRendererName;
            this.drawRenderers();
            this.updateScrollBar();
            if (this._scrollToNode && this._dataProvider.getScrollIndex() > -1) {
                this.scrollToIndex(this._dataProvider.getScrollIndex());
            }
            else if (this._scrollToPosition >= 0) {
                this.scrollPosition = this._scrollToPosition;
                this._scrollToPosition = -1;
            }
            this._scrollToNode = false;
            if (this._renderers.length > 0) {
                this.drawLines();
            }
            this.ntGraphics.show();
            this._drawTreeEnabled = false;
        }
    }

    public function getDragType():String {
        return DragType.SOFT;
    }

    public function getHitArea():InteractiveObject {
        return this.background;
    }

    public function getNation():String {
        return this._dataProvider.nation;
    }

    public function getNodeByID(param1:Number):IRenderer {
        return this._renderers[this._dataProvider.getIndexByID(param1)];
    }

    public function getRootNode():IRenderer {
        return this._renderers[0];
    }

    public function invalidateNodesData(param1:String, param2:Object):void {
        this.ntGraphics.hide();
        this._drawTreeEnabled = false;
        this._scrollToPosition = this._positionByNation[param1] != undefined ? Number(this._positionByNation[param1]) : Number(0);
        this._dataProvider.invalidate(param1, param2);
    }

    public function isParentUnlocked(param1:Number, param2:Number):Boolean {
        var _loc3_:Object = this._dataProvider.getItemByID(param2);
        var _loc4_:UnlockProps = _loc3_.unlockProps as UnlockProps;
        App.utils.asserter.assertNotNull(_loc4_, UNLOCK_PROPS_SHOULD_BE_ARRAY);
        return _loc4_ != null && _loc4_.hasID(param1);
    }

    public function onDragging(param1:Number, param2:Number):void {
        var _loc3_:Number = this._dragOffset - stage.mouseX;
        _loc3_ = Math.max(0, Math.min(this._totalWidth - width, Math.round(_loc3_)));
        this._scrollPosition = Math.round(_loc3_ / this.scrollStepFactor);
        this.ntGraphics.x = -_loc3_;
        this.updateScrollBar();
    }

    public function onEndDrag():void {
        this._isDragging = false;
        var _loc1_:Boolean = this.showTreeNodeSelector();
        if (_loc1_) {
            this.updateTreeNodeSelectorPosition();
            this.treeNodeSelector.visible = true;
        }
    }

    public function onStartDrag():void {
        this.treeNodeSelector.visible = false;
        if (this._isDragging == true) {
            return;
        }
        this._isDragging = true;
        this._dragOffset = stage.mouseX - this.ntGraphics.x;
    }

    public function scrollToIndex(param1:Number):void {
        var _loc2_:IRenderer = null;
        if (-1 < param1 && param1 < this._renderers.length) {
            _loc2_ = this._renderers[param1];
            if (_loc2_ != null) {
                this.scrollPosition = Math.round((_loc2_.x + (this.nodeWidth + x - width >> 1)) / this.scrollStepFactor);
            }
        }
    }

    public function setItemsField(param1:Array, param2:String):void {
        var _loc4_:Number = NaN;
        var _loc5_:Array = null;
        var _loc6_:IRenderer = null;
        var _loc3_:Number = param1.length;
        var _loc7_:Boolean = false;
        var _loc8_:Number = 0;
        while (_loc8_ < _loc3_) {
            _loc5_ = param1[_loc8_];
            _loc4_ = this._dataProvider.getIndexByID(_loc5_[0]);
            if (_loc4_ > -1 && this._dataProvider.length > _loc4_) {
                this._dataProvider.setItemField(param2, _loc4_, _loc5_[1]);
                _loc6_ = this._renderers[_loc4_];
                _loc6_.invalidateNodeState(0);
                _loc6_.invalidate(InvalidationType.DATA);
                if (!_loc7_ && param2 == NodeData.VEH_COMPARE_TREE_NODE_DATA) {
                    if (_loc6_ == this._curRend) {
                        _loc7_ = true;
                        this.treeNodeSelector.visible = this.showTreeNodeSelector();
                    }
                }
            }
            _loc8_++;
        }
    }

    public function setNodesStates(param1:Number, param2:Array, param3:String = null):void {
        var _loc5_:Number = NaN;
        var _loc6_:Array = null;
        var _loc7_:Boolean = false;
        var _loc4_:Number = param2.length;
        var _loc8_:Number = 0;
        while (_loc8_ < _loc4_) {
            _loc6_ = param2[_loc8_];
            _loc5_ = this._dataProvider.getIndexByID(_loc6_[0]);
            if (_loc5_ > -1 && this._dataProvider.length > _loc5_) {
                if (param3 != null) {
                    _loc7_ = this._dataProvider.setItemField(param3, _loc5_, _loc6_[2]);
                }
                else {
                    _loc7_ = false;
                }
                if (this._dataProvider.setState(_loc5_, param1, _loc6_[1]) || _loc7_) {
                    this._renderers[_loc5_].invalidateNodeState(param1);
                }
            }
            _loc8_++;
        }
    }

    public function setVehicleTypeXP(param1:Array):void {
        var _loc3_:Number = NaN;
        var _loc4_:Array = null;
        var _loc2_:Number = param1.length;
        var _loc5_:Number = 0;
        while (_loc5_ < _loc2_) {
            _loc4_ = param1[_loc5_];
            _loc3_ = this._dataProvider.getIndexByID(_loc4_[0]);
            if (_loc3_ > -1 && this._dataProvider.length > _loc3_) {
                this._dataProvider.setEarnedXP(_loc3_, _loc4_[1]);
                this._renderers[_loc3_].invalidateNodeState(0);
            }
            _loc5_++;
        }
    }

    public function storeScrollPosition():void {
        if (this._dataProvider != null) {
            this._positionByNation[this._dataProvider.nation] = this._scrollPosition;
        }
    }

    protected function updateLayouts():void {
        if (this.background != null) {
            this.background.width = _width;
            this.background.height = _height;
        }
        this.ntGraphics.y = Math.max(_height - this.containerHeight >> 1, NT_TREE_MIN_POSITION_Y);
        this.scrollPosition = this._scrollPosition;
        this.drawScrollBar();
        this.updateScrollBar();
    }

    private function updateScrollBar():void {
        if (this.scrollBar != null) {
            this.scrollBar.setScrollProperties(this.scrollPageSize, 0, this.maxScroll);
            this.scrollBar.position = this.scrollPosition;
            this.scrollBar.visible = this.maxScroll > 0;
        }
    }

    private function activateCoolDown():void {
        this._requestInCoolDown = true;
        App.utils.scheduler.scheduleTask(this.deactivateCoolDown, DEF_ACTIVATE_COOLDOWN);
    }

    private function deactivateCoolDown():void {
        this._requestInCoolDown = false;
    }

    private function createItemRenderer(param1:Number, param2:NodeData):IRenderer {
        var _loc3_:IRenderer = new this._itemRendererClass();
        _loc3_.container = this;
        _loc3_.setup(param1, param2);
        _loc3_.addEventListener(TechTreeEvent.CLICK_2_OPEN, this.onRendererClick2OpenHandler, false, 0, true);
        _loc3_.addEventListener(TechTreeEvent.CLICK_2_UNLOCK, this.onRendererClick2UnlockHandler, false, 0, true);
        _loc3_.addEventListener(TechTreeEvent.CLICK_2_BUY, this.onRendererClick2BuyHandler, false, 0, true);
        _loc3_.addEventListener(MouseEvent.ROLL_OVER, this.onRendRollOverHandler, false, 0, true);
        _loc3_.addEventListener(MouseEvent.ROLL_OUT, this.onRendRollOutHandler, false, 0, true);
        _loc3_.addEventListener(TechTreeEvent.RESTORE_VEHICLE, this.onRendererRestoreVehicleHandler, false, 0, true);
        _loc3_.validateNowEx();
        return _loc3_;
    }

    private function cleanUpRenderer(param1:IRenderer):void {
        param1.removeEventListener(TechTreeEvent.CLICK_2_OPEN, this.onRendererClick2OpenHandler);
        param1.removeEventListener(TechTreeEvent.CLICK_2_UNLOCK, this.onRendererClick2UnlockHandler);
        param1.removeEventListener(TechTreeEvent.CLICK_2_BUY, this.onRendererClick2BuyHandler);
        param1.removeEventListener(MouseEvent.ROLL_OVER, this.onRendRollOverHandler);
        param1.removeEventListener(MouseEvent.ROLL_OUT, this.onRendRollOutHandler);
        param1.removeEventListener(TechTreeEvent.RESTORE_VEHICLE, this.onRendererRestoreVehicleHandler);
        param1.dispose();
    }

    private function removeItemRenderers():void {
        while (this._renderers.length > 0) {
            this.cleanUpRenderer(this._renderers.pop());
        }
        if (this.ntGraphics != null) {
            this.ntGraphics.clearUp();
        }
    }

    private function drawRenderers():void {
        var _loc2_:IRenderer = null;
        var _loc5_:Object = null;
        var _loc6_:int = 0;
        var _loc11_:NodeData = null;
        if (this._itemRendererClass == null) {
            return;
        }
        if (this.ntGraphics != null) {
            this.ntGraphics.clearCache();
        }
        var _loc1_:Number = this._dataProvider.length;
        while (this._renderers.length > _loc1_) {
            _loc2_ = this._renderers.pop();
            this.cleanUpRenderer(_loc2_);
            if (this.ntGraphics != null) {
                this.ntGraphics.removeRenderer(_loc2_);
            }
        }
        var _loc3_:Number = 0;
        var _loc4_:Vector.<Distance> = new Vector.<Distance>(10);
        var _loc7_:Boolean = false;
        var _loc8_:Boolean = this._dataProvider.getDisplaySettings().isLevelDisplayed;
        var _loc9_:Number = 0;
        while (_loc9_ < _loc1_) {
            if (_loc9_ < this._renderers.length) {
                _loc7_ = false;
                _loc2_ = this._renderers[_loc9_];
                if (this.ntGraphics != null) {
                    this.ntGraphics.clearUpRenderer(_loc2_);
                    this.ntGraphics.clearLinesAndArrows(_loc2_);
                }
                _loc11_ = this._dataProvider.getItemAt(_loc9_);
                _loc2_.setup(_loc9_, _loc11_);
            }
            else {
                _loc7_ = true;
                _loc2_ = this.createItemRenderer(_loc9_, this._dataProvider.getItemAt(_loc9_));
            }
            if (_loc7_ && _loc2_ != null) {
                this.ntGraphics.addChild(DisplayObject(_loc2_));
                this._renderers.push(_loc2_);
            }
            if (_loc8_) {
                _loc6_ = _loc2_.getLevel() - 1;
                if (_loc6_ > -1) {
                    if (_loc4_[_loc6_] != null) {
                        _loc5_ = _loc4_[_loc6_];
                        _loc5_.start = Math.min(_loc5_.start, _loc2_.getInX());
                        _loc5_.end = Math.max(_loc5_.end, _loc2_.getInX());
                    }
                    else {
                        _loc4_[_loc6_] = new Distance(_loc2_.getInX(), _loc2_.getInX());
                    }
                }
            }
            _loc3_ = Math.max(_loc3_, _loc2_.getInX() + this.nodeWidth);
            _loc9_++;
        }
        var _loc10_:Number = this.ntGraphics.drawLevelsDelimiters(_loc4_, this.containerHeight - (this.scrollBar != null ? this.scrollBar.height : 0), this.nodeWidth);
        this._totalWidth = _loc3_ + _loc10_;
        this.scrollPosition = this._scrollPosition;
    }

    private function drawLines():void {
        var _loc1_:Number = this._renderers.length;
        if (_loc1_ > 0) {
            this.ntGraphics.drawTopLines(this._renderers[0], false);
        }
        var _loc2_:Number = 1;
        while (_loc2_ < _loc1_) {
            this.ntGraphics.drawNodeLines(this._renderers[_loc2_], false);
            _loc2_++;
        }
    }

    private function drawScrollBar():void {
        if (this.scrollBar != null) {
            this.scrollBar.y = height - this.scrollBarBottomOffset;
            this.scrollBar.width = _width - this.scrollBarRightOffset;
            this.scrollBar.validateNow();
        }
    }

    private function showTreeNodeSelector():Boolean {
        return !this._isDragging && this._curRend != null && this._curRend.valueObject != null && this._curRend.valueObject.isCompareModeAvailable && !this._curRend.valueObject.isCompareBasketFull;
    }

    private function updateTreeNodeSelectorPosition():void {
        this.treeNodeSelector.x = this._curRend.x + TREE_NODE_SELECTOR_X_SHIFT + this.ntGraphics.x;
        this.treeNodeSelector.y = this._curRend.y - (this.treeNodeSelector.height >> 1) + this.ntGraphics.y + TREE_NODE_SELECTOR_Y_SHIFT;
    }

    public function get view():ITechTreePage {
        return this._view;
    }

    public function set view(param1:ITechTreePage):void {
        if (param1 == this._view) {
            return;
        }
        this._view = param1;
        var _loc2_:ScrollBar = null;
        if (this._view != null) {
            _loc2_ = this._view.getScrollBar();
        }
        this.scrollBar = _loc2_;
    }

    public function set itemRendererName(param1:String):void {
        var _loc3_:IRenderer = null;
        if (param1 == "" || this._itemRendererName == param1) {
            return;
        }
        this._itemRendererName = param1;
        var _loc2_:Class = App.utils.classFactory.getClass(this._itemRendererName);
        this._asserter.assertNotNull(_loc2_, Errors.BAD_LINKAGE + this._itemRendererName);
        this._itemRendererClass = _loc2_;
        while (this._renderers.length) {
            _loc3_ = this._renderers.pop();
            this.cleanUpRenderer(_loc3_);
            if (this.ntGraphics != null) {
                this.ntGraphics.removeRenderer(_loc3_);
            }
        }
    }

    public function get scrollPosition():Number {
        return this._scrollPosition;
    }

    public function set scrollPosition(param1:Number):void {
        param1 = Math.max(0, Math.min(this.maxScroll, Math.round(param1)));
        if (this._scrollPosition == param1) {
            return;
        }
        this._scrollPosition = param1;
        this.ntGraphics.x = -Math.min(Math.abs(this._totalWidth - width), this.scrollStepFactor * this._scrollPosition);
        this.updateScrollBar();
        var _loc2_:Boolean = this.showTreeNodeSelector();
        if (_loc2_) {
            this.updateTreeNodeSelectorPosition();
        }
        this.treeNodeSelector.visible = _loc2_;
    }

    public function get maxScroll():Number {
        return Math.ceil((this._totalWidth - width) / this.scrollStepFactor);
    }

    public function get scrollPageSize():Number {
        return Math.ceil(width / this.scrollStepFactor);
    }

    public function get dataProvider():INationTreeDataProvider {
        return this._dataProvider;
    }

    public function set dataProvider(param1:INationTreeDataProvider):void {
        if (this._dataProvider != null) {
            this._dataProvider.removeEventListener(TechTreeEvent.DATA_BUILD_COMPLETE, this.onDataProviderDataBuildCompleteHandler);
        }
        this._dataProvider = param1;
        if (this._dataProvider != null) {
            this._dataProvider.addEventListener(TechTreeEvent.DATA_BUILD_COMPLETE, this.onDataProviderDataBuildCompleteHandler, false, 0, true);
        }
    }

    private function onDataProviderDataBuildCompleteHandler(param1:TechTreeEvent):void {
        this._drawTreeEnabled = true;
        invalidateData();
    }

    private function onScrollBarScrollHandler(param1:Event):void {
        var _loc2_:Number = param1.target.position;
        if (isNaN(_loc2_)) {
            return;
        }
        this.scrollPosition = _loc2_;
        App.contextMenuMgr.hide();
    }

    private function onMouseWheelHandler(param1:MouseEvent):void {
        this.scrollPosition = this.scrollPosition - (param1.delta > 0 ? 1 : -1);
    }

    private function onRendererClick2OpenHandler(param1:TechTreeEvent):void {
        if (this.view != null) {
            this.view.goToNextVehicleS(this._curRend.valueObject.id);
        }
    }

    private function onRendererClick2UnlockHandler(param1:TechTreeEvent):void {
        var _loc2_:UnlockProps = null;
        if (!this._requestInCoolDown && this.view != null) {
            _loc2_ = this._curRend.valueObject.unlockProps;
            if (_loc2_ != null) {
                this.view.request4UnlockS(this._curRend.valueObject.id, _loc2_.parentID, _loc2_.unlockIdx, _loc2_.xpCost);
                this.activateCoolDown();
            }
        }
    }

    private function onRendererClick2BuyHandler(param1:TechTreeEvent):void {
        if (!this._requestInCoolDown && this.view != null) {
            this.view.request4BuyS(this._curRend.valueObject.id);
            this.activateCoolDown();
        }
    }

    private function onTreeNodeSelectorClickHandler(param1:MouseEvent):void {
        if (App.utils.commons.isLeftButton(param1) && !this._requestInCoolDown && this.view != null) {
            this.view.request4VehCompareS(this._curRend.valueObject.id);
            this.activateCoolDown();
        }
    }

    private function onRendRollOverHandler(param1:MouseEvent):void {
        var _loc2_:Renderer = param1.target as Renderer;
        this._asserter.assertNotNull(_loc2_, "Renderer" + Errors.CANT_NULL);
        this._curRend = _loc2_;
        var _loc3_:Boolean = this.showTreeNodeSelector();
        if (_loc3_) {
            this.updateTreeNodeSelectorPosition();
            this.treeNodeSelector.visible = true;
        }
    }

    private function onRendRollOutHandler(param1:MouseEvent):void {
        if (!this.treeNodeSelector.hit.hitTestPoint(App.stage.mouseX, App.stage.mouseY)) {
            this._curRend = null;
            this.treeNodeSelector.visible = false;
        }
    }

    private function onTreeNodeSelectorRollOutHandler(param1:MouseEvent):void {
        if (!this._curRend.hitTestPoint(App.stage.mouseX, App.stage.mouseY)) {
            this._curRend = null;
            this.treeNodeSelector.visible = false;
        }
    }

    private function onRendererRestoreVehicleHandler(param1:TechTreeEvent):void {
        var _loc2_:NodeData = null;
        if (!this._requestInCoolDown && this.view != null && param1.index > -1) {
            _loc2_ = this._dataProvider.getItemAt(param1.index);
            this.view.request4RestoreS(_loc2_.id);
            this.activateCoolDown();
        }
    }
}
}
