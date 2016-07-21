package net.wg.gui.lobby.fortifications.popovers.impl {
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import net.wg.data.constants.Values;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.IconTextButton;
import net.wg.gui.interfaces.IButtonIconLoader;
import net.wg.gui.lobby.fortifications.data.BuildingPopoverHeaderVO;
import net.wg.gui.lobby.fortifications.events.FortBuildingCardPopoverEvent;
import net.wg.gui.lobby.fortifications.utils.impl.FortCommonUtils;

import scaleform.clik.core.UIComponent;
import scaleform.clik.events.ButtonEvent;

public class FortPopoverHeader extends UIComponent {

    private static const UPGRADE_BTN_ICON_PNG:String = "level_up.png";

    public static const BUILDING_ALPHA_NORMAL:Number = 1;

    public static const BUILDING_ALPHA_DISABLED:Number = 0.2;

    public var buildingName:TextField = null;

    public var buildingIcon:PopoverBuildingTexture = null;

    public var titleStatus:TextField = null;

    public var bodyStatus:TextField = null;

    public var upgradeBtn:IconTextButton = null;

    public var destroyBtn:IButtonIconLoader = null;

    public var buildLevel:TextField = null;

    public var mapInfoTF:TextField = null;

    private var model:BuildingPopoverHeaderVO = null;

    public function FortPopoverHeader() {
        super();
        this.mapInfoTF.autoSize = TextFieldAutoSize.LEFT;
    }

    private static function updateTextAlign(param1:Boolean, param2:TextField):void {
        var _loc3_:String = !!param1 ? TextFormatAlign.CENTER : TextFormatAlign.LEFT;
        FortCommonUtils.instance.changeTextAlign(param2, _loc3_);
    }

    override protected function configUI():void {
        super.configUI();
        this.upgradeBtn.icon = UPGRADE_BTN_ICON_PNG;
        this.upgradeBtn.mouseEnabledOnDisabled = true;
        this.destroyBtn.mouseEnabledOnDisabled = true;
        this.destroyBtn.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_FORTIFICATION_DESTRUCTION;
    }

    override protected function onDispose():void {
        this.upgradeBtn.removeEventListener(ButtonEvent.CLICK, this.headerActionHandler);
        this.destroyBtn.removeEventListener(ButtonEvent.CLICK, this.headerActionHandler);
        this.mapInfoTF.removeEventListener(MouseEvent.ROLL_OVER, this.onMapInfoRollOver);
        this.mapInfoTF.removeEventListener(MouseEvent.ROLL_OUT, this.onMapInfoRollOut);
        this.upgradeBtn.dispose();
        this.upgradeBtn = null;
        this.destroyBtn.dispose();
        this.destroyBtn = null;
        this.buildingIcon.dispose();
        this.buildingIcon = null;
        this.model = null;
        super.onDispose();
    }

    public function setData(param1:BuildingPopoverHeaderVO):void {
        this.model = param1;
        this.buildingName.htmlText = this.model.buildingName;
        this.buildingIcon.setState(this.model.buildingIcon);
        this.buildLevel.htmlText = this.model.buildLevel;
        if (this.model.mapInfo != Values.EMPTY_STR) {
            this.mapInfoTF.htmlText = this.model.mapInfo;
            this.mapInfoTF.visible = true;
            this.mapInfoTF.addEventListener(MouseEvent.ROLL_OVER, this.onMapInfoRollOver);
            this.mapInfoTF.addEventListener(MouseEvent.ROLL_OUT, this.onMapInfoRollOut);
        }
        else {
            this.mapInfoTF.visible = false;
            this.mapInfoTF.removeEventListener(MouseEvent.ROLL_OVER, this.onMapInfoRollOver);
            this.mapInfoTF.removeEventListener(MouseEvent.ROLL_OUT, this.onMapInfoRollOut);
        }
        this.titleStatus.htmlText = this.model.titleStatus;
        this.bodyStatus.htmlText = this.model.bodyStatus;
        if (this.model.titleStatus == Values.EMPTY_STR && this.model.bodyStatus == Values.EMPTY_STR) {
            this.buildingIcon.alpha = BUILDING_ALPHA_NORMAL;
        }
        else {
            this.buildingIcon.alpha = BUILDING_ALPHA_DISABLED;
            updateTextAlign(this.model.titleStatus == Values.EMPTY_STR, this.bodyStatus);
        }
        updateTextAlign(this.model.showUpgradeButton, this.buildLevel);
        this.upgradeBtn.visible = this.model.showUpgradeButton;
        this.upgradeBtn.enabled = this.model.enableUpgradeBtn;
        if (this.upgradeBtn.enabled && this.upgradeBtn.visible) {
            this.upgradeBtn.addEventListener(ButtonEvent.CLICK, this.headerActionHandler);
        }
        if (this.upgradeBtn.visible && this.model.upgradeButtonToolTip != Values.EMPTY_STR) {
            this.upgradeBtn.tooltip = this.model.upgradeButtonToolTip;
        }
        this.destroyBtn.visible = this.model.isVisibleDemountBtn;
        this.destroyBtn.enabled = this.model.enableDemountBtn;
        if (this.destroyBtn.visible && this.destroyBtn.enabled) {
            this.destroyBtn.addEventListener(ButtonEvent.CLICK, this.headerActionHandler);
        }
        if (this.model.canDeleteBuilding && this.destroyBtn.visible && this.model.demountBtnTooltip != Values.EMPTY_STR) {
            this.destroyBtn.tooltip = this.model.demountBtnTooltip;
        }
        this.updateFilters();
    }

    public function setModernizationDestructionEnabling(param1:Boolean, param2:Boolean, param3:String, param4:String):void {
        this.upgradeBtn.enabled = param1;
        this.destroyBtn.enabled = param2;
        this.upgradeBtn.tooltip = param3;
        this.destroyBtn.tooltip = param4;
    }

    private function updateFilters():void {
        if (this.model.glowColor == Values.DEFAULT_INT) {
            return;
        }
        if (this.model.titleStatus != Values.EMPTY_STR) {
            App.utils.commons.setGlowFilter(this.titleStatus, this.model.glowColor);
        }
        if (this.model.titleStatus == Values.EMPTY_STR && this.model.bodyStatus != Values.EMPTY_STR && !this.model.canDeleteBuilding) {
            App.utils.commons.setGlowFilter(this.bodyStatus, this.model.glowColor);
        }
    }

    private function headerActionHandler(param1:ButtonEvent):void {
        if (param1.target == this.upgradeBtn) {
            dispatchEvent(new FortBuildingCardPopoverEvent(FortBuildingCardPopoverEvent.UPGRADE_BUILDING));
        }
        else if (param1.target == this.destroyBtn) {
            dispatchEvent(new FortBuildingCardPopoverEvent(FortBuildingCardPopoverEvent.DESTROY_BUILDING));
        }
    }

    private function onMapInfoRollOver(param1:MouseEvent):void {
        var _loc2_:String = null;
        if (this.model.isToolTipSpecial) {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.MAP_SMALL, null, this.model.tooltipData);
        }
        else {
            _loc2_ = App.toolTipMgr.getNewFormatter().addHeader(this.model.tooltipData.mapName).addBody(this.model.tooltipData.description).make();
            if (_loc2_.length > 0) {
                App.toolTipMgr.showComplex(_loc2_);
            }
        }
    }

    private function onMapInfoRollOut(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }
}
}
