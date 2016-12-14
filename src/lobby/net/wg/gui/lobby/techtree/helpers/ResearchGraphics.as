package net.wg.gui.lobby.techtree.helpers {
import net.wg.gui.lobby.techtree.controls.ExperienceInformation;
import net.wg.gui.lobby.techtree.interfaces.IRenderer;

public class ResearchGraphics extends ModulesGraphics {

    public var xpInfo:ExperienceInformation;

    public function ResearchGraphics() {
        super();
    }

    override public function clearUp():void {
        var _loc1_:Number = 0;
        if (rootRenderer != null) {
            _loc1_++;
        }
        if (this.xpInfo != null) {
            _loc1_++;
        }
        removeExtraRenderers(_loc1_);
    }

    override public function setup():void {
        super.setup();
        this.xpInfo.setOwner(IRenderer(rootRenderer));
    }

    override protected function onDispose():void {
        this.xpInfo.dispose();
        this.xpInfo = null;
        super.onDispose();
    }
}
}
