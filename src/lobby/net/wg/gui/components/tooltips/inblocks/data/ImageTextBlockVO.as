package net.wg.gui.components.tooltips.inblocks.data {
import net.wg.data.VO.PaddingVO;
import net.wg.data.daapi.base.DAAPIDataClass;

public class ImageTextBlockVO extends DAAPIDataClass {

    private static const IMAGE_PADDING_FIELD_NAME:String = "imagePadding";

    private static const TEXTS_PADDING_FIELD_NAME:String = "textsPadding";

    public var title:String = "";

    public var description:String = "";

    public var imagePath:String = "";

    public var imagePadding:PaddingVO = null;

    public var textsPadding:PaddingVO = null;

    public var textsOffset:int = -1;

    public var imageAtLeft:Boolean = true;

    public var textsGap:int = 0;

    public var textsAlign:String = "";

    public function ImageTextBlockVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == IMAGE_PADDING_FIELD_NAME && param2 != null) {
            this.imagePadding = new PaddingVO(param2);
            return false;
        }
        if (param1 == TEXTS_PADDING_FIELD_NAME && param2 != null) {
            this.textsPadding = new PaddingVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        if (this.imagePadding != null) {
            this.imagePadding.dispose();
            this.imagePadding = null;
        }
        if (this.textsPadding != null) {
            this.textsPadding.dispose();
            this.textsPadding = null;
        }
        super.onDispose();
    }
}
}
