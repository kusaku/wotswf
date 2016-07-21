package net.wg.gui.cyberSport.controls {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.gui.cyberSport.controls.data.CSAnimationVO;
import net.wg.gui.events.CSAnimationEvent;
import net.wg.gui.events.UILoaderEvent;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.events.ButtonEvent;

public class CSAnimation extends MovieClip implements IDisposable {

    public var leavesOldIcon:CSAnimationIcon = null;

    public var leavesNewIcon:CSAnimationIcon = null;

    public var ribbonOldIcon:CSAnimationIcon = null;

    public var ribbonNewIcon:CSAnimationIcon = null;

    public var divisionOldIcon:CSAnimationIcon = null;

    public var divisionNewIcon:CSAnimationIcon = null;

    public var divisionAdditionalIcon:CSAnimationIcon = null;

    public var logoOldIcon:CSAnimationIcon = null;

    public var logoNewIcon:CSAnimationIcon = null;

    public var infoBlock:MovieClip = null;

    public var headerTF:TextField = null;

    public var descriptionTF:TextField = null;

    public var shadow:MovieClip = null;

    private var _iconsForLoad:uint = 0;

    public function CSAnimation() {
        super();
        stop();
    }

    public function dispose():void {
        this.infoBlock.applyBtn.removeEventListener(ButtonEvent.CLICK, this.onApplyBtnClickHandler);
        if (this.leavesOldIcon) {
            this.leavesOldIcon.icon.addEventListener(UILoaderEvent.COMPLETE, this.onIconLoadCompleteHandler);
            this.leavesOldIcon.icon.addEventListener(UILoaderEvent.IOERROR, this.onIconLoadIOErrorHandler);
            this.leavesOldIcon.dispose();
            this.leavesOldIcon = null;
        }
        if (this.leavesNewIcon) {
            this.leavesNewIcon.icon.addEventListener(UILoaderEvent.COMPLETE, this.onIconLoadCompleteHandler);
            this.leavesNewIcon.icon.addEventListener(UILoaderEvent.IOERROR, this.onIconLoadIOErrorHandler);
            this.leavesNewIcon.dispose();
            this.leavesNewIcon = null;
        }
        if (this.ribbonOldIcon) {
            this.ribbonOldIcon.icon.addEventListener(UILoaderEvent.COMPLETE, this.onIconLoadCompleteHandler);
            this.ribbonOldIcon.icon.addEventListener(UILoaderEvent.IOERROR, this.onIconLoadIOErrorHandler);
            this.ribbonOldIcon.dispose();
            this.ribbonOldIcon = null;
        }
        if (this.ribbonNewIcon) {
            this.ribbonNewIcon.icon.addEventListener(UILoaderEvent.COMPLETE, this.onIconLoadCompleteHandler);
            this.ribbonNewIcon.icon.addEventListener(UILoaderEvent.IOERROR, this.onIconLoadIOErrorHandler);
            this.ribbonNewIcon.dispose();
            this.ribbonNewIcon = null;
        }
        if (this.divisionOldIcon) {
            this.divisionOldIcon.icon.addEventListener(UILoaderEvent.COMPLETE, this.onIconLoadCompleteHandler);
            this.divisionOldIcon.icon.addEventListener(UILoaderEvent.IOERROR, this.onIconLoadIOErrorHandler);
            this.divisionOldIcon.dispose();
            this.divisionOldIcon = null;
        }
        if (this.divisionNewIcon) {
            this.divisionNewIcon.icon.addEventListener(UILoaderEvent.COMPLETE, this.onIconLoadCompleteHandler);
            this.divisionNewIcon.icon.addEventListener(UILoaderEvent.IOERROR, this.onIconLoadIOErrorHandler);
            this.divisionNewIcon.dispose();
            this.divisionNewIcon = null;
        }
        if (this.divisionAdditionalIcon) {
            this.divisionAdditionalIcon.icon.addEventListener(UILoaderEvent.COMPLETE, this.onIconLoadCompleteHandler);
            this.divisionAdditionalIcon.icon.addEventListener(UILoaderEvent.IOERROR, this.onIconLoadIOErrorHandler);
            this.divisionAdditionalIcon.dispose();
            this.divisionAdditionalIcon = null;
        }
        if (this.logoOldIcon) {
            this.logoOldIcon.icon.addEventListener(UILoaderEvent.COMPLETE, this.onIconLoadCompleteHandler);
            this.logoOldIcon.icon.addEventListener(UILoaderEvent.IOERROR, this.onIconLoadIOErrorHandler);
            this.logoOldIcon.dispose();
            this.logoOldIcon = null;
        }
        if (this.logoNewIcon) {
            this.logoNewIcon.icon.addEventListener(UILoaderEvent.COMPLETE, this.onIconLoadCompleteHandler);
            this.logoNewIcon.icon.addEventListener(UILoaderEvent.IOERROR, this.onIconLoadIOErrorHandler);
            this.logoNewIcon.dispose();
            this.logoNewIcon = null;
        }
        this.headerTF = null;
        this.descriptionTF = null;
        this.infoBlock.applyBtn.dispose();
        this.infoBlock = null;
        this.shadow = null;
    }

    public function setData(param1:CSAnimationVO):void {
        this.infoBlock.headerTF.htmlText = param1.headerText;
        this.infoBlock.descriptionTF.htmlText = param1.descriptionText;
        this.infoBlock.applyBtn.label = param1.applyBtnLabel;
        this.infoBlock.applyBtn.addEventListener(ButtonEvent.CLICK, this.onApplyBtnClickHandler);
        this.shadow.mouseEnabled = this.mouseChildren = true;
        if (this.leavesOldIcon && StringUtils.isNotEmpty(param1.leavesOldSource)) {
            this.setIconData(this.leavesOldIcon, param1.leavesOldSource);
        }
        if (this.leavesNewIcon && StringUtils.isNotEmpty(param1.leavesNewSource)) {
            this.setIconData(this.leavesNewIcon, param1.leavesNewSource);
        }
        if (this.ribbonOldIcon && StringUtils.isNotEmpty(param1.ribbonOldSource)) {
            this.setIconData(this.ribbonOldIcon, param1.ribbonOldSource);
        }
        if (this.ribbonNewIcon && StringUtils.isNotEmpty(param1.ribbonNewSource)) {
            this.setIconData(this.ribbonNewIcon, param1.ribbonNewSource);
        }
        if (this.divisionOldIcon && StringUtils.isNotEmpty(param1.divisionOldSource)) {
            this.setIconData(this.divisionOldIcon, param1.divisionOldSource);
        }
        if (this.divisionNewIcon && StringUtils.isNotEmpty(param1.divisionNewSource)) {
            this.setIconData(this.divisionNewIcon, param1.divisionNewSource);
        }
        if (this.divisionAdditionalIcon && StringUtils.isNotEmpty(param1.divisionAdditionalSource)) {
            this.setIconData(this.divisionAdditionalIcon, param1.divisionNewSource);
        }
        if (this.logoOldIcon && StringUtils.isNotEmpty(param1.logoOldSource)) {
            this.setIconData(this.logoOldIcon, param1.logoOldSource);
        }
        if (this.logoNewIcon && StringUtils.isNotEmpty(param1.logoNewSource)) {
            this.setIconData(this.logoNewIcon, param1.logoNewSource);
        }
        this.addFrameScript(1, this.startAnimationSound);
    }

    private function setIconData(param1:CSAnimationIcon, param2:String):void {
        param1.icon.source = param2;
        param1.icon.addEventListener(UILoaderEvent.COMPLETE, this.onIconLoadCompleteHandler);
        param1.icon.addEventListener(UILoaderEvent.IOERROR, this.onIconLoadIOErrorHandler);
        param1.mouseEnabled = param1.mouseChildren = false;
        this._iconsForLoad++;
    }

    private function startAnimationSound():void {
        dispatchEvent(new CSAnimationEvent(CSAnimationEvent.ANIMATIONS_LOADED));
    }

    private function onIconLoadCompleteHandler(param1:UILoaderEvent):void {
        param1.target.removeEventListener(UILoaderEvent.COMPLETE, this.onIconLoadCompleteHandler);
        param1.target.removeEventListener(UILoaderEvent.IOERROR, this.onIconLoadIOErrorHandler);
        this._iconsForLoad--;
        if (this._iconsForLoad == 0) {
            play();
        }
    }

    private function onApplyBtnClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new CSAnimationEvent(CSAnimationEvent.APPLY_BTN_CLICK));
    }

    private function onIconLoadIOErrorHandler(param1:UILoaderEvent):void {
        param1.target.removeEventListener(UILoaderEvent.COMPLETE, this.onIconLoadCompleteHandler);
        param1.target.removeEventListener(UILoaderEvent.IOERROR, this.onIconLoadIOErrorHandler);
        dispatchEvent(new CSAnimationEvent(CSAnimationEvent.ANIMATIONS_LOAD_ERROR));
    }
}
}
