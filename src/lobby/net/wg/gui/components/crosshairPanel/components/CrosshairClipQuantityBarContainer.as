package net.wg.gui.components.crosshairPanel.components {
import flash.utils.getDefinitionByName;

import net.wg.data.constants.Values;
import net.wg.infrastructure.base.SimpleContainer;

public class CrosshairClipQuantityBarContainer extends SimpleContainer {

    private static const MEDIUM_LIMIT:int = 31;

    private static const HEAVY_LIMIT:int = 13;

    private static const LIGHT_CLIP_QUANTITY_BAR_TOTAL_FRAMES:int = 100;

    private static const MEDIUM_CLIP_QUANTITY_BAR_TOTAL_FRAMES:int = 31;

    private static const HEAVY_CLIP_QUANTITY_BAR_TOTAL_FRAMES:int = 13;

    public static const TYPE_LIGHT:String = "CrosshairLightClipQuantityBarUI";

    public static const TYPE_MEDIUM:String = "CrosshairMediumClipQuantityBarUI";

    public static const TYPE_HEAVY:String = "CrosshairHeavyClipQuantityBarUI";

    private static const CLIP_CAPACITY_VALIDATION:String = "clipCapacity";

    private var _clipCapacity:Number = -1;

    private var _burst:Number = -1;

    private var _currBar:CrosshairClipQuantityBar = null;

    private var _quantityInClip:Number = -1;

    private var _clipState:String = "normal";

    private var _isReloaded:Boolean = false;

    public function CrosshairClipQuantityBarContainer() {
        super();
    }

    override protected function onDispose():void {
        if (this._currBar) {
            this._currBar.dispose();
            this._currBar = null;
        }
    }

    override protected function draw():void {
        var viewType:String = null;
        var mode:String = null;
        var clipTotalFrames:Number = NaN;
        var metric:Number = NaN;
        var viewClass:Class = null;
        super.draw();
        if (isInvalid(CLIP_CAPACITY_VALIDATION)) {
            if (this._clipCapacity > 1) {
                if (!this._currBar) {
                    viewType = TYPE_LIGHT;
                    mode = CrosshairClipQuantityBar.MODE_PERCENT;
                    clipTotalFrames = LIGHT_CLIP_QUANTITY_BAR_TOTAL_FRAMES;
                    metric = this._clipCapacity;
                    if (this._burst > 1) {
                        metric = Math.ceil(this._clipCapacity / this._burst);
                    }
                    if (metric < HEAVY_LIMIT) {
                        viewType = TYPE_HEAVY;
                        if (this._burst > 1) {
                            mode = CrosshairClipQuantityBar.MODE_QUEUE;
                            clipTotalFrames = Math.min(metric + 1, HEAVY_CLIP_QUANTITY_BAR_TOTAL_FRAMES);
                        }
                        else {
                            mode = CrosshairClipQuantityBar.MODE_AMMO;
                            clipTotalFrames = Math.min(this._clipCapacity + 1, HEAVY_CLIP_QUANTITY_BAR_TOTAL_FRAMES);
                        }
                    }
                    else if (metric < MEDIUM_LIMIT) {
                        viewType = TYPE_MEDIUM;
                        clipTotalFrames = MEDIUM_CLIP_QUANTITY_BAR_TOTAL_FRAMES;
                        if (this._burst > 1) {
                            mode = CrosshairClipQuantityBar.MODE_QUEUE;
                            clipTotalFrames = Math.min(metric + 1, MEDIUM_CLIP_QUANTITY_BAR_TOTAL_FRAMES);
                        }
                        else {
                            mode = CrosshairClipQuantityBar.MODE_AMMO;
                            clipTotalFrames = Math.min(this._clipCapacity + 1, MEDIUM_CLIP_QUANTITY_BAR_TOTAL_FRAMES);
                        }
                    }
                    try {
                        viewClass = getDefinitionByName(viewType) as Class;
                        this._currBar = new viewClass();
                        this._currBar.initialize(mode, this._clipCapacity, this._burst, clipTotalFrames);
                        addChild(this._currBar);
                        if (this._quantityInClip != Values.DEFAULT_INT) {
                            this._currBar.updateInfo(this._quantityInClip, this._clipState, this._isReloaded);
                        }
                    }
                    catch (error:Error) {
                    }
                }
            }
            else if (this._currBar) {
                this._currBar.dispose();
                removeChild(this._currBar);
                this._currBar = null;
            }
        }
    }

    public function updateInfo(param1:Number, param2:String, param3:Boolean):void {
        this._quantityInClip = param1;
        this._clipState = param2;
        this._isReloaded = param3;
        if (this._currBar) {
            this._currBar.updateInfo(this._quantityInClip, this._clipState, this._isReloaded);
        }
    }

    public function setClipsParam(param1:Number, param2:Number):void {
        if (this._clipCapacity != param1) {
            this._clipCapacity = param1;
            this._burst = param2;
            invalidate(CLIP_CAPACITY_VALIDATION);
        }
    }
}
}
