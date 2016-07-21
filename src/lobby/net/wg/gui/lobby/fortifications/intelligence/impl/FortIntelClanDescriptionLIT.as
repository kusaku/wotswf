package net.wg.gui.lobby.fortifications.intelligence.impl {
import flash.events.MouseEvent;

import net.wg.gui.components.advanced.LineIconText;
import net.wg.gui.lobby.fortifications.data.ClanStatItemVO;

public class FortIntelClanDescriptionLIT extends LineIconText {

    private var _model:ClanStatItemVO = null;

    public function FortIntelClanDescriptionLIT() {
        super();
    }

    private static function onRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    override protected function onDispose():void {
        this._model = null;
        removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
    }

    public function get model():ClanStatItemVO {
        return this._model;
    }

    public function set model(param1:ClanStatItemVO):void {
        this._model = param1;
        if (this._model) {
            iconSource = this._model.icon;
            text = this._model.value;
        }
    }

    private function onRollOverHandler(param1:MouseEvent):void {
        if (!this._model) {
            return;
        }
        var _loc2_:String = App.toolTipMgr.getNewFormatter().addHeader(this._model.ttHeader).addBody(this._model.ttBody).make();
        if (_loc2_.length > 0) {
            App.toolTipMgr.showComplex(_loc2_);
        }
    }
}
}
