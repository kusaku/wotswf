package net.wg.gui.lobby.techtree.data.vo {
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.gui.lobby.techtree.interfaces.IValueObject;
import net.wg.utils.ILocale;

public class ShopPrice implements IValueObject {

    private static const MIN_SOURCE_ARRAY_LEN:uint = 2;

    private static const SOURCE_ARRAY_CREDITS_INDEX:uint = 0;

    private static const SOURCE_ARRAY_GOLD_INDEX:uint = 1;

    private static const SOURCE_ARRAY_ACTIONPRICE_DATA_INDEX:uint = 2;

    private var _credits:Number;

    private var _gold:Number;

    private var _actionPriceDataVo:ActionPriceVO;

    private var _creditsLabel:String;

    private var _goldLabel:String;

    public function ShopPrice(param1:Number = 0, param2:Number = 0, param3:Object = null) {
        super();
        this._credits = param1;
        if (this._credits > 0) {
            this._creditsLabel = App.utils.locale.integer(this._credits);
        }
        else {
            this._creditsLabel = "0";
        }
        this._gold = param2;
        if (this._gold > 0) {
            this._goldLabel = App.utils.locale.integer(this._gold);
        }
        else {
            this._goldLabel = "0";
        }
        this._actionPriceDataVo = !!param3 ? new ActionPriceVO(param3) : null;
    }

    public function dispose():void {
        if (this._actionPriceDataVo != null) {
            this._actionPriceDataVo.dispose();
            this._actionPriceDataVo = null;
        }
    }

    public function fromArray(param1:Array, param2:ILocale):void {
        if (param1.length >= MIN_SOURCE_ARRAY_LEN) {
            this._credits = !!isNaN(param1[SOURCE_ARRAY_CREDITS_INDEX]) ? Number(0) : Number(param1[SOURCE_ARRAY_CREDITS_INDEX]);
            this._creditsLabel = param2.integer(this._credits);
            this._gold = !!isNaN(param1[SOURCE_ARRAY_GOLD_INDEX]) ? Number(0) : Number(param1[SOURCE_ARRAY_GOLD_INDEX]);
            this._goldLabel = param2.gold(this._gold);
            this._actionPriceDataVo = !!param1[SOURCE_ARRAY_ACTIONPRICE_DATA_INDEX] ? new ActionPriceVO(param1[SOURCE_ARRAY_ACTIONPRICE_DATA_INDEX]) : null;
        }
    }

    public function fromObject(param1:Object, param2:ILocale):void {
        if (param1 == null) {
            return;
        }
        if (param1.credits != null) {
            this._credits = param1.credits;
            this._creditsLabel = param2.integer(this._credits);
        }
        if (param1.gold != null) {
            this._gold = param1.gold;
            this._goldLabel = param2.gold(this._gold);
        }
        if (param1._actionPriceData != null) {
            this._actionPriceDataVo = new ActionPriceVO(param1.actionPriceData);
        }
    }

    public function toString():String {
        return "[ShopPrice: credits = " + this._credits + ", gold = " + this._gold + ", actionPriceDataVo = " + this._actionPriceDataVo + "]";
    }

    public function get credits():Number {
        return this._credits;
    }

    public function get creditsLabel():String {
        return this._creditsLabel;
    }

    public function get gold():Number {
        return this._gold;
    }

    public function get goldLabel():String {
        return this._goldLabel;
    }

    public function get actionPriceDataVo():ActionPriceVO {
        return this._actionPriceDataVo;
    }
}
}
