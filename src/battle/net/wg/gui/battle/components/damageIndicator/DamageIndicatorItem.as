package net.wg.gui.battle.components.damageIndicator {
import flash.display.Sprite;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class DamageIndicatorItem extends Sprite implements IDisposable {

    private static const SHOW_WITHOUT_ANIMATION_FRAME:int = 11;

    public var standardAnimation:AnimationContainer = null;

    public var extendedAnimation:AnimationContainer = null;

    private var _isStandard:Boolean = false;

    private var _standardStateContainer:StandardStateContainer = null;

    private var _extendedStateContainer:ExtendedStateContainer = null;

    private var _settingIsWithAnimation:Boolean = true;

    private var _yawDegrees:Number = 0;

    public function DamageIndicatorItem() {
        super();
        visible = false;
        this._standardStateContainer = this.standardAnimation.stateContainer;
        this._extendedStateContainer = ExtendedStateContainer(this.extendedAnimation.stateContainer);
    }

    public function dispose():void {
        this._standardStateContainer = null;
        this._extendedStateContainer = null;
        this.standardAnimation.dispose();
        this.standardAnimation = null;
        this.extendedAnimation.dispose();
        this.extendedAnimation = null;
    }

    public function hide():void {
        visible = false;
    }

    public function init():void {
        this._standardStateContainer.init();
        this._extendedStateContainer.init();
    }

    public function setYaw(param1:Number):void {
        this._yawDegrees = param1 * 180 / Math.PI;
        if (this._isStandard) {
            this.standardAnimation.rotation = this._yawDegrees;
        }
        else {
            this.extendedAnimation.rotation = this._yawDegrees;
        }
    }

    public function showExtended(param1:String, param2:String, param3:int, param4:String, param5:String, param6:String):void {
        visible = true;
        this.extendedAnimation.visible = true;
        if (!this._settingIsWithAnimation && param3 < SHOW_WITHOUT_ANIMATION_FRAME) {
            this.extendedAnimation.gotoAndPlay(SHOW_WITHOUT_ANIMATION_FRAME);
        }
        else {
            this.extendedAnimation.gotoAndPlay(param3);
        }
        this._extendedStateContainer.setExtendedData(param1, param2, param4, param5, param6);
    }

    public function showStandard(param1:String, param2:int):void {
        visible = true;
        this.standardAnimation.visible = true;
        this.standardAnimation.gotoAndPlay(param2);
        this._standardStateContainer.updateBGState(param1);
    }

    public function updateSettings(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean):void {
        this._settingIsWithAnimation = param3;
        if (this._isStandard == param1) {
            this.standardAnimation.rotation = this._yawDegrees;
        }
        else {
            this.extendedAnimation.rotation = this._yawDegrees;
            this._isStandard = param1;
            this.standardAnimation.visible = this._isStandard;
            this.extendedAnimation.visible = !this._isStandard;
        }
        this._extendedStateContainer.updateSettings(param2, param4);
    }
}
}
