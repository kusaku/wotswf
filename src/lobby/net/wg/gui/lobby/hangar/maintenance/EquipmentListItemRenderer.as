package net.wg.gui.lobby.hangar.maintenance {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.Currencies;
import net.wg.data.constants.SoundTypes;
import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
import net.wg.gui.components.advanced.ModuleTypesUIWithFill;
import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.components.controls.IconText;
import net.wg.gui.components.controls.SoundListItemRenderer;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.gui.events.ModuleInfoEvent;
import net.wg.gui.lobby.hangar.maintenance.data.ModuleVO;
import net.wg.gui.lobby.hangar.maintenance.events.OnEquipmentRendererOver;

import scaleform.clik.constants.InvalidationType;
import scaleform.gfx.MouseEventEx;

public class EquipmentListItemRenderer extends SoundListItemRenderer {

    private static const SHOP:String = "shop";

    private static const HANGAR:String = "hangar";

    private static const HANGAR_CANT_INSTALL:String = "hangarCantInstall";

    private static const VEHICLE:String = "vehicle";

    private static const PRICE_COLOR_INSTALLED_EQUIPMENT:Number = 6710886;

    public var moduleType:ModuleTypesUIWithFill;

    public var titleField:TextField;

    public var descField:TextField;

    public var errorField:TextField;

    public var priceMC:IconText;

    public var actionPrice:ActionPrice;

    public var targetMC:MovieClip;

    public var hitMc:MovieClip;

    private const RENDERER_HEIGHT:int = 46;

    public function EquipmentListItemRenderer() {
        super();
    }

    override public function setData(param1:Object):void {
        super.setData(param1);
        invalidate(InvalidationType.DATA);
    }

    override protected function configUI():void {
        super.configUI();
        addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        addEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler);
        addEventListener(MouseEvent.CLICK, this.onClickHandler);
        soundType = SoundTypes.NORMAL_BTN;
        if (this.hitMc) {
            hitArea = this.hitMc;
        }
    }

    override protected function onDispose():void {
        removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler);
        removeEventListener(MouseEvent.CLICK, this.onClickHandler);
        this.moduleType.dispose();
        this.moduleType = null;
        this.titleField = null;
        this.descField = null;
        this.priceMC.dispose();
        this.priceMC = null;
        this.targetMC = null;
        this.hitMc = null;
        this.errorField = null;
        this.actionPrice.dispose();
        this.actionPrice = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:ActionPriceVO = null;
        if (isInvalid(InvalidationType.DATA)) {
            if (data) {
                visible = true;
                if (this.module.target == 1 && this.module.status != "") {
                    this.titleField.text = this.descField.text = "";
                }
                else {
                    this.titleField.text = this.module.name;
                    this.descField.text = this.module.desc;
                }
                App.utils.asserter.assertFrameExists(this.module.moduleLabel, this.moduleType);
                this.moduleType.gotoAndStop(this.module.moduleLabel);
                this.priceMC.visible = false;
                this.actionPrice.visible = false;
                if (this.module.target == 3) {
                    _loc1_ = null;
                    if (this.module.actionPriceVo) {
                        _loc1_ = this.module.actionPriceVo;
                        _loc1_.forCredits = this.module.currency == CURRENCIES_CONSTANTS.CREDITS;
                    }
                    this.actionPrice.setData(_loc1_);
                    this.actionPrice.setup(this);
                    this.actionPrice.validateNow();
                    this.priceMC.visible = !this.actionPrice.visible;
                    this.priceMC.text = App.utils.locale.integer(this.module.price);
                    this.priceMC.textColor = this.module.price < this.module.userCredits[this.module.currency] ? Number(Currencies.TEXT_COLORS[this.module.currency]) : Number(Currencies.TEXT_COLORS[CURRENCIES_CONSTANTS.ERROR]);
                    if (this.module.status == MENU.MODULEFITS_NOT_WITH_INSTALLED_EQUIPMENT) {
                        this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_DISABLE;
                    }
                    else if (this.module.price < this.module.userCredits[this.module.currency]) {
                        this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ICON;
                    }
                    else {
                        this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ERROR;
                    }
                    if (this.module.status == MENU.MODULEFITS_NOT_WITH_INSTALLED_EQUIPMENT) {
                        this.priceMC.textColor = PRICE_COLOR_INSTALLED_EQUIPMENT;
                    }
                    this.priceMC.icon = this.module.currency;
                    this.priceMC.validateNow();
                    this.targetMC.gotoAndStop(SHOP);
                }
                else if (this.module.target == 2) {
                    if (this.module.status == "") {
                        this.targetMC.gotoAndPlay(HANGAR);
                    }
                    else if (this.module.status != MENU.MODULEFITS_CREDITS_ERROR && this.module.status == MENU.MODULEFITS_GOLD_ERROR) {
                        this.targetMC.gotoAndPlay(HANGAR_CANT_INSTALL);
                    }
                }
                else if (this.module.target == 1) {
                    this.targetMC.gotoAndPlay(VEHICLE);
                    this.targetMC.textField.text = this.module.status == "" ? "" : MENU.FITTINGLISTITEMRENDERER_REPLACE;
                }
                this.errorField.text = this.module.status;
                enabled = this.module.status != MENU.MODULEFITS_UNLOCK_ERROR && this.module.status != MENU.MODULEFITS_NOT_WITH_INSTALLED_EQUIPMENT;
                mouseEnabled = true;
            }
            else {
                visible = false;
            }
        }
        super.draw();
    }

    override public function get height():Number {
        return this.RENDERER_HEIGHT;
    }

    override public function set height(param1:Number):void {
    }

    override public function set width(param1:Number):void {
    }

    private function get module():ModuleVO {
        return data as ModuleVO;
    }

    private function onRollOverHandler(param1:MouseEvent):void {
        owner.dispatchEvent(new OnEquipmentRendererOver(OnEquipmentRendererOver.ON_EQUIPMENT_RENDERER_OVER, this.module.id, this.module.prices, this.module.inventoryCount, this.module.vehicleCount, this.module.slotIndex));
    }

    private function onRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onClickHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
        if (param1 is MouseEventEx) {
            if (App.utils.commons.isRightButton(param1)) {
                dispatchEvent(new ModuleInfoEvent(ModuleInfoEvent.SHOW_INFO, this.module.id));
            }
        }
    }
}
}
