package net.wg.gui.lobby.vehicleCustomization.controls {
import flash.display.MovieClip;

import net.wg.data.constants.Values;
import net.wg.data.constants.generated.CUSTOMIZATION_BONUS_ANIMATION_TYPES;
import net.wg.gui.lobby.vehicleCustomization.data.panels.AnimationBonusVO;
import net.wg.infrastructure.interfaces.IMovieClip;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import org.idmedia.as3commons.lang.Exception;

public class AnimatedBonus extends MovieClip implements IDisposable, IMovieClip {

    private static const KEY_NONE:String = "none";

    private static const KEY_SET:String = "set";

    private static const KEY_RESET:String = "reset";

    private static const KEY_DIFF:String = "diff";

    private static const KEY_SUM:String = "sum";

    private static const KEY_INSTALL:String = "install";

    private static const KEY_REINSTALL:String = "reinstall";

    private static const KEY_ADD:String = "add";

    private static const KEY_REMOVE:String = "remove";

    private static const KEY_BUY:String = "buy";

    private static const KEY_TAKE_OFF:String = "takeOff";

    public var bigLabel:LabelBonus = null;

    public var newLabel:LabelBonus = null;

    public var oldLabel:LabelBonus = null;

    public var resultLabel:LabelBonus = null;

    private var _install:Boolean = false;

    private var _primarySlot:String = "";

    private var _additionalSlot:String = "";

    public function AnimatedBonus() {
        super();
    }

    public function dispose():void {
        stop();
        this.bigLabel.dispose();
        this.bigLabel = null;
        this.newLabel.dispose();
        this.newLabel = null;
        this.oldLabel.dispose();
        this.oldLabel = null;
        this.resultLabel.dispose();
        this.resultLabel = null;
    }

    private function buyBonus(param1:String):void {
        this.newLabel.label = this._primarySlot;
        this.oldLabel.label = this.bigLabel.label;
        this.bigLabel.label = param1;
        this.resultLabel.label = param1;
        this._primarySlot = Values.EMPTY_STR;
        this.oldLabel.glowRed();
        this.newLabel.glowGreen();
        this.move(KEY_BUY);
    }

    private function diffBonus(param1:String, param2:String):void {
        this.resultLabel.label = this._primarySlot = param2;
        this.newLabel.label = this._additionalSlot = param1;
        this.resultLabel.glowGreen();
        this.newLabel.glowRed();
        this.move(KEY_DIFF);
    }

    private function installBonus(param1:String):void {
        if (this._install) {
            this.newLabel.label = this._additionalSlot;
            this.oldLabel.label = this._primarySlot;
            this.resultLabel.label = this._primarySlot = param1;
            this._additionalSlot = Values.EMPTY_STR;
            this.newLabel.glowRed();
            this.oldLabel.glowGreen();
            this.resultLabel.glowGreen();
            this.move(KEY_SUM);
        }
        else {
            this.newLabel.label = this.oldLabel.label = this.resultLabel.label = this._primarySlot = param1;
            this.newLabel.glowRed();
            this.oldLabel.glowGreen();
            this.resultLabel.glowGreen();
            this.move(KEY_INSTALL);
        }
    }

    private function reinstallBonus(param1:String):void {
        this.oldLabel.label = this._primarySlot;
        this.newLabel.label = this._primarySlot = param1;
        this.oldLabel.glowGreen();
        this.newLabel.glowGreen();
        this.move(KEY_REINSTALL);
    }

    private function resetBonus(param1:String, param2:String, param3:String):void {
        if (this._install) {
            this.resultLabel.label = this._primarySlot;
            this.oldLabel.label = this._additionalSlot = param2;
            this.newLabel.label = param1;
            this.resultLabel.glowGreen();
            this.oldLabel.glowRed();
            this.newLabel.glowRed();
            this.move(KEY_REMOVE);
        }
        else {
            this.newLabel.label = param1;
            this.resultLabel.label = this._primarySlot = param2;
            this.oldLabel.label = Values.EMPTY_STR;
            this.resultLabel.glowRed();
            this.newLabel.glow(param3);
            this.move(KEY_RESET);
        }
    }

    private function setBonus(param1:String, param2:String):void {
        if (this._install) {
            this.resultLabel.label = this._primarySlot;
            this.oldLabel.label = this._additionalSlot;
            this.newLabel.label = this._additionalSlot = param1;
            this.resultLabel.glowGreen();
            this.oldLabel.glowRed();
            this.newLabel.glowRed();
            this.move(KEY_ADD);
        }
        else {
            this.oldLabel.label = this._primarySlot;
            this.newLabel.label = this._primarySlot = param1;
            this.resultLabel.label = Values.EMPTY_STR;
            this.oldLabel.glow(param2);
            this.newLabel.glow(param2);
            this.move(KEY_SET);
        }
    }

    private function setDefault(param1:String, param2:String):void {
        this.bigLabel.glowWhite();
        this.bigLabel.label = param1;
        this.newLabel.label = this._primarySlot = param2;
        this.resultLabel.label = Values.EMPTY_STR;
        this.oldLabel.label = Values.EMPTY_STR;
        this.move(KEY_NONE);
    }

    private function takeOffBonus(param1:String, param2:String):void {
        this.oldLabel.label = this._primarySlot;
        this.newLabel.label = param1;
        this.resultLabel.label = this.bigLabel.label;
        this.bigLabel.label = param2;
        this.newLabel.glowGreen();
        this.oldLabel.glowGreen();
        this.resultLabel.glowWhite();
        this.move(KEY_TAKE_OFF);
    }

    private function uninstallBonus(param1:String):void {
        this.newLabel.label = this.oldLabel.label = this.resultLabel.label = this._primarySlot = param1;
        this.newLabel.glowGreen();
        this.oldLabel.glowRed();
        this.resultLabel.glowRed();
        this.move(KEY_INSTALL);
    }

    private function move(param1:String):void {
        stop();
        gotoAndPlay(param1);
    }

    public function set data(param1:AnimationBonusVO):void {
        this._install = param1.install;
        switch (param1.animationType) {
            case CUSTOMIZATION_BONUS_ANIMATION_TYPES.NONE:
                this.setDefault(param1.value1, param1.value2);
                break;
            case CUSTOMIZATION_BONUS_ANIMATION_TYPES.SET:
                this.setBonus(param1.value1, param1.color);
                break;
            case CUSTOMIZATION_BONUS_ANIMATION_TYPES.RESET:
                this.resetBonus(param1.value1, param1.value2, param1.color);
                break;
            case CUSTOMIZATION_BONUS_ANIMATION_TYPES.DIFF:
                this.diffBonus(param1.value1, param1.value2);
                break;
            case CUSTOMIZATION_BONUS_ANIMATION_TYPES.INSTALL:
                this.installBonus(param1.value1);
                break;
            case CUSTOMIZATION_BONUS_ANIMATION_TYPES.REINSTALL:
                this.reinstallBonus(param1.value1);
                break;
            case CUSTOMIZATION_BONUS_ANIMATION_TYPES.UNINSTALL:
                this.uninstallBonus(param1.value1);
                break;
            case CUSTOMIZATION_BONUS_ANIMATION_TYPES.BUY:
                this.buyBonus(param1.value1);
                break;
            case CUSTOMIZATION_BONUS_ANIMATION_TYPES.TAKE_OFF:
                this.takeOffBonus(param1.value1, param1.value2);
                break;
            default:
                DebugUtils.LOG_ERROR(new Exception("Invalid animationType").getStackTrace());
        }
    }
}
}
