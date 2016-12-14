package net.wg.gui.lobby.christmas.controls {
import net.wg.gui.lobby.christmas.event.ChristmasAwardRendererEvent;
import net.wg.gui.lobby.christmas.interfaces.IChristmasAwardAnimRenderer;
import net.wg.gui.lobby.quests.data.AwardCarouselItemRendererVO;
import net.wg.infrastructure.base.UIComponentEx;

public class ChristmasAwardAnimRenderer extends UIComponentEx implements IChristmasAwardAnimRenderer {

    private static const SHOW_LABEL:String = "show";

    private static const HIDE_LABEL:String = "hide";

    private static const SHOW_ANIM_LAST_FRAME:int = 24;

    public var renderer:ChristmasAwardRenderer = null;

    public function ChristmasAwardAnimRenderer() {
        super();
        addFrameScript(SHOW_ANIM_LAST_FRAME, this.onShowAnimFinished);
    }

    override protected function onDispose():void {
        this.renderer.dispose();
        this.renderer = null;
        super.onDispose();
    }

    public function hide():void {
        gotoAndPlay(HIDE_LABEL);
    }

    public function setData(param1:AwardCarouselItemRendererVO):void {
        this.renderer.setData(param1);
    }

    public function show():void {
        gotoAndPlay(SHOW_LABEL);
    }

    private function onShowAnimFinished():void {
        dispatchEvent(new ChristmasAwardRendererEvent(ChristmasAwardRendererEvent.SHOW_ANIM_FINISHED));
    }
}
}
