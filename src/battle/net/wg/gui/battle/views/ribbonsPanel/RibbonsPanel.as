package net.wg.gui.battle.views.ribbonsPanel {
import flash.display.Sprite;
import flash.events.Event;
import flash.utils.Dictionary;

import net.wg.gui.battle.views.ribbonsPanel.data.RibbonAnimationStates;
import net.wg.gui.battle.views.ribbonsPanel.data.RibbonQueue;
import net.wg.gui.battle.views.ribbonsPanel.data.RibbonQueueItem;
import net.wg.gui.battle.views.ribbonsPanel.data.RibbonSettings;
import net.wg.infrastructure.base.meta.IRibbonsPanelMeta;
import net.wg.infrastructure.base.meta.impl.RibbonsPanelMeta;

public class RibbonsPanel extends RibbonsPanelMeta implements IRibbonsPanelMeta {

    private static const MAX_COUNT_RIBBONS:int = 3;

    private static const WITH_NAME_WITH_TANKNAME_OFFSET_X:int = -155;

    private static const WITH_NAME_WITHOUT_TANKNAME_OFFSET_X:int = -142;

    private static const WITHOUT_NAME_WITH_TANKNAME_OFFSET_X:int = -119;

    private static const WITHOUT_NAME_WITHOUT_TANKNAME_OFFSET_X:int = -102;

    private static const RIBBON_TYPE_PARAM_IDX:int = 0;

    private static const RIBBON_TEXT_PARAM_IDX:int = 1;

    private var _storageMap:Dictionary = null;

    private var _ribbonsSettings:Dictionary = null;

    private var _calculatedMaxCountRenderers:int = 0;

    private var _isVisible:Boolean = false;

    private var _ribbonQueue:RibbonQueue = null;

    private var _visibleItems:Vector.<RibbonCtrl> = null;

    private var _isShowPlaying:Boolean = false;

    private var _isHidePlaying:Boolean = false;

    private var _countVisibleItems:int = 0;

    private var _countHidedItems:int = 0;

    private var _textsSprite:Sprite = null;

    private var _offsetX:int = 0;

    public function RibbonsPanel() {
        super();
        this._storageMap = new Dictionary();
        this._ribbonsSettings = new Dictionary();
        this._visibleItems = new Vector.<RibbonCtrl>();
        this._ribbonQueue = new RibbonQueue();
        this._textsSprite = new Sprite();
        addChild(this._textsSprite);
        mouseChildren = mouseEnabled = false;
        visible = false;
    }

    public function setFreeWorkingHeight(param1:int):void {
        this._calculatedMaxCountRenderers = Math.min(param1 / RibbonCtrl.ITEM_HEIGHT ^ 0, MAX_COUNT_RIBBONS);
    }

    public function get freeHeightForRenderers():int {
        return this._calculatedMaxCountRenderers * RibbonCtrl.ITEM_HEIGHT;
    }

    override protected function onDispose():void {
        var _loc1_:RibbonSettings = null;
        var _loc2_:RibbonCtrl = null;
        for each(_loc1_ in this._ribbonsSettings) {
            _loc1_.dispose();
        }
        this._ribbonsSettings = null;
        this._textsSprite = null;
        this._ribbonQueue.dispose();
        this._ribbonQueue = null;
        this._visibleItems.splice(0, this._visibleItems.length);
        this._visibleItems = null;
        for each(_loc2_ in this._storageMap) {
            _loc2_.dispose();
        }
        App.utils.data.cleanupDynamicObject(this._storageMap);
        this._storageMap = null;
        super.onDispose();
    }

    public function as_addBattleEfficiencyEvent(param1:String, param2:String, param3:String, param4:String, param5:String):void {
        var _loc6_:RibbonCtrl = null;
        if (this._isShowPlaying || this._isHidePlaying) {
            this._ribbonQueue.pushShow(param1, param2, param3, param4, param5);
        }
        else {
            _loc6_ = this._storageMap[param1];
            _loc6_.updateData(param2, param3, param4, param5);
            if (_loc6_.animationState == RibbonAnimationStates.IS_STATIC_SHOW) {
                onChangeS();
            }
            else {
                this._isShowPlaying = true;
                this.shiftItems();
                this._visibleItems.push(_loc6_);
                _loc6_.showAnim(this._countVisibleItems);
                this._countVisibleItems++;
                onShowS();
            }
        }
    }

    public function as_setSettings(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean):void {
        this.setSettings(param1, param2, param3, param4);
    }

    public function as_setup(param1:Array, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean):void {
        var _loc7_:RibbonCtrl = null;
        var _loc8_:Array = null;
        var _loc9_:String = null;
        var _loc10_:String = null;
        var _loc11_:RibbonSettings = null;
        var _loc6_:int = param1.length;
        var _loc12_:int = 0;
        while (_loc12_ < _loc6_) {
            _loc8_ = param1[_loc12_];
            _loc9_ = _loc8_[RIBBON_TYPE_PARAM_IDX];
            App.utils.asserter.assert(RibbonSettings.isAvailableRibbonType(_loc9_), "Not such ribbonTypeIcon = " + _loc9_);
            _loc10_ = _loc8_[RIBBON_TEXT_PARAM_IDX];
            _loc11_ = new RibbonSettings(_loc9_, _loc10_);
            this._ribbonsSettings[_loc9_] = _loc11_;
            _loc7_ = new RibbonCtrl(_loc11_, this.animationCallback, param2);
            this._storageMap[_loc9_] = _loc7_;
            addChildAt(_loc7_.iconsAnim, 0);
            this._textsSprite.addChild(_loc7_.textsAnim);
            _loc12_++;
        }
        this.setSettings(param3, param2, param4, param5);
    }

    public function setSettings(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean):void {
        var _loc5_:RibbonCtrl = null;
        var _loc6_:* = null;
        if (param1 != this._isVisible) {
            this._isVisible = param1;
            visible = param1;
        }
        for (_loc6_ in this._storageMap) {
            _loc5_ = this._storageMap[_loc6_];
            _loc5_.setSettings(param2, param3, param4);
        }
        this.calculateOffset(param3, param4);
        dispatchEvent(new Event(Event.CHANGE));
    }

    private function calculateOffset(param1:Boolean, param2:Boolean):void {
        if (param1) {
            if (param2) {
                this._offsetX = WITH_NAME_WITH_TANKNAME_OFFSET_X;
            }
            else {
                this._offsetX = WITH_NAME_WITHOUT_TANKNAME_OFFSET_X;
            }
        }
        else if (param2) {
            this._offsetX = WITHOUT_NAME_WITH_TANKNAME_OFFSET_X;
        }
        else {
            this._offsetX = WITHOUT_NAME_WITHOUT_TANKNAME_OFFSET_X;
        }
    }

    public function shiftItems():void {
        var _loc1_:RibbonCtrl = null;
        var _loc2_:int = this._countVisibleItems;
        var _loc3_:* = _loc2_ == this._calculatedMaxCountRenderers;
        var _loc4_:int = 0;
        if (_loc3_) {
            _loc4_ = 1;
            _loc1_ = this._visibleItems[0];
            _loc1_.hideInBottom();
            this._countHidedItems++;
            this._isHidePlaying = true;
        }
        while (_loc4_ < _loc2_) {
            _loc1_ = this._visibleItems[_loc4_];
            _loc1_.shiftAnim(_loc4_);
            _loc4_++;
        }
    }

    private function onShowAnimComplete():void {
        this._isShowPlaying = false;
        this.checkQueue();
    }

    private function onHideAnimationComplete(param1:String):void {
        this._visibleItems.shift();
        onHideS(param1);
        this._countVisibleItems--;
        this._countHidedItems--;
        if (this._countHidedItems == 0) {
            this._isHidePlaying = false;
            this.checkQueue();
        }
    }

    private function checkQueue():void {
        var _loc2_:RibbonCtrl = null;
        var _loc3_:String = null;
        var _loc4_:Boolean = false;
        var _loc1_:RibbonQueueItem = this._ribbonQueue.readNext();
        if (_loc1_ != null) {
            _loc2_ = this._storageMap[_loc1_.ribbonType];
            _loc3_ = _loc2_.animationState;
            _loc4_ = _loc3_ == RibbonAnimationStates.IS_STATIC_SHOW || _loc3_ == RibbonAnimationStates.INVISIBLE;
            if (_loc1_.animationType == RibbonQueueItem.SHOW && (_loc4_ && !this._isShowPlaying)) {
                _loc2_.updateData(_loc1_.valueStr, _loc1_.vehName, _loc1_.vehType, _loc1_.countVehs);
                this._ribbonQueue.shiftQueue();
                if (_loc3_ == RibbonAnimationStates.INVISIBLE) {
                    this._isShowPlaying = true;
                    this.shiftItems();
                    _loc2_.showAnim(this._countVisibleItems);
                    this._visibleItems.push(_loc2_);
                    this._countVisibleItems++;
                    onShowS();
                }
                else if (_loc3_ == RibbonAnimationStates.IS_STATIC_SHOW) {
                    onChangeS();
                    this.checkQueue();
                }
            }
            else if (_loc1_.animationType == RibbonQueueItem.HIDE) {
                this.hideByOrder(_loc1_.ribbonType);
                this._ribbonQueue.shiftQueue();
            }
        }
    }

    private function animationCallback(param1:String, param2:String):void {
        if (param1 == RibbonCtrl.CALLBACK_TYPE_SHOW_FINISHED) {
            this.onShowAnimComplete();
        }
        else if (param1 == RibbonCtrl.CALLBACK_TYPE_HIDE_FINISHED) {
            this.onHideAnimationComplete(param2);
        }
        else if (param1 == RibbonCtrl.CALLBACK_LIFETIME_COOLDOWN) {
            if (this._isShowPlaying || this._isHidePlaying) {
                this._ribbonQueue.unshiftHide(param2);
            }
            else {
                this.hideByOrder(param2);
            }
        }
    }

    private function hideByOrder(param1:String):void {
        var _loc2_:RibbonCtrl = this._storageMap[param1];
        var _loc3_:int = this._visibleItems.indexOf(_loc2_);
        while (_loc3_ >= 0) {
            this._isHidePlaying = true;
            this._countHidedItems++;
            this._visibleItems[_loc3_].hideByOrder(_loc3_);
            _loc3_--;
        }
    }

    public function get offsetX():int {
        return this._offsetX;
    }
}
}
