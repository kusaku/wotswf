package net.wg.gui.lobby.settings.events {
import flash.events.Event;

public class SettingViewEvent extends Event {

    public static var ON_CONTROL_CHANGED:String = "on_control_changed";

    public static var ON_AUTO_DETECT_QUALITY:String = "on_auto_detect_quality";

    public static var ON_AUTO_DETECT_ACOUSTIC:String = "on_auto_detect_acoustic";

    public static var ON_SOUND_SPEAKER_CHANGE:String = "on_sound_speaker_change";

    public static var ON_VIVOX_TEST:String = "on_vivox_test";

    public static var ON_UPDATE_CAPTURE_DEVICE:String = "on_update_capture_device";

    public static var ON_PTT_CONTROL_CHANGED:String = "on_relate_control_changed";

    public static var ON_PTT_SOUND_CONTROL_CHANGED:String = "on_ptt_sound_control_changed";

    public var viewId:String;

    public var controlId:String;

    public var controlValue:Object;

    public function SettingViewEvent(param1:String, param2:String, param3:String = "", param4:Object = null, param5:Boolean = true, param6:Boolean = false) {
        super(param1, param5, param6);
        this.viewId = param2;
        this.controlId = param3;
        this.controlValue = param4;
    }

    override public function clone():Event {
        return new SettingViewEvent(type, this.viewId, this.controlId, this.controlValue, bubbles, cancelable);
    }

    override public function toString():String {
        return formatToString("SettingViewEvent", "type", "viewId", "controlId", "controlValue", "bubbles", "cancelable", "eventPhase");
    }
}
}
