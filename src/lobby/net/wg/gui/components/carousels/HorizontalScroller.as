package net.wg.gui.components.carousels {
import flash.display.DisplayObject;
import flash.events.Event;
import flash.geom.Rectangle;

import net.wg.gui.components.carousels.interfaces.IHorizontalScrollerCursorManager;
import net.wg.gui.components.controls.ScrollBar;
import net.wg.gui.components.controls.events.ScrollBarEvent;
import net.wg.gui.components.controls.events.ScrollEvent;
import net.wg.gui.components.controls.scroller.ScrollerBase;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.interfaces.IDataProvider;

public class HorizontalScroller extends ScrollerBase {

    private static const D_START_DRAG:Number = 4;

    private static const INVALIDATION_TYPE_SCROLLBAR:String = "invalidationTypeScrollbar";

    private static const ACCELERATION:int = 3;

    private static const INVALID_GO_TO_INDEX:String = "invalidGoToIndex";

    private static const VIEW_PORT_NAME:String = "viewPort";

    private var _itemRendererFactory:Class;

    private var _itemRendererLinkage:String;

    private var _measuredTypicalItemRendererWidth:Number = NaN;

    private var _dataProvider:IDataProvider = null;

    private var _snapScrollPositionToItemRendererSize:Boolean = false;

    private var _gap:Number = 0;

    private var _rendererWidth:Number = 0;

    private var _cursorManager:IHorizontalScrollerCursorManager = null;

    private var _equableScrolling:Boolean = false;

    private var _leftScrolling:Boolean = false;

    private var _rightScrolling:Boolean = false;

    private var _selectedIndex:int = -1;

    private var _scrollbarRef:ScrollBar = null;

    private var _scrollBarHandlingInProgress:Boolean = false;

    private var _ignoreScrollBarHandler:Boolean = false;

    private var _expectTargetPosition:Number = 0;

    private var _tooltipDecorator:TooltipDecorator = null;

    private var _goToOffset:Number = 0;

    private var _goToIndex:int = -1;

    private var _rowCount:int = 1;

    private var _scrollIfRendererVisible:Boolean = false;

    private var _goToDuration:Number = 0;

    public function HorizontalScroller() {
        super();
    }

    override protected function createMask():void {
        super.createMask();
        var _loc1_:Rectangle = new Rectangle(viewPortOffsetLeft, viewPortOffsetTop, width - viewPortOffsetLeft - viewPortOffsetRight, height - viewPortOffsetTop - viewPortOffsetBottom);
        this._cursorManager.setTouchRect(_loc1_);
    }

    override protected function layoutChildren():void {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        super.layoutChildren();
        if (this._scrollbarRef != null && this._dataProvider != null && isInvalid(InvalidationType.DATA, InvalidationType.SIZE, HorizontalScroller.INVALIDATION_TYPE_SCROLLBAR)) {
            _loc1_ = this._measuredTypicalItemRendererWidth + this._gap;
            _loc2_ = this._dataProvider.length * _loc1_ - width - this._gap;
            this._scrollbarRef.setScrollProperties(width, 0, _loc2_, _loc1_);
        }
        if (this._scrollbarRef != null && !this._scrollBarHandlingInProgress) {
            this._ignoreScrollBarHandler = true;
            this._scrollbarRef.position = horizontalScrollPosition;
            this._ignoreScrollBarHandler = false;
        }
        this._scrollBarHandlingInProgress = false;
    }

    override protected function configUI():void {
        super.configUI();
        this._tooltipDecorator = new TooltipDecorator();
        var _loc1_:HorizontalScrollerViewPort = new HorizontalScrollerViewPort();
        _loc1_.owner = this;
        _loc1_.gap = this._gap;
        _loc1_.setSelectedIndex(this._selectedIndex);
        _loc1_.tooltipDecorator = this._tooltipDecorator;
        _loc1_.name = VIEW_PORT_NAME;
        viewPort = _loc1_;
        this._cursorManager = new HorizontalScrollerCursorManager();
        container.addChildAt(DisplayObject(this._cursorManager), 0);
        dStartDragX = D_START_DRAG;
        dStartDragY = Number.MAX_VALUE;
    }

    override protected function onDispose():void {
        this.unsubFromScrollbar();
        this._scrollbarRef = null;
        this._itemRendererFactory = null;
        if (viewPort != null) {
            viewPort.dispose();
        }
        if (this._cursorManager != null) {
            this._cursorManager.dispose();
            this._cursorManager = null;
        }
        if (this._dataProvider != null) {
            this._dataProvider.removeEventListener(Event.CHANGE, this.onDataProviderChangeHandler);
            this._dataProvider = null;
        }
        if (this._tooltipDecorator != null) {
            this._tooltipDecorator.dispose();
            this._tooltipDecorator = null;
        }
        super.onDispose();
    }

    override protected function updateScrollPosition():void {
        var _loc2_:int = 0;
        var _loc3_:Number = NaN;
        var _loc1_:Boolean = isInvalid(INVALID_GO_TO_INDEX);
        if (_loc1_) {
            if (this._goToIndex >= 0) {
                _loc2_ = int(width / pageWidth * this._goToOffset) * pageWidth;
                _loc3_ = (this._goToIndex / this._rowCount ^ 0) * pageWidth - _loc2_;
                if (_loc3_ > maxHorizontalScrollPosition) {
                    _loc3_ = maxHorizontalScrollPosition;
                }
                else if (_loc3_ < minHorizontalScrollPosition) {
                    _loc3_ = minHorizontalScrollPosition;
                }
                if (this._scrollIfRendererVisible || horizontalScrollPosition > _loc3_ || horizontalScrollPosition + width <= _loc3_) {
                    this.startScroll();
                    throwToHorizontalPosition(_loc3_, this._goToDuration);
                }
            }
        }
        super.updateScrollPosition();
        if (_loc1_) {
            viewPort.validateNow();
        }
    }

    override protected function draw():void {
        var _loc1_:* = false;
        this.refreshDataViewPortProperties();
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            _loc1_ = maxHorizontalScrollPosition != minHorizontalScrollPosition;
            this._cursorManager.enable = _loc1_;
            if (this._scrollbarRef != null) {
                this._scrollbarRef.visible = _loc1_;
            }
            if (hasEventListener(Event.RESIZE)) {
                dispatchEvent(new Event(Event.RESIZE));
            }
        }
    }

    override protected function horizontalTweenEase(param1:Number):Number {
        if (this._equableScrolling) {
            return ACCELERATION * param1;
        }
        return super.horizontalTweenEase(param1);
    }

    override protected function initTouchScroll():void {
        if (maxHorizontalScrollPosition != minHorizontalScrollPosition) {
            super.initTouchScroll();
        }
    }

    override protected function startTouchScroll():void {
        this._cursorManager.startTouchScroll();
        mouseChildren = false;
        super.startTouchScroll();
    }

    override protected function completeTouchScroll():void {
        super.completeTouchScroll();
        this._cursorManager.stopTouchScroll();
        mouseChildren = true;
    }

    override protected function completeScroll():void {
        this._tooltipDecorator.enabled = true;
        super.completeScroll();
    }

    override protected function startScroll():void {
        this._tooltipDecorator.enabled = false;
        super.startScroll();
    }

    public function goToItem(param1:int, param2:Boolean):void {
        this._goToIndex = param1;
        this._scrollIfRendererVisible = param2;
        invalidate(INVALID_GO_TO_INDEX);
    }

    public function setScrollbar(param1:ScrollBar):void {
        this.unsubFromScrollbar();
        this._scrollbarRef = param1;
        if (this._scrollbarRef != null) {
            this._scrollbarRef.addEventListener(Event.SCROLL, this.onScrollbarRefScrollHandler);
            this._scrollbarRef.addEventListener(ScrollBarEvent.ON_END_DRAG, this.onScrollBarRefOnEndDragHandler);
        }
        invalidate(INVALIDATION_TYPE_SCROLLBAR);
    }

    public function startScrollLeft():void {
        var _loc1_:Number = NaN;
        if (this.availableScrollLeft) {
            if (!this._leftScrolling) {
                this._expectTargetPosition = horizontalScrollPosition - pageWidth;
            }
            else {
                this._expectTargetPosition = this._expectTargetPosition - pageWidth;
            }
            _loc1_ = horizontalScrollPosition / pageWidth;
            throwToHorizontalPosition(minHorizontalScrollPosition, pageThrowDuration * _loc1_);
            this._equableScrolling = true;
            this._leftScrolling = true;
            this.startScroll();
        }
    }

    public function startScrollRight():void {
        var _loc1_:Number = NaN;
        if (this.availableScrollRight) {
            if (!this._rightScrolling) {
                this._expectTargetPosition = horizontalScrollPosition + pageWidth;
            }
            else {
                this._expectTargetPosition = this._expectTargetPosition + pageWidth;
            }
            _loc1_ = (maxHorizontalScrollPosition - horizontalScrollPosition) / pageWidth;
            throwToHorizontalPosition(maxHorizontalScrollPosition, pageThrowDuration * _loc1_);
            this._equableScrolling = true;
            this._rightScrolling = true;
            this.startScroll();
        }
    }

    public function stopScroll():void {
        if (this._leftScrolling) {
            if (this._expectTargetPosition > horizontalScrollPosition) {
                throwToHorizontalPosition(roundDownToNearest(horizontalScrollPosition, pageWidth), pageThrowDuration);
            }
            else {
                throwToHorizontalPosition(roundDownToNearest(this._expectTargetPosition, pageWidth), pageThrowDuration);
            }
            this._equableScrolling = false;
            this._leftScrolling = false;
        }
        if (this._rightScrolling) {
            if (this._expectTargetPosition < horizontalScrollPosition) {
                throwToHorizontalPosition(roundUpToNearest(horizontalScrollPosition, pageWidth), pageThrowDuration);
            }
            else {
                throwToHorizontalPosition(roundUpToNearest(this._expectTargetPosition, pageWidth), pageThrowDuration);
            }
            this._equableScrolling = false;
            this._rightScrolling = false;
        }
    }

    private function refreshDataViewPortProperties():void {
        if (isInvalid(InvalidationType.DATA)) {
            this.dataViewPort.dataProvider = this._dataProvider;
        }
        if (isInvalid(InvalidationType.SETTINGS)) {
            this.dataViewPort.rendererWidth = this._rendererWidth;
            this.dataViewPort.itemRendererFactory = this._itemRendererFactory;
            this.dataViewPort.rowCount = this._rowCount;
            this.dataViewPort.gap = this._gap;
            this._measuredTypicalItemRendererWidth = this.dataViewPort.rendererWidth;
        }
    }

    private function unsubFromScrollbar():void {
        if (this._scrollbarRef != null) {
            this._scrollbarRef.removeEventListener(Event.SCROLL, this.onScrollbarRefScrollHandler);
            this._scrollbarRef.removeEventListener(ScrollBarEvent.ON_END_DRAG, this.onScrollBarRefOnEndDragHandler);
        }
    }

    override public function get horizontalScrollStep():Number {
        var _loc1_:Number = super.horizontalScrollStep;
        if (this._snapScrollPositionToItemRendererSize && _loc1_ !== _loc1_) {
            _loc1_ = this._measuredTypicalItemRendererWidth;
        }
        return _loc1_;
    }

    public function get selectedIndex():int {
        if (viewPort != null) {
            return this.dataViewPort.selectedIndex;
        }
        return this._selectedIndex;
    }

    public function set selectedIndex(param1:int):void {
        if (viewPort != null) {
            this.dataViewPort.setSelectedIndex(param1);
        }
        this._selectedIndex = param1;
    }

    public function get gap():Number {
        return this._gap;
    }

    public function set gap(param1:Number):void {
        this._gap = param1;
        invalidate(InvalidationType.SETTINGS);
    }

    public function get itemRendererClassReference():String {
        return this._itemRendererLinkage;
    }

    public function set itemRendererClassReference(param1:String):void {
        if (!StringUtils.isEmpty(param1)) {
            this._itemRendererLinkage = param1;
            this._itemRendererFactory = App.instance.utils.classFactory.getClass(param1);
            invalidate(InvalidationType.SETTINGS);
        }
    }

    public function get snapScrollPositionToItemRendererSize():Boolean {
        return this._snapScrollPositionToItemRendererSize;
    }

    public function set snapScrollPositionToItemRendererSize(param1:Boolean):void {
        this._snapScrollPositionToItemRendererSize = param1;
    }

    public function get dataProvider():IDataProvider {
        return this._dataProvider;
    }

    public function set dataProvider(param1:IDataProvider):void {
        if (param1 != this._dataProvider) {
            if (this._dataProvider != null) {
                this._dataProvider.removeEventListener(Event.CHANGE, this.onDataProviderChangeHandler);
            }
            this._dataProvider = param1;
            if (this._dataProvider != null) {
                this._dataProvider.addEventListener(Event.CHANGE, this.onDataProviderChangeHandler);
            }
            invalidate(InvalidationType.DATA);
        }
    }

    public function set goToOffset(param1:Number):void {
        this._goToOffset = param1;
    }

    public function get availableScrollLeft():Boolean {
        return horizontalScrollPosition > minHorizontalScrollPosition;
    }

    public function get availableScrollRight():Boolean {
        return horizontalScrollPosition < maxHorizontalScrollPosition;
    }

    public function get rendererWidth():Number {
        return this._rendererWidth;
    }

    public function set rendererWidth(param1:Number):void {
        this._rendererWidth = param1;
        invalidate(InvalidationType.SETTINGS);
    }

    public function get measuredTypicalItemRendererWidth():Number {
        return this._measuredTypicalItemRendererWidth;
    }

    public function get rowCount():int {
        return this._rowCount;
    }

    public function set rowCount(param1:int):void {
        if (this._rowCount != param1) {
            this._rowCount = param1;
            invalidate(InvalidationType.SETTINGS);
        }
    }

    private function get dataViewPort():HorizontalScrollerViewPort {
        return HorizontalScrollerViewPort(this.viewPort);
    }

    private function onDataProviderChangeHandler(param1:Event):void {
        invalidate(InvalidationType.DATA);
    }

    private function onScrollBarRefOnEndDragHandler(param1:Event):void {
        finishHorizontalScroll();
    }

    private function onScrollbarRefScrollHandler(param1:Event):void {
        if (!this._ignoreScrollBarHandler) {
            this._scrollBarHandlingInProgress = true;
            this.startScroll();
            throwToHorizontalPosition(this._scrollbarRef.position, 0);
            this.completeScroll();
            dispatchEvent(new ScrollEvent(ScrollEvent.SCROLL_COMPLETE));
        }
    }

    public function get goToDuration():Number {
        return this._goToDuration;
    }

    public function set goToDuration(param1:Number):void {
        this._goToDuration = param1;
    }
}
}
