package net.wg.gui.lobby.vehicleCustomization.data.panels {
import net.wg.data.daapi.base.DAAPIDataClass;

public class CustomizationBonusPanelVO extends DAAPIDataClass {

    private static const BONUS_RENDERER_LIST_FIELD:String = "bonusRenderersList";

    public var bonusTitle:String = "";

    private var _bonusRenderersList:Vector.<CustomizationBonusRendererVO> = null;

    public function CustomizationBonusPanelVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Object = null;
        var _loc4_:CustomizationBonusRendererVO = null;
        if (param1 == BONUS_RENDERER_LIST_FIELD) {
            this._bonusRenderersList = new Vector.<CustomizationBonusRendererVO>();
            _loc3_ = {};
            _loc4_ = null;
            for each(_loc3_ in param2) {
                _loc4_ = new CustomizationBonusRendererVO(_loc3_);
                this._bonusRenderersList.push(_loc4_);
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:int = 0;
        var _loc2_:int = this._bonusRenderersList.length;
        _loc1_ = 0;
        while (_loc1_ < _loc2_) {
            this._bonusRenderersList[_loc1_].dispose();
            _loc1_++;
        }
        this._bonusRenderersList.splice(0, _loc2_);
        this._bonusRenderersList = null;
        super.onDispose();
    }

    public function get bonusRenderersList():Array {
        return App.utils.data.vectorToArray(this._bonusRenderersList);
    }
}
}
