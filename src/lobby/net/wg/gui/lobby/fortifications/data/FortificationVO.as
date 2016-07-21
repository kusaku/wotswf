package net.wg.gui.lobby.fortifications.data {
import net.wg.gui.lobby.fortifications.data.base.BaseFortificationVO;

public class FortificationVO extends BaseFortificationVO {

    private static const ORDER_SELECTOR_VO:String = "orderSelectorVO";

    public var orderSelectorVO:CheckBoxIconVO = null;

    public var clanProfileBtnLbl:String = "";

    private var _clanName:String = "";

    private var _defResText:String = "";

    private var _levelTitle:String = "";

    private var _clanListBtnTooltip:String = "";

    public function FortificationVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == ORDER_SELECTOR_VO) {
            this.orderSelectorVO = new CheckBoxIconVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        this.orderSelectorVO.dispose();
        this.orderSelectorVO = null;
        super.onDispose();
    }

    public function get defResText():String {
        return this._defResText;
    }

    public function set defResText(param1:String):void {
        this._defResText = param1;
    }

    public function get levelTitle():String {
        return this._levelTitle;
    }

    public function set levelTitle(param1:String):void {
        this._levelTitle = param1;
    }

    public function get clanName():String {
        return this._clanName;
    }

    public function set clanName(param1:String):void {
        this._clanName = param1;
    }

    public function get clanListBtnTooltip():String {
        return this._clanListBtnTooltip;
    }

    public function set clanListBtnTooltip(param1:String):void {
        this._clanListBtnTooltip = param1;
    }
}
}
