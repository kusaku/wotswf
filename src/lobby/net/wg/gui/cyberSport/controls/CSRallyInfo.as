package net.wg.gui.cyberSport.controls {
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.gui.components.advanced.ClanEmblem;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.cyberSport.controls.data.CSRallyInfoVO;
import net.wg.gui.cyberSport.controls.events.CSRallyInfoEvent;
import net.wg.infrastructure.base.UIComponentEx;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.events.ButtonEvent;

public class CSRallyInfo extends UIComponentEx {

    private static const INVALIDATION_TYPE_ICON:String = "invalidationTypeIcon";

    private static const ICON_SIZE:int = 64;

    public var nameTF:TextField = null;

    public var profileBtn:SoundButtonEx = null;

    public var descriptionTF:TextField = null;

    public var ladderIcon:UILoaderAlt = null;

    public var emblemIcon:ClanEmblem = null;

    private var _iconPath:String = null;

    private var _rallyId:Number = NaN;

    private var _nameTooltip:String = null;

    private var _descriptionTooltip:String = null;

    public function CSRallyInfo() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.emblemIcon.setImage(null);
        this.emblemIcon.iconWidth = ICON_SIZE;
        this.emblemIcon.iconHeight = ICON_SIZE;
        this.profileBtn.addEventListener(ButtonEvent.PRESS, this.onProfileBtnPressHandler);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALIDATION_TYPE_ICON)) {
            this.emblemIcon.setImage(this._iconPath);
        }
    }

    override protected function onDispose():void {
        this.profileBtn.removeEventListener(ButtonEvent.PRESS, this.onProfileBtnPressHandler);
        this.removeTooltipHandlers();
        this.profileBtn.dispose();
        this.ladderIcon.dispose();
        this.emblemIcon.dispose();
        this.nameTF = null;
        this.profileBtn = null;
        this.descriptionTF = null;
        this.ladderIcon = null;
        this.emblemIcon = null;
        super.onDispose();
    }

    public function setData(param1:CSRallyInfoVO):void {
        this.removeTooltipHandlers();
        this.profileBtn.label = param1.profileBtnLabel;
        this.profileBtn.tooltip = param1.profileBtnTooltip;
        this._rallyId = param1.id;
        this.updateIcon(param1.icon);
        this._nameTooltip = this.truncateText(this.nameTF, param1.name);
        if (this._nameTooltip) {
            this.nameTF.addEventListener(MouseEvent.ROLL_OVER, this.onNameRollOverHandler);
            this.nameTF.addEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        }
        this._descriptionTooltip = this.truncateText(this.descriptionTF, param1.description);
        if (this._descriptionTooltip) {
            this.descriptionTF.addEventListener(MouseEvent.ROLL_OVER, this.onDescriptionRollOverHandler);
            this.descriptionTF.addEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        }
        this.ladderIcon.visible = param1.showLadder;
        if (param1.showLadder) {
            this.ladderIcon.source = param1.ladderIcon;
        }
        invalidateData();
    }

    public function updateIcon(param1:String):void {
        this._iconPath = !!StringUtils.isEmpty(param1) ? null : param1;
        this.emblemIcon.validateNow();
        invalidate(INVALIDATION_TYPE_ICON);
    }

    private function removeTooltipHandlers():void {
        this.descriptionTF.removeEventListener(MouseEvent.ROLL_OVER, this.onDescriptionRollOverHandler);
        this.descriptionTF.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.nameTF.removeEventListener(MouseEvent.ROLL_OVER, this.onNameRollOverHandler);
        this.nameTF.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
    }

    private function truncateText(param1:TextField, param2:String):String {
        var _loc3_:String = null;
        param1.htmlText = param2;
        var _loc4_:String = param1.text;
        param1.defaultTextFormat = param1.getTextFormat();
        var _loc5_:String = App.utils.commons.truncateTextFieldText(param1, _loc4_);
        if (_loc4_ == _loc5_) {
            param1.htmlText = param2;
        }
        else {
            _loc3_ = _loc4_;
        }
        return _loc3_;
    }

    private function onDescriptionRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.show(this._descriptionTooltip);
    }

    private function onNameRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.show(this._nameTooltip);
    }

    private function onControlRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onProfileBtnPressHandler(param1:ButtonEvent):void {
        dispatchEvent(new CSRallyInfoEvent(CSRallyInfoEvent.SHOW_PROFILE, this._rallyId, true));
    }
}
}
