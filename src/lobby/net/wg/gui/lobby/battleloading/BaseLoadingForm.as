package net.wg.gui.lobby.battleloading {
import flash.text.TextField;

import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.components.icons.BattleTypeIcon;
import net.wg.gui.lobby.battleloading.interfaces.IBaseLoadingForm;
import net.wg.gui.lobby.eventInfoPanel.data.EventInfoPanelVO;
import net.wg.gui.lobby.eventInfoPanel.interfaces.IEventInfoPanel;
import net.wg.infrastructure.base.UIComponentEx;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.StatusIndicator;

public class BaseLoadingForm extends UIComponentEx implements IBaseLoadingForm {

    private static const PROGRESS:String = "progress";

    public var mapText:TextField;

    public var battleText:TextField;

    public var winText:TextField;

    public var loadingBar:StatusIndicator;

    public var eventInfoPanel:IEventInfoPanel;

    public var battleIcon:BattleTypeIcon;

    public var mapIcon:UILoaderAlt;

    private var _winTextPosY:int;

    private var _battleTextPosY:int;

    private var _battleTypeStr:String;

    private var _winStr:String;

    private var _progress:Number = 0;

    private var _mapName:String = "";

    private var _frameLabel:String = "";

    public function BaseLoadingForm() {
        super();
        if (this.eventInfoPanel != null) {
            this.eventInfoPanel.visible = false;
        }
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            this.battleText.htmlText = this._battleTypeStr;
            if (StringUtils.isNotEmpty(this._winStr)) {
                this.winText.htmlText = this._winStr;
                this.alignHeaderText();
            }
            this.mapText.htmlText = this._mapName;
            this.battleIcon.visible = true;
            this.battleIcon.type = this._frameLabel;
        }
        if (isInvalid(PROGRESS)) {
            this.loadingBar.position = this._progress;
        }
    }

    override protected function onDispose():void {
        this.mapText = null;
        this.battleText = null;
        this.winText = null;
        this.loadingBar.dispose();
        this.loadingBar = null;
        if (this.eventInfoPanel != null) {
            this.eventInfoPanel.dispose();
        }
        this.eventInfoPanel = null;
        this.battleIcon.dispose();
        this.battleIcon = null;
        if (this.mapIcon != null) {
            this.mapIcon.dispose();
            this.mapIcon = null;
        }
        super.onDispose();
    }

    public function getMapIconComponent():UILoaderAlt {
        return this.mapIcon;
    }

    public function setBattleTypeFrameName(param1:String):void {
        if (param1 != this._frameLabel) {
            this._frameLabel = param1;
            invalidateData();
        }
    }

    public function setBattleTypeName(param1:String):void {
        if (param1 != this._battleTypeStr) {
            this._battleTypeStr = param1;
            invalidateData();
        }
    }

    public function setEventInfo(param1:EventInfoPanelVO):void {
        this.eventInfoPanel.visible = param1 != null;
        if (param1 != null) {
            this.eventInfoPanel.update(param1);
        }
    }

    public function setMapIcon(param1:String):void {
        if (param1 != this.mapIcon.source) {
            this.mapIcon.source = param1;
        }
    }

    public function updateMapName(param1:String):void {
        if (param1 != this._mapName) {
            this._mapName = param1;
            invalidateData();
        }
    }

    public function updateProgress(param1:Number):void {
        if (param1 != this._progress) {
            this._progress = param1;
            invalidate(PROGRESS);
        }
    }

    public function updateWinText(param1:String):void {
        if (param1 != this._winStr) {
            this._winStr = param1;
            if (param1.length > 0) {
                this._winTextPosY = this.winText.y + (this.winText.height >> 1);
                this._battleTextPosY = this.battleText.y + (this.winText.height >> 1);
            }
            invalidateData();
        }
    }

    protected function alignHeaderText():void {
        this.winText.y = this._winTextPosY - (this.winText.textHeight >> 1);
        this.battleText.y = this._battleTextPosY - (this.winText.textHeight >> 1);
    }
}
}
