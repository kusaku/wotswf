package net.wg.gui.components.tooltips.inblocks.blocks {
import flash.text.TextField;

public class BaseTextBlock extends BaseTooltipBlock {

    public function BaseTextBlock() {
        super();
    }

    protected static function updateTextFieldHeight(param1:TextField):void {
        App.utils.commons.updateTextFieldSize(param1, false, true);
    }
}
}
