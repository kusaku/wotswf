package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.BaseDAAPIComponent;

public class CalendarMeta extends BaseDAAPIComponent {

    public var onMonthChanged:Function;

    public var onDateSelected:Function;

    public var formatYMHeader:Function;

    public function CalendarMeta() {
        super();
    }

    public function onMonthChangedS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.onMonthChanged, "onMonthChanged" + Errors.CANT_NULL);
        this.onMonthChanged(param1);
    }

    public function onDateSelectedS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.onDateSelected, "onDateSelected" + Errors.CANT_NULL);
        this.onDateSelected(param1);
    }

    public function formatYMHeaderS(param1:Number):String {
        App.utils.asserter.assertNotNull(this.formatYMHeader, "formatYMHeader" + Errors.CANT_NULL);
        return this.formatYMHeader(param1);
    }
}
}
