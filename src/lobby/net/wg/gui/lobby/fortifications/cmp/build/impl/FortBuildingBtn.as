package net.wg.gui.lobby.fortifications.cmp.build.impl {
import flash.display.MovieClip;
import flash.events.Event;
import flash.geom.Rectangle;

import net.wg.gui.lobby.fortifications.cmp.base.impl.FortBuildingBase;
import net.wg.gui.lobby.fortifications.cmp.build.IBuildingTexture;

public class FortBuildingBtn extends FortBuildingBase {

    private static const START_ANIMATION:String = "startAnimation";

    public var building:IBuildingTexture;

    public var blendingEffect:IBuildingTexture;

    public var blinkingButton:BuildingBlinkingBtn;

    private var _isInOverviewMode:Boolean = false;

    private var _levelUp:Boolean = false;

    private var _currentState:String = "";

    public function FortBuildingBtn() {
        super();
        this.blinkingButton.gotoAndStop(0);
        this.blinkingButton.alpha = 0;
        this.blinkingButton.visible = false;
        this.setLevelUpState(false);
        this.building.addEventListener(Event.COMPLETE, this.onBuildingCompleteHandler);
    }

    override public function dispose():void {
        this.building.removeEventListener(Event.COMPLETE, this.onBuildingCompleteHandler);
        this.building.dispose();
        this.building = null;
        this.blendingEffect.dispose();
        this.blendingEffect = null;
        this.blinkingButton.dispose();
        this.blinkingButton = null;
        super.dispose();
    }

    public function currentState():String {
        return this._currentState;
    }

    public function getAlpha(param1:Boolean):int {
        return !!param1 ? 1 : 0;
    }

    public function getBuildingShape():MovieClip {
        return this.building.getBuildingShape();
    }

    public function handleMousePress():void {
        this.setLevelUpState(false);
        App.contextMenuMgr.hide();
    }

    public function setBuildingShapeBounds(param1:Rectangle):void {
        this.building.setBuildingShapeBounds(param1);
    }

    public function setCurrentState(param1:String):void {
        this.updateStates(param1);
    }

    public function setIconOffsets(param1:Number, param2:Number):void {
        this.building.setIconOffsets(param1, param2);
        this.blendingEffect.setIconOffsets(param1, param2);
        this.blinkingButton.setIconOffsets(param1, param2);
    }

    public function setLevelUpState(param1:Boolean):void {
        if (this._levelUp == param1) {
            return;
        }
        this._levelUp = param1;
        this.building.alpha = this.getAlpha(!param1);
        if (param1 && !this.blinkingButton.visible) {
            this.blinkingButton.visible = true;
        }
        this.blinkingButton.alpha = this.getAlpha(param1);
        if (param1) {
            this.blinkingButton.gotoAndPlay(START_ANIMATION);
        }
        else {
            this.blinkingButton.gotoAndStop(0);
        }
    }

    private function updateStates(param1:String):void {
        if (this._currentState == param1) {
            return;
        }
        this._currentState = param1;
        this.building.setState(param1);
        if (!this._isInOverviewMode) {
            this.blendingEffect.setState(param1);
            this.blinkingButton.setState(param1);
        }
    }

    public function set isInOverviewMode(param1:Boolean):void {
        if (param1) {
            this._isInOverviewMode = param1;
            this.blendingEffect.visible = false;
            this.blinkingButton.visible = false;
        }
    }

    private function onBuildingCompleteHandler(param1:Event):void {
        dispatchEvent(new Event(Event.COMPLETE));
    }
}
}
