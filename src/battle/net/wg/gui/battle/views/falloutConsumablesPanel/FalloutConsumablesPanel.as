package net.wg.gui.battle.views.falloutConsumablesPanel {
import flash.geom.Point;
import flash.utils.getQualifiedClassName;

import net.wg.data.constants.Linkages;
import net.wg.gui.battle.views.consumablesPanel.BattleOrderButton;
import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesButton;
import net.wg.gui.battle.views.falloutConsumablesPanel.interfaces.IFalloutConsumablesPanel;
import net.wg.gui.battle.views.falloutConsumablesPanel.rageBar.RageBar;
import net.wg.gui.battle.views.falloutConsumablesPanel.rageBar.VO.RageBarVO;
import net.wg.infrastructure.base.meta.impl.FalloutConsumablesPanelMeta;

public class FalloutConsumablesPanel extends FalloutConsumablesPanelMeta implements IFalloutConsumablesPanel {

    private static const FALLOUT_Y_OFFSET:int = 69;

    private static const ITEM_WIDTH_FALLOUT_PADDING:int = 48;

    private static const SLOT_FALLOUT_PADDING:int = 55;

    private static const EMPTY_STR:String = "";

    private var _rageBar:RageBar = null;

    private var _ragePoint:Point;

    public function FalloutConsumablesPanel() {
        this._ragePoint = new Point(7, 54);
        super();
    }

    public function as_initializeRageProgress(param1:Boolean, param2:Object):void {
        if (this._rageBar == null) {
            this._rageBar = App.utils.classFactory.getComponent(Linkages.RAGE_BAR, RageBar);
            addChild(this._rageBar);
        }
        var _loc3_:RageBarVO = new RageBarVO(param2);
        this._rageBar.maxValue = _loc3_.maxValue;
        this._rageBar.curValue = _loc3_.curValue;
        invalidate(INVALIDATE_DRAW_LAYOUT);
    }

    public function as_updateProgressBarValueByDelta(param1:Number):void {
        if (this._rageBar) {
            this._rageBar.updateProgressDelta(param1);
        }
    }

    public function as_updateProgressBarValue(param1:Number):void {
        if (this._rageBar) {
            this._rageBar.updateProgress(param1);
        }
    }

    override protected function drawLayout():void {
        var _loc2_:int = 0;
        var _loc7_:IConsumablesButton = null;
        var _loc1_:int = slotIdxMap.length;
        var _loc3_:int = 0;
        var _loc4_:String = EMPTY_STR;
        var _loc5_:String = EMPTY_STR;
        var _loc6_:Boolean = false;
        var _loc8_:uint = 0;
        while (_loc8_ < _loc1_) {
            if (slotIdxMap[_loc8_] >= 0) {
                _loc7_ = getRendererBySlotIdx(_loc8_);
                if (_loc7_.visible) {
                    if (!_loc6_) {
                        _loc4_ = getQualifiedClassName(_loc7_);
                        _loc6_ = true;
                    }
                    else {
                        _loc5_ = getQualifiedClassName(_loc7_);
                        if (_loc5_ != _loc4_) {
                            _loc3_ = _loc3_ + SLOT_FALLOUT_PADDING;
                            _loc4_ = _loc5_;
                        }
                        else {
                            _loc3_ = _loc3_ + ITEM_WIDTH_FALLOUT_PADDING;
                        }
                    }
                    _loc7_.x = _loc3_;
                    if (_loc7_ is BattleOrderButton && !_loc2_) {
                        _loc2_ = _loc7_.x;
                    }
                }
            }
            _loc8_++;
        }
        if (this._rageBar) {
            this._rageBar.x = _loc2_ + this._ragePoint.x;
            this._rageBar.y = this._ragePoint.y;
        }
        x = stageWidth - (_loc3_ + ITEM_WIDTH_PADDING) >> 1;
        y = stageHeight - FALLOUT_Y_OFFSET;
    }

    override protected function onDispose():void {
        this._rageBar.dispose();
        this._rageBar = null;
        this._ragePoint = null;
        super.onDispose();
    }
}
}
