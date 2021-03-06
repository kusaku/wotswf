package net.wg.gui.lobby.profile.pages.technique {
import net.wg.gui.lobby.profile.components.AwardsTileListBlock;
import net.wg.gui.lobby.profile.pages.awards.AwardsMainContainer;
import net.wg.utils.ILocale;

public class TechAwardsMainContainer extends AwardsMainContainer {

    public var blockMarksOnGun:AwardsTileListBlock;

    public function TechAwardsMainContainer() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        var _loc1_:ILocale = App.utils.locale;
        this.blockMarksOnGun.labelText = _loc1_.makeString(PROFILE.SECTION_AWARDS_LABELS_MARKSONGUN);
        blocks.unshift(this.blockMarksOnGun);
    }
}
}
