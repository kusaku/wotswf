package net.wg.gui.lobby.fortifications.cmp.calendar.impl {
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.Values;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.events.UILoaderEvent;
import net.wg.gui.lobby.fortifications.cmp.tankIcon.impl.FortTankIcon;
import net.wg.gui.lobby.fortifications.data.FortCalendarEventVO;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.ListItemRenderer;

public class CalendarEventListRenderer extends ListItemRenderer {

    public var headerTF:TextField = null;

    public var timeTF:TextField = null;

    public var directionTF:TextField = null;

    public var resultTF:TextField = null;

    public var icon:UILoaderAlt = null;

    public var backImage:UILoaderAlt = null;

    public var tankIcon:FortTankIcon = null;

    protected var model:FortCalendarEventVO = null;

    public function CalendarEventListRenderer() {
        super();
        preventAutosizing = true;
    }

    override public function setData(param1:Object):void {
        this.model = FortCalendarEventVO(param1);
        invalidateData();
    }

    override protected function configUI():void {
        super.configUI();
        mouseChildren = true;
        this.headerTF.addEventListener(MouseEvent.ROLL_OVER, this.onClanOverHandler);
        this.headerTF.addEventListener(MouseEvent.ROLL_OUT, this.onControlOutHandler);
        this.resultTF.addEventListener(MouseEvent.ROLL_OVER, this.onResultOverHandler);
        this.resultTF.addEventListener(MouseEvent.ROLL_OUT, this.onControlOutHandler);
    }

    override protected function onDispose():void {
        this.headerTF.removeEventListener(MouseEvent.ROLL_OVER, this.onClanOverHandler);
        this.headerTF.removeEventListener(MouseEvent.ROLL_OUT, this.onControlOutHandler);
        this.resultTF.removeEventListener(MouseEvent.ROLL_OVER, this.onResultOverHandler);
        this.resultTF.removeEventListener(MouseEvent.ROLL_OUT, this.onControlOutHandler);
        this.backImage.removeEventListener(UILoaderEvent.COMPLETE, this.onBackImgLoadCompleteHandler);
        this.icon.dispose();
        this.icon = null;
        this.backImage.dispose();
        this.backImage = null;
        this.headerTF = null;
        this.timeTF = null;
        this.directionTF = null;
        this.resultTF = null;
        this.tankIcon.dispose();
        this.tankIcon = null;
        this.model = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            if (this.model) {
                this.headerTF.htmlText = this.model.title;
                this.timeTF.htmlText = this.model.timeInfo;
                this.directionTF.htmlText = this.model.direction;
                this.resultTF.htmlText = this.model.result;
                this.resultTF.visible = this.model.result != Values.EMPTY_STR;
                this.icon.source = this.model.icon;
                this.icon.visible = Boolean(this.model.icon);
                this.backImage.source = this.model.background;
                this.backImage.visible = Boolean(this.model.background);
                if (this.backImage.visible) {
                    this.backImage.addEventListener(UILoaderEvent.COMPLETE, this.onBackImgLoadCompleteHandler);
                }
                this.tankIcon.visible = this.model.showTankIcon;
                if (this.model.showTankIcon) {
                    this.tankIcon.update(this.model.tankIconVO);
                }
                visible = true;
            }
            else {
                visible = false;
            }
        }
        mouseChildren = true;
    }

    private function onResultOverHandler(param1:MouseEvent):void {
        var _loc2_:String = null;
        if (this.model) {
            _loc2_ = App.toolTipMgr.getNewFormatter().addHeader(this.model.resultTTHeader).addBody(this.model.resultTTBody).make();
            if (_loc2_.length > 0) {
                App.toolTipMgr.showComplex(_loc2_);
            }
        }
    }

    private function onControlOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onClanOverHandler(param1:MouseEvent):void {
        if (this.model && this.model.clanID) {
        }
    }

    private function onBackImgLoadCompleteHandler(param1:UILoaderEvent):void {
        this.backImage.removeEventListener(UILoaderEvent.COMPLETE, this.onBackImgLoadCompleteHandler);
        this.backImage.x = Math.round(this.width - this.backImage.width);
    }
}
}
