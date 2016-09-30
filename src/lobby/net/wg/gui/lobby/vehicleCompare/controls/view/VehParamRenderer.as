package net.wg.gui.lobby.vehicleCompare.controls.view {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.generated.HANGAR_ALIASES;
import net.wg.gui.components.controls.Image;
import net.wg.gui.components.controls.SoundListItemRenderer;
import net.wg.gui.lobby.vehicleCompare.data.VehCompareParamVO;
import net.wg.gui.lobby.vehicleCompare.events.VehCompareParamsListEvent;
import net.wg.gui.lobby.vehicleCompare.events.VehCompareVehParamRendererEvent;
import net.wg.infrastructure.managers.ITooltipMgr;
import net.wg.utils.ICommons;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;

public class VehParamRenderer extends SoundListItemRenderer {

    private static const SIMPLE_TITLE_TF_X:int = 39;

    private static const ADVANCED_TITLE_TF_X:int = 68;

    private static const ROTATION_0:int = 0;

    private static const ROTATION_90:int = 90;

    public var titleTF:TextField = null;

    public var hitMC:Sprite = null;

    public var icon:Image = null;

    public var arrow:Sprite = null;

    public var bottomLine:Sprite = null;

    protected var model:VehCompareParamVO = null;

    private var _commons:ICommons = null;

    private var _tooltip:String = null;

    private var _tooltipMgr:ITooltipMgr;

    public function VehParamRenderer() {
        this._tooltipMgr = App.toolTipMgr;
        super();
        cacheAsBitmap = true;
        this._commons = App.utils.commons;
    }

    private static function isParentElement(param1:String):Boolean {
        return param1 == HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_SIMPLE_TOP;
    }

    private static function isChildElement(param1:String):Boolean {
        return param1 == HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_ADVANCED;
    }

    override public function setData(param1:Object):void {
        this._tooltipMgr.hide();
        if (param1 == null) {
            return;
        }
        super.setData(param1);
        this.model = VehCompareParamVO(param1);
        invalidateData();
    }

    override protected function configUI():void {
        super.configUI();
        this.bottomLine.visible = false;
        this.titleTF.mouseEnabled = false;
        hitArea = this.hitMC;
        mouseEnabledOnDisabled = true;
        addEventListener(MouseEvent.ROLL_OVER, this.onMouseRollOverHandler);
        addEventListener(MouseEvent.ROLL_OUT, this.onMouseRollOutHandler);
        addEventListener(MouseEvent.CLICK, this.onMouseClickHandler);
    }

    override protected function onDispose():void {
        this._tooltipMgr.hide();
        removeEventListener(MouseEvent.ROLL_OVER, this.onMouseRollOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT, this.onMouseRollOutHandler);
        removeEventListener(MouseEvent.CLICK, this.onMouseClickHandler);
        this.icon.dispose();
        this.icon = null;
        this.arrow = null;
        this._tooltipMgr = null;
        this.titleTF = null;
        this.model = null;
        this.hitMC = null;
        this._commons = null;
        this.bottomLine = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.hitMC.width = width;
            this.hitMC.height = height;
        }
        this.hideAll();
        if (this.model != null && isInvalid(InvalidationType.DATA)) {
            this._tooltip = this.model.tooltip;
            enabled = buttonMode = this.model.isEnabled;
            this.titleTF.htmlText = this.model.titleText;
            if (isParentElement(this.model.state)) {
                this.titleTF.x = SIMPLE_TITLE_TF_X;
                this.arrow.rotation = !!this.model.isOpen ? Number(ROTATION_90) : Number(ROTATION_0);
                this.titleTF.visible = true;
                this.arrow.visible = true;
                this.bottomLine.visible = true;
                this.bottomLine.y = height;
            }
            else if (isChildElement(this.model.state)) {
                this.titleTF.x = ADVANCED_TITLE_TF_X;
                this.icon.visible = StringUtils.isNotEmpty(this.model.iconSource);
                if (this.icon.visible) {
                    this.icon.source = this.model.iconSource;
                }
                mouseChildren = true;
                this.titleTF.visible = true;
                this.bottomLine.visible = false;
                this._commons.updateTextFieldSize(this.titleTF, true, false);
            }
        }
    }

    private function hideAll():void {
        this.titleTF.visible = false;
        this.arrow.visible = false;
        this.icon.visible = false;
    }

    private function onMouseRollOverHandler(param1:MouseEvent):void {
        if (StringUtils.isNotEmpty(this._tooltip)) {
            this._tooltipMgr.showSpecial(this._tooltip, null, this.model.paramID);
        }
    }

    private function onMouseRollOutHandler(param1:MouseEvent):void {
        this._tooltipMgr.hide();
    }

    private function onMouseClickHandler(param1:MouseEvent):void {
        var _loc2_:VehCompareVehParamRendererEvent = null;
        if (this.model == null) {
            return;
        }
        if (isParentElement(this.model.state)) {
            this.model.isOpen = !this.model.isOpen;
            dispatchEvent(new VehCompareParamsListEvent(VehCompareParamsListEvent.RENDER_CLICK, true));
        }
        else if (isChildElement(this.model.state)) {
            _loc2_ = new VehCompareVehParamRendererEvent(VehCompareVehParamRendererEvent.PARAM_CLICK);
            _loc2_.stageY = param1.stageY;
            dispatchEvent(_loc2_);
        }
    }
}
}
