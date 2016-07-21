package net.wg.gui.lobby.clans.profile.VOs {
import net.wg.data.daapi.base.DAAPIDataClass;

public class ClanProfileFortificationViewVO extends DAAPIDataClass {

    private static const SORTIES_STATS:String = "sortiesStats";

    private static const BATTLES_STATS:String = "battlesStats";

    private static const SORTIES_SCHEMA:String = "fortSortiesSchema";

    private var _sortiesStats:ClanProfileFortificationStatsViewVO = null;

    private var _battlesStats:ClanProfileFortificationStatsViewVO = null;

    private var _fortSortiesSchema:ClanProfileFortificationsSchemaViewVO = null;

    public function ClanProfileFortificationViewVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == SORTIES_STATS && param2) {
            this._sortiesStats = new ClanProfileFortificationStatsViewVO(param2);
            return false;
        }
        if (param1 == BATTLES_STATS && param2) {
            this._battlesStats = new ClanProfileFortificationStatsViewVO(param2);
            return false;
        }
        if (param1 == SORTIES_SCHEMA && param2) {
            this._fortSortiesSchema = new ClanProfileFortificationsSchemaViewVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        if (this._fortSortiesSchema != null) {
            this._fortSortiesSchema.dispose();
            this._fortSortiesSchema = null;
        }
        if (this._sortiesStats != null) {
            this._sortiesStats.dispose();
            this._sortiesStats = null;
        }
        if (this._battlesStats != null) {
            this._battlesStats.dispose();
            this._battlesStats = null;
        }
        super.onDispose();
    }

    public function get sortiesStats():ClanProfileFortificationStatsViewVO {
        return this._sortiesStats;
    }

    public function get battlesStats():ClanProfileFortificationStatsViewVO {
        return this._battlesStats;
    }

    public function get fortSortiesSchema():ClanProfileFortificationsSchemaViewVO {
        return this._fortSortiesSchema;
    }
}
}
