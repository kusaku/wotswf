package net.wg.gui.battle.views.ribbonsPanel.data {
public class RibbonTextSettings {

    private static const GREEN_RIBBON_NAME_TEXT_COLOR:int = 16317658;

    private static const GREEN_VALUE_TEXT_COLOR:int = 16317658;

    private static const GREEN_SHADOW_COLOR:int = 4289280;

    private static const GREY_VALUE_TEXT_COLOR:int = 16777215;

    private static const GREY_RIBBON_NAME_TEXT_COLOR:int = 16777215;

    private static const GREY_SHADOW_COLOR:int = 0;

    public static const SHADOW_BLUR:Number = 5;

    public static const SHADOW_STRENGTH:Number = 1.5;

    public static const SHADOW_ALPHA:Number = 1;

    public static const SHADOW_DISTANCE:Number = 0;

    public static const GREY:String = "grey";

    public static const GREEN:String = "green";

    private var _ribbonNameTextColor:uint = 0;

    private var _valueTextColor:uint = 0;

    private var _shadowColor:uint = 0;

    public function RibbonTextSettings(param1:String) {
        super();
        switch (param1) {
            case GREY:
                this._valueTextColor = GREY_VALUE_TEXT_COLOR;
                this._shadowColor = GREY_SHADOW_COLOR;
                this._ribbonNameTextColor = GREY_RIBBON_NAME_TEXT_COLOR;
                break;
            case GREEN:
                this._valueTextColor = GREEN_VALUE_TEXT_COLOR;
                this._shadowColor = GREEN_SHADOW_COLOR;
                this._ribbonNameTextColor = GREEN_RIBBON_NAME_TEXT_COLOR;
                break;
            default:
                App.utils.asserter.assert(false, "No such rendererType: " + param1);
        }
    }

    public function get valueTextColor():uint {
        return this._valueTextColor;
    }

    public function get shadowColor():uint {
        return this._shadowColor;
    }

    public function get ribbonNameTextColor():uint {
        return this._ribbonNameTextColor;
    }
}
}
