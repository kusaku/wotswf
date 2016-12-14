package net.wg.gui.lobby.techtree.sub {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.geom.Point;

import net.wg.data.constants.Errors;
import net.wg.data.constants.Linkages;
import net.wg.data.constants.generated.NODE_STATE_FLAGS;
import net.wg.gui.lobby.techtree.TechTreeEvent;
import net.wg.gui.lobby.techtree.constants.NodeEntityType;
import net.wg.gui.lobby.techtree.data.ResearchVODataProvider;
import net.wg.gui.lobby.techtree.data.vo.NodeData;
import net.wg.gui.lobby.techtree.data.vo.ResearchDisplayInfo;
import net.wg.gui.lobby.techtree.helpers.ModulesGraphics;
import net.wg.gui.lobby.techtree.helpers.NodeIndexFilter;
import net.wg.gui.lobby.techtree.interfaces.IRenderer;
import net.wg.gui.lobby.techtree.interfaces.IResearchContainer;
import net.wg.gui.lobby.techtree.interfaces.IResearchDataProvider;
import net.wg.gui.lobby.techtree.math.ADG_ItemLevelsBuilder;
import net.wg.gui.lobby.techtree.math.MatrixPosition;
import net.wg.gui.lobby.techtree.nodes.FakeNode;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.entity.IFocusContainer;

import scaleform.clik.constants.InvalidationType;

public class ModulesTree extends UIComponentEx implements IResearchContainer, IFocusContainer {

    private static const ERROR:String = "ERROR: ";

    private static const ZERO_LEVEL_ONE_NODE_ONLY:String = ERROR + "In zero level must has one node only.";

    private static const ROOT_RENDERER_ON_DISPLAY_LIST:String = ERROR + "Root renderer must be on display list.";

    private static const CYCLIC_REFERENCE_ERROR:String = ERROR + "Has cyclic reference.";

    public var yRatio:Number = 90;

    public var xRatio:Number = 90;

    public var topLevelX:Number = 10;

    public var nextLevelX:Number = 800;

    public var maxNodesOnLevel:Number = 10;

    public var rGraphics:ModulesGraphics;

    protected var _dataProvider:IResearchDataProvider;

    private var _vehicleNodeClass:Class = null;

    private var _itemNodeClass:Class = null;

    private var _fakeNodeClass:Class = null;

    private var _drawEnabled:Boolean = false;

    private var _levelsBuilder:ADG_ItemLevelsBuilder;

    private var _positionByID:Object;

    private var _renderers:Vector.<Vector.<IRenderer>>;

    private var _topRenderers:Vector.<IRenderer>;

    public function ModulesTree() {
        super();
    }

    override protected function onDispose():void {
        visible = false;
        this.removeItemRenderers();
        this.rGraphics.dispose();
        this.rGraphics = null;
        App.utils.data.cleanupDynamicObject(this._positionByID);
        this._positionByID = null;
        if (this._dataProvider != null) {
            this._dataProvider.removeEventListener(TechTreeEvent.DATA_BUILD_COMPLETE, this.onDataProviderDataBuildCompleteHandler);
            this._dataProvider.dispose();
            this._dataProvider = null;
        }
        this._vehicleNodeClass = null;
        this._itemNodeClass = null;
        this._fakeNodeClass = null;
        this._levelsBuilder = null;
        super.onDispose();
    }

    override protected function initialize():void {
        super.initialize();
        this._dataProvider = new ResearchVODataProvider();
        this._dataProvider.addEventListener(TechTreeEvent.DATA_BUILD_COMPLETE, this.onDataProviderDataBuildCompleteHandler, false, 0, true);
        this._levelsBuilder = null;
        this._renderers = new Vector.<Vector.<IRenderer>>();
        this._topRenderers = new Vector.<IRenderer>();
        this._positionByID = {};
        this.rGraphics.arrowRenderer = Linkages.RESEARCH_ITEMS_ARROW;
        this.rGraphics.container = this;
    }

    override protected function configUI():void {
        super.configUI();
        this.setupVehicleRenderer(this.rootRenderer, true);
        if (this.rGraphics != null) {
            this.rGraphics.xRatio = this.xRatio >> 1;
        }
    }

    override protected function draw():void {
        if (isInvalid(InvalidationType.SIZE)) {
            this.updateLayouts();
        }
        if (!this._drawEnabled) {
            return;
        }
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            this.rGraphics.setup();
            if (this.drawRenderers()) {
                this.drawLines();
            }
            this._drawEnabled = false;
            this.onDrawComplece();
        }
    }

    public function canInstallItems():Boolean {
        return false;
    }

    public function cleanUpRenderer(param1:IRenderer):void {
        if (param1 == null) {
            return;
        }
        param1.dispose();
    }

    public function getChildren(param1:IRenderer):Vector.<IRenderer> {
        var _loc2_:Vector.<IRenderer> = null;
        var _loc4_:NodeIndexFilter = null;
        var _loc3_:Number = param1.matrixPosition.row + 1;
        if (_loc3_ < this._renderers.length) {
            _loc4_ = new NodeIndexFilter(this._levelsBuilder.getChildrenLevelIdxs(param1.index));
            _loc2_ = Vector.<IRenderer>(this._renderers[_loc3_].filter(_loc4_.doFilter, _loc4_));
        }
        else {
            _loc2_ = new Vector.<IRenderer>();
        }
        return _loc2_;
    }

    public function getComponentForFocus():InteractiveObject {
        return this;
    }

    public function getNation():String {
        return this._dataProvider.nation;
    }

    public function getNodeByID(param1:Number):IRenderer {
        var _loc2_:MatrixPosition = this._positionByID[param1];
        var _loc3_:IRenderer = null;
        if (_loc2_.column == -1) {
            _loc3_ = this._topRenderers[_loc2_.row];
        }
        else {
            _loc3_ = this._renderers[_loc2_.row][_loc2_.column];
        }
        return _loc3_;
    }

    public function getParents(param1:IRenderer):Vector.<IRenderer> {
        var _loc2_:Vector.<IRenderer> = null;
        var _loc4_:NodeIndexFilter = null;
        var _loc3_:Number = param1.matrixPosition.row - 1;
        if (_loc3_ > 0 && _loc3_ < this._renderers.length) {
            _loc4_ = new NodeIndexFilter(this._levelsBuilder.getParentLevelIdxs(param1.index));
            _loc2_ = Vector.<IRenderer>(this._renderers[_loc3_].filter(_loc4_.doFilter, _loc4_));
        }
        else {
            _loc2_ = new Vector.<IRenderer>();
        }
        return _loc2_;
    }

    public function getRootNode():IRenderer {
        return this.rootRenderer;
    }

    public function getRootState():Number {
        return this._dataProvider.length > 0 ? Number(this._dataProvider.getItemAt(0).state) : Number(0);
    }

    public function getTopLevel():Vector.<IRenderer> {
        return this._topRenderers;
    }

    public function hasUnlockedParent(param1:Number, param2:Number):Boolean {
        var _loc4_:IRenderer = null;
        var _loc3_:Array = this._levelsBuilder.getParentLevelIdxs(param2);
        var _loc5_:int = _loc3_.length;
        var _loc6_:Number = 0;
        while (_loc6_ < _loc5_) {
            _loc4_ = this._renderers[param1][_loc3_[_loc6_]];
            if (_loc4_ != null && _loc4_.isUnlocked()) {
                return true;
            }
            _loc6_++;
        }
        return false;
    }

    public function invalidateNodesData(param1:String, param2:Object):void {
        this._drawEnabled = false;
        this._dataProvider.invalidate(param1, param2);
    }

    public function isParentUnlocked(param1:Number, param2:Number):Boolean {
        var _loc3_:Number = 0;
        var _loc4_:Number = this._dataProvider.getIndexByID(param1);
        if (_loc4_ > -1 && this._dataProvider.length > _loc4_) {
            _loc3_ = this._dataProvider.getItemAt(_loc4_).state;
        }
        else {
            _loc4_ = this._dataProvider.getTopLevelIndexByID(param1);
            if (_loc4_ > -1 && this._dataProvider.topLength > _loc4_) {
                _loc3_ = this._dataProvider.getTopLevelAt(_loc4_).state;
            }
        }
        return (_loc3_ & NODE_STATE_FLAGS.UNLOCKED) > 0;
    }

    public function isRootUnlocked():Boolean {
        return this.rootRenderer != null ? Boolean(this.rootRenderer.isUnlocked()) : false;
    }

    protected function onDrawComplece():void {
    }

    protected function updateLayouts():void {
    }

    protected function updateRootData():Boolean {
        var _loc2_:NodeData = null;
        var _loc3_:MatrixPosition = null;
        var _loc1_:Boolean = false;
        if (this._levelsBuilder.nodesByLevel[0][1] == null) {
            if (this.rootRenderer) {
                _loc1_ = true;
                _loc2_ = this._dataProvider.getRootItem();
                _loc3_ = new MatrixPosition(0, 0);
                this._renderers[0][0] = this.rootRenderer;
                this._positionByID[_loc2_.id] = new MatrixPosition(0, 0);
                this.rootRenderer.setup(0, _loc2_, 0, _loc3_);
                this.rootRenderer.validateNowEx();
            }
        }
        return _loc1_;
    }

    protected function setupItemRenderer(param1:IRenderer):void {
        if (param1 == null) {
            return;
        }
        param1.container = this;
    }

    protected function setupVehicleRenderer(param1:IRenderer, param2:Boolean = false):void {
        if (param1 == null) {
            return;
        }
        param1.container = this;
    }

    protected function onCircleReferenceDetected():void {
    }

    protected function drawRenderers():Boolean {
        if (this._levelsBuilder == null || this.rGraphics == null) {
            return false;
        }
        var _loc1_:Boolean = false;
        var _loc2_:RenderersOnScene = this.flushRenderersOnScene();
        this._renderers = this.createRenderersMatrix();
        this._positionByID = {};
        if (this.updateRootData()) {
            this.updateTopRenderers();
            this.updateRenderers(_loc2_);
            this.drawLayout();
            _loc1_ = true;
        }
        return _loc1_;
    }

    private function createRenderersMatrix():Vector.<Vector.<IRenderer>> {
        var _loc1_:MatrixPosition = this._levelsBuilder.levelDimension;
        var _loc2_:Vector.<Vector.<IRenderer>> = new Vector.<Vector.<IRenderer>>(_loc1_.row);
        var _loc3_:int = _loc1_.row;
        var _loc4_:Number = 0;
        while (_loc4_ < _loc3_) {
            _loc2_[_loc4_] = new Vector.<IRenderer>(_loc1_.column);
            _loc4_++;
        }
        return _loc2_;
    }

    private function flushRenderersOnScene():RenderersOnScene {
        var _loc1_:Vector.<IRenderer> = null;
        var _loc2_:IRenderer = null;
        var _loc6_:int = 0;
        var _loc7_:Number = NaN;
        var _loc3_:RenderersOnScene = new RenderersOnScene();
        var _loc4_:int = this._renderers.length;
        var _loc5_:Number = 1;
        while (_loc5_ < _loc4_) {
            _loc1_ = this._renderers[_loc5_];
            _loc6_ = _loc1_.length;
            _loc7_ = 0;
            while (_loc7_ < _loc6_) {
                _loc2_ = _loc1_[_loc7_];
                if (_loc2_ != null) {
                    this.rGraphics.clearUpRenderer(_loc2_);
                    this.rGraphics.clearLinesAndArrows(_loc2_);
                    _loc3_.addRenderer(_loc2_);
                }
                _loc7_++;
            }
            _loc5_++;
        }
        return _loc3_;
    }

    private function createItemRenderer(param1:uint):IRenderer {
        var _loc2_:IRenderer = null;
        switch (param1) {
            case NodeEntityType.TOP_VEHICLE:
            case NodeEntityType.NEXT_VEHICLE:
                _loc2_ = new this._vehicleNodeClass();
                this.setupVehicleRenderer(_loc2_);
                break;
            case NodeEntityType.RESEARCH_ITEM:
                _loc2_ = new this._itemNodeClass();
                this.setupItemRenderer(_loc2_);
                break;
            case NodeEntityType.UNDEFINED:
                _loc2_ = new this._fakeNodeClass();
        }
        return _loc2_;
    }

    private function removeItemRenderers():void {
        var _loc1_:Vector.<IRenderer> = null;
        while (this._topRenderers.length > 0) {
            this.cleanUpRenderer(this._topRenderers.pop());
        }
        while (this._renderers.length > 0) {
            _loc1_ = this._renderers.pop();
            while (_loc1_.length > 0) {
                this.cleanUpRenderer(_loc1_.pop());
            }
        }
        this._renderers = null;
        this._topRenderers = null;
    }

    private function updateTopRenderers():void {
        var _loc2_:IRenderer = null;
        var _loc3_:MatrixPosition = null;
        var _loc4_:NodeData = null;
        var _loc1_:Number = this._dataProvider.topLength;
        var _loc5_:Boolean = false;
        while (this._topRenderers.length > _loc1_) {
            _loc2_ = this._topRenderers.pop();
            this.cleanUpRenderer(_loc2_);
            if (this.rGraphics != null) {
                this.rGraphics.removeRenderer(_loc2_);
            }
        }
        var _loc6_:Number = 0;
        while (_loc6_ < _loc1_) {
            if (_loc6_ < this._topRenderers.length) {
                _loc5_ = false;
                _loc2_ = this._topRenderers[_loc6_];
                if (this.rGraphics != null) {
                    this.rGraphics.clearUpRenderer(_loc2_);
                    this.rGraphics.clearLinesAndArrows(_loc2_);
                }
            }
            else {
                _loc5_ = true;
                _loc2_ = this.createItemRenderer(NodeEntityType.TOP_VEHICLE);
            }
            if (_loc2_ != null) {
                _loc3_ = new MatrixPosition(_loc6_, -1);
                _loc4_ = this._dataProvider.getTopLevelAt(_loc6_);
                this._positionByID[_loc4_.id] = _loc3_;
                _loc2_.setup(_loc6_, _loc4_, NodeEntityType.TOP_VEHICLE, _loc3_);
                _loc2_.validateNowEx();
                if (_loc5_) {
                    this._topRenderers.push(_loc2_);
                    this.rGraphics.addChild(DisplayObject(_loc2_));
                }
            }
            _loc6_++;
        }
    }

    private function updateRenderers(param1:RenderersOnScene):void {
        var _loc2_:IRenderer = null;
        var _loc3_:MatrixPosition = null;
        var _loc4_:Object = null;
        var _loc5_:NodeData = null;
        var _loc7_:Array = null;
        var _loc10_:Number = NaN;
        var _loc11_:Number = NaN;
        var _loc12_:Number = NaN;
        var _loc14_:uint = 0;
        var _loc15_:Vector.<IRenderer> = null;
        var _loc16_:Vector.<IRenderer> = null;
        var _loc17_:Object = null;
        var _loc18_:Object = null;
        var _loc19_:FakeNode = null;
        var _loc20_:IRenderer = null;
        var _loc21_:IRenderer = null;
        var _loc22_:FakeNode = null;
        var _loc23_:int = 0;
        var _loc24_:int = 0;
        var _loc6_:Array = this._levelsBuilder.nodesByLevel;
        var _loc8_:Vector.<FakeNode> = new Vector.<FakeNode>();
        var _loc9_:Number = _loc6_.length;
        var _loc13_:Boolean = false;
        _loc11_ = 1;
        while (_loc11_ < _loc9_) {
            _loc7_ = _loc6_[_loc11_];
            _loc10_ = _loc7_.length;
            _loc12_ = 0;
            while (_loc12_ < _loc10_) {
                _loc4_ = _loc7_[_loc12_];
                if (_loc4_ != null) {
                    _loc5_ = null;
                    _loc13_ = false;
                    if (-1 < _loc4_.index && _loc4_.index < this._dataProvider.length) {
                        _loc5_ = this._dataProvider.getItemAt(_loc4_.index);
                    }
                    _loc14_ = this._dataProvider.resolveEntityType(_loc5_);
                    _loc3_ = new MatrixPosition(_loc11_, _loc12_);
                    _loc2_ = param1.getRenderer(_loc14_);
                    if (_loc2_ == null) {
                        _loc13_ = true;
                        _loc2_ = this.createItemRenderer(_loc14_);
                    }
                    if (_loc2_ != null) {
                        this._renderers[_loc11_][_loc12_] = _loc2_;
                        if (_loc5_ != null) {
                            this._positionByID[_loc5_.id] = _loc3_;
                        }
                        _loc2_.setup(_loc4_.index, _loc5_, _loc14_, _loc3_);
                        if (_loc2_.isFake()) {
                            _loc22_ = _loc2_ as FakeNode;
                            App.utils.asserter.assertNotNull(_loc22_, "fakeNodeRenderer " + Errors.CANT_NULL);
                            _loc8_.push(_loc22_);
                        }
                        _loc2_.validateNowEx();
                        if (_loc13_) {
                            this.rGraphics.addChild(DisplayObject(_loc2_));
                        }
                    }
                }
                _loc12_++;
            }
            _loc11_++;
        }
        param1.clearUp(this);
        _loc9_ = _loc8_.length;
        _loc11_ = 0;
        while (_loc11_ < _loc9_) {
            _loc19_ = _loc8_[_loc11_];
            _loc15_ = new Vector.<IRenderer>();
            _loc17_ = this._levelsBuilder.getChildrenLevelIdxs(_loc19_.index);
            _loc23_ = _loc17_.length;
            _loc12_ = 0;
            while (_loc12_ < _loc23_) {
                _loc20_ = this._renderers[_loc19_.matrixPosition.row + 1][_loc17_[_loc12_]];
                if (_loc20_ != null) {
                    _loc15_.push(_loc20_);
                }
                _loc12_++;
            }
            _loc19_.setChildren(_loc15_);
            _loc16_ = new Vector.<IRenderer>();
            _loc18_ = this._levelsBuilder.getParentLevelIdxs(_loc19_.index);
            _loc24_ = _loc18_.length;
            _loc12_ = 0;
            while (_loc12_ < _loc24_) {
                _loc21_ = this._renderers[_loc19_.matrixPosition.row - 1][_loc18_[_loc12_]];
                if (_loc21_ != null) {
                    _loc16_.push(_loc21_);
                }
                _loc12_++;
            }
            _loc19_.setParents(_loc16_);
            _loc11_++;
        }
    }

    private function drawLayout():void {
        var _loc5_:Number = NaN;
        var _loc6_:Number = NaN;
        var _loc7_:IRenderer = null;
        var _loc12_:Vector.<IRenderer> = null;
        var _loc13_:Point = null;
        var _loc16_:ResearchDisplayInfo = null;
        var _loc18_:int = 0;
        var _loc19_:Number = NaN;
        var _loc1_:Object = this._levelsBuilder.levelDimension;
        var _loc2_:Number = this.rootRenderer.getY();
        var _loc3_:Number = this.rootRenderer.getOutX();
        var _loc4_:Number = (this._topRenderers.length - 1) * this.yRatio;
        var _loc8_:int = this._topRenderers.length;
        _loc5_ = 0;
        _loc6_ = _loc2_ - (_loc4_ >> 1);
        while (_loc5_ < _loc8_) {
            _loc7_ = this._topRenderers[_loc5_];
            _loc7_.x = this.topLevelX;
            _loc7_.y = _loc6_ - (_loc7_.getY() - _loc7_.y);
            _loc5_++;
            _loc6_ = _loc6_ + this.yRatio;
        }
        var _loc9_:Array = new Array(_loc1_.column);
        _loc4_ = (_loc1_.column - 1) * this.yRatio;
        _loc9_[0] = _loc2_ - (_loc4_ >> 1);
        var _loc10_:int = _loc1_.column;
        var _loc11_:Number = 1;
        while (_loc11_ < _loc10_) {
            _loc9_[_loc11_] = _loc9_[_loc11_ - 1] + this.yRatio;
            _loc11_++;
        }
        var _loc14_:Number = _loc3_ + this.xRatio;
        var _loc15_:Number = 0;
        var _loc17_:int = this._renderers.length;
        _loc5_ = 1;
        while (_loc5_ < _loc17_) {
            _loc12_ = this._renderers[_loc5_];
            _loc18_ = _loc12_.length;
            _loc19_ = 0;
            while (_loc19_ < _loc18_) {
                _loc7_ = _loc12_[_loc19_];
                if (_loc7_ != null) {
                    _loc16_ = _loc7_.getDisplayInfo() as ResearchDisplayInfo;
                    if (_loc16_ != null && _loc16_.isDrawVehicle()) {
                        _loc13_ = new Point(this.nextLevelX, _loc9_[_loc19_] - _loc7_.getRatioY());
                    }
                    else {
                        _loc13_ = new Point(_loc14_, _loc9_[_loc19_] - _loc7_.getRatioY());
                        _loc15_ = Math.max(_loc7_.getActualWidth(), _loc15_);
                    }
                    _loc7_.setPosition(_loc13_);
                }
                _loc19_++;
            }
            _loc14_ = _loc14_ + (this.xRatio + _loc15_);
            _loc5_++;
        }
    }

    private function drawLines():void {
        var _loc1_:IRenderer = null;
        var _loc2_:Vector.<IRenderer> = null;
        var _loc4_:NodeIndexFilter = null;
        var _loc5_:Number = NaN;
        var _loc6_:Vector.<IRenderer> = null;
        var _loc9_:int = 0;
        var _loc10_:Number = NaN;
        var _loc3_:Boolean = this.isRootUnlocked();
        this.rGraphics.drawTopLevelLines(this.rootRenderer, this._topRenderers, false);
        var _loc7_:int = this._renderers.length - 1;
        var _loc8_:Number = 0;
        while (_loc8_ < _loc7_) {
            _loc2_ = this._renderers[_loc8_];
            _loc9_ = _loc2_.length;
            _loc10_ = 0;
            while (_loc10_ < _loc9_) {
                _loc1_ = _loc2_[_loc10_];
                if (_loc1_ != null) {
                    _loc5_ = _loc1_.matrixPosition.row + 1;
                    _loc4_ = new NodeIndexFilter(this._levelsBuilder.getChildrenLevelIdxs(_loc1_.index));
                    _loc6_ = Vector.<IRenderer>(this._renderers[_loc5_].filter(_loc4_.doFilter, _loc4_));
                    this.rGraphics.drawOutgoingLines(_loc1_, _loc6_, false, _loc3_);
                }
                _loc10_++;
            }
            _loc8_++;
        }
    }

    public function get rootRenderer():IRenderer {
        return this.rGraphics != null ? IRenderer(this.rGraphics.rootRenderer) : null;
    }

    public function get dataProvider():IResearchDataProvider {
        return this._dataProvider;
    }

    public function set dataProvider(param1:IResearchDataProvider):void {
        if (this._dataProvider != null) {
            this._dataProvider.removeEventListener(TechTreeEvent.DATA_BUILD_COMPLETE, this.onDataProviderDataBuildCompleteHandler);
        }
        this._dataProvider = param1;
        if (this._dataProvider != null) {
            this._dataProvider.addEventListener(TechTreeEvent.DATA_BUILD_COMPLETE, this.onDataProviderDataBuildCompleteHandler, false, 0, true);
        }
    }

    public function get vehicleNodeClass():Class {
        return this._vehicleNodeClass;
    }

    public function set vehicleNodeClass(param1:Class):void {
        if (this._vehicleNodeClass == param1) {
            return;
        }
        this._vehicleNodeClass = param1;
        invalidateData();
    }

    public function get itemNodeClass():Class {
        return this._itemNodeClass;
    }

    public function set itemNodeClass(param1:Class):void {
        if (this._itemNodeClass == param1) {
            return;
        }
        this._itemNodeClass = param1;
        invalidateData();
    }

    public function get fakeNodeClass():Class {
        return this._fakeNodeClass;
    }

    public function set fakeNodeClass(param1:Class):void {
        if (this._fakeNodeClass == param1) {
            return;
        }
        this._fakeNodeClass = param1;
        invalidateData();
    }

    private function onDataProviderDataBuildCompleteHandler(param1:TechTreeEvent):void {
        this._levelsBuilder = new ADG_ItemLevelsBuilder(this._dataProvider.length, this.maxNodesOnLevel);
        this._dataProvider.populate(this._levelsBuilder);
        this._levelsBuilder.process();
        if (this._levelsBuilder.hasCyclicReference()) {
            this.onCircleReferenceDetected();
            return;
        }
        this._drawEnabled = true;
        invalidateData();
    }
}
}

import net.wg.gui.lobby.techtree.constants.NodeEntityType;
import net.wg.gui.lobby.techtree.interfaces.IRenderer;
import net.wg.gui.lobby.techtree.sub.ModulesTree;

class RenderersOnScene {

    private var _items:Vector.<IRenderer>;

    private var _vehicles:Vector.<IRenderer>;

    private var _fakes:Vector.<IRenderer>;

    function RenderersOnScene() {
        super();
        this._items = new Vector.<IRenderer>();
        this._vehicles = new Vector.<IRenderer>();
        this._fakes = new Vector.<IRenderer>();
    }

    public function addRenderer(param1:IRenderer):void {
        switch (param1.getEntityType()) {
            case NodeEntityType.NEXT_VEHICLE:
                this._vehicles.push(param1);
                break;
            case NodeEntityType.RESEARCH_ITEM:
                this._items.push(param1);
                break;
            case NodeEntityType.UNDEFINED:
                this._fakes.push(param1);
        }
    }

    public function getRenderer(param1:uint):IRenderer {
        var _loc2_:IRenderer = null;
        switch (param1) {
            case NodeEntityType.NEXT_VEHICLE:
                if (this._vehicles.length > 0) {
                    _loc2_ = this._vehicles.pop();
                }
                break;
            case NodeEntityType.RESEARCH_ITEM:
                if (this._items.length > 0) {
                    _loc2_ = this._items.pop();
                }
                break;
            case NodeEntityType.UNDEFINED:
                if (this._fakes.length > 0) {
                    _loc2_ = this._fakes.pop();
                }
        }
        return _loc2_;
    }

    public function clearUp(param1:ModulesTree):void {
        this.clearVector(param1, this._items);
        this.clearVector(param1, this._vehicles);
        this.clearVector(param1, this._fakes);
    }

    private function clearVector(param1:ModulesTree, param2:Vector.<IRenderer>):void {
        var _loc3_:IRenderer = null;
        while (param2.length > 0) {
            _loc3_ = param2.pop();
            param1.cleanUpRenderer(_loc3_);
            param1.rGraphics.removeRenderer(_loc3_);
        }
    }
}
