package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.rally.views.room.BaseRallyRoomViewWithWaiting;

public class CyberSportUnitMeta extends BaseRallyRoomViewWithWaiting {

    public var toggleFreezeRequest:Function;

    public var toggleStatusRequest:Function;

    public var showSettingsRoster:Function;

    public var resultRosterSlotsSettings:Function;

    public var cancelRosterSlotsSettings:Function;

    public var lockSlotRequest:Function;

    public function CyberSportUnitMeta() {
        super();
    }

    public function toggleFreezeRequestS():void {
        App.utils.asserter.assertNotNull(this.toggleFreezeRequest, "toggleFreezeRequest" + Errors.CANT_NULL);
        this.toggleFreezeRequest();
    }

    public function toggleStatusRequestS():void {
        App.utils.asserter.assertNotNull(this.toggleStatusRequest, "toggleStatusRequest" + Errors.CANT_NULL);
        this.toggleStatusRequest();
    }

    public function showSettingsRosterS(param1:Object):void {
        App.utils.asserter.assertNotNull(this.showSettingsRoster, "showSettingsRoster" + Errors.CANT_NULL);
        this.showSettingsRoster(param1);
    }

    public function resultRosterSlotsSettingsS(param1:Array):void {
        App.utils.asserter.assertNotNull(this.resultRosterSlotsSettings, "resultRosterSlotsSettings" + Errors.CANT_NULL);
        this.resultRosterSlotsSettings(param1);
    }

    public function cancelRosterSlotsSettingsS():void {
        App.utils.asserter.assertNotNull(this.cancelRosterSlotsSettings, "cancelRosterSlotsSettings" + Errors.CANT_NULL);
        this.cancelRosterSlotsSettings();
    }

    public function lockSlotRequestS(param1:int):void {
        App.utils.asserter.assertNotNull(this.lockSlotRequest, "lockSlotRequest" + Errors.CANT_NULL);
        this.lockSlotRequest(param1);
    }
}
}
