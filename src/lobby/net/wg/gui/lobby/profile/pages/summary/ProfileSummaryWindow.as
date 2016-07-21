package net.wg.gui.lobby.profile.pages.summary {
import net.wg.gui.lobby.profile.ProfileOpenInfoEvent;
import net.wg.gui.lobby.profile.components.ProfileWindowFooter;
import net.wg.gui.lobby.profile.data.ProfileGroupBlockVO;
import net.wg.infrastructure.base.meta.IProfileSummaryWindowMeta;
import net.wg.infrastructure.base.meta.impl.ProfileSummaryWindowMeta;

public class ProfileSummaryWindow extends ProfileSummaryWindowMeta implements IProfileSummaryWindowMeta {

    public function ProfileSummaryWindow() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        footer.addEventListener(ProfileOpenInfoEvent.CLAN, this.onClanOpenHandler);
        footer.addEventListener(ProfileOpenInfoEvent.CLUB, this.onClubOpenHandler);
    }

    override protected function applyResizing():void {
        super.applyResizing();
        footer.y = currentDimension.y - footer.height >> 0;
    }

    override protected function onDispose():void {
        footer.removeEventListener(ProfileOpenInfoEvent.CLAN, this.onClanOpenHandler);
        footer.removeEventListener(ProfileOpenInfoEvent.CLUB, this.onClubOpenHandler);
        super.onDispose();
    }

    override protected function setClanData(param1:ProfileGroupBlockVO):void {
        ProfileWindowFooter(footer).setClanData(param1);
    }

    override protected function setClubData(param1:ProfileGroupBlockVO):void {
        ProfileWindowFooter(footer).setClubData(param1);
    }

    public function as_setClanEmblem(param1:String):void {
        ProfileWindowFooter(footer).setClanEmblem(param1);
    }

    public function as_setClubEmblem(param1:String):void {
        ProfileWindowFooter(footer).setClubEmblem(param1);
    }

    private function onClubOpenHandler(param1:ProfileOpenInfoEvent):void {
        openClubProfileS(param1.id);
    }

    private function onClanOpenHandler(param1:ProfileOpenInfoEvent):void {
        openClanStatisticS();
    }
}
}
