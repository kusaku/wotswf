package net.wg.gui.lobby.components {
import flash.display.MovieClip;
import flash.geom.Point;

public class ResizableViewStack extends DataViewStack {

    private static const OFFSET_INVALID:String = "layoutInv";

    private static const AVAILABLE_SIZE_INV:String = "availSizeInv";

    private var availableSize:Point = null;

    private var _centerOffset:int = 0;

    public function ResizableViewStack() {
        super();
    }

    override public function show(param1:String):MovieClip {
        var _loc2_:IResizableContent = IResizableContent(currentView);
        var _loc3_:MovieClip = super.show(param1);
        if (_loc2_) {
            _loc2_.active = false;
        }
        _loc2_ = IResizableContent(_loc3_);
        _loc2_.active = true;
        if (this.availableSize) {
            _loc2_.setViewSize(this.availableSize.x, this.availableSize.y);
        }
        _loc2_.centerOffset = this._centerOffset;
        return _loc3_;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(AVAILABLE_SIZE_INV)) {
            if (this.availableSize && currentView) {
                IResizableContent(currentView).setViewSize(this.availableSize.x, this.availableSize.y);
            }
        }
        if (isInvalid(OFFSET_INVALID)) {
            if (currentView) {
                IResizableContent(currentView).centerOffset = this._centerOffset;
            }
        }
    }

    override protected function onDispose():void {
        this.availableSize = null;
        super.onDispose();
    }

    public function setAvailableSize(param1:Number, param2:Number):void {
        if (this.availableSize == null) {
            this.availableSize = new Point();
        }
        this.availableSize.x = param1;
        this.availableSize.y = param2;
        invalidate(AVAILABLE_SIZE_INV);
    }

    public function set centerOffset(param1:int):void {
        this._centerOffset = param1;
        invalidate(OFFSET_INVALID);
    }
}
}
