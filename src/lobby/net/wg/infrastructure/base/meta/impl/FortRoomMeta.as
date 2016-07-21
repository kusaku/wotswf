package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.rally.views.room.BaseRallyRoomViewWithOrdersPanel;

public class FortRoomMeta extends BaseRallyRoomViewWithOrdersPanel {

    public var showChangeDivisionWindow:Function;

    public function FortRoomMeta() {
        super();
    }

    public function showChangeDivisionWindowS():void {
        App.utils.asserter.assertNotNull(this.showChangeDivisionWindow, "showChangeDivisionWindow" + Errors.CANT_NULL);
        this.showChangeDivisionWindow();
    }
}
}
