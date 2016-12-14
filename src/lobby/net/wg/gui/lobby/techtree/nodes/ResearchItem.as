package net.wg.gui.lobby.techtree.nodes {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.Aliases;
import net.wg.data.constants.Errors;
import net.wg.data.constants.Linkages;
import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.data.constants.generated.NODE_STATE_FLAGS;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.advanced.ModuleTypesUIWithFill;
import net.wg.gui.lobby.modulesPanel.components.ExtraIcon;
import net.wg.gui.lobby.techtree.TechTreeEvent;
import net.wg.gui.lobby.techtree.constants.NodeEntityType;
import net.wg.gui.lobby.techtree.constants.TTSoundID;
import net.wg.gui.lobby.techtree.controls.ExperienceLabel;
import net.wg.gui.lobby.techtree.interfaces.INodesContainer;
import net.wg.gui.lobby.techtree.interfaces.IResearchContainer;
import net.wg.infrastructure.events.IconLoaderEvent;

import org.idmedia.as3commons.util.StringUtils;

public class ResearchItem extends Renderer {

    private static const DEFAULT_EXTRA_ICON_X:int = 41;

    private static const DEFAULT_EXTRA_ICON_Y:int = 41;

    private static const EXTRA_ICON_X_SHIFT:int = 2;

    private static const EXTRA_ICON_Y_SHIFT:int = 2;

    private static const EXTRA_ICON_ALPHA_TRANSPARENT:Number = 0.5;

    private static const EXTRA_ICON_ALPHA:Number = 1;

    private static const RESEARCH_CONTAINER:String = "researchContainer";

    public var typeIcon:ModuleTypesUIWithFill;

    public var levelIcon:MovieClip;

    public var nameField:TextField;

    public var xpLabel:ExperienceLabel;

    private var _extraIcon:ExtraIcon;

    public function ResearchItem() {
        super();
    }

    override public function getExtraState():Object {
        return {
            "rootState": (this.containerEx != null ? this.containerEx.getRootState() : 0),
            "isParentUnlocked": (this.containerEx != null ? this.containerEx.hasUnlockedParent(matrixPosition.row - 1, index) : false)
        };
    }

    override public function isActionEnabled():Boolean {
        var _loc1_:Boolean = super.isActionEnabled();
        if (_loc1_ && stateProps.enough == NODE_STATE_FLAGS.ENOUGH_MONEY) {
            _loc1_ = container != null && this.containerEx.canInstallItems() && (valueObject.state & NODE_STATE_FLAGS.INSTALLED) == 0;
        }
        return _loc1_;
    }

    override public function isAvailable4Buy():Boolean {
        if (!dataInited) {
            return false;
        }
        return container != null && this.containerEx.canInstallItems() && (valueObject.state & NODE_STATE_FLAGS.INSTALLED) == 0 && super.isAvailable4Buy();
    }

    override public function populateUI():void {
        var _loc2_:String = null;
        var _loc1_:String = getItemName();
        this.nameField.wordWrap = true;
        this.nameField.autoSize = TextFieldAutoSize.CENTER;
        this.nameField.text = _loc1_;
        _loc2_ = getItemType();
        if (_loc2_.length > 0) {
            this.typeIcon.visible = true;
            App.utils.asserter.assertFrameExists(_loc2_, this.typeIcon);
            this.typeIcon.gotoAndStop(_loc2_);
        }
        else {
            this.typeIcon.visible = false;
        }
        var _loc3_:int = getLevel();
        if (_loc3_ > -1) {
            this.levelIcon.gotoAndStop(_loc3_);
        }
        if (this.xpLabel != null) {
            this.xpLabel.visible = !this.isAutoUnlocked();
            if (this.xpLabel.visible) {
                this.xpLabel.setOwner(this, doValidateNow);
            }
        }
        if (button != null) {
            button.label = getNamedLabel(stateProps.label);
            button.enabled = this.isActionEnabled();
            if (button.setAnimation(stateProps.id, stateProps.animation)) {
                button.visible = stateProps.visible;
            }
            button.setOwner(this, doValidateNow);
        }
        this.applyExtraSource();
        super.populateUI();
    }

    override public function showContextMenu():void {
        if (button != null) {
            button.endAnimation(true);
        }
        App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.RESEARCH_ITEM, this, {
            "nodeCD": valueObject.id,
            "rootCD": container.getRootNode().getID(),
            "nodeState": valueObject.state,
            "previewAlias": Aliases.TECHTREE
        });
    }

    override public function toString():String {
        return "[ResearchItem " + index + ", " + name + "]";
    }

    override protected function onDispose():void {
        this.typeIcon.dispose();
        this.typeIcon = null;
        if (this.xpLabel != null) {
            this.xpLabel.dispose();
            this.xpLabel = null;
        }
        this.levelIcon = null;
        this.nameField = null;
        if (this._extraIcon != null) {
            this._extraIcon.removeEventListener(IconLoaderEvent.ICON_LOADED, this.onExtraIconLoadedHandler);
            this._extraIcon.dispose();
            this._extraIcon = null;
        }
        App.contextMenuMgr.hide();
        super.onDispose();
    }

    override protected function preInitialize():void {
        super.preInitialize();
        entityType = NodeEntityType.RESEARCH_ITEM;
        soundId = TTSoundID.RESEARCH_ITEM;
        tooltipID = TOOLTIPS_CONSTANTS.TECHTREE_MODULE;
        isDelegateEvents = true;
    }

    override protected function handleClick(param1:uint = 0):void {
        super.handleClick(param1);
        App.contextMenuMgr.hide();
        if (button != null) {
            button.endAnimation(true);
            if (!button.enabled) {
                button.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
        }
        dispatchEvent(new TechTreeEvent(TechTreeEvent.CLICK_2_OPEN, 0, _index, entityType));
    }

    public function isAutoUnlocked():Boolean {
        return dataInited && (valueObject.state & NODE_STATE_FLAGS.AUTO_UNLOCKED) > 0;
    }

    private function applyExtraSource():void {
        var _loc1_:String = valueObject.extraInfo;
        this.typeIcon.hideExtraIcon();
        switch (_loc1_) {
            case RES_ICONS.MAPS_ICONS_MODULES_MAGAZINEGUNICON:
                this.setExtraIcon(Linkages.MAGAZINE_GUN_ICON);
                break;
            case RES_ICONS.MAPS_ICONS_MODULES_HYDRAULICCHASSISICON:
                this.setExtraIcon(Linkages.HYDRAULIC_CHASSIS_ICON);
                break;
            default:
                this.applyExtraSourceLoad();
        }
    }

    private function setExtraIcon(param1:String):void {
        this.typeIcon.setExtraIcon(param1);
        this.typeIcon.extraIconX = DEFAULT_EXTRA_ICON_X;
        this.typeIcon.extraIconY = DEFAULT_EXTRA_ICON_Y;
        if ((button && button.visible || this.xpLabel && this.xpLabel.visible) != true) {
            this.typeIcon.showExtraIcon();
            this.typeIcon.extraIconAlpha = stateProps.index == 0 ? Number(EXTRA_ICON_ALPHA_TRANSPARENT) : Number(EXTRA_ICON_ALPHA);
        }
    }

    private function applyExtraSourceLoad():void {
        var _loc1_:String = valueObject.extraInfo;
        if (this._extraIcon == null && StringUtils.isNotEmpty(_loc1_)) {
            this._extraIcon = new ExtraIcon();
            this._extraIcon.addEventListener(IconLoaderEvent.ICON_LOADED, this.onExtraIconLoadedHandler, false, 0, true);
            this._extraIcon.visible = false;
            addChild(this._extraIcon);
        }
        if (this._extraIcon != null) {
            this._extraIcon.setSource(_loc1_);
            this._extraIcon.visible = !(button && button.visible || this.xpLabel && this.xpLabel.visible);
            if (this._extraIcon.visible) {
                this._extraIcon.alpha = stateProps.index == 0 ? Number(EXTRA_ICON_ALPHA_TRANSPARENT) : Number(EXTRA_ICON_ALPHA);
            }
        }
    }

    override public function set container(param1:INodesContainer):void {
        if (param1 is IResearchContainer) {
            super.container = param1;
        }
    }

    public function get containerEx():IResearchContainer {
        var _loc1_:IResearchContainer = null;
        if (container != null) {
            _loc1_ = container as IResearchContainer;
            App.utils.asserter.assertNotNull(_loc1_, RESEARCH_CONTAINER + Errors.CANT_NULL);
            return _loc1_;
        }
        return null;
    }

    private function onExtraIconLoadedHandler(param1:IconLoaderEvent):void {
        this._extraIcon.x = this.typeIcon.x + this.typeIcon.width - this._extraIcon.width - EXTRA_ICON_X_SHIFT;
        this._extraIcon.y = this.typeIcon.y + this.typeIcon.height - this._extraIcon.height - EXTRA_ICON_Y_SHIFT;
    }
}
}
