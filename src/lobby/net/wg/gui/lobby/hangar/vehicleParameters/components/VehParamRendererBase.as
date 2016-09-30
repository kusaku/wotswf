package net.wg.gui.lobby.hangar.vehicleParameters.components {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.data.constants.generated.HANGAR_ALIASES;
import net.wg.gui.components.controls.SoundListItemRenderer;
import net.wg.gui.lobby.hangar.vehicleParameters.data.VehParamVO;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;

public class VehParamRendererBase extends SoundListItemRenderer {

    public var valueTF:TextField = null;

    public var titleTF:TextField = null;

    public var hitMC:Sprite = null;

    protected var model:VehParamVO = null;

    public function VehParamRendererBase() {
        super();
    }

    override public function setData(param1:Object):void {
        if (param1 == null) {
            return;
        }
        super.setData(param1);
        this.model = VehParamVO(param1);
        invalidateData();
    }

    override protected function configUI():void {
        super.configUI();
        this.valueTF.mouseEnabled = false;
        this.titleTF.mouseEnabled = false;
        this.hitMC.height = height;
        hitArea = this.hitMC;
    }

    override protected function onDispose():void {
        this.valueTF = null;
        this.titleTF = null;
        this.model = null;
        this.hitMC = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        this.hitMC.height = height;
        if (this.model != null) {
            if (isInvalid(InvalidationType.DATA)) {
                enabled = buttonMode = this.model.isEnabled;
                if (StringUtils.isNotEmpty(this.model.valueText)) {
                    this.valueTF.htmlText = this.model.valueText;
                }
                if (StringUtils.isNotEmpty(this.model.valueText)) {
                    this.titleTF.htmlText = this.model.titleText;
                }
            }
            if (this.model.state != HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_ADVANCED) {
                this.layoutHitArea();
            }
        }
    }

    protected function layoutHitArea():void {
        this.hitMC.x = this.valueTF.width - this.valueTF.textWidth;
        this.hitMC.width = width - this.hitMC.x;
    }
}
}
