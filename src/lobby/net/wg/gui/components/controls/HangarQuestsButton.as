package net.wg.gui.components.controls {
import net.wg.gui.components.interfaces.IHangarQuestsButton;

import org.idmedia.as3commons.util.StringUtils;

public class HangarQuestsButton extends ButtonIconLoader implements IHangarQuestsButton {

    private static const BG_SRC_INVALID:String = "bgSrcInv";

    public var bg:net.wg.gui.components.controls.Image;

    private var _bgSource:String;

    public function HangarQuestsButton() {
        super();
    }

    override protected function onDispose():void {
        this.bg.dispose();
        this.bg = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(BG_SRC_INVALID)) {
            if (StringUtils.isNotEmpty(this._bgSource)) {
                this.bg.source = this._bgSource;
            }
        }
    }

    public function get bgSource():String {
        return this._bgSource;
    }

    public function set bgSource(param1:String):void {
        if (this._bgSource != param1) {
            this._bgSource = param1;
            invalidate(BG_SRC_INVALID);
        }
    }
}
}
