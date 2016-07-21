package net.wg.gui.lobby.settings.config {
import net.wg.gui.lobby.settings.vo.CursorTabsDataVo;
import net.wg.gui.lobby.settings.vo.MarkerTabsDataVo;
import net.wg.gui.lobby.settings.vo.SettingsControlProp;
import net.wg.gui.lobby.settings.vo.TabsDataVo;
import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
import net.wg.gui.lobby.settings.vo.config.SettingConfigDataVo;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class SettingsConfigHelper implements IDisposable {

    public static var GAME_SETTINGS:String = "GameSettings";

    public static var GRAPHIC_SETTINGS:String = "GraphicSettings";

    public static var SOUND_SETTINGS:String = "SoundSettings";

    public static var CONTROLS_SETTINGS:String = "ControlsSettings";

    public static var CURSOR_SETTINGS:String = "AimSettings";

    public static var MARKER_SETTINGS:String = "MarkerSettings";

    public static var OTHER_SETTINGS:String = "OtherSettings";

    public static var TYPE_CHECKBOX:String = "Checkbox";

    public static var TYPE_SLIDER:String = "Slider";

    public static var TYPE_STEP_SLIDER:String = "StepSlider";

    public static var TYPE_RANGE_SLIDER:String = "RangeSlider";

    public static var TYPE_DROPDOWN:String = "DropDown";

    public static var TYPE_BUTTON_BAR:String = "ButtonBar";

    public static var TYPE_LABEL:String = "Label";

    public static var TYPE_VALUE:String = "Value";

    public static var TYPE_KEYINPUT:String = "KeyInput";

    public static var LOCALIZATION:String = "#settings:";

    public static var NO_COLOR_FILTER_DATA:int = 0;

    public static var ADVANCED_GRAPHICS_DATA:int = 0;

    public static var KEYS_LAYOUT:String = "keysLayout";

    public static var KEYBOARD_IMPORTANT_BINDS:String = "keyboardImportantBinds";

    public static var KEYBOARD:String = "keyboard";

    public static var PUSH_TO_TALK:String = "pushToTalk";

    public static var KEYS_LAYOUT_ORDER:String = "keysLayoutOrder";

    public static var PTT:String = "PTT";

    public static var ENABLE_VO_IP:String = "enableVoIP";

    public static var VOICE_CHAT_SUPORTED:String = "voiceChatSupported";

    public static var MIC_VIVOX_VOLUME:String = "micVivoxVolume";

    public static var ALTERNATIVE_VOICES:String = "alternativeVoices";

    public static var DEF_ALTERNATIVE_VOICE:String = "default";

    public static var AUTODETECT_BUTTON:String = "autodetectButton";

    public static var QUALITY_ORDER:String = "qualityOrder";

    public static var PRESETS:String = "presets";

    public static var MASTER_VOLUME_TOGGLE:String = "masterVolumeToggle";

    public static var SOUND_QUALITY:String = "soundQuality";

    public static var SOUND_QUALITY_VISIBLE:String = "soundQualityVisible";

    public static var SIZE:String = "sizes";

    public static var REFRESH_RATE:String = "refreshRate";

    public static var DYNAMIC_RENDERER:String = "dynamicRenderer";

    public static var ASPECTRATIO:String = "aspectRatio";

    public static var INTERFACE_SCALE:String = "interfaceScale";

    public static var GAMMA:String = "gamma";

    public static var VERTICAL_SYNC:String = "vertSync";

    public static var TRIPLE_BUFFERED:String = "tripleBuffered";

    public static var FOV:String = "fov";

    public static var DYNAMIC_FOV:String = "dynamicFov";

    public static var HAVOK_ENABLED:String = "HAVOK_ENABLED";

    public static var FULL_SCREEN:String = "fullScreen";

    public static var RESOLUTION:String = "resolution";

    public static var WINDOW_SIZE:String = "windowSize";

    public static var MONITOR:String = "monitor";

    public static var SMOOTHING:String = "smoothing";

    public static var CUSTOM_AA:String = "customAA";

    public static var MULTISAMPLING:String = "multisampling";

    public static var reservedImaginaryControls:Array = [QUALITY_ORDER, WINDOW_SIZE, RESOLUTION, MULTISAMPLING, CUSTOM_AA];

    public static var COLOR_GRADING_TECHNIQUE:String = "COLOR_GRADING_TECHNIQUE";

    public static var COLOR_FILTER_INTENSITY:String = "colorFilterIntensity";

    public static var COLOR_FILTER_IMAGES:String = "colorFilterImages";

    public static var IS_COLOR_BLIND:String = "isColorBlind";

    public static var TEXTURE_QUALITY:String = "TEXTURE_QUALITY";

    public static var DECALS_QUALITY:String = "DECALS_QUALITY";

    public static var SHADOWS_QUALITY:String = "SHADOWS_QUALITY";

    public static var TERRAIN_QUALITY:String = "TERRAIN_QUALITY";

    public static var WATER_QUALITY:String = "WATER_QUALITY";

    public static var LIGHTING_QUALITY:String = "LIGHTING_QUALITY";

    public static var SPEEDTREE_QUALITY:String = "SPEEDTREE_QUALITY";

    public static var FLORA_QUALITY:String = "FLORA_QUALITY";

    public static var EFFECTS_QUALITY:String = "EFFECTS_QUALITY";

    public static var POST_PROCESSING_QUALITY:String = "POST_PROCESSING_QUALITY";

    public static var MOTION_BLUR_QUALITY:String = "MOTION_BLUR_QUALITY";

    public static var FAR_PLANE:String = "FAR_PLANE";

    public static var OBJECT_LOD:String = "OBJECT_LOD";

    public static var SNIPER_MODE_EFFECTS_QUALITY:String = "SNIPER_MODE_EFFECTS_QUALITY";

    public static var SNIPER_MODE_GRASS_ENABLED:String = "SNIPER_MODE_GRASS_ENABLED";

    public static var VEHICLE_TRACES_ENABLED:String = "VEHICLE_TRACES_ENABLED";

    public static var SEMITRANSPARENT_LEAVES_ENABLED:String = "SEMITRANSPARENT_LEAVES_ENABLED";

    public static var VEHICLE_DUST_ENABLED:String = "VEHICLE_DUST_ENABLED";

    public static var FPS_PERFORMANCER:String = "fpsPerfomancer";

    public static var DRR_AUTOSCALER_ENABLED:String = "DRR_AUTOSCALER_ENABLED";

    public static var RENDER_PIPELINE:String = "RENDER_PIPELINE";

    public static var CUSTOM:String = "CUSTOM";

    public static var GRAPHIC_QUALITY:String = "graphicsQuality";

    public static var GRAPHIC_QUALITY_HDSD:String = "graphicsQualityHDSD";

    public static var VIBRO_IS_CONNECTED:String = "vibroIsConnected";

    public static var ENABLE_OL_FILTER:String = "enableOlFilter";

    public static var DYNAMIC_CAMERA:String = "dynamicCamera";

    public static var HOR_STABILIZATION_SNP:String = "horStabilizationSnp";

    public static var RECEIVE_CLAN_INVITES_NOTIFICATIONS:String = "receiveClanInvitesNotifications";

    public static var INTERFACE_SCALE_DISABLED:String = "interfaceScaleDisabled";

    public static var KEY_RANGE:Object = {
        "defaultRange": ["APOSTROPHE", "SEMICOLON", "LBRACKET", "STOP", "COMMA", "SLASH", "BACKSLASH", "RBRACKET", "SPACE", "LSHIFT", "LALT", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "W", "V", "X", "Y", "Z", "UPARROW", "DOWNARROW", "LEFTARROW", "RIGHTARROW", "MOUSE0", "MOUSE1", "MOUSE2", "MOUSE3", "MOUSE4", "MOUSE5", "MOUSE6", "MOUSE7", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12", "INSERT", "DELETE", "HOME", "END", "NUMPAD0", "NUMPAD1", "NUMPAD2", "NUMPAD3", "NUMPAD4", "NUMPAD5", "NUMPAD6", "NUMPAD7", "NUMPAD8", "NUMPAD9", "NAMPADSLASH", "NAMPADSTAR", "NUMPADMINUS", "ADD", "NUMPADPERIOD"],
        "pushToTalk": ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "lbracket", "rbracket", "a", "s", "d", "f", "g", "h", "j", "k", "l", "semicolon", "backslash", "z", "x", "c", "v", "b", "n", "m", "comma", "stop", "slash", "insert", "delete", "home", "end", "apostrophe"],
        "sizeUp": ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "lbracket", "rbracket", "a", "s", "d", "f", "g", "h", "j", "k", "l", "semicolon", "backslash", "z", "x", "c", "v", "b", "n", "m", "comma", "stop", "slash", "insert", "delete", "home", "end", "apostrophe", "MINUS", "EQUALS", "numpadslash", "numpadstar", "numpadminus", "add", "numpadperiod", "numpad0", "numpad1", "numpad2", "numpad3", "numpad4", "numpad5", "numpad6", "numpad7", "numpad8", "numpad9", "MOUSE4", "MOUSE5"],
        "sizeDown": ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "lbracket", "rbracket", "a", "s", "d", "f", "g", "h", "j", "k", "l", "semicolon", "backslash", "z", "x", "c", "v", "b", "n", "m", "comma", "stop", "slash", "insert", "delete", "home", "end", "apostrophe", "MINUS", "EQUALS", "numpadslash", "numpadstar", "numpadminus", "add", "numpadperiod", "numpad0", "numpad1", "numpad2", "numpad3", "numpad4", "numpad5", "numpad6", "numpad7", "numpad8", "numpad9", "MOUSE4", "MOUSE5"],
        "visible": ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "lbracket", "rbracket", "a", "s", "d", "f", "g", "h", "j", "k", "l", "semicolon", "backslash", "z", "x", "c", "v", "b", "n", "m", "comma", "stop", "slash", "insert", "delete", "home", "end", "apostrophe", "MINUS", "EQUALS", "numpadslash", "numpadstar", "numpadminus", "add", "numpadperiod", "numpad0", "numpad1", "numpad2", "numpad3", "numpad4", "numpad5", "numpad6", "numpad7", "numpad8", "numpad9", "MOUSE4", "MOUSE5"],
        "showRadialMenu": ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "lbracket", "rbracket", "a", "s", "d", "f", "g", "h", "j", "k", "l", "semicolon", "backslash", "z", "x", "c", "v", "b", "n", "m", "comma", "stop", "slash", "insert", "delete", "home", "end", "apostrophe", "MINUS", "EQUALS", "space", "numpadslash", "numpadstar", "numpadminus", "add", "numpadperiod", "numpad0", "numpad1", "numpad2", "numpad3", "numpad4", "numpad5", "numpad6", "numpad7", "numpad8", "numpad9", "MOUSE2", "MOUSE3", "MOUSE4", "MOUSE5", "MOUSE6", "MOUSE7"]
    };

    private static var _instance:SettingsConfigHelper = null;

    private var _settingsData:SettingsDataVo = null;

    private var _markerTabsDataProvider:Array = null;

    private var _cursorTabsDataProvider:Array = null;

    private var _liveUpdateVideoSettingsOrderData:Vector.<String> = null;

    private var _liveUpdateVideoSettingsData:Object = null;

    private var _tabsDataProvider:Array = null;

    public function SettingsConfigHelper(param1:PrivateClass) {
        super();
        this._settingsData = new SettingConfigDataVo();
        this._markerTabsDataProvider = [new MarkerTabsDataVo({
            "label": SETTINGS.MARKER_ENEMYTITLE,
            "linkage": null,
            "id": "enemy",
            "formID": "enemyForm",
            "markerID": "markerEnemy",
            "markerFlag": 1
        }), new MarkerTabsDataVo({
            "label": SETTINGS.MARKER_ALLYTITLE,
            "linkage": null,
            "id": "ally",
            "formID": "allyForm",
            "markerID": "markerAlly",
            "markerFlag": 2
        }), new MarkerTabsDataVo({
            "label": SETTINGS.MARKER_DEADTITLE,
            "linkage": null,
            "id": "dead",
            "formID": "deadForm",
            "markerID": "markerDead",
            "markerFlag": 2
        })];
        this._cursorTabsDataProvider = [new CursorTabsDataVo({
            "label": SETTINGS.CURSOR_ARCADETITLE,
            "linkage": null,
            "id": "arcade",
            "formID": "arcadeForm",
            "crosshairID": "arcadeCursor"
        }), new CursorTabsDataVo({
            "label": SETTINGS.CURSOR_SNIPPERTITLE,
            "linkage": null,
            "id": "sniper",
            "formID": "sniperForm",
            "crosshairID": "snipperCursor"
        })];
        this._liveUpdateVideoSettingsOrderData = Vector.<String>([MONITOR, FULL_SCREEN, WINDOW_SIZE, RESOLUTION, SIZE, REFRESH_RATE, DYNAMIC_RENDERER, INTERFACE_SCALE]);
        this._liveUpdateVideoSettingsData = {
            "monitor": null,
            "fullScreen": null,
            "windowSize": null,
            "resolution": null,
            "refreshRate": null,
            "dynamicRenderer": null,
            "interfaceScale": null
        };
        this._tabsDataProvider = [new TabsDataVo({
            "label": SETTINGS.GAMETITLE,
            "linkage": GAME_SETTINGS
        }), new TabsDataVo({
            "label": SETTINGS.GRAFICTITLE,
            "linkage": GRAPHIC_SETTINGS
        }), new TabsDataVo({
            "label": SETTINGS.SOUNDTITLE,
            "linkage": SOUND_SETTINGS
        }), new TabsDataVo({
            "label": SETTINGS.KEYBOARDTITLE,
            "linkage": CONTROLS_SETTINGS
        }), new TabsDataVo({
            "label": SETTINGS.CURSORTITLE,
            "linkage": CURSOR_SETTINGS
        }), new TabsDataVo({
            "label": SETTINGS.MARKERTITLE,
            "linkage": MARKER_SETTINGS
        })];
    }

    public static function get instance():SettingsConfigHelper {
        if (_instance == null) {
            _instance = new SettingsConfigHelper(new PrivateClass());
        }
        return _instance;
    }

    public function dispose():void {
        var _loc1_:SettingsControlProp = null;
        this._settingsData.dispose();
        this._settingsData = null;
        this._markerTabsDataProvider.splice(0);
        this._markerTabsDataProvider = null;
        this._cursorTabsDataProvider.splice(0);
        this._cursorTabsDataProvider = null;
        this._liveUpdateVideoSettingsOrderData.splice(0, this._liveUpdateVideoSettingsOrderData.length);
        this._liveUpdateVideoSettingsOrderData = null;
        for each(_loc1_ in this._liveUpdateVideoSettingsData) {
            _loc1_.dispose();
        }
        this._liveUpdateVideoSettingsData = null;
        this._tabsDataProvider.splice(0);
        this._tabsDataProvider = null;
        _instance = null;
    }

    public function getControlId(param1:String, param2:String):String {
        return param1.replace(param2, "");
    }

    public function get tabsDataProviderWithOther():Array {
        var _loc1_:Array = this._tabsDataProvider.concat();
        _loc1_.push(new TabsDataVo({
            "label": SETTINGS.OTHERTITLE,
            "linkage": OTHER_SETTINGS
        }));
        return _loc1_;
    }

    public function get settingsData():SettingsDataVo {
        return this._settingsData;
    }

    public function set settingsData(param1:SettingsDataVo):void {
        this._settingsData = param1;
    }

    public function get markerTabsDataProvider():Array {
        return this._markerTabsDataProvider;
    }

    public function set markerTabsDataProvider(param1:Array):void {
        this._markerTabsDataProvider = param1;
    }

    public function get cursorTabsDataProvider():Array {
        return this._cursorTabsDataProvider;
    }

    public function set cursorTabsDataProvider(param1:Array):void {
        this._cursorTabsDataProvider = param1;
    }

    public function get liveUpdateVideoSettingsOrderData():Vector.<String> {
        return this._liveUpdateVideoSettingsOrderData;
    }

    public function set liveUpdateVideoSettingsOrderData(param1:Vector.<String>):void {
        this._liveUpdateVideoSettingsOrderData = param1;
    }

    public function get liveUpdateVideoSettingsData():Object {
        return this._liveUpdateVideoSettingsData;
    }

    public function get tabsDataProvider():Array {
        return this._tabsDataProvider;
    }

    public function set tabsDataProvider(param1:Array):void {
        this._tabsDataProvider = param1;
    }
}
}

class PrivateClass {

    function PrivateClass() {
        super();
    }
}
