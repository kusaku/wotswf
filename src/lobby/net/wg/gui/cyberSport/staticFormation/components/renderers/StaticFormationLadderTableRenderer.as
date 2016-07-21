package net.wg.gui.cyberSport.staticFormation.components.renderers {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.gui.components.controls.ButtonIconTextTransparent;
import net.wg.gui.components.controls.Image;
import net.wg.gui.components.controls.TableRenderer;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationLadderTableRendererVO;
import net.wg.gui.cyberSport.staticFormation.events.FormationLadderEvent;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class StaticFormationLadderTableRenderer extends TableRenderer {

    private static const IMG_TAG:String = "img://";

    public var placeTf:TextField = null;

    public var pointsTf:TextField = null;

    public var nameTf:TextField = null;

    public var battlesTf:TextField = null;

    public var winPercentTf:TextField = null;

    public var showProfileBtn:ButtonIconTextTransparent = null;

    public var emblemIcon:Image = null;

    public var selfBg:MovieClip = null;

    private var _rendererData:StaticFormationLadderTableRendererVO = null;

    public function StaticFormationLadderTableRenderer() {
        super();
    }

    override public function setData(param1:Object):void {
        super.setData(param1);
        if (this._rendererData != param1) {
            this.clearData();
            this._rendererData = StaticFormationLadderTableRendererVO(param1);
            this.updateEmblemIcon();
            invalidateData();
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.showProfileBtn.addEventListener(ButtonEvent.PRESS, this.onShowProfileBtnPress);
    }

    override protected function draw():void {
        var _loc1_:* = false;
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            _loc1_ = this._rendererData != null;
            if (this.placeTf.visible = _loc1_) {
                this.placeTf.htmlText = this._rendererData.place;
            }
            if (this.pointsTf.visible = _loc1_) {
                this.pointsTf.htmlText = this._rendererData.points;
            }
            if (this.nameTf.visible = _loc1_) {
                this.nameTf.htmlText = this._rendererData.formationName;
            }
            if (this.battlesTf.visible = _loc1_) {
                this.battlesTf.htmlText = this._rendererData.battlesCount;
            }
            if (this.winPercentTf.visible = _loc1_) {
                this.winPercentTf.htmlText = this._rendererData.winPercent;
            }
            if (this.showProfileBtn.visible = _loc1_ && !this._rendererData.isCurrentTeam) {
                this.showProfileBtn.label = this._rendererData.showProfileBtnText;
                this.showProfileBtn.tooltip = this._rendererData.showProfileBtnTooltip;
            }
            this.selfBg.visible = _loc1_ && this._rendererData.isMyClub;
            this.emblemIcon.visible = _loc1_;
        }
        if (isInvalid(InvalidationType.SIZE)) {
            this.selfBg.width = _width;
        }
    }

    override protected function onDispose():void {
        this.showProfileBtn.removeEventListener(ButtonEvent.PRESS, this.onShowProfileBtnPress);
        this.showProfileBtn.dispose();
        this.emblemIcon.dispose();
        this.placeTf = null;
        this.pointsTf = null;
        this.nameTf = null;
        this.battlesTf = null;
        this.winPercentTf = null;
        this.showProfileBtn = null;
        this.emblemIcon = null;
        this.selfBg = null;
        this.clearData();
        super.onDispose();
    }

    public function updateEmblemIcon():void {
        if (StringUtils.isNotEmpty(this._rendererData.emblemIconPath)) {
            this.emblemIcon.source = IMG_TAG + this._rendererData.emblemIconPath;
        }
    }

    private function clearData():void {
        if (this._rendererData != null) {
            this._rendererData.dispose();
            this._rendererData = null;
        }
    }

    override public function set enabled(param1:Boolean):void {
        super.enabled = param1;
        mouseChildren = param1;
    }

    public function get formationId():Number {
        return this._rendererData != null ? Number(this._rendererData.formationId) : Number(NaN);
    }

    public function get emblemIconPath():String {
        return this._rendererData != null ? this._rendererData.emblemIconPath : null;
    }

    private function onShowProfileBtnPress(param1:ButtonEvent):void {
        if (this._rendererData != null) {
            dispatchEvent(new FormationLadderEvent(FormationLadderEvent.SHOW_FORMATION_PROFILE, this._rendererData.formationId, true));
        }
    }
}
}
