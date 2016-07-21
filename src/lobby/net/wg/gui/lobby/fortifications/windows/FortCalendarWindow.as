package net.wg.gui.lobby.fortifications.windows {
import flash.display.InteractiveObject;

import net.wg.data.Aliases;
import net.wg.gui.components.advanced.Calendar;
import net.wg.gui.lobby.fortifications.cmp.calendar.impl.CalendarPreviewBlock;
import net.wg.gui.lobby.fortifications.data.FortCalendarDayVO;
import net.wg.gui.lobby.fortifications.data.FortCalendarPreviewBlockVO;
import net.wg.infrastructure.base.meta.IFortCalendarWindowMeta;
import net.wg.infrastructure.base.meta.impl.FortCalendarWindowMeta;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.utils.ILocale;

public class FortCalendarWindow extends FortCalendarWindowMeta implements IFortCalendarWindowMeta {

    public var calendar:Calendar;

    public var previewBlock:CalendarPreviewBlock;

    public function FortCalendarWindow() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.calendar.defaultFocusToSelected = true;
        this.calendar.addEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onCalendarRequestFocusHandler);
        this.calendar.dayVOClass = FortCalendarDayVO;
        var _loc1_:ILocale = App.utils.locale;
        this.calendar.setOutOfBoundsTooltip(_loc1_.makeString(FORTIFICATIONS.FORTCALENDARWINDOW_CALENDAR_DAYTOOLTIP_NOTAVAILABLE_HEADER), _loc1_.makeString(FORTIFICATIONS.FORTCALENDARWINDOW_CALENDAR_DAYTOOLTIP_NOTAVAILABLE_BODY));
    }

    override protected function onPopulate():void {
        super.onPopulate();
        registerFlashComponentS(this.calendar, Aliases.CALENDAR);
        window.title = FORTIFICATIONS.FORTCALENDARWINDOW_TITLE;
    }

    override protected function onDispose():void {
        this.calendar.removeEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onCalendarRequestFocusHandler);
        this.calendar = null;
        this.previewBlock.dispose();
        this.previewBlock = null;
        super.onDispose();
    }

    override protected function onSetModalFocus(param1:InteractiveObject):void {
        var _loc2_:InteractiveObject = this.calendar.getComponentForFocus();
        if (_loc2_ == null) {
            _loc2_ = param1;
        }
        super.onSetModalFocus(_loc2_);
    }

    override protected function updatePreviewData(param1:FortCalendarPreviewBlockVO):void {
        this.previewBlock.model = param1;
    }

    private function onCalendarRequestFocusHandler(param1:FocusRequestEvent):void {
        setFocus(param1.focusContainer.getComponentForFocus());
    }
}
}
