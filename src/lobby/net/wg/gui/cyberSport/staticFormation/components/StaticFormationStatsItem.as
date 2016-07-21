package net.wg.gui.cyberSport.staticFormation.components {
import flash.text.TextFieldAutoSize;

import net.wg.gui.components.advanced.DashLineTextItem;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStatsItemVO;
import net.wg.infrastructure.interfaces.entity.IUpdatable;

import scaleform.clik.constants.InvalidationType;

public class StaticFormationStatsItem extends DashLineTextItem implements IUpdatable {

    private var _data:StaticFormationStatsItemVO = null;

    public function StaticFormationStatsItem() {
        super();
    }

    override protected function onDispose():void {
        this._data = null;
        super.onDispose();
    }

    override protected function applySizeChanges():void {
        dashLine.width = _width - labelTextField.width - valueTextField.width - (dashLinePadding << 1) | 0;
        dashLine.x = labelTextField.width + dashLinePadding | 0;
        valueTextField.x = _width - valueTextField.width | 0;
        dashLine.validateNow();
    }

    override protected function draw():void {
        if (isInvalid(VALUE_INV)) {
            valueTextField.autoSize = TextFieldAutoSize.RIGHT;
            valueTextField.htmlText = this._data.value;
            invalidate(InvalidationType.SIZE);
        }
        if (isInvalid(LABEL_INV)) {
            labelTextField.autoSize = TextFieldAutoSize.LEFT;
            labelTextField.htmlText = this._data.label;
            invalidate(InvalidationType.SIZE);
        }
        if (isInvalid(InvalidationType.SIZE)) {
            this.applySizeChanges();
        }
    }

    public function update(param1:Object):void {
        if (this._data == param1) {
            return;
        }
        this._data = StaticFormationStatsItemVO(param1);
        if (this._data) {
            this.label = this._data.label;
            this.value = this._data.value;
        }
    }
}
}
