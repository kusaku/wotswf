package net.wg.gui.battle.views.ribbonsPanel.data {
import net.wg.data.constants.BattleAtlasItem;
import net.wg.data.constants.generated.BATTLE_EFFICIENCY_TYPES;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class RibbonSettings implements IDisposable {

    private static const RIBBONS_TYPES:Vector.<String> = new <String>[BATTLE_EFFICIENCY_TYPES.ARMOR, BATTLE_EFFICIENCY_TYPES.DAMAGE, BATTLE_EFFICIENCY_TYPES.RAM, BATTLE_EFFICIENCY_TYPES.BURN, BATTLE_EFFICIENCY_TYPES.DESTRUCTION, BATTLE_EFFICIENCY_TYPES.TEAM_DESTRUCTION, BATTLE_EFFICIENCY_TYPES.DETECTION, BATTLE_EFFICIENCY_TYPES.ASSIST_TRACK, BATTLE_EFFICIENCY_TYPES.ASSIST_SPOT, BATTLE_EFFICIENCY_TYPES.CRITS, BATTLE_EFFICIENCY_TYPES.CAPTURE, BATTLE_EFFICIENCY_TYPES.DEFENCE, BATTLE_EFFICIENCY_TYPES.ASSIST];

    private static const BACKGROUNDS:Object = {
        "green": new BackgroundAtlasNames(BackgroundAtlasNames.GREEN),
        "grey": new BackgroundAtlasNames(BackgroundAtlasNames.GREY)
    };

    private static const TEXT_SETTINGS:Object = {
        "green": new RibbonTextSettings(RibbonTextSettings.GREEN),
        "grey": new RibbonTextSettings(RibbonTextSettings.GREY)
    };

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
    }

    public static function isAvailableRibbonType(param1:String):Boolean {
        return RIBBONS_TYPES.indexOf(param1) >= 0;
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
