package net.wg.gui.lobby.techtree {
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.KeyboardEvent;
import flash.text.TextField;
import flash.ui.Keyboard;

import net.wg.data.Aliases;
import net.wg.data.constants.Linkages;
import net.wg.data.constants.generated.NODE_STATE_FLAGS;
import net.wg.gui.components.controls.ScrollBar;
import net.wg.gui.components.miniclient.TechTreeMiniClientComponent;
import net.wg.gui.lobby.techtree.controls.NationsButtonBar;
import net.wg.gui.lobby.techtree.data.NationXMLDataProvider;
import net.wg.gui.lobby.techtree.data.vo.NodeData;
import net.wg.gui.lobby.techtree.helpers.TitleAppearance;
import net.wg.gui.lobby.techtree.interfaces.ITechTreePage;
import net.wg.gui.lobby.techtree.sub.NationTree;
import net.wg.infrastructure.base.meta.impl.TechTreeMeta;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.IndexEvent;
import scaleform.clik.events.InputEvent;
import scaleform.gfx.TextFieldEx;

public class TechTreePage extends TechTreeMeta implements ITechTreePage {

    private static const BACKGROUND_ALPHA:Number = 0.9;

    private static const WARNING_VERTICAL_GAP:int = 5;

    private static const WARN_VISIBILITY_BORDER:int = 900;

    private static const EMPTY_STR:String = "";

    public var titleField:TextField = null;

    public var nationTree:NationTree = null;

    public var nationsBar:NationsButtonBar = null;

    public var scrollBar:ScrollBar = null;

    public var treeRightBG:Sprite = null;

    private var _titleAppearance:TitleAppearance = null;

    private var _miniClient:TechTreeMiniClientComponent = null;

    public function TechTreePage() {
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
        requestNationTreeDataS();
    }

    override protected function onBeforeDispose():void {
        App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE, KeyboardEvent.KEY_DOWN);
        this.nationsBar.removeEventListener(IndexEvent.INDEX_CHANGE, this.onNationsBarIndexChangeHandler);
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        this._miniClient = null;
        this._titleAppearance.clearUp();
        this._titleAppearance = null;
        this.nationsBar.dispose();
        this.nationsBar = null;
        this.nationTree.dispose();
        this.nationTree = null;
        this.scrollBar.dispose();
        this.scrollBar = null;
        this.treeRightBG = null;
        this.titleField = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this._titleAppearance = new TitleAppearance(this.titleField);
        this.titleField.mouseEnabled = false;
        TextFieldEx.setVerticalAlign(this.titleField, TextFieldEx.VALIGN_CENTER);
        this.nationsBar.addEventListener(IndexEvent.INDEX_CHANGE, this.onNationsBarIndexChangeHandler, false, 0, true);
        this.nationsBar.focused = 1;
        this.nationTree.view = this;
        this.treeRightBG.mouseEnabled = this.treeRightBG.tabEnabled = false;
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
        setFocus(this.nationsBar);
    }

    public function as_refreshNationTreeData(param1:String):void {
        var _loc2_:Object = getNationTreeDataS(param1);
        this.nationTree.storeScrollPosition();
        this.nationTree.invalidateNodesData(param1, _loc2_);
    }

    override protected function setAvailableNations(param1:DataProvider):void {
        this.nationsBar.dataProvider = param1;
    }

    override protected function setInventoryItems(param1:Array):void {
        this.nationTree.setNodesStates(NODE_STATE_FLAGS.IN_INVENTORY, param1);
    }

    override protected function setNext2Unlock(param1:Array):void {
        this.nationTree.setNodesStates(NODE_STATE_FLAGS.NEXT_2_UNLOCK, param1, NodeData.UNLOCK_PROPS_FIELD);
    }

    override protected function setNodeVehCompareData(param1:Array):void {
        this.nationTree.setItemsField(param1, NodeData.VEH_COMPARE_TREE_NODE_DATA);
    }

    override protected function setNodesStates(param1:Number, param2:Array):void {
        this.nationTree.setNodesStates(param1, param2);
    }

    public function as_setSelectedNation(param1:String):void {
        var _loc2_:int = this.nationsBar.dataProvider.indexOf(param1);
        if (_loc2_ > -1) {
            this.nationsBar.selectedIndex = _loc2_;
        }
    }

    override protected function setUnlockProps(param1:Array):void {
        this.nationTree.setItemsField(param1, NodeData.UNLOCK_PROPS_FIELD);
    }

    override protected function setVehicleTypeXP(param1:Array):void {
        this.nationTree.setVehicleTypeXP(param1);
    }

    public function as_showMiniClientInfo(param1:String, param2:String):void {
        this._miniClient = TechTreeMiniClientComponent(App.utils.classFactory.getComponent(Linkages.TECH_TREE_MINI_CLIENT_COMPONENT, TechTreeMiniClientComponent));
        this._miniClient.update(param1, param2);
        addChild(this._miniClient);
        registerFlashComponentS(this._miniClient, Aliases.MINI_CLIENT_LINKED);
        this.updateMiniClientLayouts();
    }

    public function as_useXMLDumping():void {
        this.nationTree.dataProvider = new NationXMLDataProvider();
    }

    public function getScrollBar():ScrollBar {
        return this.scrollBar;
    }

    protected function updateLayouts():void {
        this.nationsBar.height = _height;
        this.nationTree.setSize(Math.round(_width - this.nationTree.x), Math.round(_height));
        this.treeRightBG.x = _width - this.treeRightBG.width;
        this.treeRightBG.height = _height;
        this._titleAppearance.updateInTT(_width, App.appHeight);
        if (this._miniClient) {
            this.updateMiniClientLayouts();
        }
    }

    private function updateMiniClientLayouts():void {
        this._miniClient.visible = _height > WARN_VISIBILITY_BORDER;
        this._miniClient.y = this.titleField.y + this.titleField.textHeight + WARNING_VERTICAL_GAP >> 0;
        this._miniClient.x = _width - this._miniClient.width >> 1;
    }

    override public function get isModal():Boolean {
        return true;
    }

    override public function get modalAlpha():Number {
        return BACKGROUND_ALPHA;
    }

    private function handleEscape(param1:InputEvent):void {
        onCloseTechTreeS();
    }

    private function onNationsBarIndexChangeHandler(param1:IndexEvent):void {
        var _loc2_:String = this.nationsBar.itemToLabel(param1.data);
        var _loc3_:Object = getNationTreeDataS(_loc2_);
        var _loc4_:String = MENU.nation_tree_title(_loc2_);
        this.titleField.text = !!_loc4_ ? _loc4_ : EMPTY_STR;
        this.nationTree.storeScrollPosition();
        this.nationTree.invalidateNodesData(_loc2_, _loc3_);
        App.contextMenuMgr.hide();
    }
}
}
