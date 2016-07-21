package net.wg.gui.lobby.fortifications.cmp.build.impl {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
import net.wg.gui.fortBase.IBuildingVO;
import net.wg.gui.lobby.fortifications.popovers.impl.PopoverBuildingTexture;
import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.utils.ITweenAnimator;

public class BuildingThumbnail extends MovieClip implements IDisposable {

    private static const BUILDING_ALPHA_NORMAL:Number = 1;

    private static const BUILDING_ALPHA_DISABLED:Number = 0.5;

    public var buildingMC:PopoverBuildingTexture = null;

    public var levelMC:MovieClip = null;

    public var smoke:Sprite = null;

    private var _ttHeader:String;

    private var _ttBody:String;

    private var _disableLowLevel:Boolean = false;

    private var _model:IBuildingVO;

    private var _alwaysShowLvl:Boolean = false;

    private var _animator:ITweenAnimator;

    public function BuildingThumbnail() {
        super();
        this._animator = App.utils.tweenAnimator;
        this.init();
    }

    private static function onRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    public function dispose():void {
        removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
        this._animator.removeAnims(this.levelMC);
        this.buildingMC.dispose();
        this.buildingMC = null;
        this.levelMC = null;
        this.smoke = null;
        this._model = null;
        this._animator = null;
    }

    private function init():void {
        this.levelMC.alpha = 0;
        this.levelMC.visible = false;
        this.showSmoke = false;
        addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
    }

    private function updateView():void {
        if (this._model) {
            this.levelMC.gotoAndStop(this._model.buildingLevel);
            if (this._model.isInFoundationState) {
                this.buildingMC.setState(RES_FORT.MAPS_FORT_BUILDINGS_SMALL_FOUNDATION_STATE);
            }
            else {
                this.buildingMC.setState(this._model.iconSource);
            }
            if (this._disableLowLevel && this.model.buildingLevel < FORTIFICATION_ALIASES.CLAN_BATTLE_BUILDING_MIN_LEVEL || !this.model.isAvailable) {
                this.buildingMC.alpha = BUILDING_ALPHA_DISABLED;
            }
            else {
                this.buildingMC.alpha = BUILDING_ALPHA_NORMAL;
            }
            this.showSmoke = this._model.looted;
        }
    }

    public function set showLevel(param1:Boolean):void {
        if (param1) {
            if (stage && !this.alwaysShowLvl) {
                this._animator.removeAnims(this.levelMC);
                this._animator.addFadeInAnim(this.levelMC, null);
            }
            else {
                this.levelMC.visible = true;
                this.levelMC.alpha = 1;
            }
        }
        else if (stage) {
            this._animator.removeAnims(this.levelMC);
            this._animator.addFadeOutAnim(this.levelMC, null);
        }
        else {
            this.levelMC.alpha = 0;
            this.levelMC.visible = false;
        }
    }

    public function set disableLowLevel(param1:Boolean):void {
        this._disableLowLevel = param1;
        this.updateView();
    }

    public function set showSmoke(param1:Boolean):void {
        this.smoke.visible = param1;
    }

    public function get model():IBuildingVO {
        return this._model;
    }

    public function set model(param1:IBuildingVO):void {
        this._model = param1;
        if (this._model && this._model.toolTipData && this._model.toolTipData.length > 0) {
            this._ttHeader = this._model.toolTipData[0];
            this._ttBody = this._model.toolTipData.length > 1 ? this._model.toolTipData[1] : null;
        }
        else {
            this._ttHeader = null;
            this._ttBody = null;
        }
        this.updateView();
    }

    public function get alwaysShowLvl():Boolean {
        return this._alwaysShowLvl;
    }

    public function set alwaysShowLvl(param1:Boolean):void {
        this._alwaysShowLvl = param1;
    }

    private function onRollOverHandler(param1:MouseEvent):void {
        var _loc2_:String = App.toolTipMgr.getNewFormatter().addHeader(this._ttHeader).addBody(this._ttBody).make();
        if (_loc2_.length > 0) {
            App.toolTipMgr.showComplex(_loc2_);
        }
    }
}
}
