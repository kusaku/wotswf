package net.wg.gui.lobby.clans.profile.VOs {
import net.wg.gui.lobby.fortifications.data.BuildingsComponentVO;

public class ClanProfileFortificationsSchemaViewVO extends BuildingsComponentVO {

    private static const TEXTS:String = "texts";

    public var texts:ClanProfileFortificationsTextsVO = null;

    public function ClanProfileFortificationsSchemaViewVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == TEXTS) {
            this.texts = new ClanProfileFortificationsTextsVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        this.texts.dispose();
        this.texts = null;
        super.onDispose();
    }
}
}
