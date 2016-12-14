package net.wg.gui.lobby.fortifications.cmp.calendar.impl {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.gui.components.controls.SortableTable;
import net.wg.gui.lobby.fortifications.data.FortCalendarPreviewBlockVO;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;

public class CalendarPreviewBlock extends UIComponentEx {

    public var dateTF:TextField;

    public var dateInfoTF:TextField;

    public var noEventsTF:TextField;

    public var list:SortableTable;

    public var shadowSeparator:Sprite;

    private var _model:FortCalendarPreviewBlockVO;

    public function CalendarPreviewBlock() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.shadowSeparator.mouseChildren = this.shadowSeparator.mouseEnabled = false;
    }

    override protected function onDispose():void {
        this.dateTF = null;
        this.dateInfoTF = null;
        this.shadowSeparator = null;
        this.noEventsTF = null;
        this.list.dispose();
        this.list = null;
        this._model = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (this._model && isInvalid(InvalidationType.DATA)) {
            this.dateTF.htmlText = this._model.dateString;
            this.dateInfoTF.htmlText = this._model.dateInfo;
            if (this._model.hasEvents) {
                this.list.listDP = new DataProvider(this._model.events);
                this.list.visible = true;
                this.noEventsTF.visible = false;
            }
            else {
                this.list.listDP = new DataProvider([]);
                this.noEventsTF.htmlText = this._model.noEventsText;
                this.noEventsTF.visible = true;
                this.list.visible = false;
            }
        }
    }

    public function get model():FortCalendarPreviewBlockVO {
        return this._model;
    }

    public function set model(param1:FortCalendarPreviewBlockVO):void {
        this._model = param1;
        invalidateData();
    }
}
}
