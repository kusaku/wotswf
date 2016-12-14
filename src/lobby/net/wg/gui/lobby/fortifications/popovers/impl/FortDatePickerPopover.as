package net.wg.gui.lobby.fortifications.popovers.impl {
import net.wg.data.Aliases;
import net.wg.gui.components.advanced.Calendar;
import net.wg.gui.components.popovers.PopOver;
import net.wg.gui.lobby.fortifications.data.FortCalendarDayVO;
import net.wg.infrastructure.base.meta.IFortDatePickerPopoverMeta;
import net.wg.infrastructure.base.meta.impl.FortDatePickerPopoverMeta;
import net.wg.infrastructure.interfaces.IWrapper;

public class FortDatePickerPopover extends FortDatePickerPopoverMeta implements IFortDatePickerPopoverMeta {

    public var calendar:Calendar;

    public function FortDatePickerPopover() {
        super();
    }

    override protected function initialize():void {
        super.initialize();
        this.calendar.needToInitFocus = false;
        this.calendar.dayVOClass = FortCalendarDayVO;
        this.calendar.setOutOfBoundsTooltip(App.utils.locale.makeString(FORTIFICATIONS.FORTDATEPICKERPOPOVER_CALENDAR_DAYTOOLTIP_NOTAVAILABLE_HEADER), App.utils.locale.makeString(FORTIFICATIONS.FORTDATEPICKERPOPOVER_CALENDAR_DAYTOOLTIP_NOTAVAILABLE_BODY));
    }

    override protected function onPopulate():void {
        super.onPopulate();
        registerFlashComponentS(this.calendar, Aliases.CALENDAR);
    }

    override protected function onDispose():void {
        this.calendar = null;
        super.onDispose();
    }

    override public function set wrapper(param1:IWrapper):void {
        super.wrapper = param1;
        PopOver(param1).isCloseBtnVisible = true;
    }
}
}
