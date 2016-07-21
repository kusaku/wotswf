package net.wg.gui.lobby.boosters.components {
import flash.display.DisplayObject;
import flash.events.Event;
import flash.text.TextField;

import net.wg.data.constants.Linkages;
import net.wg.gui.components.common.containers.HorizontalGroupLayout;
import net.wg.gui.lobby.boosters.data.BoostersWindowFiltersVO;
import net.wg.gui.lobby.components.ButtonFilters;
import net.wg.gui.lobby.components.events.FiltersEvent;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.utils.ICommons;

public class BoostersWindowFilters extends UIComponentEx {

    private static const FILTERS_BUTTON_GAP:int = 12;

    private static const LABEL_FILTERS_GAP:int = 8;

    private static const FILTERS_GAP:int = 45;

    private static const INVALID_FILTERS_SIZE:String = "invalidFiltersSize";

    public var qualityFiltersLabelTf:TextField;

    public var typeFiltersLabelTf:TextField;

    public var qualityFilters:ButtonFilters;

    public var typeFilters:ButtonFilters;

    public function BoostersWindowFilters() {
        super();
        this.setupFilters(this.qualityFilters);
        this.setupFilters(this.typeFilters);
        this.qualityFilters.addEventListener(FiltersEvent.FILTERS_CHANGED, this.onChangeFiltersHandler);
        this.typeFilters.addEventListener(FiltersEvent.FILTERS_CHANGED, this.onChangeFiltersHandler);
        this.qualityFilters.addEventListener(Event.RESIZE, this.onFiltersResizeHandler);
        this.typeFilters.addEventListener(Event.RESIZE, this.onFiltersResizeHandler);
    }

    override protected function onDispose():void {
        this.qualityFilters.removeEventListener(FiltersEvent.FILTERS_CHANGED, this.onChangeFiltersHandler);
        this.typeFilters.removeEventListener(FiltersEvent.FILTERS_CHANGED, this.onChangeFiltersHandler);
        this.qualityFilters.removeEventListener(Event.RESIZE, this.onFiltersResizeHandler);
        this.typeFilters.removeEventListener(Event.RESIZE, this.onFiltersResizeHandler);
        this.qualityFilters.dispose();
        this.qualityFilters = null;
        this.typeFilters.dispose();
        this.typeFilters = null;
        this.qualityFiltersLabelTf = null;
        this.typeFiltersLabelTf = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALID_FILTERS_SIZE)) {
            this.layoutFilters();
        }
    }

    public function resetFilters(param1:int):void {
        this.qualityFilters.resetFilters(param1);
        this.typeFilters.resetFilters(param1);
    }

    public function setData(param1:BoostersWindowFiltersVO):void {
        this.qualityFiltersLabelTf.htmlText = param1.qualityFiltersLabel;
        this.typeFiltersLabelTf.htmlText = param1.typeFiltersLabel;
        var _loc2_:ICommons = App.utils.commons;
        _loc2_.updateTextFieldSize(this.qualityFiltersLabelTf, true, false);
        _loc2_.updateTextFieldSize(this.typeFiltersLabelTf, true, false);
        this.qualityFilters.setData(param1.qualityFilters);
        this.typeFilters.setData(param1.typeFilters);
        this.qualityFiltersLabelTf.visible = false;
        this.typeFiltersLabelTf.visible = false;
        this.qualityFilters.visible = false;
        this.typeFilters.visible = false;
        invalidate(INVALID_FILTERS_SIZE);
    }

    private function layoutFilters():void {
        var _loc1_:int = 0;
        if (this.qualityFilters.width > 0) {
            _loc1_ = this.layoutFilterGroup(_loc1_, this.qualityFilters, this.qualityFiltersLabelTf);
        }
        if (this.typeFilters.width > 0) {
            this.layoutFilterGroup(_loc1_, this.typeFilters, this.typeFiltersLabelTf);
        }
    }

    private function layoutFilterGroup(param1:int, param2:DisplayObject, param3:DisplayObject):int {
        param3.visible = true;
        param2.visible = true;
        param3.x = param1;
        param1 = param1 + (param3.width + LABEL_FILTERS_GAP);
        param2.x = param1;
        param1 = param1 + (param2.width + FILTERS_GAP);
        return param1;
    }

    private function setupFilters(param1:ButtonFilters):void {
        param1.layout = new HorizontalGroupLayout(FILTERS_BUTTON_GAP, false);
        param1.buttonLinkage = Linkages.BUTTON_BLACK;
    }

    private function onFiltersResizeHandler(param1:Event):void {
        invalidate(INVALID_FILTERS_SIZE);
    }

    private function onChangeFiltersHandler(param1:FiltersEvent):void {
        var _loc2_:* = this.qualityFilters.filtersValue | this.typeFilters.filtersValue;
        dispatchEvent(new FiltersEvent(FiltersEvent.FILTERS_CHANGED, _loc2_));
    }
}
}
