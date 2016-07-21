package net.wg.gui.lobby.fortifications.cmp.build.impl {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.gui.lobby.fortifications.data.BuildingProgressLblVO;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class ProgressTotalLabels extends MovieClip implements IDisposable {

    private static const FORMAT_PATTERN:String = "###";

    public var currentValue:TextField;

    public var totalValue:TextField;

    public var separator:TextField;

    private var model:BuildingProgressLblVO;

    public function ProgressTotalLabels() {
        super();
    }

    public function dispose():void {
        this.model = null;
    }

    public function set setData(param1:BuildingProgressLblVO):void {
        this.model = param1;
        this.currentValue.htmlText = this.model.currentValueFormatter.replace(FORMAT_PATTERN, this.model.currentValue);
        this.totalValue.htmlText = this.model.totalValue;
        this.separator.htmlText = this.model.separator;
    }
}
}
