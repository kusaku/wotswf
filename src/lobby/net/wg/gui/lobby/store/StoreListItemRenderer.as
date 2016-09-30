package net.wg.gui.lobby.store {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

import net.wg.data.VO.StoreTableData;
import net.wg.data.constants.Errors;
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
import net.wg.data.constants.generated.FITTING_TYPES;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.lobby.store.data.StoreTooltipMapVO;
import net.wg.gui.lobby.store.shop.ShopRent;
import net.wg.infrastructure.exceptions.AbstractException;
import net.wg.infrastructure.managers.ITooltipMgr;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.utils.Constraints;
import scaleform.gfx.TextFieldEx;

public class StoreListItemRenderer extends ComplexListItemRenderer {

    private static const OVER_STATE:String = "over";

    private static const OUT_STATE:String = "out";

    private static const DOTS:String = "...";

    public var credits:ModuleRendererCredits = null;

    public var actionPrice:ActionPrice = null;

    public var errorField:TextField = null;

    public var hitMc:Sprite;

    public var rent:ShopRent = null;

    public function StoreListItemRenderer() {
        super();
    }

    override protected function onDispose():void {
        removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDownHandler);
        this.actionPrice.dispose();
        this.actionPrice = null;
        this.credits.dispose();
        this.credits = null;
        this.errorField = null;
        this.hitMc = null;
        if (this.rent != null) {
            this.rent.dispose();
            this.rent = null;
        }
        hitArea = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        TextFieldEx.setVerticalAlign(this.errorField, TextFieldEx.VALIGN_CENTER);
        constraints.addElement(textField.name, textField, Constraints.ALL);
        constraints.addElement(descField.name, descField, Constraints.ALL);
        constraints.addElement(this.credits.name, this.credits, Constraints.RIGHT);
        constraints.addElement(this.errorField.name, this.errorField, Constraints.ALL);
        addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDownHandler);
        hitArea = this.hitMc;
    }

    override protected function draw():void {
        var _loc1_:Point = null;
        if (isInvalid(InvalidationType.DATA)) {
            this.update();
            if (enabled) {
                _loc1_ = new Point(mouseX, mouseY);
                _loc1_ = this.localToGlobal(_loc1_);
                if (this.hitTestPoint(_loc1_.x, _loc1_.y, true)) {
                    setState(OVER_STATE);
                    dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
                }
            }
        }
        super.draw();
        if (this.actionPrice) {
            this.actionPrice.setup(this);
        }
    }

    protected function update():void {
        var _loc1_:StoreTableData = null;
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        var _loc4_:Number = NaN;
        var _loc5_:Number = NaN;
        var _loc6_:String = null;
        var _loc7_:int = 0;
        var _loc8_:String = null;
        if (data) {
            if (App.instance) {
                _loc6_ = "data in shopTableItemRenderer must extends StoreTableData class!";
                App.utils.asserter.assert(data is StoreTableData, _loc6_);
            }
            _loc1_ = StoreTableData(data);
            _loc2_ = 0;
            _loc3_ = 1;
            _loc4_ = _loc1_.price[_loc2_];
            _loc5_ = _loc1_.price[_loc3_];
            visible = true;
            this.onPricesCalculated(_loc5_, _loc4_, _loc1_);
            textField.htmlText = _loc1_.name;
            descField.text = data.desc;
            if (descField.getLineLength(2) != -1) {
                _loc7_ = 0;
                _loc8_ = data.desc.substr(descField.getLineLength(0) + descField.getLineLength(1) - 1, 1);
                if (_loc8_ == "\n") {
                    _loc7_ = -1;
                }
                else {
                    _loc7_ = -3;
                }
                descField.text = descField.text.substr(0, descField.getLineLength(0) + descField.getLineLength(1) + _loc7_) + DOTS;
            }
            this.updateTexts(_loc1_, _loc5_, _loc4_);
            if (hitTestPoint(App.stage.mouseX, App.stage.mouseY, true)) {
                this.shopTooltip();
            }
            this.updateRent(_loc1_);
        }
        else {
            visible = false;
        }
    }

    protected function onPricesCalculated(param1:Number, param2:Number, param3:StoreTableData):void {
    }

    protected function updateTexts(param1:StoreTableData, param2:Number, param3:Number):void {
    }

    protected function getTooltipMapping():StoreTooltipMapVO {
        throw new AbstractException("InventoryListItemRenderer::getTooltipMapping" + Errors.ABSTRACT_INVOKE);
    }

    protected final function infoItem():void {
        dispatchEvent(new StoreEvent(StoreEvent.INFO, StoreTableData(data).id));
    }

    protected final function getHelper():StoreHelper {
        return StoreHelper.getInstance();
    }

    protected function onLeftButtonClick(param1:Object):void {
    }

    protected function onRightButtonClick():void {
        this.infoItem();
    }

    protected function shopTooltip():void {
        var _loc1_:ITooltipMgr = null;
        var _loc2_:StoreTableData = null;
        var _loc3_:String = null;
        var _loc4_:Number = NaN;
        if (App.instance) {
            _loc1_ = App.toolTipMgr;
            _loc2_ = StoreTableData(data);
            switch (_loc2_.itemTypeName) {
                case FITTING_TYPES.VEHICLE:
                    _loc1_.showSpecial(this.getTooltipMapping().vehId, null, _loc2_.id);
                    break;
                case FITTING_TYPES.SHELL:
                    _loc1_.showSpecial(this.getTooltipMapping().shellId, null, _loc2_.id, _loc2_.inventoryCount);
                    break;
                default:
                    _loc3_ = this.getTooltipMapping().defaultId;
                    if (_loc3_ == TOOLTIPS_CONSTANTS.INVENTORY_MODULE) {
                        _loc4_ = _loc2_.currency == CURRENCIES_CONSTANTS.GOLD ? Number(_loc2_.gold) : Number(_loc2_.credits);
                        _loc1_.showSpecial(_loc3_, null, _loc2_.id, _loc4_, _loc2_.currency, _loc2_.inventoryCount, _loc2_.vehicleCount);
                    }
                    else {
                        _loc1_.showSpecial(_loc3_, null, _loc2_.id, _loc2_.inventoryCount, _loc2_.vehicleCount);
                    }
            }
        }
    }

    private function updateRent(param1:StoreTableData):void {
        if (this.rent) {
            if (!param1.rentLeft || param1.rentLeft == Values.EMPTY_STR) {
                this.rent.visible = false;
            }
            else {
                this.rent.updateText(param1.rentLeft);
                this.rent.y = descField.y + descField.textHeight ^ 0;
                this.rent.visible = true;
            }
        }
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        if (App.instance) {
            App.toolTipMgr.hide();
        }
        if (enabled) {
            if (!_focused && !_displayFocus || focusIndicator != null) {
                setState(OUT_STATE);
            }
            callLogEvent(param1);
        }
    }

    override protected function handleMousePress(param1:MouseEvent):void {
        if (App.instance) {
            App.toolTipMgr.hide();
        }
        super.handleMousePress(param1);
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        super.handleMouseRollOver(param1);
        this.shopTooltip();
    }

    private function onMouseDownHandler(param1:MouseEvent):void {
        if (App.utils.commons.isRightButton(param1)) {
            this.onRightButtonClick();
        }
        else if (App.utils.commons.isLeftButton(param1)) {
            this.onLeftButtonClick(param1.target);
        }
    }
}
}
