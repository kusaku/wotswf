package net.wg.gui.lobby.settings {
import flash.display.MovieClip;

import net.wg.gui.components.advanced.ButtonBarEx;
import net.wg.gui.components.crosshair.ClipQuantityBar;
import net.wg.gui.components.crosshair.CrosshairSniper;

public class AimSettingsBase extends SettingsBaseView {

    private static const NORMAL_STR:String = "normal";

    public var tabs:ButtonBarEx = null;

    public var arcadeForm:SettingsArcadeForm = null;

    public var sniperForm:SettingsArcadeForm = null;

    public var crosshairMC:CrosshairSniper = null;

    public var arcadeCursor:MovieClip = null;

    public var snipperCursor:MovieClip = null;

    public var cassete:ClipQuantityBar = null;

    public var snpCassete:ClipQuantityBar = null;

    public function AimSettingsBase() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.cassete = ClipQuantityBar.create(7, 1);
        this.cassete.quantityInClip = 7;
        this.cassete.clipState = NORMAL_STR;
        this.snpCassete = ClipQuantityBar.create(7, 1);
        this.snpCassete.quantityInClip = 7;
        this.snpCassete.clipState = NORMAL_STR;
        MovieClip(this.arcadeCursor.cassette).addChild(this.cassete);
        MovieClip(this.snipperCursor.cassette).addChild(this.snpCassete);
    }

    override protected function onBeforeDispose():void {
        if (this.cassete && this.arcadeCursor) {
            MovieClip(this.arcadeCursor.cassette).removeChild(this.cassete);
        }
        if (this.snpCassete && this.snipperCursor) {
            MovieClip(this.snipperCursor.cassette).removeChild(this.snpCassete);
        }
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        this.tabs.dispose();
        this.tabs = null;
        this.arcadeForm.dispose();
        this.arcadeForm = null;
        this.sniperForm.dispose();
        this.sniperForm = null;
        this.crosshairMC.dispose();
        this.crosshairMC = null;
        this.arcadeCursor.dispose();
        this.arcadeCursor = null;
        this.snipperCursor.dispose();
        this.snipperCursor = null;
        this.cassete = null;
        this.snpCassete = null;
        super.onDispose();
    }
}
}
