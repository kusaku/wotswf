package net.wg.gui.cyberSport.controls {
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.events.UILoaderEvent;

public class CSLadderIconButton extends SoundButtonEx {

    private static var INVALIDATE_ICON_ENABLED:String = "restoreEnable";

    public var loaderTop:CSAnimationIcon = null;

    public var loaderBottom:CSAnimationIcon = null;

    private var _loaderTopLoadCompleted:Boolean = false;

    private var _loaderBottomLoadCompleted:Boolean = false;

    private var _restoreEnable:Boolean = false;

    public function CSLadderIconButton() {
        super();
    }

    override protected function onDispose():void {
        this.loaderTop.icon.removeEventListener(UILoaderEvent.COMPLETE, this.onLoaderTopLoadedHandler);
        this.loaderTop.dispose();
        this.loaderTop = null;
        this.loaderBottom.icon.removeEventListener(UILoaderEvent.COMPLETE, this.onLoaderBottomLoadedHandler);
        this.loaderBottom.dispose();
        this.loaderBottom = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.loaderTop.icon.autoSize = false;
        this.loaderBottom.icon.autoSize = false;
        this.loaderTop.icon.addEventListener(UILoaderEvent.COMPLETE, this.onLoaderTopLoadedHandler);
        this.loaderBottom.icon.addEventListener(UILoaderEvent.COMPLETE, this.onLoaderBottomLoadedHandler);
        scaleX = scaleY = 1;
    }

    public function setSource(param1:String, param2:Boolean):void {
        this.enabled = false;
        this._restoreEnable = param2;
        this._loaderBottomLoadCompleted = false;
        this._loaderTopLoadCompleted = false;
        if (this.loaderTop.icon.source == param1) {
            this.restoreEnabled();
        }
        this.loaderTop.icon.source = param1;
        this.loaderBottom.icon.source = param1;
    }

    private function onImageLoaded():void {
        if (this._loaderBottomLoadCompleted && this._loaderTopLoadCompleted) {
            this.restoreEnabled();
        }
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALIDATE_ICON_ENABLED)) {
            this.enabled = this._restoreEnable;
        }
    }

    private function restoreEnabled():void {
        invalidate(INVALIDATE_ICON_ENABLED);
    }

    private function onLoaderBottomLoadedHandler(param1:UILoaderEvent):void {
        this._loaderBottomLoadCompleted = true;
        this.onImageLoaded();
    }

    private function onLoaderTopLoadedHandler(param1:UILoaderEvent):void {
        this._loaderTopLoadCompleted = true;
        this.onImageLoaded();
    }
}
}
