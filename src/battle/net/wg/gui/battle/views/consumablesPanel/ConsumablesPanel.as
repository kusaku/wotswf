package net.wg.gui.battle.views.consumablesPanel {
import flash.events.MouseEvent;
import flash.geom.ColorTransform;

import net.wg.data.constants.InvalidationType;
import net.wg.data.constants.Linkages;
import net.wg.data.constants.generated.BATTLE_CONSUMABLES_PANEL_TAGS;
import net.wg.gui.battle.components.buttons.BattleButton;
import net.wg.gui.battle.views.consumablesPanel.VO.ConsumablesVO;
import net.wg.gui.battle.views.consumablesPanel.constants.COLOR_STATES;
import net.wg.gui.battle.views.consumablesPanel.events.ConsumablesPanelEvent;
import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleOrderButton;
import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleShellButton;
import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesButton;
import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesPanel;
import net.wg.infrastructure.base.meta.impl.ConsumablesPanelMeta;

public class ConsumablesPanel extends ConsumablesPanelMeta implements IConsumablesPanel {

    protected static const ITEM_WIDTH_PADDING:int = 57;

    protected static const INVALIDATE_DRAW_LAYOUT:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

    private static const CONSUMABLES_PANEL_Y_OFFSET:int = 58;

    private static const POPUP_Y_OFFSET:int = -6;

    private static const POPUP_X_OFFSET:int = 29;

    protected var stageWidth:int = 0;

    protected var stageHeight:int = 0;

    protected var renderers:Vector.<BattleButton>;

    protected var slotIdxMap:Vector.<int>;

    private var _shellCurrentIdx:int = -1;

    private var _shellNextIdx:int = -1;

    private var _expandedIdx:int = -1;

    private var _popUp:EntitiesStatePopup;

    private var _isExpand:Boolean = false;

    public function ConsumablesPanel() {
        this.renderers = new Vector.<BattleButton>();
        this.slotIdxMap = new <int>[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1];
        super();
    }

    public function as_setKeysToSlots(param1:Array):void {
        var _loc2_:IConsumablesButton = null;
        var _loc3_:Array = null;
        for each(_loc3_ in param1) {
            _loc2_ = this.getRendererBySlotIdx(_loc3_[0]);
            if (_loc2_) {
                _loc2_.key = _loc3_[2];
                _loc2_.consumablesVO.keyCode = _loc3_[1];
            }
        }
    }

    public function as_setItemQuantityInSlot(param1:int, param2:int):void {
        var _loc3_:IConsumablesButton = this.getRendererBySlotIdx(param1);
        if (_loc3_) {
            _loc3_.quantity = param2;
        }
    }

    public function as_setItemTimeQuantityInSlot(param1:int, param2:int, param3:Number, param4:Number):void {
        var _loc5_:IConsumablesButton = this.getRendererBySlotIdx(param1);
        if (_loc5_) {
            _loc5_.setCoolDownTime(param3);
            _loc5_.quantity = param2;
        }
    }

    public function as_setCoolDownTime(param1:int, param2:Number):void {
        var _loc3_:IConsumablesButton = this.getRendererBySlotIdx(param1);
        if (_loc3_) {
            _loc3_.setCoolDownTime(param2);
        }
    }

    public function as_setCoolDownPosAsPercent(param1:int, param2:Number):void {
        var _loc3_:IConsumablesButton = this.getRendererBySlotIdx(param1);
        if (_loc3_) {
            _loc3_.setCoolDownPosAsPercent(param2);
        }
    }

    public function as_addShellSlot(param1:int, param2:Number, param3:Number, param4:int, param5:Number, param6:String, param7:String, param8:String):void {
        var _loc9_:BattleShellButton = App.utils.classFactory.getComponent(Linkages.SHELL_BUTTON_BATTLE, BattleShellButton);
        var _loc10_:String = !!param4 ? param6 : param7;
        addChild(_loc9_);
        var _loc11_:ConsumablesVO = _loc9_.consumablesVO;
        _loc11_.shellIconPath = param6;
        _loc11_.noShellIconPath = param7;
        _loc11_.keyCode = param2;
        _loc9_.icon = _loc10_;
        _loc9_.tooltipStr = param8;
        _loc9_.quantity = param4;
        _loc9_.key = param3;
        _loc9_.addClickCallBack(this);
        var _loc12_:int = this.renderers.length;
        this.renderers.push(_loc9_);
        this.slotIdxMap[param1] = _loc12_;
        invalidate(INVALIDATE_DRAW_LAYOUT);
    }

    public function as_setCurrentShell(param1:int):void {
        var _loc2_:IBattleShellButton = null;
        var _loc3_:Boolean = false;
        var _loc4_:int = 0;
        if (this._shellNextIdx == param1) {
            _loc2_ = this.getRendererBySlotIdx(this._shellNextIdx) as BattleShellButton;
            if (_loc2_) {
                _loc2_.setNext(false, true);
            }
            this._shellNextIdx = -1;
        }
        if (this._shellCurrentIdx >= 0) {
            _loc2_ = this.getRendererBySlotIdx(this._shellCurrentIdx) as BattleShellButton;
            if (_loc2_) {
                if (_loc2_.reloading) {
                    _loc4_ = _loc2_.coolDownCurrentFrame;
                    _loc3_ = true;
                }
                _loc2_.clearCoolDownTime();
                _loc2_.setCurrent(false, true);
            }
        }
        _loc2_ = this.getRendererBySlotIdx(param1) as BattleShellButton;
        if (_loc2_ && _loc2_.enabled && !_loc2_.empty) {
            this._shellCurrentIdx = param1;
            _loc2_.setCurrent(true);
            if (_loc3_) {
                _loc2_.consumablesVO.customCoolDownFrame = _loc4_;
            }
        }
    }

    public function as_setNextShell(param1:int):void {
        var _loc2_:IBattleShellButton = null;
        if (this._shellNextIdx >= 0) {
            _loc2_ = this.getRendererBySlotIdx(this._shellNextIdx) as BattleShellButton;
            if (_loc2_) {
                _loc2_.setNext(false, true);
            }
        }
        _loc2_ = this.getRendererBySlotIdx(param1) as BattleShellButton;
        if (_loc2_ && _loc2_.enabled && !_loc2_.empty) {
            this._shellNextIdx = param1;
            _loc2_.setNext(true);
        }
    }

    public function as_addEquipmentSlot(param1:int, param2:Number, param3:Number, param4:String, param5:int, param6:Number, param7:String, param8:String):void {
        if (param4 == null) {
            param4 = BATTLE_CONSUMABLES_PANEL_TAGS.WITHOUT_TAG;
        }
        var _loc9_:BattleEquipmentButton = App.utils.classFactory.getComponent(Linkages.EQUIPMENT_BUTTON, BattleEquipmentButton);
        addChild(_loc9_);
        var _loc10_:ConsumablesVO = _loc9_.consumablesVO;
        _loc10_.keyCode = param2;
        _loc10_.tag = param4;
        _loc9_.icon = param7;
        _loc9_.tooltipStr = param8;
        _loc9_.quantity = param5;
        _loc9_.key = param3;
        _loc9_.addClickCallBack(this);
        _loc9_.setCoolDownTime(param6);
        var _loc11_:int = this.renderers.length;
        this.renderers.push(_loc9_);
        this.slotIdxMap[param1] = _loc11_;
        invalidate(INVALIDATE_DRAW_LAYOUT);
    }

    public function as_showEquipmentSlots(param1:Boolean):void {
        var _loc2_:Boolean = false;
        var _loc4_:IConsumablesButton = null;
        var _loc3_:int = this.renderers.length;
        var _loc5_:uint = 0;
        while (_loc5_ < _loc3_) {
            _loc4_ = this.getRenderer(_loc5_);
            if (_loc4_ is BattleEquipmentButton) {
                _loc4_.visible = param1;
                _loc2_ = true;
            }
            _loc5_++;
        }
        if (_loc2_) {
            invalidate();
        }
    }

    public function as_expandEquipmentSlot(param1:int, param2:Array):void {
        this.collapsePopup();
        this.expandPopup(param1, param2);
    }

    public function as_collapseEquipmentSlot():void {
        this.collapsePopup();
    }

    public function as_addOptionalDeviceSlot(param1:int, param2:Number, param3:String, param4:String):void {
        var _loc5_:BattleOptionalDeviceButton = App.utils.classFactory.getComponent(Linkages.OPTIONAL_DEVICE_BUTTON, BattleOptionalDeviceButton);
        addChild(_loc5_);
        _loc5_.icon = param3;
        _loc5_.tooltipStr = param4;
        _loc5_.setCoolDownTime(param2);
        var _loc6_:int = this.renderers.length;
        this.renderers.push(_loc5_);
        this.slotIdxMap[param1] = _loc6_;
        invalidate(INVALIDATE_DRAW_LAYOUT);
    }

    public function as_addOrderSlot(param1:int, param2:Number, param3:Number, param4:int, param5:String, param6:String, param7:Boolean, param8:Boolean, param9:Number, param10:Number):void {
        var _loc11_:BattleOrderButton = App.utils.classFactory.getComponent(Linkages.ORDER_BUTTON, BattleOrderButton);
        addChild(_loc11_);
        var _loc12_:ConsumablesVO = _loc11_.consumablesVO;
        _loc12_.keyCode = param2;
        _loc11_.icon = param5;
        _loc11_.tooltipStr = param6;
        _loc11_.quantity = param4;
        _loc11_.key = param3;
        _loc11_.quantityVisible = param8;
        _loc11_.setCoolDownTime(param9);
        _loc11_.addClickCallBack(this);
        var _loc13_:int = this.renderers.length;
        this.renderers.push(_loc11_);
        this.slotIdxMap[param1] = _loc13_;
        invalidate(INVALIDATE_DRAW_LAYOUT);
    }

    public function as_setOrderAvailable(param1:int, param2:Boolean):void {
        var _loc3_:IBattleOrderButton = null;
        _loc3_ = this.getRendererBySlotIdx(param1) as IBattleOrderButton;
        if (_loc3_) {
            _loc3_.available = param2;
        }
    }

    public function as_setOrderActivated(param1:int):void {
        var _loc2_:IBattleOrderButton = null;
        _loc2_ = this.getRendererBySlotIdx(param1) as IBattleOrderButton;
        if (_loc2_) {
            _loc2_.setActivated();
        }
    }

    public function as_showOrdersSlots(param1:Boolean):void {
        var _loc2_:Boolean = false;
        var _loc4_:IConsumablesButton = null;
        var _loc3_:int = this.renderers.length;
        var _loc5_:uint = 0;
        while (_loc5_ < _loc3_) {
            _loc4_ = this.getRenderer(_loc5_);
            if (_loc4_ is BattleOrderButton) {
                _loc4_.visible = param1;
                _loc2_ = true;
            }
            _loc5_++;
        }
        if (_loc2_) {
            invalidate();
        }
    }

    public function as_isVisible():Boolean {
        return this._isExpand;
    }

    public function as_reset():void {
        var _loc1_:BattleButton = null;
        this._shellCurrentIdx = -1;
        this._shellNextIdx = -1;
        this.collapsePopup();
        for each(_loc1_ in this.renderers) {
            removeChild(_loc1_);
            _loc1_.dispose();
        }
        this.renderers.length = 0;
        this.slotIdxMap.length = 0;
        this.slotIdxMap = new <int>[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1];
    }

    public function as_switchToPosmortem():void {
        var _loc1_:IConsumablesButton = this.getRendererBySlotIdx(this._shellCurrentIdx);
        if (_loc1_) {
            _loc1_.setCoolDownTime(0);
        }
        this._shellCurrentIdx = -1;
        this._shellNextIdx = -1;
        this.collapsePopup();
    }

    public function as_updateEntityState(param1:String, param2:String):void {
        if (this._isExpand) {
            this._popUp.updateData(param1, param2);
        }
    }

    private function expandPopup(param1:int, param2:Array):void {
        this._expandedIdx = param1;
        if (!this._popUp) {
            this._popUp = App.utils.classFactory.getComponent(Linkages.ENTITIES_POPUP, EntitiesStatePopup);
            addChild(this._popUp);
            this._popUp.addClickHandler(this);
            this._popUp.createPopup(param2);
        }
        else {
            this._popUp.setData(param2);
        }
        this._popUp.visible = true;
        this._popUp.x = this.slotIdxMap[this._expandedIdx] * ITEM_WIDTH_PADDING - (this._popUp.width >> 1) + POPUP_X_OFFSET;
        this._popUp.y = -CONSUMABLES_PANEL_Y_OFFSET - POPUP_Y_OFFSET;
        this._isExpand = true;
        dispatchEvent(new ConsumablesPanelEvent(ConsumablesPanelEvent.SWITCH_POPUP));
        this.setColorTransformForRenderers();
    }

    private function collapsePopup():void {
        if (!this._isExpand) {
            return;
        }
        onPopUpClosedS();
        this._expandedIdx = -1;
        this._isExpand = false;
        if (!this._popUp) {
            return;
        }
        this._popUp.visible = false;
        dispatchEvent(new ConsumablesPanelEvent(ConsumablesPanelEvent.SWITCH_POPUP));
        this.clearColorTransformForRenderers();
    }

    private function setColorTransformForRenderers():void {
        var _loc2_:IConsumablesButton = null;
        var _loc1_:ColorTransform = COLOR_STATES.DARK_COLOR_TRANSFORM;
        var _loc3_:int = this.renderers.length;
        var _loc4_:uint = 0;
        while (_loc4_ < _loc3_) {
            if (_loc4_ != this.slotIdxMap[this._expandedIdx]) {
                _loc2_ = this.getRenderer(_loc4_);
                if (_loc2_) {
                    _loc2_.setColorTransform(_loc1_);
                }
            }
            _loc4_++;
        }
    }

    private function clearColorTransformForRenderers():void {
        var _loc1_:IConsumablesButton = null;
        var _loc2_:int = this.renderers.length;
        var _loc3_:uint = 0;
        while (_loc3_ < _loc2_) {
            _loc1_ = this.getRenderer(_loc3_);
            if (_loc1_) {
                _loc1_.clearColorTransform();
            }
            _loc3_++;
        }
    }

    protected function drawLayout():void {
        var _loc3_:IConsumablesButton = null;
        var _loc1_:int = this.slotIdxMap.length;
        var _loc2_:int = 0;
        var _loc4_:uint = 0;
        while (_loc4_ < _loc1_) {
            if (this.slotIdxMap[_loc4_] >= 0) {
                _loc3_ = this.getRendererBySlotIdx(_loc4_);
                if (_loc3_ && _loc3_.visible) {
                    _loc3_.x = _loc2_;
                    _loc2_ = _loc2_ + ITEM_WIDTH_PADDING;
                }
            }
            _loc4_++;
        }
        x = this.stageWidth - _loc2_ >> 1;
        y = this.stageHeight - CONSUMABLES_PANEL_Y_OFFSET;
    }

    protected function getRenderer(param1:int):IConsumablesButton {
        return IConsumablesButton(this.renderers[param1]);
    }

    protected function getRendererBySlotIdx(param1:int):IConsumablesButton {
        return IConsumablesButton(this.renderers[this.slotIdxMap[param1]]);
    }

    private function onStageMouseDownHandler(param1:MouseEvent):void {
        if (this._isExpand) {
            if (!(param1.target is EntityStateButton)) {
                this.collapsePopup();
            }
        }
    }

    public function updateStage(param1:Number, param2:Number):void {
        this.stageWidth = param1;
        this.stageHeight = param2;
        invalidate(INVALIDATE_DRAW_LAYOUT);
    }

    public function onButtonClick(param1:Object):void {
        onClickedToSlotS(param1.consumablesVO.keyCode);
    }

    override protected function configUI():void {
        super.configUI();
        App.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.onStageMouseDownHandler);
    }

    override protected function onDispose():void {
        var _loc1_:BattleButton = null;
        App.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onStageMouseDownHandler);
        if (this._popUp) {
            this._popUp.dispose();
            this._popUp = null;
        }
        for each(_loc1_ in this.renderers) {
            _loc1_.dispose();
        }
        this.renderers.splice(0, this.renderers.length);
        this.renderers = null;
        this.slotIdxMap = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALIDATE_DRAW_LAYOUT)) {
            this.drawLayout();
        }
    }

    public function get isExpand():Boolean {
        return this._isExpand;
    }
}
}
