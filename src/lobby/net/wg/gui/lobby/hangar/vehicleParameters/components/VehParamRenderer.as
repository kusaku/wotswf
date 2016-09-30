package net.wg.gui.lobby.hangar.vehicleParameters.components {
import flash.display.Sprite;
import flash.events.MouseEvent;

import net.wg.data.constants.generated.HANGAR_ALIASES;
import net.wg.gui.components.advanced.StatusDeltaIndicatorAnim;
import net.wg.gui.components.controls.Image;
import net.wg.infrastructure.managers.ITooltipMgr;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;

public class VehParamRenderer extends VehParamRendererBase {

    private static const SIMPLE_TITLE_TF_X:int = 117;

    private static const SIMPLE_VALUE_TF_X:int = 265;

    private static const ADVANCED_TITLE_TF_X:int = 146;

    private static const ROTATION_0:int = 0;

    private static const ROTATION_90:int = 90;

    private static const BUFF_ICON_PADDING:int = -17;

    public var icon:Image = null;

    public var indicator:StatusDeltaIndicatorAnim = null;

    public var arrow:Sprite = null;

    public var buffIcon:Image = null;

    private var _tooltip:String = null;

    private var _tooltipMgr:ITooltipMgr;

    private var _simpleHitX:int = 0;

    private var _simpleHitW:int = 0;

    public function VehParamRenderer() {
        this._tooltipMgr = App.toolTipMgr;
        super();
    }

    override public function setData(param1:Object):void {
        super.setData(param1);
        this._tooltipMgr.hide();
    }

    override protected function configUI():void {
        super.configUI();
        this._simpleHitX = this.arrow.x - (this.arrow.width >> 1);
        this._simpleHitW = width - this._simpleHitX;
        mouseEnabledOnDisabled = true;
        addEventListener(MouseEvent.ROLL_OVER, this.onMouseRollOverHandler);
        addEventListener(MouseEvent.ROLL_OUT, this.onMouseRollOutHandler);
    }

    override protected function onDispose():void {
        this._tooltipMgr.hide();
        removeEventListener(MouseEvent.ROLL_OVER, this.onMouseRollOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT, this.onMouseRollOutHandler);
        this.icon.dispose();
        this.icon = null;
        this.indicator.dispose();
        this.indicator = null;
        this.buffIcon.dispose();
        this.buffIcon = null;
        this.arrow = null;
        this._tooltipMgr = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        this.hideAll();
        hitMC.height = height;
        if (model != null && isInvalid(InvalidationType.DATA)) {
            this._tooltip = model.tooltip;
            if (model.state == HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_SIMPLE_TOP) {
                titleTF.x = SIMPLE_TITLE_TF_X;
                valueTF.x = SIMPLE_VALUE_TF_X;
                this.arrow.rotation = !!model.isOpen ? Number(ROTATION_90) : Number(ROTATION_0);
                this.buffIcon.visible = StringUtils.isNotEmpty(model.buffIconSrc);
                if (this.buffIcon.visible) {
                    this.buffIcon.source = model.buffIconSrc;
                    this.buffIcon.x = valueTF.x + valueTF.width - valueTF.textWidth + BUFF_ICON_PADDING;
                }
                titleTF.visible = true;
                valueTF.visible = true;
                this.arrow.visible = true;
            }
            else if (model.state == HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_SIMPLE_BOTTOM) {
                this.indicator.setData(model.indicatorVO);
                this.indicator.visible = true;
                this.buffIcon.visible = false;
            }
            else if (model.state == HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_ADVANCED) {
                titleTF.x = ADVANCED_TITLE_TF_X;
                valueTF.x = 0;
                this.icon.visible = StringUtils.isNotEmpty(model.iconSource);
                if (this.icon.visible) {
                    this.icon.source = model.iconSource;
                }
                mouseChildren = true;
                titleTF.visible = true;
                valueTF.visible = true;
                this.buffIcon.visible = false;
            }
            if (model.state != HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_ADVANCED) {
                hitMC.x = this._simpleHitX;
                hitMC.width = this._simpleHitW;
            }
            else {
                layoutHitArea();
            }
        }
    }

    private function hideAll():void {
        titleTF.visible = false;
        valueTF.visible = false;
        this.indicator.visible = false;
        this.arrow.visible = false;
        this.icon.visible = false;
        this.buffIcon.visible = false;
    }

    private function onMouseRollOverHandler(param1:MouseEvent):void {
        if (StringUtils.isNotEmpty(this._tooltip)) {
            this._tooltipMgr.showSpecial(this._tooltip, null, model.paramID);
        }
    }

    private function onMouseRollOutHandler(param1:MouseEvent):void {
        this._tooltipMgr.hide();
    }
}
}
