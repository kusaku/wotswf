package net.wg.gui.lobby.techtree {
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

import net.wg.data.constants.LobbyMetrics;
import net.wg.data.constants.generated.NODE_STATE_FLAGS;
import net.wg.gui.lobby.techtree.data.ResearchXMLDataProvider;
import net.wg.gui.lobby.techtree.data.vo.NodeData;
import net.wg.gui.lobby.techtree.interfaces.IResearchPage;
import net.wg.gui.lobby.techtree.sub.ResearchItems;
import net.wg.infrastructure.base.meta.impl.ResearchMeta;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.interfaces.entity.IFocusContainer;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.InputEvent;

public class ResearchPage extends ResearchMeta implements IResearchPage {

    private static const BACKGROUND_ALPHA:Number = 0.9;

    private static const RATIO_Y:int = 100;

    private static const RATIO_X:int = 100;

    private static const TOP_LEVEL_X:int = 10;

    private static const NEXT_LEVEL_X:int = 800;

    private static const MAX_NODEX_ON_LEVEL:int = 10;

    public var researchItems:ResearchItems;

    public var background:Sprite;

    public function ResearchPage() {
        super();
        _deferredDispose = true;
    }

    override public function updateStage(param1:Number, param2:Number):void {
        setViewSize(param1, param2);
    }

    override protected function onPopulate():void {
        super.onPopulate();
        if (!initialized) {
            validateNow();
        }
        this.researchItems.addEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onResearchItemsRequestFocusHandler, false, 0, true);
        requestNationDataS();
    }

    override protected function onBeforeDispose():void {
        App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE, KeyboardEvent.KEY_DOWN);
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        this.researchItems.removeEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onResearchItemsRequestFocusHandler, false);
        this.researchItems.dispose();
        this.researchItems = null;
        this.background = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.researchItems.view = this;
        App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE, KeyboardEvent.KEY_DOWN, this.handleEscape, true);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.updateLayouts();
        }
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(this.researchItems);
    }

    override protected function initialize():void {
        super.initialize();
        this.researchItems.yRatio = RATIO_Y;
        this.researchItems.xRatio = RATIO_X;
        this.researchItems.topLevelX = TOP_LEVEL_X;
        this.researchItems.nextLevelX = NEXT_LEVEL_X;
        this.researchItems.maxNodesOnLevel = MAX_NODEX_ON_LEVEL;
    }

    public function as_drawResearchItems(param1:String, param2:Number):void {
        var _loc3_:Object = getResearchItemsDataS(param2, false);
        this.researchItems.invalidateNodesData(param1, _loc3_);
    }

    public function as_setFreeXP(param1:Number):void {
        this.researchItems.setFreeXP(param1);
    }

    override protected function setInstalledItems(param1:Array):void {
        this.researchItems.setNodesStates(NODE_STATE_FLAGS.INSTALLED, param1);
    }

    override protected function setInventoryItems(param1:Array):void {
        this.researchItems.setNodesStates(NODE_STATE_FLAGS.IN_INVENTORY, param1);
    }

    override protected function setNext2Unlock(param1:Array):void {
        this.researchItems.setNodesStates(NODE_STATE_FLAGS.NEXT_2_UNLOCK, param1, NodeData.UNLOCK_PROPS_FIELD);
    }

    override protected function setNodeVehCompareData(param1:Array):void {
        this.researchItems.setItemsField(param1, NodeData.VEH_COMPARE_TREE_NODE_DATA);
    }

    override protected function setNodesStates(param1:Number, param2:Array):void {
        this.researchItems.setNodesStates(param1, param2);
    }

    public function as_setRootNodeVehCompareData(param1:Object):void {
        this.researchItems.updateRootVehCompareData(param1);
    }

    override protected function setVehicleTypeXP(param1:Array):void {
        this.researchItems.setVehicleTypeXP(param1);
    }

    public function as_setWalletStatus(param1:Object):void {
        App.utils.voMgr.walletStatusVO.update(param1);
        this.researchItems.setWalletStatus();
    }

    public function as_useXMLDumping():void {
        this.researchItems.dataProvider = new ResearchXMLDataProvider();
    }

    protected function updateLayouts():void {
        if (this.background != null) {
            this.background.width = _width;
            this.background.height = _height + LobbyMetrics.LOBBY_MESSENGER_HEIGHT;
        }
        this.researchItems.y = 0;
        this.researchItems.x = _width - LobbyMetrics.MIN_STAGE_WIDTH >> 1;
        this.researchItems.height = _height;
    }

    override public function get isModal():Boolean {
        return true;
    }

    override public function get modalAlpha():Number {
        return BACKGROUND_ALPHA;
    }

    private function handleEscape(param1:InputEvent):void {
        exitFromResearchS();
    }

    private function onResearchItemsRequestFocusHandler(param1:FocusRequestEvent):void {
        setFocus(IFocusContainer(param1.focusContainer).getComponentForFocus());
    }
}
}
