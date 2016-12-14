package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.battle.components.BattleDisplayable;
import net.wg.gui.battle.views.battleDamagePanel.models.MessageRenderModel;
import net.wg.infrastructure.exceptions.AbstractException;

public class BattleDamageLogPanelMeta extends BattleDisplayable {

    private var _vectorMessageRenderModel:Vector.<MessageRenderModel>;

    public function BattleDamageLogPanelMeta() {
        super();
    }

    override protected function onDispose():void {
        var _loc1_:MessageRenderModel = null;
        if (this._vectorMessageRenderModel) {
            for each(_loc1_ in this._vectorMessageRenderModel) {
                _loc1_.dispose();
            }
            this._vectorMessageRenderModel.splice(0, this._vectorMessageRenderModel.length);
            this._vectorMessageRenderModel = null;
        }
        super.onDispose();
    }

    public final function as_detailStats(param1:Boolean, param2:Array):void {
        var _loc6_:MessageRenderModel = null;
        var _loc3_:Vector.<MessageRenderModel> = this._vectorMessageRenderModel;
        this._vectorMessageRenderModel = new Vector.<MessageRenderModel>(0);
        var _loc4_:uint = param2.length;
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_) {
            this._vectorMessageRenderModel[_loc5_] = new MessageRenderModel(param2[_loc5_]);
            _loc5_++;
        }
        this.detailStats(param1, this._vectorMessageRenderModel);
        if (_loc3_) {
            for each(_loc6_ in _loc3_) {
                _loc6_.dispose();
            }
            _loc3_.splice(0, _loc3_.length);
        }
    }

    protected function detailStats(param1:Boolean, param2:Vector.<MessageRenderModel>):void {
        var _loc3_:String = "as_detailStats" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc3_);
        throw new AbstractException(_loc3_);
    }
}
}
