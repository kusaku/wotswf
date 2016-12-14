package net.wg.gui.components.carousels {
import flash.events.Event;

import net.wg.gui.components.controls.events.ScrollEvent;
import net.wg.gui.interfaces.ISoundButton;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.DirectionMode;
import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.interfaces.IDataProvider;

public class ScrollCarousel extends UIComponentEx {

    public var leftArrow:ISoundButton = null;

    public var rightArrow:ISoundButton = null;

    public var scrollList:HorizontalScroller = null;

    private var _isArrowScroll:Boolean = false;

    private var _roundCountRenderer:Boolean = true;

    public function ScrollCarousel() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.leftArrow.addEventListener(ButtonEvent.PRESS, this.onLeftArrowPressHandler);
        this.leftArrow.addEventListener(ButtonEvent.CLICK, this.onArrowReleaseHandler);
        this.leftArrow.addEventListener(ButtonEvent.RELEASE_OUTSIDE, this.onArrowReleaseHandler);
        this.rightArrow.addEventListener(ButtonEvent.PRESS, this.onRightArrowPressHandler);
        this.rightArrow.addEventListener(ButtonEvent.CLICK, this.onArrowReleaseHandler);
        this.rightArrow.addEventListener(ButtonEvent.RELEASE_OUTSIDE, this.onArrowReleaseHandler);
        this.scrollList.mouseWheelDirection = DirectionMode.HORIZONTAL;
        this.scrollList.addEventListener(ScrollEvent.SCROLL_COMPLETE, this.onScrollListScrollCompleteHandler);
        this.scrollList.addEventListener(ScrollEvent.SCROLL_START, this.onScrollListScrollStartHandler);
        this.scrollList.addEventListener(Event.RESIZE, this.onScrollListResizeHandler);
    }

    override protected function onDispose():void {
        this.leftArrow.removeEventListener(ButtonEvent.PRESS, this.onLeftArrowPressHandler);
        this.leftArrow.removeEventListener(ButtonEvent.CLICK, this.onArrowReleaseHandler);
        this.leftArrow.removeEventListener(ButtonEvent.RELEASE_OUTSIDE, this.onArrowReleaseHandler);
        this.rightArrow.removeEventListener(ButtonEvent.PRESS, this.onRightArrowPressHandler);
        this.rightArrow.removeEventListener(ButtonEvent.CLICK, this.onArrowReleaseHandler);
        this.rightArrow.removeEventListener(ButtonEvent.RELEASE_OUTSIDE, this.onArrowReleaseHandler);
        this.scrollList.removeEventListener(ScrollEvent.SCROLL_COMPLETE, this.onScrollListScrollCompleteHandler);
        this.scrollList.removeEventListener(ScrollEvent.SCROLL_START, this.onScrollListScrollStartHandler);
        this.scrollList.removeEventListener(Event.RESIZE, this.onScrollListResizeHandler);
        if (this._isArrowScroll) {
            this.scrollList.stopScroll();
        }
        this.scrollList.dispose();
        this.scrollList = null;
        this.leftArrow.dispose();
        this.leftArrow = null;
        this.rightArrow.dispose();
        this.rightArrow = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            if (this.scrollList.pageWidth == 0) {
                this.scrollList.validateNow();
            }
            this.updateLayout(width);
        }
    }

    public function goToItem(param1:int, param2:Boolean = false):void {
        this.scrollList.goToItem(param1, param2);
    }

    protected function updateLayout(param1:Number, param2:Number = 0):void {
        var _loc3_:Number = this.leftArrow.x - this.scrollList.x >> 0;
        var _loc4_:Number = this.rightArrow.x - this.scrollList.x - this.scrollList.width >> 0;
        var _loc5_:Number = param1 + _loc3_ - _loc4_;
        var _loc6_:Number = this.scrollList.width >> 0;
        if (this._roundCountRenderer) {
            _loc5_ = (_loc5_ / this.scrollList.pageWidth >> 0) * this.scrollList.pageWidth - this.scrollList.gap;
        }
        if (_loc6_ != _loc5_) {
            this.scrollList.width = _loc5_;
        }
        this.scrollList.x = (param1 - _loc5_ >> 1) + param2;
        this.leftArrow.x = this.scrollList.x + _loc3_;
        this.rightArrow.x = this.scrollList.x + _loc5_ + _loc4_;
    }

    protected function scrollListResizeComplete():void {
        this.updateAvailableScroll(this.scrollList.availableScrollLeft, this.scrollList.availableScrollRight);
    }

    protected function updateAvailableScroll(param1:Boolean, param2:Boolean):void {
        this.leftArrow.enabled = param1;
        this.rightArrow.enabled = param2;
    }

    public function get rendererWidth():Number {
        return this.scrollList.rendererWidth;
    }

    public function set rendererWidth(param1:Number):void {
        this.scrollList.rendererWidth = param1;
    }

    public function set dataProvider(param1:IDataProvider):void {
        this.scrollList.dataProvider = param1;
    }

    public function get pageWidth():Number {
        return this.scrollList.pageWidth;
    }

    public function set pageWidth(param1:Number):void {
        this.scrollList.pageWidth = param1;
    }

    public function get selectedIndex():int {
        return this.scrollList.selectedIndex;
    }

    public function set selectedIndex(param1:int):void {
        this.scrollList.selectedIndex = param1;
    }

    public function get itemRenderer():String {
        return this.scrollList.itemRendererClassReference;
    }

    public function set itemRenderer(param1:String):void {
        this.scrollList.itemRendererClassReference = param1;
    }

    public function get gap():Number {
        return this.scrollList.gap;
    }

    public function set gap(param1:Number):void {
        this.scrollList.gap = param1;
    }

    public function get roundCountRenderer():Boolean {
        return this._roundCountRenderer;
    }

    public function set roundCountRenderer(param1:Boolean):void {
        this._roundCountRenderer = param1;
        invalidateSize();
    }

    private function onScrollListResizeHandler(param1:Event):void {
        this.scrollListResizeComplete();
    }

    private function onLeftArrowPressHandler(param1:ButtonEvent):void {
        this._isArrowScroll = true;
        this.scrollList.startScrollLeft();
    }

    private function onRightArrowPressHandler(param1:ButtonEvent):void {
        this._isArrowScroll = true;
        this.scrollList.startScrollRight();
    }

    private function onArrowReleaseHandler(param1:Event):void {
        this._isArrowScroll = false;
        this.scrollList.stopScroll();
    }

    private function onScrollListScrollCompleteHandler(param1:Event):void {
        this.updateAvailableScroll(this.scrollList.availableScrollLeft, this.scrollList.availableScrollRight);
        if (this._isArrowScroll) {
            this._isArrowScroll = false;
            this.scrollList.stopScroll();
        }
    }

    private function onScrollListScrollStartHandler(param1:Event):void {
        this.updateAvailableScroll(true, true);
    }
}
}
