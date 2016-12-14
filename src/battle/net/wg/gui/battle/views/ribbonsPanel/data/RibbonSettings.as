package net.wg.gui.battle.views.ribbonsPanel.data {
import flash.utils.Dictionary;

import net.wg.data.constants.BattleAtlasItem;
import net.wg.data.constants.generated.BATTLE_EFFICIENCY_TYPES;
import net.wg.data.constants.generated.TANK_TYPES;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class RibbonSettings implements IDisposable {

    private static const WITH_NAME_WITH_TANKNAME_PADDINGS:String = "withNameWithTanknamePaddings";

    private static const WITHOUT_NAME_WITH_TANKNAME_PADDINGS:String = "withoutNameWithTanknamePaddings";

    private static const WITH_NAME_WITHOUT_TANKNAME_PADDINGS:String = "withNameWithoutTanknamePaddings";

    private static const WITHOUT_NAME_WITHOUT_TANKNAME_PADDINGS:String = "withoutNameWithoutTanknamePaddings";

    private static const RIBBONS_TYPES:Vector.<String> = new <String>[BATTLE_EFFICIENCY_TYPES.ARMOR, BATTLE_EFFICIENCY_TYPES.DAMAGE, BATTLE_EFFICIENCY_TYPES.RAM, BATTLE_EFFICIENCY_TYPES.BURN, BATTLE_EFFICIENCY_TYPES.DESTRUCTION, BATTLE_EFFICIENCY_TYPES.TEAM_DESTRUCTION, BATTLE_EFFICIENCY_TYPES.DETECTION, BATTLE_EFFICIENCY_TYPES.ASSIST_TRACK, BATTLE_EFFICIENCY_TYPES.ASSIST_SPOT, BATTLE_EFFICIENCY_TYPES.CRITS, BATTLE_EFFICIENCY_TYPES.CAPTURE, BATTLE_EFFICIENCY_TYPES.DEFENCE, BATTLE_EFFICIENCY_TYPES.ASSIST];

    private static const BACKGROUNDS:Object = {
        "green": new BackgroundAtlasNames(BackgroundAtlasNames.GREEN),
        "grey": new BackgroundAtlasNames(BackgroundAtlasNames.GREY)
    };

    private static const TEXT_SETTINGS:Object = {
        "green": new RibbonTextSettings(RibbonTextSettings.GREEN),
        "grey": new RibbonTextSettings(RibbonTextSettings.GREY)
    };

    private static const PADDINGS_X:Dictionary = new Dictionary();

    public static const ICON_X_PADDINGS:Dictionary = new Dictionary();

    private var _backgrounds:BackgroundAtlasNames = null;

    private var _textSettings:RibbonTextSettings = null;

    private var _icon:String;

    private var _ribbonText:String;

    private var _ribbonType:String;

    public function RibbonSettings(param1:String, param2:String) {
        super();
        this._ribbonText = param2;
        this._ribbonType = param1;
        switch (param1) {
            case BATTLE_EFFICIENCY_TYPES.ARMOR:
                this._backgrounds = BACKGROUNDS[BackgroundAtlasNames.GREY];
                this._textSettings = TEXT_SETTINGS[RibbonTextSettings.GREY];
                this._icon = BattleAtlasItem.RIBBONS_ARMOR;
                break;
            case BATTLE_EFFICIENCY_TYPES.DAMAGE:
                this._backgrounds = BACKGROUNDS[BackgroundAtlasNames.GREEN];
                this._textSettings = TEXT_SETTINGS[RibbonTextSettings.GREEN];
                this._icon = BattleAtlasItem.RIBBONS_DAMAGE;
                break;
            case BATTLE_EFFICIENCY_TYPES.RAM:
                this._backgrounds = BACKGROUNDS[BackgroundAtlasNames.GREEN];
                this._textSettings = TEXT_SETTINGS[RibbonTextSettings.GREEN];
                this._icon = BattleAtlasItem.RIBBONS_RAM;
                break;
            case BATTLE_EFFICIENCY_TYPES.BURN:
                this._backgrounds = BACKGROUNDS[BackgroundAtlasNames.GREEN];
                this._textSettings = TEXT_SETTINGS[RibbonTextSettings.GREEN];
                this._icon = BattleAtlasItem.RIBBONS_BURN;
                break;
            case BATTLE_EFFICIENCY_TYPES.DESTRUCTION:
                this._backgrounds = BACKGROUNDS[BackgroundAtlasNames.GREEN];
                this._textSettings = TEXT_SETTINGS[RibbonTextSettings.GREEN];
                this._icon = BattleAtlasItem.RIBBONS_KILL;
                break;
            case BATTLE_EFFICIENCY_TYPES.DETECTION:
                this._backgrounds = BACKGROUNDS[BackgroundAtlasNames.GREEN];
                this._textSettings = TEXT_SETTINGS[RibbonTextSettings.GREEN];
                this._icon = BattleAtlasItem.RIBBONS_SPOTTED;
                break;
            case BATTLE_EFFICIENCY_TYPES.ASSIST_TRACK:
                this._backgrounds = BACKGROUNDS[BackgroundAtlasNames.GREEN];
                this._textSettings = TEXT_SETTINGS[RibbonTextSettings.GREEN];
                this._icon = BattleAtlasItem.RIBBONS_ASSIST_TRACK;
                break;
            case BATTLE_EFFICIENCY_TYPES.ASSIST_SPOT:
                this._backgrounds = BACKGROUNDS[BackgroundAtlasNames.GREEN];
                this._textSettings = TEXT_SETTINGS[RibbonTextSettings.GREEN];
                this._icon = BattleAtlasItem.RIBBONS_ASSIST_SPOT;
                break;
            case BATTLE_EFFICIENCY_TYPES.CRITS:
                this._backgrounds = BACKGROUNDS[BackgroundAtlasNames.GREEN];
                this._textSettings = TEXT_SETTINGS[RibbonTextSettings.GREEN];
                this._icon = BattleAtlasItem.RIBBONS_CRITS;
                break;
            case BATTLE_EFFICIENCY_TYPES.CAPTURE:
                this._backgrounds = BACKGROUNDS[BackgroundAtlasNames.GREEN];
                this._textSettings = TEXT_SETTINGS[RibbonTextSettings.GREEN];
                this._icon = BattleAtlasItem.RIBBONS_CAPTURE;
                break;
            case BATTLE_EFFICIENCY_TYPES.DEFENCE:
                this._backgrounds = BACKGROUNDS[BackgroundAtlasNames.GREEN];
                this._textSettings = TEXT_SETTINGS[RibbonTextSettings.GREEN];
                this._icon = BattleAtlasItem.RIBBONS_DEFENCE;
                break;
            default:
                App.utils.asserter.assert(false, "No such ribbonType: " + param1);
        }
        PADDINGS_X[WITH_NAME_WITH_TANKNAME_PADDINGS] = new PaddingSettings(-156, 0, -2, 7, 26);
        PADDINGS_X[WITHOUT_NAME_WITH_TANKNAME_PADDINGS] = new PaddingSettings(-112, 3, 0, 0, 24);
        PADDINGS_X[WITH_NAME_WITHOUT_TANKNAME_PADDINGS] = new PaddingSettings(-135, 0, -3, 0, 0);
        PADDINGS_X[WITHOUT_NAME_WITHOUT_TANKNAME_PADDINGS] = new PaddingSettings(-94, 4, 5, 0, 0);
        ICON_X_PADDINGS[TANK_TYPES.LIGHT_TANK] = -2;
        ICON_X_PADDINGS[TANK_TYPES.MEDIUM_TANK] = -1;
        ICON_X_PADDINGS[TANK_TYPES.HEAVY_TANK] = 0;
        ICON_X_PADDINGS[TANK_TYPES.AT_SPG] = -1;
        ICON_X_PADDINGS[TANK_TYPES.SPG] = -1;
    }

    public static function isAvailableRibbonType(param1:String):Boolean {
        return RIBBONS_TYPES.indexOf(param1) >= 0;
    }

    public static function getPaddings(param1:Boolean, param2:Boolean):PaddingSettings {
        if (param1) {
            if (param2) {
                return PADDINGS_X[WITH_NAME_WITH_TANKNAME_PADDINGS];
            }
            return PADDINGS_X[WITH_NAME_WITHOUT_TANKNAME_PADDINGS];
        }
        if (param2) {
            return PADDINGS_X[WITHOUT_NAME_WITH_TANKNAME_PADDINGS];
        }
        return PADDINGS_X[WITHOUT_NAME_WITHOUT_TANKNAME_PADDINGS];
    }

    public final function dispose():void {
        this._backgrounds = null;
        this._textSettings = null;
    }

    public function get backgrounds():BackgroundAtlasNames {
        return this._backgrounds;
    }

    public function get textSettings():RibbonTextSettings {
        return this._textSettings;
    }

    public function get icon():String {
        return this._icon;
    }

    public function get ribbonText():String {
        return this._ribbonText;
    }

    public function get ribbonType():String {
        return this._ribbonType;
    }
}
}
