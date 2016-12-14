package net.wg.gui.battle.views.ribbonsPanel {
import flash.display.FrameLabel;
import flash.text.TextField;

import net.wg.data.constants.Linkages;
import net.wg.gui.battle.views.ribbonsPanel.data.RibbonAnimationStates;
import net.wg.gui.battle.views.ribbonsPanel.data.RibbonSettings;
import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.utils.IClassFactory;
import net.wg.utils.IScheduler;

public class RibbonCtrl implements IDisposable {

    public static const SHOW_ANIM:String = "show";

    public static const SHOW_MST_ANIM:String = "showMST";

    public static const HIDE_LEFT_ANIM:String = "hideLeft";

    public static const HIDE_BOTTOM_ANIM:String = "hideBottom";

    public static const DEFAULT_STATE:String = "default";

    private static const SHIFT_ANIM:String = "shiftPosition";

    public static const ITEM_HEIGHT:int = 30;

    private static const LIFE_TIME:int = 3000;

    private static const ANIM_DELAY_BY_ITEM:int = 80;

    private static const FRAME_SHIFT:int = 2;

    public static const CALLBACK_TYPE_SHOW_FINISHED:String = "showFinished";

    public static const CALLBACK_TYPE_HIDE_FINISHED:String = "hideFinished";

    public static const CALLBACK_LIFETIME_COOLDOWN:String = "hideInProgress";

    public var iconsAnim:AnimationSet = null;

    public var textsAnim:AnimationSet = null;

    public var ribbonType:String;

    public var animationState:String = "invisible";

    private var _icons:RibbonIcons = null;

    private var _texts:RibbonTexts = null;

    private var _idx:int = 0;

    private var _animationCompleteCallback:Function;

    private var _isExtendedAnim:Boolean = false;

    private var _showLbl:String = "";

    private var _showLastFrameIdx:int = 0;

    private var _showMSTLastFrameIdx:int = 0;

    private var _hideLeftLastFrameIdx:int = 0;

    private var _hideBottomLastFrameIdx:int = 0;

    private var _shiftLastFrameIdx:int = 0;

    private var _scheduler:IScheduler = null;

    private var _isMustBeHided:Boolean = false;

    public function RibbonCtrl(param1:RibbonSettings, param2:Function, param3:Boolean) {
        super();
        this._scheduler = App.utils.scheduler;
        this._isExtendedAnim = param3;
        this.ribbonType = param1.ribbonType;
        var _loc4_:IClassFactory = App.utils.classFactory;
        var _loc5_:Class = _loc4_.getClass(Linkages.RIBBONS_ANIMATION_SET);
        this.iconsAnim = new _loc5_();
        this.textsAnim = new _loc5_();
        this.checkAnimSetFrameIdxs(this.iconsAnim);
        this._icons = _loc4_.getComponent(Linkages.RIBBON_ICONS, RibbonIcons);
        this._texts = _loc4_.getComponent(Linkages.RIBBON_TEXT, RibbonTexts);
        this.textsAnim.init(this._texts);
        this.iconsAnim.init(this._icons);
        this._texts.init(param1);
        var _loc6_:TextField = this._texts.ribbonNameTF;
        this._icons.init(param1, _loc6_.x + _loc6_.textWidth);
        this.iconsAnim.addFrameScript(this._hideLeftLastFrameIdx, this.onHideAnimCompleteFrameHandler);
        this.iconsAnim.addFrameScript(this._hideBottomLastFrameIdx, this.onHideAnimCompleteFrameHandler);
        this.iconsAnim.addFrameScript(this._shiftLastFrameIdx, this.onShiftPositionAnimCompleteFrameHandler);
        this.iconsAnim.addFrameScript(this._showLastFrameIdx, this.onShowAnimCompleteFrameHandler);
        this.iconsAnim.addFrameScript(this._showMSTLastFrameIdx, this.onShowAnimCompleteFrameHandler);
        this.iconsAnim.visible = false;
        this.iconsAnim.stop();
        this.textsAnim.visible = false;
        this.textsAnim.stop();
        this._animationCompleteCallback = param2;
    }

    private function checkAnimSetFrameIdxs(param1:AnimationSet):void {
        var _loc3_:FrameLabel = null;
        var _loc4_:FrameLabel = null;
        var _loc2_:Array = param1.currentLabels;
        var _loc5_:int = _loc2_.length;
        var _loc6_:int = 0;
        while (_loc6_ < _loc5_) {
            if (_loc6_ < _loc5_ - 1) {
                _loc3_ = _loc2_[_loc6_];
                _loc4_ = _loc2_[_loc6_ + 1];
                switch (_loc3_.name) {
                    case SHOW_ANIM:
                        this._showLastFrameIdx = _loc4_.frame - FRAME_SHIFT;
                        break;
                    case SHOW_MST_ANIM:
                        this._showMSTLastFrameIdx = _loc4_.frame - FRAME_SHIFT;
                        break;
                    case HIDE_LEFT_ANIM:
                        this._hideLeftLastFrameIdx = _loc4_.frame - FRAME_SHIFT;
                        break;
                    case HIDE_BOTTOM_ANIM:
                        this._hideBottomLastFrameIdx = _loc4_.frame - FRAME_SHIFT;
                        break;
                    case SHIFT_ANIM:
                        this._shiftLastFrameIdx = _loc4_.frame - FRAME_SHIFT;
                }
            }
            _loc6_++;
        }
    }

    public final function dispose():void {
        this._scheduler.cancelTask(this.shiftItems);
        this._scheduler.cancelTask(this.onLifetimeCooldown);
        this._scheduler.cancelTask(this.showAnimByScheduler);
        this._scheduler = null;
        this.iconsAnim.dispose();
        this.iconsAnim = null;
        this.textsAnim.dispose();
        this.textsAnim = null;
        this._icons.dispose();
        this._icons = null;
        this._texts.dispose();
        this._texts = null;
        this._animationCompleteCallback = null;
    }

    private function onLifetimeCooldown():void {
        this._animationCompleteCallback(CALLBACK_LIFETIME_COOLDOWN, this.ribbonType);
    }

    public function hideByOrder(param1:int):void {
        var _loc2_:int = param1 * ANIM_DELAY_BY_ITEM;
        if (_loc2_ > 0) {
            this._scheduler.scheduleTask(this.onHideItemInLeft, _loc2_);
        }
        else {
            this.onHideItemInLeft();
        }
    }

    private function onHideItemInLeft():void {
        this._scheduler.cancelTask(this.shiftItems);
        this._scheduler.cancelTask(this.onLifetimeCooldown);
        this.animationState = RibbonAnimationStates.HIDE_IN_PROGRESS;
        if (this.animationState == RibbonAnimationStates.SHIFT_IN_PROGRESS) {
            this._isMustBeHided = true;
        }
        else {
            this.iconsAnim.gotoAndPlay(HIDE_LEFT_ANIM);
            this.textsAnim.gotoAndPlay(HIDE_LEFT_ANIM);
        }
    }

    public function hideInBottom():void {
        if (this.animationState != RibbonAnimationStates.HIDE_IN_PROGRESS) {
            this.animationState = RibbonAnimationStates.HIDE_IN_PROGRESS;
            this._scheduler.cancelTask(this.shiftItems);
            this._scheduler.cancelTask(this.onLifetimeCooldown);
            this.iconsAnim.gotoAndPlay(HIDE_BOTTOM_ANIM);
            this.textsAnim.gotoAndPlay(HIDE_BOTTOM_ANIM);
        }
    }

    public function setSettings(param1:Boolean, param2:Boolean, param3:Boolean):void {
        this._texts.setSettings(param1, param2, param3);
        this._icons.setSettings(param2, param3);
        this._isExtendedAnim = param1;
        if (param1) {
            this._showLbl = SHOW_ANIM;
        }
        else {
            this._showLbl = SHOW_MST_ANIM;
        }
    }

    public function shiftAnim(param1:int):void {
        this.animationState = RibbonAnimationStates.SHIFT_IN_PROGRESS;
        var _loc2_:int = ANIM_DELAY_BY_ITEM * param1;
        if (_loc2_ > 0) {
            this._scheduler.scheduleTask(this.shiftItems, ANIM_DELAY_BY_ITEM * param1);
        }
        else {
            this.shiftItems();
        }
    }

    private function shiftItems():void {
        this.iconsAnim.gotoAndPlay(SHIFT_ANIM);
        this.textsAnim.gotoAndPlay(SHIFT_ANIM);
    }

    public function showAnim(param1:int):void {
        this.animationState = RibbonAnimationStates.SHOW_IN_PROGRESS;
        this._scheduler.scheduleTask(this.showAnimByScheduler, param1 * ANIM_DELAY_BY_ITEM);
    }

    private function showAnimByScheduler():void {
        this.textsAnim.visible = true;
        this.iconsAnim.visible = true;
        this.iconsAnim.gotoAndPlay(this._showLbl);
        this.iconsAnim.glowAnim.gotoAndPlay(1);
        this.textsAnim.gotoAndPlay(this._showLbl);
        if (this._isExtendedAnim) {
            this._texts.showUpdateAnim();
        }
    }

    public function updateData(param1:String, param2:String, param3:String, param4:String):void {
        if (this.animationState == RibbonAnimationStates.IS_STATIC_SHOW) {
        }
        this._texts.setData(param2, param1, param4, param3);
        this._icons.setTankIcon(param3);
        this._scheduler.cancelTask(this.onLifetimeCooldown);
        this._scheduler.scheduleTask(this.onLifetimeCooldown, LIFE_TIME);
        this._texts.showUpdateAnim();
    }

    private function onShowAnimCompleteFrameHandler():void {
        this.animationState = RibbonAnimationStates.IS_STATIC_SHOW;
        this._scheduler.scheduleTask(this.onLifetimeCooldown, LIFE_TIME);
        this.iconsAnim.stop();
        this._animationCompleteCallback(CALLBACK_TYPE_SHOW_FINISHED, this.ribbonType);
    }

    private function onHideAnimCompleteFrameHandler():void {
        this.animationState = RibbonAnimationStates.INVISIBLE;
        this.iconsAnim.stop();
        this.iconsAnim.visible = false;
        this.textsAnim.visible = false;
        if (this._idx > 0) {
            this.iconsAnim.y = 0;
            this.textsAnim.y = 0;
        }
        this._idx = 0;
        this._animationCompleteCallback(CALLBACK_TYPE_HIDE_FINISHED, this.ribbonType);
        this._isMustBeHided = false;
    }

    private function onShiftPositionAnimCompleteFrameHandler():void {
        this.animationState = RibbonAnimationStates.IS_STATIC_SHOW;
        this._idx++;
        this.textsAnim.y = this.iconsAnim.y = ITEM_HEIGHT * this._idx;
        this.textsAnim.gotoAndStop(DEFAULT_STATE);
        this.iconsAnim.gotoAndStop(DEFAULT_STATE);
        if (this._isMustBeHided) {
            this.onLifetimeCooldown();
        }
    }

    public function get idx():int {
        return this._idx;
    }
}
}
