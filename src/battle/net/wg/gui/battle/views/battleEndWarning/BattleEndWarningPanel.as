package net.wg.gui.battle.views.battleEndWarning {
import flash.display.MovieClip;

import net.wg.gui.battle.views.battleEndWarning.containers.Timer;
import net.wg.infrastructure.base.meta.IBattleEndWarningPanelMeta;
import net.wg.infrastructure.base.meta.impl.BattleEndWarningPanelMeta;

public class BattleEndWarningPanel extends BattleEndWarningPanelMeta implements IBattleEndWarningPanelMeta {

    private static const FRAME_SHOW:String = "show";

    private static const FRAME_HIDE:String = "hide";

    private static const DELIMITER:String = ":";

    public var background:MovieClip = null;

    public var timer:Timer = null;

    public function BattleEndWarningPanel() {
        super();
    }

    public function as_setTotalTime(param1:String, param2:String):void {
        this.timer.timeText.text = param1 + DELIMITER + param2;
    }

    public function as_setTextInfo(param1:String):void {
        this.timer.infoText.text = param1;
        visible = true;
    }

    public function as_setState(param1:Boolean):void {
        if (param1) {
            visible = param1;
            gotoAndPlay(FRAME_SHOW);
            this.background.gotoAndPlay(FRAME_SHOW);
        }
        else {
            gotoAndPlay(FRAME_HIDE);
            this.background.gotoAndPlay(FRAME_HIDE);
        }
    }

    override protected function onDispose():void {
        this.background = null;
        this.timer.dispose();
        this.timer = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        visible = false;
        addFrameScript(totalFrames - 1, this.onHideComplete);
    }

    private function onHideComplete():void {
        visible = false;
    }
}
}
