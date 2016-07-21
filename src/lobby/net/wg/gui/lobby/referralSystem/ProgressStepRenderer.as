package net.wg.gui.lobby.referralSystem {
import flash.display.Sprite;
import flash.events.MouseEvent;

import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.advanced.interfaces.IComplexProgressStepRenderer;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.events.UILoaderEvent;
import net.wg.gui.lobby.referralSystem.data.ProgressStepVO;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.managers.ITooltipMgr;

import scaleform.clik.constants.InvalidationType;

public class ProgressStepRenderer extends UIComponentEx implements IComplexProgressStepRenderer {

    public var icon:UILoaderAlt = null;

    public var line:Sprite = null;

    private var _id:String = null;

    private var _tooltipMgr:ITooltipMgr;

    private var _showLine:Boolean = true;

    public function ProgressStepRenderer() {
        this._tooltipMgr = App.toolTipMgr;
        super();
        this.icon.autoSize = false;
    }

    override protected function configUI():void {
        super.configUI();
        addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        addEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler);
    }

    override protected function onDispose():void {
        removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler);
        this.icon.removeEventListener(UILoaderEvent.COMPLETE, this.onIconCompleteHandler);
        this.icon.dispose();
        this.icon = null;
        this.line = null;
        this._tooltipMgr = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.icon.x = -this.icon.width >> 1;
        }
    }

    public function setData(param1:ProgressStepVO):void {
        this.icon.addEventListener(UILoaderEvent.COMPLETE, this.onIconCompleteHandler);
        this.icon.source = param1.icon;
        this._id = param1.id;
    }

    public function get showLine():Boolean {
        return this._showLine;
    }

    public function set showLine(param1:Boolean):void {
        this._showLine = param1;
        this.line.visible = this._showLine;
    }

    private function onRollOutHandler(param1:MouseEvent):void {
        this._tooltipMgr.hide();
    }

    private function onRollOverHandler(param1:MouseEvent):void {
        this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.REF_SYS_AWARDS, null, this._id);
    }

    private function onIconCompleteHandler(param1:UILoaderEvent):void {
        this.icon.removeEventListener(UILoaderEvent.COMPLETE, this.onIconCompleteHandler);
        invalidateSize();
    }
}
}
