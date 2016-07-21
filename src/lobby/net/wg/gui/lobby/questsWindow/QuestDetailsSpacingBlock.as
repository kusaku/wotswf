package net.wg.gui.lobby.questsWindow {
import net.wg.gui.lobby.questsWindow.components.AbstractResizableContent;
import net.wg.gui.lobby.questsWindow.data.QuestDetailsSpacingVO;

import scaleform.clik.constants.InvalidationType;

public class QuestDetailsSpacingBlock extends AbstractResizableContent {

    private var _data:QuestDetailsSpacingVO = null;

    public function QuestDetailsSpacingBlock() {
        super();
    }

    override public function setData(param1:Object):void {
        if (this._data != param1) {
            this.disposeData();
            this._data = new QuestDetailsSpacingVO(param1);
            invalidateData();
        }
    }

    override protected function onDispose():void {
        this.disposeData();
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA) && this._data != null) {
            this.layoutComponents();
        }
    }

    private function disposeData():void {
        if (this._data != null) {
            this._data.dispose();
            this._data = null;
        }
    }

    private function layoutComponents():void {
        this.setSize(this.width, this._data.spacing);
        isReadyForLayout = true;
    }
}
}
