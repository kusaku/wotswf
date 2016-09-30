package net.wg.gui.lobby.vehiclePreview.controls {
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.gui.data.VehCompareEntrypointVO;
import net.wg.gui.interfaces.IButtonIconLoader;
import net.wg.gui.interfaces.IUpdatableComponent;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewVehicleInfoPanelVO;
import net.wg.gui.lobby.vehiclePreview.events.VehPreviewEvent;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IInfoIcon;

public class VehPreviewVehicleInfoPanel extends UIComponentEx implements IUpdatableComponent {

    private static const BOTTOM_MARGIN:int = 9;

    public var infoTf:TextField = null;

    public var bg:MovieClip = null;

    public var infoIcon:IInfoIcon = null;

    public var addToCompareBtn:IButtonIconLoader = null;

    public var compareInfoTf:TextField = null;

    private var _compareBtnEnabled:Boolean = false;

    public function VehPreviewVehicleInfoPanel() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.mouseEnabled = false;
        this.bg.mouseEnabled = false;
        this.bg.mouseChildren = false;
        this.addToCompareBtn.addEventListener(MouseEvent.CLICK, this.onCompareBtnClickHandler);
        this.addToCompareBtn.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_VEHICLECOMPAREBTN;
        this.addToCompareBtn.mouseEnabledOnDisabled = true;
        this.addToCompareBtn.focusable = false;
    }

    override protected function onDispose():void {
        this.infoTf = null;
        this.bg = null;
        this.infoIcon.dispose();
        this.infoIcon = null;
        this.addToCompareBtn.removeEventListener(MouseEvent.CLICK, this.onCompareBtnClickHandler);
        this.addToCompareBtn.dispose();
        this.addToCompareBtn = null;
        this.compareInfoTf = null;
        super.onDispose();
    }

    public function update(param1:Object):void {
        var _loc2_:VehPreviewVehicleInfoPanelVO = VehPreviewVehicleInfoPanelVO(param1);
        var _loc3_:VehCompareEntrypointVO = _loc2_.vehCompareVO;
        var _loc4_:Boolean = _loc3_.modeAvailable;
        this.infoTf.visible = !_loc4_;
        this.infoIcon.visible = _loc4_;
        this.compareInfoTf.visible = _loc4_;
        this.addToCompareBtn.visible = _loc4_;
        if (_loc4_) {
            this.compareInfoTf.htmlText = _loc3_.label;
            this._compareBtnEnabled = _loc3_.btnEnabled;
            this.addToCompareBtn.enabled = _loc3_.btnEnabled;
            this.addToCompareBtn.tooltip = _loc3_.btnTooltip;
            this.infoIcon.tooltip = _loc2_.infoTooltip;
            this.bg.height = this.infoIcon.y << 1;
        }
        else {
            this.infoTf.htmlText = _loc2_.info;
            App.utils.commons.updateTextFieldSize(this.infoTf, false, true);
            this.bg.height = this.infoTf.y + this.infoTf.height + BOTTOM_MARGIN;
        }
        height = actualHeight;
    }

    private function onCompareBtnClickHandler(param1:Event):void {
        if (this._compareBtnEnabled) {
            dispatchEvent(new VehPreviewEvent(VehPreviewEvent.COMPARE_CLICK, true));
        }
    }
}
}
