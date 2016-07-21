package net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl {
import net.wg.data.managers.IToolTipParams;
import net.wg.data.managers.impl.ToolTipParams;
import net.wg.gui.components.advanced.DashLineTextItem;
import net.wg.gui.lobby.fortifications.data.ClanStatItemVO;
import net.wg.infrastructure.interfaces.entity.IUpdatable;

public class ClanStatDashLineTextItem extends DashLineTextItem implements IUpdatable {

    private var _data:ClanStatItemVO = null;

    private var _ttParams:IToolTipParams = null;

    public function ClanStatDashLineTextItem() {
        super();
    }

    override protected function onDispose():void {
        this.clearData();
        super.onDispose();
    }

    public function clearData():void {
        if (this._ttParams) {
            this._ttParams.dispose();
            this._ttParams = null;
        }
        if (this._data) {
            this._data.dispose();
            this._data = null;
        }
    }

    public function update(param1:Object):void {
        this.clearData();
        this._data = ClanStatItemVO(param1);
        if (this._data) {
            this.label = this._data.label;
            this.value = this._data.value;
            this.enabled = this._data.enabled;
            if (this._data.ttBodyParams && this._data.ttLabel) {
                this._ttParams = new ToolTipParams(null, this._data.ttBodyParams);
                toolTipParams = this._ttParams;
                tooltip = this._data.ttLabel;
            }
        }
    }
}
}
