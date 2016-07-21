package net.wg.gui.lobby.clans.profile.views {
import net.wg.data.Aliases;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.fortifications.cmp.impl.FortWelcomeInfoView;
import net.wg.infrastructure.base.meta.IClanProfileFortificationPromoViewMeta;
import net.wg.infrastructure.base.meta.impl.ClanProfileFortificationPromoViewMeta;

public class ClanProfileFortificationPromoView extends ClanProfileFortificationPromoViewMeta implements IClanProfileFortificationPromoViewMeta {

    private static const RELATIVITY_ADDITION_HEIGHT:uint = 500;

    public var info:FortWelcomeInfoView = null;

    public var promoMC:UILoaderAlt = null;

    public function ClanProfileFortificationPromoView() {
        super();
    }

    override protected function onDispose():void {
        this.info = null;
        this.promoMC.dispose();
        this.promoMC = null;
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.info.relativityHeight = RELATIVITY_ADDITION_HEIGHT;
        registerFlashComponentS(this.info, Aliases.FORT_WELCOME_INFO);
        this.info.y = 0;
    }

    override protected function configUI():void {
        super.configUI();
        this.promoMC.source = RES_FORT.MAPS_FORT_CLANPROFILEFORTBG;
    }
}
}
