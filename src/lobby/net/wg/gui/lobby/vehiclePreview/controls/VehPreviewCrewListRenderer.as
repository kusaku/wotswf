package net.wg.gui.lobby.vehiclePreview.controls {
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.gui.components.controls.Image;
import net.wg.gui.components.controls.SoundListItemRenderer;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewCrewListRendererVO;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.gfx.TextFieldEx;

public class VehPreviewCrewListRenderer extends SoundListItemRenderer {

    public var icon:Image;

    public var nameTf:TextField;

    private var _tooltip:String = null;

    private var _role:String = null;

    public function VehPreviewCrewListRenderer() {
        super();
        TextFieldEx.setVerticalAlign(this.nameTf, TextFieldEx.VALIGN_CENTER);
    }

    override public function setData(param1:Object):void {
        var _loc2_:VehPreviewCrewListRendererVO = null;
        super.setData(param1);
        if (param1 != null) {
            _loc2_ = VehPreviewCrewListRendererVO(param1);
            this.icon.source = _loc2_.icon;
            this.nameTf.htmlText = _loc2_.name;
            this._tooltip = _loc2_.tooltip;
            this._role = _loc2_.role;
        }
    }

    override protected function configUI():void {
        super.configUI();
        buttonMode = false;
        enabled = false;
        mouseEnabledOnDisabled = true;
    }

    override protected function onDispose():void {
        this.icon.dispose();
        this.icon = null;
        this.nameTf = null;
        super.onDispose();
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        super.handleMouseRollOver(param1);
        if (StringUtils.isNotEmpty(this._tooltip)) {
            App.toolTipMgr.showSpecial(this._tooltip, null, this._role);
        }
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        super.handleMouseRollOut(param1);
        App.toolTipMgr.hide();
    }
}
}
