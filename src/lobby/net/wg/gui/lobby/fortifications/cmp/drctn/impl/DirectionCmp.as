package net.wg.gui.lobby.fortifications.cmp.drctn.impl {
import flash.display.BlendMode;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

import net.wg.gui.lobby.fortifications.cmp.build.impl.BuildingThumbnail;
import net.wg.gui.lobby.fortifications.cmp.drctn.IDirectionCmp;
import net.wg.gui.lobby.fortifications.data.BuildingVO;
import net.wg.gui.lobby.fortifications.data.DirectionVO;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.utils.ITweenAnimator;

import scaleform.clik.constants.InvalidationType;

public class DirectionCmp extends UIComponentEx implements IDirectionCmp {

    public static const ANIMATION_ATTACK:String = "animationAttack";

    public static const ANIMATION_HIGHLIGHT:String = "animationHighlight";

    public static const LAYOUT_LEFT_RIGHT:String = "left-right";

    public static const LAYOUT_RIGHT_LEFT:String = "right-left";

    private static const INVALID_BUILDING_RENDERER:String = "invalidBuildingRenderer";

    private static const INVALID_LAYOUT:String = "invalidLayout";

    private static const LABEL_POS_X_LR:Number = 28;

    private static const LABEL_POS_X_RL:Number = 29;

    private static const BASE_POS_X_LR:Number = 0;

    private static const BASE_POS_X_RL:Number = 200;

    private static const BASE_OFFSET:Number = 10;

    private static const BUILDINGS_GAP:Number = 10;

    private static const BUILDING_WIDTH:Number = 60;

    private static const ARROW_DEFENCE:String = "defence";

    private static const ARROW_OFFENCE:String = "offence";

    public var mouseArea:Sprite;

    public var roadPic:Sprite;

    public var labelTF:TextField;

    public var notOpenedTF:TextField;

    public var infoTF:TextField;

    public var attackAnimationMC:MovieClip;

    public var highlightMC:MovieClip;

    public var buildingsContainer:Sprite;

    public var baseBuilding:BuildingThumbnail;

    public var battleArrow:BuildingAttackIndicator;

    private var _model:DirectionVO;

    private var _isInHoverState:Boolean = false;

    private var _buildingRenderer:String = "BuildingThumbnailUI";

    private var _hoverAnimation:String = null;

    private var _showLevelsOnHover:Boolean = false;

    private var _alwaysShowLevels:Boolean = false;

    private var _disableLowLevelBuildings:Boolean = false;

    private var _layout:String = "left-right";

    private var _solidMode:Boolean = false;

    private var _labelVisible:Boolean = false;

    private var _label:String = "";

    public function DirectionCmp() {
        super();
        this.attackAnimationMC.blendMode = BlendMode.ADD;
        this.hideAnimations();
        this.baseBuilding.visible = false;
        this.battleArrow.visible = false;
        this.labelTF.visible = this._labelVisible;
        this.mouseArea.visible = this._solidMode;
    }

    override protected function configUI():void {
        super.configUI();
        this.notOpenedTF.htmlText = FORTIFICATIONS.GENERAL_DIRECTION_NOTOPENED;
        this.mouseArea.addEventListener(MouseEvent.ROLL_OVER, this.onMouseAreaRollOverHandler);
        this.mouseArea.addEventListener(MouseEvent.ROLL_OUT, this.onMouseAreaRollOutHandler);
    }

    override protected function onDispose():void {
        this.mouseArea.removeEventListener(MouseEvent.ROLL_OVER, this.onMouseAreaRollOverHandler);
        this.mouseArea.removeEventListener(MouseEvent.ROLL_OUT, this.onMouseAreaRollOutHandler);
        this.baseBuilding.dispose();
        this.baseBuilding = null;
        this.battleArrow.dispose();
        this.battleArrow = null;
        this.clearBuildings();
        var _loc1_:ITweenAnimator = App.utils.tweenAnimator;
        _loc1_.removeAnims(this.attackAnimationMC);
        _loc1_.removeAnims(this.highlightMC);
        this.buildingsContainer = null;
        this.highlightMC = null;
        this.attackAnimationMC = null;
        this.labelTF = null;
        this.notOpenedTF = null;
        this.infoTF = null;
        this.mouseArea = null;
        this.roadPic = null;
        this._model = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA, INVALID_BUILDING_RENDERER)) {
            if (this._model) {
                if (this._model.isOpened) {
                    if (this._model.isAvailable) {
                        this.setControlsVisible(true);
                        this.updateBaseBuilding();
                        this.redrawBuildings();
                        this.infoTF.visible = false;
                        this.notOpenedTF.visible = false;
                    }
                    else if (this._model.infoMessage) {
                        this.setControlsVisible(false);
                        this.infoTF.htmlText = this._model.infoMessage;
                        this.infoTF.visible = true;
                    }
                    else {
                        this.setControlsVisible(true);
                        this.updateBaseBuilding();
                        this.redrawBuildings();
                        this.infoTF.visible = false;
                        this.notOpenedTF.visible = false;
                    }
                    if (this._isInHoverState) {
                        this.showHideHowerState(true, true);
                    }
                }
                else {
                    this.setControlsVisible(false);
                    this.notOpenedTF.visible = true;
                    if (this._isInHoverState) {
                        this.showHideHowerState(false, true);
                    }
                }
                this.label = this._model.name;
                this.labelTF.visible = this._labelVisible;
                this.battleArrow.setTooltipData(this._model.buildingIndicatorTTHeader, this._model.buildingIndicatorTTBody);
            }
            else {
                this.setControlsVisible(false);
            }
        }
        if (isInvalid(InvalidationType.DATA, INVALID_LAYOUT)) {
            this.updateLayout();
            this.updateBattleArrow();
        }
        if (this._model && isInvalid(InvalidationType.SETTINGS)) {
            this.updateLevelsShowing();
        }
    }

    public function setData(param1:DirectionVO):void {
        this._model = param1;
        invalidateData();
    }

    public function showHideHowerState(param1:Boolean, param2:Boolean = false):void {
        var _loc4_:String = null;
        this._isInHoverState = param1;
        var _loc3_:ITweenAnimator = App.utils.tweenAnimator;
        _loc3_.removeAnims(this.attackAnimationMC);
        _loc3_.removeAnims(this.highlightMC);
        if (this._hoverAnimation == ANIMATION_ATTACK) {
            if (param1) {
                _loc3_.addFadeInAnim(this.attackAnimationMC, null);
                this.attackAnimationMC.gotoAndPlay(0);
            }
            else {
                _loc3_.addFadeOutAnim(this.attackAnimationMC, null);
            }
        }
        else if (this._hoverAnimation == ANIMATION_HIGHLIGHT) {
            if (param1) {
                _loc3_.addFadeInAnim(this.highlightMC, null);
            }
            else {
                _loc3_.addFadeOutAnim(this.highlightMC, null);
            }
        }
        this.updateLevelsShowing();
        if (param2 && this._model) {
            if (param1) {
                _loc4_ = App.toolTipMgr.getNewFormatter().addHeader(this._model.ttHeader).addBody(this._model.ttBody).make();
                if (_loc4_.length > 0) {
                    App.toolTipMgr.showComplex(_loc4_);
                }
            }
            else {
                App.toolTipMgr.hide();
            }
        }
    }

    private function setControlsVisible(param1:Boolean):void {
        this.buildingsContainer.visible = param1;
        this.baseBuilding.visible = param1;
        this.roadPic.visible = param1;
        this.labelTF.visible = param1;
        this.notOpenedTF.visible = param1;
        this.infoTF.visible = param1;
        this.battleArrow.visible = param1;
    }

    private function updateBaseBuilding():void {
        if (this._model && this._model.baseBuilding) {
            this.baseBuilding.model = this._model.baseBuilding;
            this.baseBuilding.visible = true;
        }
        else {
            this.baseBuilding.visible = false;
        }
    }

    private function redrawBuildings():void {
        var _loc1_:BuildingThumbnail = null;
        var _loc2_:Class = null;
        var _loc3_:uint = 0;
        var _loc4_:BuildingVO = null;
        var _loc5_:Number = NaN;
        var _loc6_:Number = NaN;
        var _loc7_:int = 0;
        this.clearBuildings();
        if (this._model && this._model.hasBuildings) {
            _loc2_ = App.utils.classFactory.getClass(this._buildingRenderer);
            _loc3_ = this._model.buildings.length;
            if (this._layout == LAYOUT_LEFT_RIGHT) {
                _loc5_ = 0;
                _loc6_ = Number(BUILDING_WIDTH + BUILDINGS_GAP);
            }
            else if (this._layout == LAYOUT_RIGHT_LEFT) {
                _loc5_ = -BUILDING_WIDTH;
                _loc6_ = -(BUILDING_WIDTH + BUILDINGS_GAP);
            }
            _loc7_ = 0;
            while (_loc7_ < _loc3_) {
                _loc1_ = App.utils.classFactory.getComponent(this._buildingRenderer, _loc2_);
                _loc4_ = this._model.buildings[_loc7_];
                if (_loc4_) {
                    _loc1_.model = _loc4_;
                    _loc1_.x = _loc5_;
                    this.buildingsContainer.addChild(_loc1_);
                }
                _loc5_ = _loc5_ + _loc6_;
                _loc7_++;
            }
        }
        this.updateLevelsShowing();
        this.updateBuildingsDisabling();
    }

    private function clearBuildings():void {
        var _loc1_:BuildingThumbnail = null;
        while (this.buildingsContainer.numChildren) {
            _loc1_ = BuildingThumbnail(this.buildingsContainer.getChildAt(0));
            this.buildingsContainer.removeChild(_loc1_);
            _loc1_.dispose();
        }
    }

    private function updateLayout():void {
        if (this._layout == LAYOUT_LEFT_RIGHT) {
            this.labelTF.x = LABEL_POS_X_LR;
            this.baseBuilding.x = BASE_POS_X_LR;
            this.buildingsContainer.x = this.baseBuilding.x + BUILDING_WIDTH + BASE_OFFSET;
            this.battleArrow.gotoAndStop(ARROW_DEFENCE);
        }
        else if (this._layout == LAYOUT_RIGHT_LEFT) {
            this.labelTF.x = LABEL_POS_X_RL;
            this.baseBuilding.x = BASE_POS_X_RL;
            this.buildingsContainer.x = this.baseBuilding.x - BASE_OFFSET;
            this.battleArrow.gotoAndStop(ARROW_OFFENCE);
        }
    }

    private function updateBattleArrow():void {
        var _loc2_:BuildingThumbnail = null;
        var _loc3_:BuildingThumbnail = null;
        var _loc4_:int = 0;
        var _loc5_:uint = 0;
        this.battleArrow.visible = false;
        var _loc1_:String = !!this._model ? this._model.getBuildingUnderAttack() : null;
        if (_loc1_) {
            if (this.baseBuilding.model && this.baseBuilding.model.uid == _loc1_) {
                _loc2_ = this.baseBuilding;
            }
            else {
                _loc4_ = this.buildingsContainer.numChildren;
                _loc5_ = 0;
                while (_loc5_ < _loc4_) {
                    _loc3_ = BuildingThumbnail(this.buildingsContainer.getChildAt(_loc5_));
                    if (_loc3_.model && _loc3_.model.uid == _loc1_) {
                        _loc2_ = _loc3_;
                        break;
                    }
                    _loc5_++;
                }
            }
        }
        if (_loc2_) {
            if (this._model.revertArrowDirection) {
                this.battleArrow.gotoAndStop(this.battleArrow.currentFrameLabel == ARROW_OFFENCE ? ARROW_DEFENCE : ARROW_OFFENCE);
            }
            this.battleArrow.x = globalToLocal(_loc2_.localToGlobal(new Point(0, 0))).x;
            this.battleArrow.visible = true;
        }
    }

    private function updateLevelsShowing():void {
        if (this._alwaysShowLevels) {
            this.showHideBuildingsLevel(true);
        }
        else if (this._showLevelsOnHover && this._isInHoverState) {
            this.showHideBuildingsLevel(true);
        }
        else {
            this.showHideBuildingsLevel(false);
        }
    }

    private function showHideBuildingsLevel(param1:Boolean):void {
        var _loc2_:BuildingThumbnail = null;
        var _loc3_:int = this.buildingsContainer.numChildren;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            _loc2_ = BuildingThumbnail(this.buildingsContainer.getChildAt(_loc4_));
            _loc2_.alwaysShowLvl = this.alwaysShowLevels;
            _loc2_.showLevel = param1;
            _loc4_++;
        }
        this.baseBuilding.alwaysShowLvl = this.alwaysShowLevels;
        this.baseBuilding.showLevel = param1;
    }

    private function updateBuildingsDisabling():void {
        var _loc1_:BuildingThumbnail = null;
        var _loc2_:int = this.buildingsContainer.numChildren;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _loc1_ = BuildingThumbnail(this.buildingsContainer.getChildAt(_loc3_));
            _loc1_.disableLowLevel = this._disableLowLevelBuildings;
            _loc3_++;
        }
        this.baseBuilding.disableLowLevel = this._disableLowLevelBuildings;
    }

    private function hideAnimations():void {
        this.attackAnimationMC.alpha = 0;
        this.attackAnimationMC.visible = false;
        this.highlightMC.alpha = 0;
        this.highlightMC.visible = false;
    }

    public function get buildingRenderer():String {
        return this._buildingRenderer;
    }

    public function set buildingRenderer(param1:String):void {
        this._buildingRenderer = param1;
        invalidate(INVALID_BUILDING_RENDERER);
    }

    public function get hoverAnimation():String {
        return this._hoverAnimation;
    }

    public function set hoverAnimation(param1:String):void {
        this._hoverAnimation = param1;
        if (this._isInHoverState && !this._hoverAnimation) {
            this.hideAnimations();
        }
    }

    public function get showLevelsOnHover():Boolean {
        return this._showLevelsOnHover;
    }

    public function set showLevelsOnHover(param1:Boolean):void {
        this._showLevelsOnHover = param1;
        this.updateLevelsShowing();
    }

    public function get alwaysShowLevels():Boolean {
        return this._alwaysShowLevels;
    }

    public function set alwaysShowLevels(param1:Boolean):void {
        this._alwaysShowLevels = param1;
        invalidate(InvalidationType.SETTINGS);
    }

    public function get disableLowLevelBuildings():Boolean {
        return this._disableLowLevelBuildings;
    }

    public function set disableLowLevelBuildings(param1:Boolean):void {
        this._disableLowLevelBuildings = param1;
        this.updateBuildingsDisabling();
    }

    public function get layout():String {
        return this._layout;
    }

    public function set layout(param1:String):void {
        this._layout = param1;
        invalidate(INVALID_LAYOUT);
    }

    public function get solidMode():Boolean {
        return this._solidMode;
    }

    public function set solidMode(param1:Boolean):void {
        this._solidMode = param1;
        this.mouseArea.visible = this._solidMode;
        this.mouseArea.useHandCursor = this.mouseArea.buttonMode = this._solidMode;
    }

    public function get labelVisible():Boolean {
        return this._labelVisible;
    }

    public function set labelVisible(param1:Boolean):void {
        this._labelVisible = param1;
        this.labelTF.visible = this._labelVisible;
    }

    public function get label():String {
        return this._label;
    }

    public function set label(param1:String):void {
        this._label = param1;
        this.labelTF.htmlText = this._label;
    }

    private function onMouseAreaRollOverHandler(param1:MouseEvent):void {
        this.showHideHowerState(true, true);
    }

    private function onMouseAreaRollOutHandler(param1:MouseEvent):void {
        this.showHideHowerState(false, true);
    }
}
}
