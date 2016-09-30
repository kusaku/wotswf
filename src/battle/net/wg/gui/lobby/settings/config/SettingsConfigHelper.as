package net.wg.gui.lobby.settings.config {
import net.wg.data.constants.Linkages;
import net.wg.data.constants.Values;
import net.wg.gui.lobby.settings.vo.CursorTabsDataVo;
import net.wg.gui.lobby.settings.vo.MarkerTabsDataVo;
import net.wg.gui.lobby.settings.vo.SettingsControlProp;
import net.wg.gui.lobby.settings.vo.TabsDataVo;
import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
import net.wg.gui.lobby.settings.vo.config.SettingConfigDataVo;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.clik.data.DataProvider;

public class SettingsConfigHelper implements IDisposable {

    private static var _instance:SettingsConfigHelper = null;

    public static const GAME_SETTINGS:String = "GameSettings";

    public static const GRAPHIC_SETTINGS:String = "GraphicSettings";

    public static const SOUND_SETTINGS:String = "SoundSettings";

    public static const CONTROLS_SETTINGS:String = "ControlsSettings";

    public static const CURSOR_SETTINGS:String = "AimSettings";

    public static const MARKER_SETTINGS:String = "MarkerSettings";

    public static const OTHER_SETTINGS:String = "OtherSettings";

    public static var FEEDBACK_SETTINGS:String = "FeedbackSettings";

    public static const TYPE_CHECKBOX:String = "Checkbox";

    public static const TYPE_SLIDER:String = "Slider";

    public static const TYPE_STEP_SLIDER:String = "StepSlider";

    public static const TYPE_RANGE_SLIDER:String = "RangeSlider";

    public static const TYPE_DROPDOWN:String = "DropDown";

    public static const TYPE_BUTTON_BAR:String = "ButtonBar";

    public static const TYPE_LABEL:String = "Label";

    public static const TYPE_VALUE:String = "Value";

    public static const TYPE_KEYINPUT:String = "KeyInput";

    public static const LOCALIZATION:String = "#settings:";

    public static const NO_COLOR_FILTER_DATA:int = 0;

    public static const ADVANCED_GRAPHICS_DATA:int = 0;

    public static const KEYS_LAYOUT:String = "keysLayout";

    public static const KEYBOARD_IMPORTANT_BINDS:String = "keyboardImportantBinds";

    public static const KEYBOARD:String = "keyboard";

    public static const PUSH_TO_TALK:String = "pushToTalk";

    public static const KEYS_LAYOUT_ORDER:String = "keysLayoutOrder";

    public static const PTT:String = "PTT";

    public static const ENABLE_VO_IP:String = "enableVoIP";

    public static const VOICE_CHAT_SUPPORTED:String = "voiceChatSupported";

    public static const MIC_VIVOX_VOLUME:String = "micVivoxVolume";

    public static const ALTERNATIVE_VOICES:String = "alternativeVoices";

    public static const BULB_VOICES:String = "bulbVoices";

    public static const DEF_ALTERNATIVE_VOICE:String = "default";

    public static const AUTODETECT_BUTTON:String = "autodetectButton";

    public static const QUALITY_ORDER:String = "qualityOrder";

    public static const PRESETS:String = "presets";

    public static const MASTER_VOLUME_TOGGLE:String = "masterVolumeToggle";

    public static const NIGHT_MODE:String = "nightMode";

    public static const BASS_BOOST:String = "bassBoost";

    public static const SOUND_QUALITY:String = "soundQuality";

    public static const SOUND_QUALITY_VISIBLE:String = "soundQualityVisible";

    public static const SIZE:String = "sizes";

    public static const REFRESH_RATE:String = "refreshRate";

    public static const DYNAMIC_RENDERER:String = "dynamicRenderer";

    public static const ASPECTRATIO:String = "aspectRatio";

    public static const INTERFACE_SCALE:String = "interfaceScale";

    public static const GAMMA:String = "gamma";

    public static const VERTICAL_SYNC:String = "vertSync";

    public static const TRIPLE_BUFFERED:String = "tripleBuffered";

    public static const FOV:String = "fov";

    public static const DYNAMIC_FOV:String = "dynamicFov";

    public static const HAVOK_ENABLED:String = "HAVOK_ENABLED";

    public static const FULL_SCREEN:String = "fullScreen";

    public static const RESOLUTION:String = "resolution";

    public static const WINDOW_SIZE:String = "windowSize";

    public static const MONITOR:String = "monitor";

    public static const SMOOTHING:String = "smoothing";

    public static const CUSTOM_AA:String = "customAA";

    public static const MULTISAMPLING:String = "multisampling";

    public static const reservedImaginaryControls:Array = [QUALITY_ORDER, WINDOW_SIZE, RESOLUTION, MULTISAMPLING, CUSTOM_AA];

    public static const COLOR_GRADING_TECHNIQUE:String = "COLOR_GRADING_TECHNIQUE";

    public static const COLOR_FILTER_INTENSITY:String = "colorFilterIntensity";

    public static const COLOR_FILTER_IMAGES:String = "colorFilterImages";

    public static const IS_COLOR_BLIND:String = "isColorBlind";

    public static const TEXTURE_QUALITY:String = "TEXTURE_QUALITY";

    public static const DECALS_QUALITY:String = "DECALS_QUALITY";

    public static const SHADOWS_QUALITY:String = "SHADOWS_QUALITY";

    public static const TERRAIN_QUALITY:String = "TERRAIN_QUALITY";

    public static const WATER_QUALITY:String = "WATER_QUALITY";

    public static const LIGHTING_QUALITY:String = "LIGHTING_QUALITY";

    public static const SPEEDTREE_QUALITY:String = "SPEEDTREE_QUALITY";

    public static const FLORA_QUALITY:String = "FLORA_QUALITY";

    public static const EFFECTS_QUALITY:String = "EFFECTS_QUALITY";

    public static const POST_PROCESSING_QUALITY:String = "POST_PROCESSING_QUALITY";

    public static const MOTION_BLUR_QUALITY:String = "MOTION_BLUR_QUALITY";

    public static const FAR_PLANE:String = "FAR_PLANE";

    public static const OBJECT_LOD:String = "OBJECT_LOD";

    public static const SNIPER_MODE_EFFECTS_QUALITY:String = "SNIPER_MODE_EFFECTS_QUALITY";

    public static const SNIPER_MODE_GRASS_ENABLED:String = "SNIPER_MODE_GRASS_ENABLED";

    public static const VEHICLE_TRACES_ENABLED:String = "VEHICLE_TRACES_ENABLED";

    public static const SEMITRANSPARENT_LEAVES_ENABLED:String = "SEMITRANSPARENT_LEAVES_ENABLED";

    public static const VEHICLE_DUST_ENABLED:String = "VEHICLE_DUST_ENABLED";

    public static const FPS_PERFORMANCER:String = "fpsPerfomancer";

    public static const DRR_AUTOSCALER_ENABLED:String = "DRR_AUTOSCALER_ENABLED";

    public static const RENDER_PIPELINE:String = "RENDER_PIPELINE";

    public static const CUSTOM:String = "CUSTOM";

    public static const GRAPHIC_QUALITY:String = "graphicsQuality";

    public static const GRAPHIC_QUALITY_HDSD:String = "graphicsQualityHDSD";

    public static const VIBRO_IS_CONNECTED:String = "vibroIsConnected";

    public static const ENABLE_OL_FILTER:String = "enableOlFilter";

    public static const DYNAMIC_CAMERA:String = "dynamicCamera";

    public static const HOR_STABILIZATION_SNP:String = "horStabilizationSnp";

    public static const RECEIVE_CLAN_INVITES_NOTIFICATIONS:String = "receiveClanInvitesNotifications";

    public static const INTERFACE_SCALE_DISABLED:String = "interfaceScaleDisabled";

    public static const KEY_RANGE:Object = {
        "defaultRange": ["APOSTROPHE", "SEMICOLON", "LBRACKET", "STOP", "COMMA", "SLASH", "BACKSLASH", "RBRACKET", "SPACE", "LSHIFT", "LALT", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "W", "V", "X", "Y", "Z", "UPARROW", "DOWNARROW", "LEFTARROW", "RIGHTARROW", "MOUSE0", "MOUSE1", "MOUSE2", "MOUSE3", "MOUSE4", "MOUSE5", "MOUSE6", "MOUSE7", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12", "INSERT", "DELETE", "HOME", "END", "NUMPAD0", "NUMPAD1", "NUMPAD2", "NUMPAD3", "NUMPAD4", "NUMPAD5", "NUMPAD6", "NUMPAD7", "NUMPAD8", "NUMPAD9", "NAMPADSLASH", "NAMPADSTAR", "NUMPADMINUS", "ADD", "NUMPADPERIOD"],
        "pushToTalk": ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "lbracket", "rbracket", "a", "s", "d", "f", "g", "h", "j", "k", "l", "semicolon", "backslash", "z", "x", "c", "v", "b", "n", "m", "comma", "stop", "slash", "insert", "delete", "home", "end", "apostrophe"],
        "sizeUp": ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "lbracket", "rbracket", "a", "s", "d", "f", "g", "h", "j", "k", "l", "semicolon", "backslash", "z", "x", "c", "v", "b", "n", "m", "comma", "stop", "slash", "insert", "delete", "home", "end", "apostrophe", "MINUS", "EQUALS", "numpadslash", "numpadstar", "numpadminus", "add", "numpadperiod", "numpad0", "numpad1", "numpad2", "numpad3", "numpad4", "numpad5", "numpad6", "numpad7", "numpad8", "numpad9", "MOUSE4", "MOUSE5"],
        "sizeDown": ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "lbracket", "rbracket", "a", "s", "d", "f", "g", "h", "j", "k", "l", "semicolon", "backslash", "z", "x", "c", "v", "b", "n", "m", "comma", "stop", "slash", "insert", "delete", "home", "end", "apostrophe", "MINUS", "EQUALS", "numpadslash", "numpadstar", "numpadminus", "add", "numpadperiod", "numpad0", "numpad1", "numpad2", "numpad3", "numpad4", "numpad5", "numpad6", "numpad7", "numpad8", "numpad9", "MOUSE4", "MOUSE5"],
        "visible": ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "lbracket", "rbracket", "a", "s", "d", "f", "g", "h", "j", "k", "l", "semicolon", "backslash", "z", "x", "c", "v", "b", "n", "m", "comma", "stop", "slash", "insert", "delete", "home", "end", "apostrophe", "MINUS", "EQUALS", "numpadslash", "numpadstar", "numpadminus", "add", "numpadperiod", "numpad0", "numpad1", "numpad2", "numpad3", "numpad4", "numpad5", "numpad6", "numpad7", "numpad8", "numpad9", "MOUSE4", "MOUSE5"],
        "showRadialMenu": ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "lbracket", "rbracket", "a", "s", "d", "f", "g", "h", "j", "k", "l", "semicolon", "backslash", "z", "x", "c", "v", "b", "n", "m", "comma", "stop", "slash", "insert", "delete", "home", "end", "apostrophe", "MINUS", "EQUALS", "space", "numpadslash", "numpadstar", "numpadminus", "add", "numpadperiod", "numpad0", "numpad1", "numpad2", "numpad3", "numpad4", "numpad5", "numpad6", "numpad7", "numpad8", "numpad9", "MOUSE2", "MOUSE3", "MOUSE4", "MOUSE5", "MOUSE6", "MOUSE7"]
    };

    private static const ENEMY_STR:String = "enemy";

    private static const ENEMY_FORM_STR:String = ENEMY_STR + "Form";

    private static const MARKER_ENEMY_STR:String = "markerEnemy";

    private static const ALLY_STR:String = "ally";

    private static const ALLY_FORM_STR:String = ALLY_STR + "Form";

    private static const MARKER_ALLY_STR:String = "markerAlly";

    private static const DEAD_STR:String = "dead";

    private static const DEAD_FORM_STR:String = DEAD_STR + "Form";

    private static const MARKER_DEAD_STR:String = "markerDead";

    private static const ARCADE_STR:String = "arcade";

    private static const ARCADE_FORM_STR:String = ARCADE_STR + "Form";

    private static const ARCADE_CURSOR_STR:String = ARCADE_STR + "Cursor";

    private static const SNIPER_STR:String = "sniper";

    private static const SNIPER_FORM_STR:String = SNIPER_STR + "Form";

    private static const SNIPER_CURSOR_STR:String = "snipperCursor";

    private var _settingsData:SettingsDataVo;

    private var _markerTabsDataProvider:Array;

    private var _cursorTabsDataProvider:Array;

    private var _liveUpdateVideoSettingsOrderData:Vector.<String>;

    private var _feedbackDataProvider:DataProvider = null;

    private var _liveUpdateVideoSettingsData:Object;

    private var _tabsDataProvider:Array;

    public function SettingsConfigHelper() {
        this._settingsData = new SettingConfigDataVo();
        this._markerTabsDataProvider = [new MarkerTabsDataVo({
            "label": SETTINGS.MARKER_ENEMYTITLE,
            "linkage": null,
            "id": ENEMY_STR,
            "formID": ENEMY_FORM_STR,
            "markerID": MARKER_ENEMY_STR,
            "markerFlag": 1
        }), new MarkerTabsDataVo({
            "label": SETTINGS.MARKER_ALLYTITLE,
            "linkage": null,
            "id": ALLY_STR,
            "formID": ALLY_FORM_STR,
            "markerID": MARKER_ALLY_STR,
            "markerFlag": 2
        }), new MarkerTabsDataVo({
            "label": SETTINGS.MARKER_DEADTITLE,
            "linkage": null,
            "id": DEAD_STR,
            "formID": DEAD_FORM_STR,
            "markerID": MARKER_DEAD_STR,
            "markerFlag": 2
        })];
        this._cursorTabsDataProvider = [new CursorTabsDataVo({
            "label": SETTINGS.CURSOR_ARCADETITLE,
            "linkage": null,
            "id": ARCADE_STR,
            "formID": ARCADE_FORM_STR,
            "crosshairID": ARCADE_CURSOR_STR
        }), new CursorTabsDataVo({
            "label": SETTINGS.CURSOR_SNIPPERTITLE,
            "linkage": null,
            "id": SNIPER_STR,
            "formID": SNIPER_FORM_STR,
            "crosshairID": SNIPER_CURSOR_STR
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
        }), new TabsDataVo({
            "label": SETTINGS.FEEDBACK,
            "linkage": FEEDBACK_SETTINGS
        })];
        super();
        App.utils.asserter.assert(!_instance, "Instantiation failed: Use TweenFlowFactory.getInstance() instead of new.");
        this._feedbackDataProvider = new DataProvider();
        this._feedbackDataProvider.push({
            "label": SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR,
            "linkage": Linkages.FEEDBACK_DAMAGE_INDICATOR
        }, {
            "label": SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL,
            "linkage": Linkages.FEEDBACK_DAMAGE_LOG
        }, {
            "label": SETTINGS.FEEDBACK_TAB_EVENTSINFO,
            "linkage": Linkages.FEEDBACK_BATTLE_EVENTS
        });
    }

    public static function get instance():SettingsConfigHelper {
        if (!_instance) {
            _instance = new SettingsConfigHelper();
        }
        return _instance;
    }

    public final function dispose():void {
        var _loc1_:SettingsControlProp = null;
        this._settingsData.dispose();
        this._settingsData = null;
        this._markerTabsDataProvider.splice(0);
        this._markerTabsDataProvider = null;
        this._cursorTabsDataProvider.splice(0);
        this._cursorTabsDataProvider = null;
        this._feedbackDataProvider.cleanUp();
        this._feedbackDataProvider = null;
        this._liveUpdateVideoSettingsOrderData.splice(0, this._liveUpdateVideoSettingsOrderData.length);
        this._liveUpdateVideoSettingsOrderData = null;
        for each(_loc1_ in this._liveUpdateVideoSettingsData) {
            if (_loc1_) {
                _loc1_.dispose();
            }
        }
        this._liveUpdateVideoSettingsData = null;
        this._tabsDataProvider.splice(0);
        this._tabsDataProvider = null;
        _instance = null;
    }

    public function getControlId(param1:String, param2:String):String {
        return param1.replace(param2, Values.EMPTY_STR);
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

    public function get feedbackDataProvider():DataProvider {
        return this._feedbackDataProvider;
    }

    public function get markerTabsDataProvider():Array {
        return this._markerTabsDataProvider;
    }

    public function get cursorTabsDataProvider():Array {
        return this._cursorTabsDataProvider;
    }

    public function get liveUpdateVideoSettingsOrderData():Vector.<String> {
        return this._liveUpdateVideoSettingsOrderData;
    }

    public function get liveUpdateVideoSettingsData():Object {
        return this._liveUpdateVideoSettingsData;
    }

    public function get tabsDataProvider():Array {
        return this._tabsDataProvider;
    }
}
}
