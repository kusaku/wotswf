package net.wg.gui.components.tooltips.inblocks.blocks {
import net.wg.gui.components.controls.SimpleTileList;
import net.wg.gui.components.tooltips.inblocks.data.ImageListBlockVO;

import scaleform.clik.constants.DirectionMode;

public class ImageListBlock extends BaseTextBlock {

    private static const LINKAGE_IMAGE_RENDERER_UI:String = "ImageRendererUI";

    public var listImg:SimpleTileList = null;

    private var _data:ImageListBlockVO = null;

    public function ImageListBlock() {
        super();
        this.listImg.itemRenderer = App.utils.classFactory.getClass(LINKAGE_IMAGE_RENDERER_UI);
        this.listImg.directionMode = DirectionMode.HORIZONTAL;
    }

    override public function setBlockData(param1:Object):void {
        this.clearData();
        this._data = new ImageListBlockVO(param1);
        invalidateBlock();
    }

    override public function setBlockWidth(param1:int):void {
        if (param1 > 0) {
            this.listImg.width = param1 - this.listImg.x;
        }
    }

    override protected function onDispose():void {
        this.listImg.dispose();
        this.listImg = null;
        this.clearData();
        super.onDispose();
    }

    override protected function onValidateBlock():Boolean {
        this.applyData();
        return false;
    }

    private function applyData():void {
        this.listImg.tileWidth = this._data.columnWidth;
        this.listImg.tileHeight = this._data.rowHeight;
        this.listImg.dataProvider = this._data.iconSrcDP;
    }

    private function clearData():void {
        if (this._data != null) {
            this._data.dispose();
            this._data = null;
        }
    }
}
}
