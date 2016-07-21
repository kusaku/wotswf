package net.wg.gui.lobby.quests.components {
import flash.text.TextField;

import net.wg.utils.ICommons;

public class QuestsProgressFallout extends BaseQuestsProgress {

    private static const GAP:int = 15;

    public var item1TF:TextField;

    public var item2TF:TextField;

    public function QuestsProgressFallout() {
        super();
        addFields(this.item1TF, this.item2TF);
    }

    override public function update(param1:Object):void {
        super.update(param1);
        this.layout();
    }

    override protected function onDispose():void {
        this.item1TF = null;
        this.item2TF = null;
        super.onDispose();
    }

    private function layout():void {
        var _loc1_:ICommons = App.utils.commons;
        _loc1_.updateTextFieldSize(this.item1TF, true, false);
        _loc1_.updateTextFieldSize(this.item2TF, true, false);
        this.item2TF.x = this.item1TF.x + this.item1TF.width + GAP | 0;
    }
}
}
