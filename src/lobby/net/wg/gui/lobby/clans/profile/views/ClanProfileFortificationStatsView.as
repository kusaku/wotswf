package net.wg.gui.lobby.clans.profile.views {
import net.wg.gui.lobby.clans.profile.cmp.ClanProfileFortStatsGroup;

public class ClanProfileFortificationStatsView extends ClanProfileFortificationAbstractTabView {

    public var sortiesStats:ClanProfileFortStatsGroup = null;

    public var battlesStats:ClanProfileFortStatsGroup = null;

    public function ClanProfileFortificationStatsView() {
        super();
    }

    override protected function onDispose():void {
        this.sortiesStats.dispose();
        this.sortiesStats = null;
        this.battlesStats.dispose();
        this.battlesStats = null;
        super.onDispose();
    }

    override protected function applyData():void {
        if (_model != null) {
            this.sortiesStats.setData(_model.sortiesStats);
            this.battlesStats.setData(_model.battlesStats);
        }
    }
}
}
