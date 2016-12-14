package net.wg.gui.lobby.hangar.maintenance {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.Currencies;
import net.wg.data.constants.SoundTypes;
import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.components.controls.IconText;
import net.wg.gui.components.controls.SoundListItemRenderer;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.gui.events.ModuleInfoEvent;
import net.wg.gui.lobby.hangar.maintenance.data.MaintenanceShellVO;
import net.wg.utils.ILocale;

import scaleform.clik.constants.InvalidationType;
import scaleform.gfx.MouseEventEx;

public class ShellListItemRenderer extends SoundListItemRenderer {

    public var icon:UILoaderAlt;

    public var title:TextField;

    public var desc:TextField;

    public var price:IconText;

    public var actionPrice:ActionPrice;

    public var hitMc:MovieClip;

    public function ShellListItemRenderer() {
        super();
    }

    override public function setData(param1:Object):void {
        super.setData(param1);
        invalidate(InvalidationType.DATA);
    }

    override protected function configUI():void {
        super.configUI();
        this.desc.text = MENU.SHELLLISTITEMRENDERER_REPLACE;
        addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        addEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler);
        addEventListener(MouseEvent.CLICK, this.onClickHandler);
        soundType = SoundTypes.NORMAL_BTN;
        if (this.hitMc) {
            hitArea = this.hitMc;
        }
    }

    override protected function draw():void {
        var _loc1_:ILocale = null;
        var _loc2_:Object = null;
        var _loc3_:ActionPriceVO = null;
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            if (data) {
                visible = true;
                this.icon.visible = true;
                this.icon.source = data.icon;
                this.title.text = data.ammoName;
                this.price.icon = data.currency;
                _loc1_ = App.utils.locale;
                this.price.textColor = data.prices[0] < data.userCredits[data.currency] ? Number(Currencies.TEXT_COLORS[data.currency]) : Number(Currencies.TEXT_COLORS[CURRENCIES_CONSTANTS.ERROR]);
                this.actionPrice.textColorType = data.prices[0] < data.userCredits[data.currency] ? ActionPrice.TEXT_COLOR_TYPE_ICON : ActionPrice.TEXT_COLOR_TYPE_ERROR;
                this.price.text = data.currency == CURRENCIES_CONSTANTS.CREDITS ? _loc1_.integer(data.prices[0]) : _loc1_.gold(data.prices[1]);
                this.price.validateNow();
                _loc2_ = !!data.hasOwnProperty("actionPriceData") ? data.actionPriceData : null;
                _loc3_ = null;
                if (_loc2_) {
                    _loc3_ = new ActionPriceVO(_loc2_);
                    _loc3_.forCredits = data.currency == CURRENCIES_CONSTANTS.CREDITS;
                }
                this.actionPrice.setData(_loc3_);
                this.actionPrice.setup(this);
                this.price.visible = !this.actionPrice.visible;
                this.actionPrice.validateNow();
            }
            else {
                visible = false;
            }
        }
    }

    override protected function onDispose():void {
        removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandler);
        removeEventListener(MouseEvent.CLICK, this.onClickHandler);
        this.icon.dispose();
        this.icon = null;
        this.title = null;
        this.desc = null;
        this.price.dispose();
        this.price = null;
        this.actionPrice.dispose();
        this.actionPrice = null;
        this.hitMc = null;
        super.onDispose();
    }

    private function onRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECH_MAIN_SHELL, null, data.id, data.prices, data.inventoryCount, data.count);
    }

    private function onRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onClickHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
        if (param1 is MouseEventEx) {
            if (App.utils.commons.isRightButton(param1)) {
                dispatchEvent(new ModuleInfoEvent(ModuleInfoEvent.SHOW_INFO, MaintenanceShellVO(data).id));
            }
        }
    }
}
}
