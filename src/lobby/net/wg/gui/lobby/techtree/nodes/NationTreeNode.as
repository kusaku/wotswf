package net.wg.gui.lobby.techtree.nodes {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.MouseEvent;

import net.wg.data.constants.Errors;
import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.techtree.TechTreeEvent;
import net.wg.gui.lobby.techtree.constants.ActionName;
import net.wg.gui.lobby.techtree.constants.NavIndicator;
import net.wg.gui.lobby.techtree.constants.NodeEntityType;
import net.wg.gui.lobby.techtree.constants.TTSoundID;
import net.wg.gui.lobby.techtree.controls.NameAndXpField;
import net.wg.gui.lobby.techtree.controls.TypeAndLevelField;
import net.wg.gui.lobby.techtree.data.vo.NodeData;
import net.wg.gui.lobby.techtree.math.MatrixPosition;
import net.wg.infrastructure.interfaces.entity.IDraggable;

public class NationTreeNode extends Renderer {

    private static const EMPTY_STR:String = "";

    private static const INDICATOR:String = "indicator ";

    public var nameAndXp:NameAndXpField;

    public var typeAndLevel:TypeAndLevelField;

    public var vIconLoader:UILoaderAlt;

    public var navContainer:Sprite;

    private var _isNavContainerAdded:Boolean = false;

    private var _isMouseMoved:Boolean = false;

    public function NationTreeNode() {
        super();
    }

    override public function getIconPath():String {
        return !!dataInited ? valueObject.smallIconPath : EMPTY_STR;
    }

    override public function hitTestPoint(param1:Number, param2:Number, param3:Boolean = false):Boolean {
        var _loc4_:Boolean = hit.hitTestPoint(param1, param2, param3);
        return _loc4_ && (button == null || !button.visible || !button.hitTestPoint(param1, param2, param3));
    }

    override public function populateUI():void {
        var _loc1_:String = null;
        _loc1_ = this.getIconPath();
        this.vIconLoader.alpha = stateProps.icoAlpha;
        if (_loc1_ != this.vIconLoader.source) {
            this.vIconLoader.source = _loc1_;
            this.vIconLoader.visible = true;
        }
        this.typeAndLevel.setOwner(this, doValidateNow);
        this.nameAndXp.setIsInAction(actionPrice && isInAction());
        this.nameAndXp.setOwner(this, doValidateNow);
        if (button != null) {
            if (isRestoreAvailable()) {
                button.action = ActionName.RESTORE;
            }
            else if (isRentAvailable() && isEnoughMoney()) {
                button.action = ActionName.RENT;
            }
            button.label = getNamedLabel(stateProps.label);
            button.enabled = isActionEnabled() && isEnoughMoney() || isEnoughXp();
            if (button.setAnimation(stateProps.id, stateProps.animation)) {
                button.visible = stateProps.visible;
            }
            button.setOwner(this, doValidateNow);
        }
        super.populateUI();
    }

    override public function setup(param1:uint, param2:NodeData, param3:uint = 0, param4:MatrixPosition = null):void {
        super.setup(param1, param2, param3, param4);
        this.drawNavIndicator();
    }

    override public function showContextMenu():void {
        if (button != null) {
            button.endAnimation(true);
        }
        this.stopDragNode();
        App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.RESEARCH_VEHICLE, this, {
            "nodeCD": valueObject.id,
            "rootCD": container.getRootNode().getID(),
            "nodeState": valueObject.state
        });
    }

    override public function toString():String {
        return "[NationTreeNode " + index + ", " + name + "]";
    }

    override protected function onDispose():void {
        removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveHandler);
        this.typeAndLevel.dispose();
        this.typeAndLevel = null;
        this.nameAndXp.dispose();
        this.nameAndXp = null;
        this.vIconLoader.dispose();
        this.vIconLoader = null;
        this.navContainer = null;
        App.contextMenuMgr.hide();
        super.onDispose();
    }

    override protected function preInitialize():void {
        super.preInitialize();
        entityType = NodeEntityType.NATION_TREE;
        soundId = TTSoundID.NATION_TREE;
        tooltipID = TOOLTIPS_CONSTANTS.TECHTREE_VEHICLE;
        isDelegateEvents = true;
    }

    override protected function handleClick(param1:uint = 0):void {
        App.contextMenuMgr.hide();
        if (button != null) {
            button.endAnimation(true);
        }
        super.handleClick(param1);
        if (!this._isMouseMoved) {
            dispatchEvent(new TechTreeEvent(TechTreeEvent.CLICK_2_OPEN, 0, _index, entityType));
        }
        this.stopDragNode();
    }

    private function stopDragNode():void {
        var _loc1_:IDraggable = null;
        var _loc2_:InteractiveObject = null;
        if (container is IDraggable) {
            removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveHandler);
            _loc1_ = IDraggable(container);
            _loc2_ = _loc1_.getHitArea();
            this._isMouseMoved = false;
            _loc2_.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
        }
    }

    private function drawNavIndicator():void {
        var _loc1_:BitmapData = null;
        this.navContainer.mouseEnabled = this.navContainer.mouseChildren = false;
        if (!this._isNavContainerAdded && NavIndicator.isDraw(entityType)) {
            _loc1_ = App.utils.classFactory.getObject(NavIndicator.getSource(entityType)) as BitmapData;
            App.utils.asserter.assertNotNull(_loc1_, INDICATOR + Errors.CANT_NULL);
            if (_loc1_ != null) {
                this.navContainer.addChild(new Bitmap(_loc1_));
                this._isNavContainerAdded = true;
            }
        }
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        super.handleMouseRollOver(param1);
        if (button != null) {
            button.startAnimation();
        }
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        super.handleMouseRollOut(param1);
        if (button != null) {
            button.endAnimation(false);
        }
    }

    override protected function handleMousePress(param1:MouseEvent):void {
        super.handleMousePress(param1);
        this.startDragNode(param1);
    }

    override protected function handleReleaseOutside(param1:MouseEvent):void {
        super.handleReleaseOutside(param1);
        if (button != null) {
            button.endAnimation(false);
        }
        if (!this.hitTestPoint(stage.mouseX, stage.mouseY)) {
            this.stopDragNode();
        }
    }

    private function startDragNode(param1:MouseEvent):void {
        if (container is IDraggable && App.utils.commons.isLeftButton(param1)) {
            addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveHandler, false, 0, true);
        }
    }

    private function onMouseMoveHandler(param1:MouseEvent):void {
        var _loc2_:IDraggable = null;
        var _loc3_:InteractiveObject = null;
        if (container is IDraggable && App.utils.commons.isLeftButton(param1)) {
            _loc2_ = IDraggable(container);
            _loc3_ = _loc2_.getHitArea();
            if (!this._isMouseMoved) {
                this._isMouseMoved = true;
                _loc3_.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
            }
            _loc3_.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE));
        }
    }
}
}
