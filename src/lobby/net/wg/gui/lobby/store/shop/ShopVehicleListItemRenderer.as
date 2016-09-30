package net.wg.gui.lobby.store.shop {
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.VO.StoreTableData;
import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.gui.components.advanced.TankIcon;
import net.wg.gui.data.VehCompareEntrypointVO;
import net.wg.gui.interfaces.IButtonIconLoader;
import net.wg.gui.lobby.store.StoreEvent;
import net.wg.gui.lobby.store.shop.base.ShopTableItemRenderer;
import net.wg.infrastructure.managers.ITooltipMgr;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;

public class ShopVehicleListItemRenderer extends ShopTableItemRenderer {

    private static const ADD_TO_COMPARE_BTN_ORIGINAL_X:int = 593;

    private static const ADD_TO_COMPARE_BTN_ORIGINAL_WIDTH:int = 160;

    public var vehicleIcon:TankIcon = null;

    public var warnMessageTf:TextField = null;

    public var addToCompareBtn:IButtonIconLoader = null;

    public var restoreInfoTf:TextField = null;

    private var _compareModeOn:Boolean = false;

    private var _addToCompareBtnOriginalY:int = 0;

    private var _tooltipMgr:ITooltipMgr;

    public function ShopVehicleListItemRenderer() {
        super();
        this._addToCompareBtnOriginalY = this.addToCompareBtn.y;
        this._tooltipMgr = App.toolTipMgr;
    }

    override protected function configUI():void {
        super.configUI();
        this.warnMessageTf.autoSize = TextFieldAutoSize.RIGHT;
        mouseChildren = true;
        this.addToCompareBtn.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_VEHICLECOMPAREBTN;
        this.addToCompareBtn.focusable = false;
        this.addToCompareBtn.mouseEnabledOnDisabled = true;
        this.addToCompareBtn.visible = false;
        this.addToCompareBtn.validateNow();
    }

    override protected function onDispose():void {
        this.warnMessageTf = null;
        this.restoreInfoTf = null;
        this.vehicleIcon.dispose();
        this.vehicleIcon = null;
        this.addToCompareBtn.dispose();
        this.addToCompareBtn = null;
        this._tooltipMgr = null;
        super.onDispose();
    }

    override protected function update():void {
        var _loc1_:StoreTableData = null;
        var _loc2_:VehCompareEntrypointVO = null;
        var _loc3_:Boolean = false;
        super.update();
        if (data) {
            _loc1_ = StoreTableData(data);
            this.warnMessageTf.visible = StringUtils.isNotEmpty(_loc1_.warnMessage);
            if (this.warnMessageTf.visible) {
                this.warnMessageTf.text = _loc1_.warnMessage;
            }
            this.restoreInfoTf.visible = StringUtils.isNotEmpty(_loc1_.restoreInfo);
            if (this.restoreInfoTf.visible) {
                this.restoreInfoTf.htmlText = _loc1_.restoreInfo;
            }
            this.updateVehicleIcon(_loc1_);
            _loc2_ = _loc1_.vehCompareVO;
            _loc3_ = _loc2_.modeAvailable;
            this._compareModeOn = _loc3_;
            this.addToCompareBtn.visible = this._compareModeOn;
            if (this._compareModeOn) {
                this.addToCompareBtn.enabled = _loc2_.btnEnabled;
                this.addToCompareBtn.tooltip = _loc2_.btnTooltip;
                if (this.restoreInfoTf.visible) {
                    App.utils.commons.updateTextFieldSize(this.restoreInfoTf, false, true);
                    this.addToCompareBtn.y = this.restoreInfoTf.y + this.restoreInfoTf.height | 0;
                }
                else {
                    this.addToCompareBtn.y = this._addToCompareBtnOriginalY;
                }
            }
        }
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.addToCompareBtn.x = ADD_TO_COMPARE_BTN_ORIGINAL_X / scaleX;
            this.addToCompareBtn.scaleX = 1 / scaleX;
            this.addToCompareBtn.width = ADD_TO_COMPARE_BTN_ORIGINAL_WIDTH;
        }
    }

    override protected function onRightButtonClick():void {
        if (this._compareModeOn) {
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.STORE_VEHICLE, this, {"id": StoreTableData(data).id});
        }
        else {
            infoItem();
        }
    }

    override protected function onLeftButtonClick(param1:Object):void {
        if (param1 == this.addToCompareBtn) {
            if (this.addToCompareBtn.enabled) {
                dispatchEvent(new StoreEvent(StoreEvent.ADD_TO_COMPARE, StoreTableData(data).id));
            }
        }
        else {
            super.onLeftButtonClick(param1);
        }
    }

    override protected function shopTooltip():void {
        if (this.addToCompareBtn.hitTestPoint(App.stage.mouseX, App.stage.mouseY, true)) {
            this._tooltipMgr.showComplex(this.addToCompareBtn.tooltip);
        }
        else {
            super.shopTooltip();
        }
    }

    private function updateVehicleIcon(param1:StoreTableData):void {
        getHelper().initVehicleIcon(this.vehicleIcon, param1);
    }

    override public function set selected(param1:Boolean):void {
        if (!this.addToCompareBtn.hitTestPoint(App.stage.mouseX, App.stage.mouseY, true)) {
            super.selected = param1;
        }
    }

    override protected function handleMousePress(param1:MouseEvent):void {
        if (param1.target != this.addToCompareBtn) {
            super.handleMousePress(param1);
        }
    }

    override protected function handleMouseRelease(param1:MouseEvent):void {
        if (param1.target != this.addToCompareBtn) {
            super.handleMouseRelease(param1);
        }
    }
}
}
