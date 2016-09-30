package net.wg.gui.lobby.techtree.sub {
import flash.display.Sprite;
import flash.events.MouseEvent;

import net.wg.data.constants.Errors;
import net.wg.data.constants.Linkages;
import net.wg.data.constants.Values;
import net.wg.gui.lobby.techtree.TechTreeEvent;
import net.wg.gui.lobby.techtree.constants.NodeEntityType;
import net.wg.gui.lobby.techtree.controls.ExperienceInformation;
import net.wg.gui.lobby.techtree.controls.PremiumLayout;
import net.wg.gui.lobby.techtree.controls.ResearchTitleBar;
import net.wg.gui.lobby.techtree.controls.TreeNodeSelector;
import net.wg.gui.lobby.techtree.data.vo.NodeData;
import net.wg.gui.lobby.techtree.data.vo.UnlockProps;
import net.wg.gui.lobby.techtree.data.vo.VehGlobalStats;
import net.wg.gui.lobby.techtree.helpers.ResearchGraphics;
import net.wg.gui.lobby.techtree.helpers.TitleAppearance;
import net.wg.gui.lobby.techtree.interfaces.IRenderer;
import net.wg.gui.lobby.techtree.interfaces.IResearchPage;
import net.wg.gui.lobby.techtree.nodes.Renderer;
import net.wg.gui.lobby.techtree.nodes.ResearchRoot;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
import net.wg.utils.IClassFactory;

import scaleform.clik.constants.InvalidationType;

public class ResearchItems extends ModulesTree implements ITutorialCustomComponent {

    private static const COOLDOWN:int = 250;

    private static const TREE_NODE_SELECTOR_X_SHIFT:int = 44;

    private static const TREE_NODE_SELECTOR_Y_SHIFT:int = 2;

    private static const COLON:String = ":";

    private static const NODE_DATA_NOT_FOUND:String = "Data of node not found by event = ";

    private static const NODE_IS_NOT_VEHICLE:String = "Node is not vehicle";

    private static const UNLOCK_INFORMATION_NOT_DEFINED:String = "Unlock information is not defined for node = ";

    public var titleDefaultY:Number = 0;

    public var view:IResearchPage;

    public var titleBar:ResearchTitleBar;

    public var premiumLayout:PremiumLayout;

    public var background:Sprite;

    public var treeNodeSelector:TreeNodeSelector;

    private var _titleAppearance:TitleAppearance = null;

    private var _requestInCoolDown:Boolean = false;

    private var _curVehRend:Renderer;

    public function ResearchItems() {
        App.tutorialMgr.addListenersToCustomTutorialComponent(this);
        super();
    }

    override public function canInstallItems():Boolean {
        return rootRenderer.inInventory() && _dataProvider.getGlobalStats().enableInstallItems;
    }

    override public function cleanUpRenderer(param1:IRenderer):void {
        if (param1 == null) {
            return;
        }
        param1.removeEventListener(TechTreeEvent.CLICK_2_UNLOCK, this.onRendererClick2UnlockHandler);
        param1.removeEventListener(TechTreeEvent.CLICK_2_BUY, this.onRendererClick2BuyHandler);
        param1.removeEventListener(TechTreeEvent.GO_TO_VEHICLE_VIEW, this.onRendererGoToVehicleViewHandler);
        param1.removeEventListener(TechTreeEvent.CLICK_2_OPEN, this.onRendererClick2OpenHandler);
        param1.removeEventListener(TechTreeEvent.CLICK_2_OPEN, this.onRenderer2Click2OpenHandler);
        param1.removeEventListener(TechTreeEvent.CLICK_VEHICLE_COMPARE, this.onRendererClickVehicleCompareHandler);
        param1.removeEventListener(TechTreeEvent.RESTORE_VEHICLE, this.onRendererRestoreVehicleHandler);
        param1.removeEventListener(MouseEvent.ROLL_OVER, this.onVehRendRollOverHandler);
        param1.removeEventListener(MouseEvent.ROLL_OUT, this.onVehRendRollOutHandler);
        super.cleanUpRenderer(param1);
    }

    override protected function onDispose():void {
        App.tutorialMgr.removeListenersFromCustomTutorialComponent(this);
        this.view = null;
        this.background = null;
        NodeData.setDisplayInfoClass(null);
        if (this._titleAppearance != null) {
            this._titleAppearance.clearUp();
            this._titleAppearance = null;
        }
        if (this.premiumLayout != null) {
            this.premiumLayout.dispose();
            this.premiumLayout = null;
        }
        this.titleBar.removeEventListener(TechTreeEvent.RETURN_2_TECHTREE, this.onTitleBarReturn2TechtreeHandler);
        this.titleBar.dispose();
        this.titleBar = null;
        this.treeNodeSelector.removeEventListener(MouseEvent.ROLL_OUT, this.onTreeNodeSelectorRollOutHandler);
        this.treeNodeSelector.removeEventListener(MouseEvent.CLICK, this.onTreeNodeSelectorClickHandler);
        this.treeNodeSelector.dispose();
        this.treeNodeSelector = null;
        this._curVehRend = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this._titleAppearance = new TitleAppearance(this.titleBar);
        this.titleBar.addEventListener(TechTreeEvent.RETURN_2_TECHTREE, this.onTitleBarReturn2TechtreeHandler, false, 0, true);
        this.treeNodeSelector.visible = false;
        this.treeNodeSelector.addEventListener(MouseEvent.ROLL_OUT, this.onTreeNodeSelectorRollOutHandler, false, 0, true);
        this.treeNodeSelector.addEventListener(MouseEvent.CLICK, this.onTreeNodeSelectorClickHandler, false, 0, true);
    }

    override protected function onDrawComplece():void {
        super.onDrawComplece();
        this.view.onResearchItemsDrawnS();
        this.treeNodeSelector.visible = this.showTreeNodeSelector();
    }

    override protected function updateLayouts():void {
        if (this._titleAppearance != null) {
            this._titleAppearance.updateInResearch(_width, App.appHeight, this.titleDefaultY);
        }
        if (rGraphics != null) {
            rGraphics.y = this.titleDefaultY - 1 + (_height >> 1);
        }
        if (this.premiumLayout != null) {
            this.premiumLayout.height = _height;
        }
        if (this.background != null) {
            this.background.height = _height;
        }
    }

    override protected function updateRootData():Boolean {
        var _loc2_:NodeData = null;
        var _loc3_:VehGlobalStats = null;
        var _loc4_:String = null;
        var _loc5_:Boolean = false;
        var _loc1_:Boolean = super.updateRootData();
        if (_loc1_) {
            _loc2_ = _dataProvider.getRootItem();
            _loc3_ = _dataProvider.getGlobalStats();
            _loc4_ = _dataProvider.nation;
            ResearchRoot(rootRenderer).setupEx(_loc3_.statusString);
            _loc5_ = rootRenderer.isPremium();
            if (this.titleBar != null) {
                this.titleBar.setNation(!!_loc3_.hasNationTree ? _loc4_ : Values.EMPTY_STR);
                this.titleBar.setTitle(!!_loc5_ ? Values.EMPTY_STR : _loc2_.longName);
                this.titleBar.setInfoMessage(_loc3_.warningMessage);
            }
            if (this.xpInfo != null) {
                this.xpInfo.setFreeXP(_loc3_.freeXP);
            }
            if (_loc5_) {
                if (!this.premiumLayout) {
                    this.premiumLayout = PremiumLayout.show(this);
                }
            }
            else {
                this.premiumLayout = null;
            }
        }
        return _loc1_;
    }

    override protected function setupItemRenderer(param1:IRenderer):void {
        super.setupItemRenderer(param1);
        param1.addEventListener(TechTreeEvent.CLICK_2_UNLOCK, this.onRendererClick2UnlockHandler, false, 0, true);
        param1.addEventListener(TechTreeEvent.CLICK_2_BUY, this.onRendererClick2BuyHandler, false, 0, true);
        param1.addEventListener(TechTreeEvent.CLICK_2_OPEN, this.onRenderer2Click2OpenHandler, false, 0, true);
    }

    override protected function setupVehicleRenderer(param1:IRenderer, param2:Boolean = false):void {
        super.setupVehicleRenderer(param1);
        param1.addEventListener(TechTreeEvent.CLICK_2_UNLOCK, this.onRendererClick2UnlockHandler, false, 0, true);
        param1.addEventListener(TechTreeEvent.CLICK_2_BUY, this.onRendererClick2BuyHandler, false, 0, true);
        param1.addEventListener(TechTreeEvent.GO_TO_VEHICLE_VIEW, this.onRendererGoToVehicleViewHandler, false, 0, true);
        param1.addEventListener(TechTreeEvent.CLICK_VEHICLE_COMPARE, this.onRendererClickVehicleCompareHandler);
        param1.addEventListener(TechTreeEvent.RESTORE_VEHICLE, this.onRendererRestoreVehicleHandler, false, 0, true);
        if (!param2) {
            param1.addEventListener(TechTreeEvent.CLICK_2_OPEN, this.onRendererClick2OpenHandler, false, 0, true);
        }
        if (param1 != rootRenderer) {
            param1.addEventListener(MouseEvent.ROLL_OVER, this.onVehRendRollOverHandler, false, 0, true);
            param1.addEventListener(MouseEvent.ROLL_OUT, this.onVehRendRollOutHandler, false, 0, true);
        }
    }

    override protected function onCircleReferenceDetected():void {
        super.onCircleReferenceDetected();
        this.titleBar.setTitle("");
        this.titleBar.setInfoMessage("");
        if (this.view != null) {
            if (App.utils != null) {
                this.view.showSystemMessageS("Error", App.utils.locale.makeString(SYSTEM_MESSAGES.UNLOCKS_DRAWFAILED));
            }
            this.view.onResearchItemsDrawnS();
        }
    }

    override protected function drawRenderers():Boolean {
        var _loc1_:Boolean = super.drawRenderers();
        if (_loc1_) {
            App.tutorialMgr.dispatchEventForCustomComponent(this);
        }
        return _loc1_;
    }

    override protected function initialize():void {
        super.initialize();
        var _loc1_:IClassFactory = App.utils.classFactory;
        vehicleNodeClass = _loc1_.getClass(Linkages.NATION_TREE_NODE_SKINNED);
        itemNodeClass = _loc1_.getClass(Linkages.RESEARCH_ITEM_NODE);
        fakeNodeClass = _loc1_.getClass(Linkages.FAKE_ITEM_NODE);
    }

    public function generatedUnstoppableEvents():Boolean {
        return true;
    }

    public function getTutorialDescriptionName():String {
        return name + COLON + Linkages.RESEARCH_ITEM_NODE;
    }

    public function needPreventInnerEvents():Boolean {
        return true;
    }

    public function setFreeXP(param1:Number):void {
        if (this.xpInfo != null) {
            this.xpInfo.setFreeXP(param1);
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
            _loc4_ = _dataProvider.getIndexByID(_loc5_[0]);
            if (_loc4_ > -1 && _dataProvider.length > _loc4_) {
                _dataProvider.setItemField(param2, _loc4_, _loc5_[1]);
                _loc6_ = getNodeByID(_loc5_[0]);
                _loc6_.invalidateNodeState(0);
                _loc6_.invalidate(InvalidationType.DATA);
            }
            else {
                _loc4_ = _dataProvider.getTopLevelIndexByID(_loc5_[0]);
                if (_loc4_ > -1 && _dataProvider.topLength > _loc4_) {
                    _dataProvider.setTopLevelField(param2, _loc4_, _loc5_[1]);
                    _loc6_ = getNodeByID(_loc5_[0]);
                    _loc6_.invalidateNodeState(0);
                    _loc6_.invalidate(InvalidationType.DATA);
                }
            }
            if (!_loc7_ && param2 == NodeData.VEH_COMPARE_TREE_NODE_DATA) {
                if (_loc6_ == this._curVehRend) {
                    _loc7_ = true;
                    this.treeNodeSelector.visible = this.showTreeNodeSelector();
                }
            }
            _loc8_++;
        }
    }

    public function setNodesStates(param1:Number, param2:Array, param3:String = null):void {
        var _loc5_:Array = null;
        var _loc6_:Boolean = false;
        var _loc7_:IRenderer = null;
        var _loc8_:Number = NaN;
        var _loc9_:Number = NaN;
        var _loc4_:Number = param2.length;
        var _loc10_:Number = 0;
        while (_loc10_ < _loc4_) {
            _loc5_ = param2[_loc10_];
            _loc8_ = _loc5_[0];
            _loc7_ = null;
            _loc6_ = false;
            _loc9_ = _dataProvider.getIndexByID(_loc8_);
            if (_loc9_ > -1 && _dataProvider.length > _loc9_) {
                if (param3 != null) {
                    _dataProvider.setItemField(param3, _loc9_, _loc5_[2]);
                }
                _loc6_ = _dataProvider.setState(_loc9_, param1, _loc5_[1]);
                _loc7_ = getNodeByID(_loc8_);
            }
            else {
                _loc9_ = _dataProvider.getTopLevelIndexByID(_loc8_);
                if (_loc9_ > -1 && _dataProvider.topLength > _loc9_) {
                    if (param3 != null) {
                        _dataProvider.setTopLevelField(param3, _loc9_, _loc5_[2]);
                    }
                    _loc6_ = _dataProvider.setTopLevelState(_loc9_, param1, _loc5_[1]);
                    _loc7_ = getNodeByID(_loc8_);
                }
            }
            if (_loc6_ && _loc7_ != null) {
                _loc7_.invalidateNodeState(param1);
            }
            _loc10_++;
        }
    }

    public function setVehicleTypeXP(param1:Array):void {
        var _loc3_:Array = null;
        var _loc4_:IRenderer = null;
        var _loc5_:Number = NaN;
        var _loc6_:Number = NaN;
        var _loc2_:Number = param1.length;
        var _loc7_:Number = 0;
        while (_loc7_ < _loc2_) {
            _loc3_ = param1[_loc7_];
            _loc5_ = _loc3_[0];
            _loc4_ = null;
            _loc6_ = _dataProvider.getIndexByID(_loc5_);
            if (_loc6_ > -1 && _dataProvider.length > _loc6_) {
                _dataProvider.setEarnedXP(_loc6_, _loc3_[1]);
                _loc4_ = getNodeByID(_loc5_);
            }
            else {
                _loc6_ = _dataProvider.getTopLevelIndexByID(_loc5_);
                if (_loc6_ > -1 && _dataProvider.topLength > _loc6_) {
                    _dataProvider.setTopLevelXP(_loc6_, _loc3_[1]);
                    _loc4_ = getNodeByID(_loc5_);
                }
            }
            if (_loc4_ != null) {
                _loc4_.invalidateNodeState(0);
            }
            _loc7_++;
        }
    }

    public function setWalletStatus():void {
        if (this.xpInfo != null) {
            this.xpInfo.setWalletStatus();
        }
    }

    public function updateRootVehCompareData(param1:Object):void {
        _dataProvider.getRootItem().setVehCompareData(param1);
        rootRenderer.invalidate(InvalidationType.DATA);
    }

    private function activateCoolDown():void {
        this._requestInCoolDown = true;
        App.utils.scheduler.scheduleTask(this.deactivateCoolDown, COOLDOWN);
    }

    private function deactivateCoolDown():void {
        this._requestInCoolDown = false;
    }

    private function showTreeNodeSelector():Boolean {
        return this._curVehRend != null && this._curVehRend.valueObject != null && this._curVehRend.valueObject.isCompareModeAvailable && !this._curVehRend.valueObject.isCompareBasketFull;
    }

    private function updateTreeNodeSelectorPosition():void {
        this.treeNodeSelector.x = this._curVehRend.x + TREE_NODE_SELECTOR_X_SHIFT + rGraphics.x;
        this.treeNodeSelector.y = this._curVehRend.y - (this.treeNodeSelector.height >> 1) + rGraphics.y + TREE_NODE_SELECTOR_Y_SHIFT;
    }

    public function get xpInfo():ExperienceInformation {
        return rGraphics != null ? ResearchGraphics(rGraphics).xpInfo : null;
    }

    private function getNodeDataByEvent(param1:TechTreeEvent):NodeData {
        var _loc2_:NodeData = null;
        if (param1.entityType == NodeEntityType.TOP_VEHICLE) {
            _loc2_ = _dataProvider.getTopLevelAt(param1.index);
        }
        else {
            _loc2_ = _dataProvider.getItemAt(param1.index);
        }
        App.utils.asserter.assertNotNull(_loc2_, NODE_DATA_NOT_FOUND + param1);
        return _loc2_;
    }

    private function onTitleBarReturn2TechtreeHandler(param1:TechTreeEvent):void {
        if (this.view != null) {
            this.view.goToTechTreeS(_dataProvider.nation);
        }
    }

    private function onRendererClick2OpenHandler(param1:TechTreeEvent):void {
        dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS, this));
        if (this.view != null) {
            App.utils.asserter.assert(NodeEntityType.isVehicleType(param1.entityType), NODE_IS_NOT_VEHICLE);
            invalidateNodesData(_dataProvider.nation, this.view.getResearchItemsDataS(this.getNodeDataByEvent(param1).id, true));
        }
    }

    private function onRendererClick2UnlockHandler(param1:TechTreeEvent):void {
        var _loc2_:NodeData = null;
        var _loc3_:UnlockProps = null;
        if (!this._requestInCoolDown && this.view != null) {
            _loc2_ = this.getNodeDataByEvent(param1);
            _loc3_ = _loc2_.unlockProps;
            App.utils.asserter.assertNotNull(_loc3_, UNLOCK_INFORMATION_NOT_DEFINED + param1.target);
            this.view.request4UnlockS(_loc2_.id, _loc3_.parentID, _loc3_.unlockIdx, _loc3_.xpCost);
            this.activateCoolDown();
        }
    }

    private function onRendererClick2BuyHandler(param1:TechTreeEvent):void {
        if (!this._requestInCoolDown && this.view != null) {
            this.view.request4BuyS(this.getNodeDataByEvent(param1).id);
            this.activateCoolDown();
        }
    }

    private function onRenderer2Click2OpenHandler(param1:TechTreeEvent):void {
        if (!this._requestInCoolDown && this.view != null) {
            this.view.request4InfoS(this.getNodeDataByEvent(param1).id, getRootNode().getID());
            this.activateCoolDown();
        }
    }

    private function onRendererGoToVehicleViewHandler(param1:TechTreeEvent):void {
        if (!this._requestInCoolDown && this.view != null && param1.index > -1) {
            this.view.goToVehicleViewS(this.getNodeDataByEvent(param1).id);
            this.activateCoolDown();
        }
    }

    private function onRendererClickVehicleCompareHandler(param1:TechTreeEvent):void {
        if (!this._requestInCoolDown && this.view != null && param1.index > -1) {
            this.view.compareVehicleS(this.getNodeDataByEvent(param1).id);
            this.activateCoolDown();
        }
    }

    private function onRendererRestoreVehicleHandler(param1:TechTreeEvent):void {
        if (!this._requestInCoolDown && this.view != null) {
            this.view.request4RestoreS(this.getNodeDataByEvent(param1).id);
            this.activateCoolDown();
        }
    }

    private function onVehRendRollOverHandler(param1:MouseEvent):void {
        var _loc2_:Renderer = param1.target as Renderer;
        App.utils.asserter.assertNotNull(_loc2_, "Renderer" + Errors.CANT_NULL);
        this._curVehRend = _loc2_;
        var _loc3_:Boolean = this.showTreeNodeSelector();
        if (_loc3_) {
            this.updateTreeNodeSelectorPosition();
            this.treeNodeSelector.visible = true;
        }
    }

    private function onVehRendRollOutHandler(param1:MouseEvent):void {
        if (!this.treeNodeSelector.hit.hitTestPoint(App.stage.mouseX, App.stage.mouseY)) {
            this._curVehRend = null;
            this.treeNodeSelector.visible = false;
        }
    }

    private function onTreeNodeSelectorRollOutHandler(param1:MouseEvent):void {
        if (!this._curVehRend.hitTestPoint(App.stage.mouseX, App.stage.mouseY)) {
            this._curVehRend = null;
            this.treeNodeSelector.visible = false;
        }
    }

    private function onTreeNodeSelectorClickHandler(param1:MouseEvent):void {
        if (!this._requestInCoolDown && this.view != null) {
            this.view.compareVehicleS(this._curVehRend.valueObject.id);
            this.activateCoolDown();
        }
    }
}
}
