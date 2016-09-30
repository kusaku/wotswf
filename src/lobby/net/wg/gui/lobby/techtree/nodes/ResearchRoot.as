package net.wg.gui.lobby.techtree.nodes {
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;

import net.wg.data.Aliases;
import net.wg.data.constants.Values;
import net.wg.data.constants.VehicleState;
import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.data.constants.generated.NODE_STATE_FLAGS;
import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO;
import net.wg.gui.components.tooltips.helpers.Utils;
import net.wg.gui.data.VehCompareEntrypointVO;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.techtree.TechTreeEvent;
import net.wg.gui.lobby.techtree.constants.ActionName;
import net.wg.gui.lobby.techtree.constants.ColorIndex;
import net.wg.gui.lobby.techtree.constants.NodeEntityType;
import net.wg.gui.lobby.techtree.constants.TTSoundID;
import net.wg.gui.lobby.techtree.controls.NameAndXpField;
import net.wg.gui.lobby.techtree.controls.TypeAndLevelField;
import net.wg.gui.lobby.techtree.interfaces.IRenderer;
import net.wg.utils.ICommons;
import net.wg.utils.ILocale;
import net.wg.utils.ITextManager;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.events.ButtonEvent;

public class ResearchRoot extends Renderer {

    private static const EMPTY_STR:String = "";

    public var vIconLoader:UILoaderAlt;

    public var nameAndXp:NameAndXpField;

    public var typeAndLevel:TypeAndLevelField;

    public var statusField:TextField;

    public var flag:MovieClip;

    public var additionalStatusField:TextField;

    public var showVehicleBtn:ISoundButtonEx;

    public var compareVehicleBtn:ISoundButtonEx;

    private var _statusString:String = "";

    private var _commons:ICommons;

    private var _locale:ILocale;

    private var _textMgr:ITextManager;

    public function ResearchRoot() {
        this._commons = App.utils.commons;
        this._locale = App.utils.locale;
        this._textMgr = App.textMgr;
        super();
    }

    override public function getColorIdxEx(param1:IRenderer):Number {
        var _loc2_:Number = ColorIndex.LOCKED;
        if (isUnlocked()) {
            if (param1 == null || this.isParentUnlocked(param1.getID())) {
                _loc2_ = ColorIndex.UNLOCKED;
            }
        }
        else if (isNext2Unlock()) {
            if (param1 == null || this.isParentUnlocked(param1.getID())) {
                _loc2_ = ColorIndex.NEXT2UNLOCK;
            }
        }
        return _loc2_;
    }

    override public function isParentUnlocked(param1:Number):Boolean {
        return dataInited && valueObject.unlockProps != null && valueObject.unlockProps.hasID(param1);
    }

    override public function populateUI():void {
        var _loc7_:* = false;
        var _loc8_:ToolTipStatusColorsVO = null;
        var _loc9_:TextFormat = null;
        var _loc1_:String = container.getNation();
        if (this.flag.currentFrameLabel != _loc1_) {
            this.flag.gotoAndStop(_loc1_);
        }
        if (this.statusField != null) {
            this.applyVehicleState(this.statusField, this._statusString);
        }
        var _loc2_:String = getIconPath();
        this.vIconLoader.alpha = stateProps.icoAlpha;
        if (_loc2_ != this.vIconLoader.source) {
            this.vIconLoader.source = _loc2_;
            this.vIconLoader.visible = true;
        }
        this.typeAndLevel.setOwner(this, doValidateNow);
        this.nameAndXp.setIsInAction(actionPrice && isInAction());
        this.nameAndXp.setOwner(this, doValidateNow);
        if (button != null) {
            _loc7_ = (valueObject.state & NODE_STATE_FLAGS.PURCHASE_DISABLED) > 0;
            if (!_loc7_) {
                if (isRestoreAvailable()) {
                    button.action = ActionName.RESTORE;
                }
                else if (isRentAvailable() && isEnoughMoney()) {
                    button.action = ActionName.RENT;
                }
                button.label = getNamedLabel(stateProps.label);
                button.enabled = isActionEnabled() && isEnoughMoney() || isEnoughXp();
                button.visible = stateProps.visible;
                button.setOwner(this, doValidateNow);
            }
            else {
                button.visible = false;
            }
        }
        var _loc3_:String = getStatus();
        var _loc4_:String = getStatusLevel();
        if (_loc3_ != Values.EMPTY_STR && Utils.instance.allowStatuses.indexOf(_loc4_) != -1) {
            _loc8_ = Utils.instance.getStatusColor(_loc4_);
            this.additionalStatusField.htmlText = _loc3_;
            this.additionalStatusField.textColor = _loc8_.textColor;
            _loc9_ = this.additionalStatusField.getTextFormat();
            _loc9_.size = _loc8_.headerFontSize;
            _loc9_.font = _loc8_.headerFontFace;
            _loc9_.color = _loc8_.textColor;
            this.additionalStatusField.setTextFormat(_loc9_);
            this.additionalStatusField.filters = _loc8_.filters;
        }
        else {
            this.additionalStatusField.htmlText = Values.EMPTY_STR;
        }
        this.showVehicleBtn.label = valueObject.showVehicleBtnLabel;
        this.showVehicleBtn.enabled = valueObject.showVehicleBtnEnabled;
        this.showVehicleBtn.addEventListener(ButtonEvent.CLICK, this.onShowVehicleBtnClickHandler, false, 0, true);
        this.compareVehicleBtn.addEventListener(ButtonEvent.CLICK, this.onCompareVehicleBtnClickHandler, false, 0, true);
        this.compareVehicleBtn.mouseEnabledOnDisabled = true;
        var _loc5_:VehCompareEntrypointVO = valueObject.vehCompareVO;
        var _loc6_:Boolean = _loc5_.modeAvailable;
        this.compareVehicleBtn.visible = _loc6_;
        if (_loc6_) {
            this.compareVehicleBtn.label = _loc5_.btnLabel;
            this.compareVehicleBtn.enabled = _loc5_.btnEnabled;
            this.compareVehicleBtn.tooltip = _loc5_.btnTooltip;
        }
        super.populateUI();
    }

    override public function showContextMenu():void {
        if (button != null) {
            button.endAnimation(true);
        }
        App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.RESEARCH_VEHICLE, this, {
            "nodeCD": valueObject.id,
            "rootCD": container.getRootNode().getID(),
            "nodeState": valueObject.state,
            "previewAlias": Aliases.RESEARCH
        });
    }

    override public function toString():String {
        return "[ResearchRoot " + index + ", " + name + "]";
    }

    override protected function onDispose():void {
        this.showVehicleBtn.removeEventListener(ButtonEvent.CLICK, this.onShowVehicleBtnClickHandler);
        this.showVehicleBtn.dispose();
        this.showVehicleBtn = null;
        this.compareVehicleBtn.removeEventListener(ButtonEvent.CLICK, this.onCompareVehicleBtnClickHandler);
        this.compareVehicleBtn.dispose();
        this.compareVehicleBtn = null;
        this.nameAndXp.dispose();
        this.nameAndXp = null;
        this.typeAndLevel.dispose();
        this.typeAndLevel = null;
        this.vIconLoader.dispose();
        this.vIconLoader = null;
        this.additionalStatusField = null;
        this.flag = null;
        this._commons = null;
        this._locale = null;
        this._textMgr = null;
        if (this.statusField != null) {
            if (this.statusField.filters != null) {
                this.statusField.filters.splice(0, this.statusField.filters.length);
                this.statusField.filters = null;
            }
            this.statusField = null;
        }
        App.contextMenuMgr.hide();
        super.onDispose();
    }

    override protected function getMouseEnabledChildren():Vector.<DisplayObjectContainer> {
        var _loc1_:Vector.<DisplayObjectContainer> = super.getMouseEnabledChildren();
        _loc1_.push(this.showVehicleBtn);
        return _loc1_;
    }

    override protected function preInitialize():void {
        super.preInitialize();
        entityType = NodeEntityType.RESEARCH_ROOT;
        soundId = TTSoundID.RESEARCH_ROOT;
        tooltipID = TOOLTIPS_CONSTANTS.TECHTREE_VEHICLE;
        isDelegateEvents = true;
    }

    override protected function handleClick(param1:uint = 0):void {
        super.handleClick(param1);
        App.contextMenuMgr.hide();
        if (button != null) {
            button.endAnimation(true);
        }
        dispatchEvent(new TechTreeEvent(TechTreeEvent.GO_TO_VEHICLE_VIEW, 0, _index, entityType));
    }

    public function setupEx(param1:String):void {
        this._statusString = param1;
        invalidateData();
    }

    private function applyVehicleState(param1:TextField, param2:String):void {
        if (StringUtils.isEmpty(param2)) {
            param1.text = Values.EMPTY_STR;
            return;
        }
        this.setVehicleStateShadowFilter(param1);
        if (param2 == VehicleState.IN_BATTLE || param2 == VehicleState.IN_PREBATTLE) {
            param1.htmlText = this.getHtmlText(param2, TEXT_MANAGER_STYLES.VEHICLE_STATUS_INFO_TEXT);
        }
        else if (param2 == VehicleState.DESTROYED || param2 == VehicleState.DEAL_IS_OVER) {
            param1.htmlText = this.getHtmlText(param2, TEXT_MANAGER_STYLES.VEHICLE_STATUS_CRITICAL_TEXT);
        }
    }

    private function getHtmlText(param1:String, param2:String):String {
        return this._textMgr.getTextStyleById(param2, this._locale.makeString(MENU.tankcarousel_vehiclestates(param1)));
    }

    private function setVehicleStateShadowFilter(param1:TextField):void {
        var _loc2_:Number = 0;
        var _loc3_:Number = 90;
        var _loc4_:uint = 0;
        var _loc5_:Number = 0.25;
        var _loc6_:Number = 8;
        var _loc7_:Number = 8;
        var _loc8_:Number = 16;
        var _loc9_:int = 2;
        this._commons.setShadowFilterWithParams(param1, _loc2_, _loc3_, _loc4_, _loc5_, _loc6_, _loc7_, _loc8_, _loc9_);
    }

    override public function set enabled(param1:Boolean):void {
        super.enabled = param1;
        mouseChildren = param1;
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        super.handleMouseRollOver(param1);
        if (button != null) {
            button.startAnimation();
        }
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        super.handleMouseRollOut(param1);
        if (button != null) {
            button.endAnimation(false);
        }
    }

    private function onShowVehicleBtnClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new TechTreeEvent(TechTreeEvent.GO_TO_VEHICLE_VIEW, 0, _index, entityType));
    }

    private function onCompareVehicleBtnClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new TechTreeEvent(TechTreeEvent.CLICK_VEHICLE_COMPARE, 0, _index, entityType));
    }
}
}
