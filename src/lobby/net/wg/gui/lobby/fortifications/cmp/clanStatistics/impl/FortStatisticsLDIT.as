package net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl {
import net.wg.data.managers.IToolTipParams;
import net.wg.gui.components.advanced.LineDescrIconText;
import net.wg.gui.lobby.fortifications.data.ClanStatItemVO;

public class FortStatisticsLDIT extends LineDescrIconText {

    private var _model:ClanStatItemVO;

    public function FortStatisticsLDIT() {
        super();
    }

    override protected function onDispose():void {
        this._model = null;
        super.onDispose();
    }

    override protected function showToolTip(param1:IToolTipParams):void {
        if (!this._model) {
            return;
        }
        var _loc2_:String = App.toolTipMgr.getNewFormatter().addHeader(this._model.ttHeader).addBody(this._model.ttBody).make();
        if (_loc2_.length > 0) {
            App.toolTipMgr.showComplex(_loc2_);
        }
    }

    public function get model():ClanStatItemVO {
        return this._model;
    }

    public function set model(param1:ClanStatItemVO):void {
        this._model = param1;
        if (this._model) {
            iconSource = this._model.icon;
            description = this._model.label;
            text = this._model.value;
            tooltip = this._model.ttHeader;
            enabled = this._model.enabled;
        }
    }
}
}
