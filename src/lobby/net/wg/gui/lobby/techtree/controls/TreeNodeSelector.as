package net.wg.gui.lobby.techtree.controls {
import flash.display.Sprite;
import flash.events.MouseEvent;

import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.managers.ITooltipMgr;

public class TreeNodeSelector extends UIComponentEx {

    private static const HOVER_ALPHA:Number = 1;

    private static const START_ALPHA:Number = 0.8;

    private static const MOUSE_DOWN_ALPHA:Number = 0.6;

    public var addToCompare:Sprite = null;

    public var hit:Sprite = null;

    private var _toolTipMgr:ITooltipMgr;

    private var _isRollOver:Boolean = false;

    public function TreeNodeSelector() {
        super();
        this._toolTipMgr = App.toolTipMgr;
    }

    override protected function configUI():void {
        super.configUI();
        addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler, false, 0, true);
        addEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler, false, 0, true);
        addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDownHandler, false, 0, true);
        addEventListener(MouseEvent.MOUSE_UP, this.onMouseUpHandler, false, 0, true);
        alpha = START_ALPHA;
        buttonMode = true;
        this.addToCompare.mouseEnabled = false;
        hitArea = this.hit;
    }

    override protected function onDispose():void {
        removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler);
        removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDownHandler);
        removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUpHandler);
        this.addToCompare = null;
        this.hit = null;
        this._toolTipMgr = null;
        super.onDispose();
    }

    private function onRollOverHandler(param1:MouseEvent):void {
        alpha = HOVER_ALPHA;
        this._isRollOver = true;
        this._toolTipMgr.showComplex(VEH_COMPARE.TECHTREE_TOOLTIPS_ADDTOCOMPARE);
    }

    private function onRollOutHandler(param1:MouseEvent):void {
        alpha = START_ALPHA;
        this._isRollOver = false;
        this._toolTipMgr.hide();
    }

    private function onMouseDownHandler(param1:MouseEvent):void {
        if (App.utils.commons.isLeftButton(param1)) {
            alpha = MOUSE_DOWN_ALPHA;
        }
    }

    private function onMouseUpHandler(param1:MouseEvent):void {
        if (this._isRollOver && App.utils.commons.isLeftButton(param1)) {
            alpha = HOVER_ALPHA;
        }
    }
}
}
