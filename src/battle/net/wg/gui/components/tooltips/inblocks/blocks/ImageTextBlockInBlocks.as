package net.wg.gui.components.tooltips.inblocks.blocks {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormatAlign;

import net.wg.data.VO.PaddingVO;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.components.tooltips.inblocks.data.ImageTextBlockVO;
import net.wg.gui.components.tooltips.inblocks.events.ToolTipBlockEvent;
import net.wg.gui.events.UILoaderEvent;

import org.idmedia.as3commons.util.StringUtils;

public class ImageTextBlockInBlocks extends BaseTooltipBlock {

    public var background:Sprite;

    public var titleTF:TextField;

    public var descriptionTF:TextField;

    public var imageLoader:UILoaderAlt;

    private var _blockWidth:int = 0;

    private var _data:ImageTextBlockVO;

    private var _isDataApplied:Boolean = false;

    private var _originImageWidth:Number = 0;

    private var _originImageHeight:Number = 0;

    public function ImageTextBlockInBlocks() {
        super();
        this.imageLoader.addEventListener(UILoaderEvent.COMPLETE, this.onImageLoaderCompleteHandler);
        this._originImageWidth = this.imageLoader.width;
        this._originImageHeight = this.imageLoader.height;
    }

    override public function cleanUp():void {
        this.clearData();
        this.imageLoader.unload();
        this.imageLoader.setSourceSize(this.imageLoader.originalWidth, this.imageLoader.originalHeight);
        this.imageLoader.width = this._originImageWidth;
        this.imageLoader.height = this._originImageHeight;
        this.titleTF.text = this.titleTF.htmlText = this.descriptionTF.text = this.descriptionTF.htmlText = null;
    }

    override public function getBg():DisplayObject {
        return this.background;
    }

    override public function setBlockData(param1:Object):void {
        this.clearData();
        this._data = new ImageTextBlockVO(param1);
        this._isDataApplied = false;
        invalidateBlock();
    }

    override public function setBlockWidth(param1:int):void {
        this._blockWidth = param1;
    }

    override protected function onDispose():void {
        this.cleanUp();
        if (this.imageLoader != null) {
            this.imageLoader.removeEventListener(UILoaderEvent.COMPLETE, this.onImageLoaderCompleteHandler);
            this.imageLoader.dispose();
        }
        this.titleTF = null;
        this.descriptionTF = null;
        this.imageLoader = null;
        this.background = null;
        super.onDispose();
    }

    override protected function onValidateBlock():Boolean {
        if (!this._isDataApplied) {
            this.applyData();
            return true;
        }
        this.layout();
        return false;
    }

    protected function onLayoutText(param1:TextField, param2:int, param3:int, param4:PaddingVO):void {
        var _loc5_:int = param4 != null ? int(param4.left - param4.right) : 0;
        param1.x = param2 + _loc5_;
        param1.y = param3 + (param4 != null ? param4.top - param4.bottom : 0);
        if (this._blockWidth > 0) {
            param1.width = this._blockWidth - param1.x;
            if (!this._data.imageAtLeft) {
                param1.width = param1.width - (this.getImageWidth() - _loc5_);
            }
        }
        App.utils.commons.updateTextFieldSize(param1, true, true);
    }

    protected function onLayoutImage():void {
        var _loc1_:PaddingVO = null;
        if (!this._data.imageAtLeft) {
            if (this._blockWidth > 0 && this.imageLoader != null && this.imageLoader.visible) {
                _loc1_ = this._data.imagePadding;
                this.imageLoader.x = this._blockWidth - this.imageLoader.width - (_loc1_ != null ? _loc1_.right : 0) | 0;
            }
        }
    }

    protected function onImageLoaderComplete():void {
        dispatchEvent(new ToolTipBlockEvent(ToolTipBlockEvent.SIZE_CHANGE, this));
    }

    private function layout():void {
        var _loc1_:int = 0;
        var _loc2_:int = _loc1_;
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc6_:Boolean = this._data.imageAtLeft;
        var _loc7_:PaddingVO = this._data.imagePadding;
        var _loc8_:String = this._data.textsAlign;
        var _loc9_:int = this._data.textsOffset;
        var _loc10_:PaddingVO = this._data.textsPadding;
        var _loc11_:int = 0;
        var _loc12_:int = 0;
        if (_loc9_ >= 0) {
            _loc3_ = _loc4_ = _loc9_;
        }
        else if (_loc6_) {
            if (_loc8_ == TextFormatAlign.LEFT) {
                _loc3_ = _loc4_ = this.getImageWidth();
            }
            else if (_loc8_ == TextFormatAlign.RIGHT) {
                _loc3_ = this._blockWidth - this.titleTF.width;
                _loc4_ = this._blockWidth - this.descriptionTF.width;
            }
        }
        else if (_loc8_ == TextFormatAlign.LEFT) {
            _loc3_ = _loc4_ = 0;
        }
        else if (_loc8_ == TextFormatAlign.RIGHT) {
            _loc5_ = this._blockWidth - this.getImageWidth();
            _loc3_ = this.imageLoader.x - this.titleTF.width;
            _loc4_ = this.imageLoader.x - this.descriptionTF.width;
        }
        if (this.titleTF != null) {
            if (this.titleTF.visible) {
                this.onLayoutText(this.titleTF, _loc3_, _loc2_, _loc10_);
                _loc2_ = _loc2_ + (this.titleTF.height + this._data.textsGap);
                _loc11_ = this.titleTF.x + this.titleTF.width;
            }
            else {
                this.titleTF.x = this.titleTF.y = this.titleTF.width = this.titleTF.height = 0;
            }
        }
        if (this.descriptionTF != null) {
            if (this.descriptionTF.visible) {
                this.onLayoutText(this.descriptionTF, _loc4_, _loc2_, _loc10_);
                _loc12_ = this.descriptionTF.x + this.descriptionTF.width;
            }
            else {
                this.descriptionTF.x = this.descriptionTF.y = this.descriptionTF.width = this.descriptionTF.height = 0;
            }
        }
        if (this.imageLoader != null) {
            if (this.imageLoader.visible) {
                _loc5_ = _loc5_ + (_loc7_ != null ? _loc7_.left : 0);
                if (!_loc6_) {
                    _loc5_ = _loc5_ + Math.max(_loc11_, _loc12_);
                }
                this.layoutImage(_loc5_, _loc1_, _loc7_);
            }
            else {
                this.imageLoader.x = this.imageLoader.y = this.imageLoader.width = this.imageLoader.height = 0;
            }
        }
    }

    private function applyData():void {
        this.applyTextData(this.titleTF, this._data.title);
        this.applyTextData(this.descriptionTF, this._data.description);
        if (this.imageLoader != null) {
            this.imageLoader.visible = StringUtils.isNotEmpty(this._data.imagePath);
            if (this.imageLoader.visible) {
                this.imageLoader.source = this._data.imagePath;
            }
        }
        this._isDataApplied = true;
    }

    private function applyTextData(param1:TextField, param2:String):void {
        if (param1 != null) {
            param1.visible = StringUtils.isNotEmpty(param2);
            if (param1.visible) {
                param1.htmlText = param2;
            }
        }
    }

    private function clearData():void {
        if (this._data != null) {
            this._data.dispose();
            this._data = null;
        }
    }

    private function getImageWidth():int {
        var _loc2_:PaddingVO = null;
        var _loc1_:int = 0;
        if (this.imageLoader != null && this.imageLoader.visible) {
            _loc1_ = this.imageLoader.width;
            _loc2_ = this._data.imagePadding;
            if (_loc2_ != null) {
                _loc1_ = _loc1_ + (_loc2_.left + _loc2_.right);
            }
        }
        return _loc1_;
    }

    private function layoutImage(param1:int, param2:int, param3:PaddingVO):void {
        this.imageLoader.x = param1;
        this.imageLoader.y = param2 + (param3 != null ? param3.top : 0);
        this.onLayoutImage();
    }

    private function onImageLoaderCompleteHandler(param1:UILoaderEvent):void {
        invalidateBlock();
        this.onImageLoaderComplete();
    }
}
}
