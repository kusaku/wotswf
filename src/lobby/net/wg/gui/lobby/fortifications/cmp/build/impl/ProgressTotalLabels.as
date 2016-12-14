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

    private var _model:BuildingProgressLblVO;

    public function ProgressTotalLabels() {
        super();
        this.separator.text = COMMON.COMMON_SLASH;
    }

    public function dispose():void {
        this._model = null;
    }

    public function set setData(param1:BuildingProgressLblVO):void {
        this._model = param1;
        this.currentValue.htmlText = this._model.currentValueFormatter.replace(FORMAT_PATTERN, this._model.currentValue);
        this.totalValue.htmlText = this._model.totalValue;
        this.separator.htmlText = this._model.separator;
    }
}
}
