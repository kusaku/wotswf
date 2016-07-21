package net.wg.gui.cyberSport.staticFormation.components {
import flash.text.TextFieldAutoSize;

import net.wg.gui.components.advanced.DashLineTextItem;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStatsItemVO;
import net.wg.infrastructure.interfaces.entity.IUpdatable;

import scaleform.clik.constants.InvalidationType;

public class BestTanksMapsItem extends DashLineTextItem implements IUpdatable {

    private static const ICON_PADDING:int = 10;

    public var icon:UILoaderAlt = null;

    private var _data:StaticFormationStatsItemVO = null;

    public function BestTanksMapsItem() {
        super();
    }

    override protected function onDispose():void {
        this.icon.dispose();
        this.icon = null;
        this._data = null;
        super.onDispose();
    }

    override protected function applySizeChanges():void {
        var _loc1_:int = 0;
        if (this._data.iconSource) {
            _loc1_ = this.icon.width + ICON_PADDING;
            this.icon.x = _width - this.icon.width;
        }
        dashLine.width = _width - labelTextField.width - valueTextField.width - (dashLinePadding << 1) - _loc1_ | 0;
        dashLine.x = labelTextField.width + dashLinePadding | 0;
        valueTextField.x = _width - valueTextField.width - _loc1_ | 0;
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
        var _loc2_:Boolean = false;
        if (this._data == param1) {
            return;
        }
        this._data = StaticFormationStatsItemVO(param1);
        if (this._data) {
            this.label = this._data.label;
            this.value = this._data.value;
            _loc2_ = Boolean(this._data.iconSource);
            if (_loc2_) {
                this.icon.source = this._data.iconSource;
            }
            this.icon.visible = _loc2_;
        }
    }
}
}
