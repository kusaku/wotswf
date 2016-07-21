package net.wg.gui.lobby.questsWindow {
import flash.display.Sprite;

import net.wg.gui.lobby.questsWindow.components.AbstractResizableContent;
import net.wg.gui.lobby.questsWindow.data.QuestDetailsSeparatorVO;

import scaleform.clik.constants.InvalidationType;

public class QuestDetailsSeparatorBlock extends AbstractResizableContent {

    public var separator:Sprite;

    private var _data:QuestDetailsSeparatorVO = null;

    private var _leftPadding:int = 0;

    private var _rightPadding:int = 0;

    private var _topPadding:int = 0;

    private var _bottomPadding:int = 0;

    public function QuestDetailsSeparatorBlock() {
        super();
    }

    override public function setData(param1:Object):void {
        if (this._data != param1) {
            this.disposeData();
            this._data = new QuestDetailsSeparatorVO(param1);
            invalidateData();
        }
    }

    override protected function onDispose():void {
        this.disposeData();
        this.separator = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA) && this._data != null) {
            this._leftPadding = this._data.paddings.left;
            this._rightPadding = this._data.paddings.right;
            this._topPadding = this._data.paddings.top;
            this._bottomPadding = this._data.paddings.bottom;
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
        this.separator.x = this._leftPadding;
        this.separator.y = this._topPadding;
        this.setSize(this._leftPadding + this.separator.width + this._rightPadding, this._topPadding + this.separator.height + this._bottomPadding);
        isReadyForLayout = true;
    }
}
}
