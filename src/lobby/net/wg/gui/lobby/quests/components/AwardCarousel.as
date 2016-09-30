package net.wg.gui.lobby.quests.components {
import flash.events.Event;

import net.wg.gui.components.carousels.ScrollCarousel;

import scaleform.clik.interfaces.IDataProvider;

public class AwardCarousel extends ScrollCarousel {

    private static const ITEMS_ON_PAGE:int = 3;

    private static const RENDERER_WIDTH:int = 116;

    private static const GO_TO_DURATION:Number = 0.5;

    private var _dataProvider:IDataProvider;

    public function AwardCarousel() {
        super();
    }

    override protected function onDispose():void {
        if (this._dataProvider != null) {
            this._dataProvider.removeEventListener(Event.CHANGE, this.onDataProviderChangeHandler);
            this._dataProvider = null;
        }
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        rendererWidth = RENDERER_WIDTH;
        pageWidth = RENDERER_WIDTH * ITEMS_ON_PAGE;
        scrollList.goToDuration = GO_TO_DURATION;
        scrollList.useTimer = true;
        scrollList.cropContent = true;
        scrollList.snapToPages = true;
    }

    private function enableCarousel(param1:Boolean):void {
        leftArrow.visible = rightArrow.visible = param1;
        scrollList.mouseWheelEnabled = param1;
        scrollList.goToDuration = 0;
        goToItem(0);
        scrollList.validateNow();
        scrollList.goToDuration = GO_TO_DURATION;
        if (!param1) {
            scrollList.horizontalScrollPosition = this._dataProvider.length * RENDERER_WIDTH - scrollList.width >> 1;
        }
    }

    override public function set dataProvider(param1:IDataProvider):void {
        super.dataProvider = param1;
        if (param1 != this._dataProvider) {
            if (this._dataProvider != null) {
                this._dataProvider.removeEventListener(Event.CHANGE, this.onDataProviderChangeHandler);
            }
            this._dataProvider = param1;
            if (this._dataProvider != null) {
                this._dataProvider.addEventListener(Event.CHANGE, this.onDataProviderChangeHandler);
                this.enableCarousel(this._dataProvider.length > ITEMS_ON_PAGE);
            }
            else {
                this.enableCarousel(false);
            }
        }
    }

    private function onDataProviderChangeHandler(param1:Event):void {
        this.enableCarousel(this._dataProvider.length > ITEMS_ON_PAGE);
    }
}
}
