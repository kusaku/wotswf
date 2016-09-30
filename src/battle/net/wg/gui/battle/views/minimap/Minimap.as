package net.wg.gui.battle.views.minimap {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;

import net.wg.gui.battle.views.minimap.constants.MinimapSizeConst;
import net.wg.gui.battle.views.minimap.containers.MinimapEntriesContainer;
import net.wg.gui.battle.views.minimap.events.MinimapEvent;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.infrastructure.base.meta.IMinimapMeta;
import net.wg.infrastructure.base.meta.impl.MinimapMeta;

import scaleform.gfx.MouseEventEx;

public class Minimap extends MinimapMeta implements IMinimapMeta {

    public var mapHit:MovieClip = null;

    public var foreground0:MovieClip = null;

    public var foreground1:MovieClip = null;

    public var foreground2:MovieClip = null;

    public var foreground3:MovieClip = null;

    public var foreground4:MovieClip = null;

    public var foreground5:MovieClip = null;

    private var _foregrounds:Vector.<MovieClip> = null;

    private var _currForeground:MovieClip = null;

    private var _currentSizeIndex:int = 0;

    private var _updateSizeIndexForce:Boolean = false;

    public var entriesContainerMask:MovieClip = null;

    public var entriesContainer:MinimapEntriesContainer = null;

    public var background:UILoaderAlt = null;

    private var _clickAreaSpr:Sprite = null;

    public function Minimap() {
        super();
        this._foregrounds = new <MovieClip>[this.foreground0, this.foreground1, this.foreground2, this.foreground3, this.foreground4, this.foreground5];
        this.foreground0.visible = this.foreground1.visible = this.foreground2.visible = this.foreground3.visible = this.foreground4.visible = this.foreground5.visible = false;
        this._currForeground = this.foreground0;
        this.entriesContainerMask.cacheAsBitmap = true;
        this.entriesContainer.mask = this.entriesContainerMask;
        this._clickAreaSpr = new Sprite();
        addChildAt(this._clickAreaSpr, getChildIndex(this.mapHit));
        this.mapHit.visible = false;
        this._clickAreaSpr.hitArea = this.mapHit;
    }

    public function as_setAlpha(param1:Number):void {
        alpha = param1;
    }

    public function as_setSize(param1:int):void {
        if (!initialized) {
            this._currentSizeIndex = param1;
        }
        else {
            this.checkNewSize(param1);
        }
    }

    private function checkNewSize(param1:int):void {
        dispatchEvent(new MinimapEvent(MinimapEvent.TRY_SIZE_CHANGED, false, false, param1));
    }

    public function getMinimapRectBySizeIndex(param1:int):Rectangle {
        var _loc2_:int = this._currentSizeIndex;
        if (param1 >= 0 && param1 < MinimapSizeConst.MAP_SIZE.length) {
            _loc2_ = param1;
        }
        return new Rectangle(0, 0, initedWidth - MinimapSizeConst.MAP_SIZE[_loc2_].x, initedHeight - MinimapSizeConst.MAP_SIZE[_loc2_].y);
    }

    public function updateSizeIndex(param1:Boolean):void {
        this._updateSizeIndexForce = param1;
        this.checkNewSize(this._currentSizeIndex);
    }

    public function setAllowedSizeIndex(param1:Number):void {
        if ((this._currentSizeIndex != param1 || this._updateSizeIndexForce) && initialized) {
            this._currentSizeIndex = param1;
            dispatchEvent(new MinimapEvent(MinimapEvent.SIZE_CHANGED));
            this.updateContent();
            applyNewSizeS(param1);
        }
        else {
            this._currentSizeIndex = param1;
        }
        this._updateSizeIndexForce = false;
    }

    public function as_setVisible(param1:Boolean):void {
        visible = param1;
        dispatchEvent(new MinimapEvent(MinimapEvent.VISIBILITY_CHANGED));
    }

    public function as_showVehiclesName(param1:Boolean):void {
        if (param1) {
            MinimapEntryController.instance.showVehiclesName();
        }
        else {
            MinimapEntryController.instance.hideVehiclesName();
        }
    }

    public function as_setBackground(param1:String):void {
        this.background.source = param1;
    }

    public function get currentTopLeftPoint():Point {
        var _loc1_:Rectangle = MinimapSizeConst.MAP_SIZE[this._currentSizeIndex];
        return _loc1_.topLeft;
    }

    override protected function configUI():void {
        super.configUI();
        this.updateSizeIndex(true);
        this._clickAreaSpr.addEventListener(MouseEvent.CLICK, this.onMouseClickHandler);
    }

    private function updateContent():void {
        this._currForeground.visible = false;
        this._currForeground = this._foregrounds[this._currentSizeIndex];
        this._currForeground.visible = true;
        this.updateContainersSize();
    }

    public function getMessageCoordinate():Number {
        return initedHeight - this.currentTopLeftPoint.y;
    }

    private function updateContainersSize():void {
        var _loc1_:Rectangle = MinimapSizeConst.MAP_SIZE[this._currentSizeIndex];
        this.background.width = _loc1_.width;
        this.background.height = _loc1_.height;
        this.background.x = _loc1_.x;
        this.background.y = _loc1_.y;
        var _loc2_:Point = MinimapSizeConst.ENTRY_CONTAINER_POINT[this._currentSizeIndex];
        this.entriesContainer.scaleX = this.background.scaleX;
        this.entriesContainer.scaleY = this.background.scaleY;
        MinimapEntryController.instance.updateScale(this._currentSizeIndex);
        this.entriesContainer.x = _loc2_.x;
        this.entriesContainer.y = _loc2_.y;
        this.entriesContainerMask.width = _loc1_.width;
        this.entriesContainerMask.height = _loc1_.height;
        this.entriesContainerMask.x = _loc2_.x;
        this.entriesContainerMask.y = _loc2_.y;
        this.mapHit.width = _loc1_.width;
        this.mapHit.height = _loc1_.height;
        this.mapHit.x = _loc1_.x;
        this.mapHit.y = _loc1_.y;
    }

    private function onMouseClickHandler(param1:MouseEvent):void {
        if (param1 is MouseEventEx && param1.target == this._clickAreaSpr) {
            setAttentionToCellS(this.mapHit.mouseX, this.mapHit.mouseY, MouseEventEx(param1).buttonIdx == MouseEventEx.RIGHT_BUTTON);
        }
    }

    public function get currentSizeIndex():Number {
        return this._currentSizeIndex;
    }

    override protected function onDispose():void {
        this.foreground0 = null;
        this.foreground1 = null;
        this.foreground2 = null;
        this.foreground3 = null;
        this.foreground4 = null;
        this.foreground5 = null;
        this._currForeground = null;
        if (this._foregrounds) {
            this._foregrounds.fixed = false;
            this._foregrounds.splice(0, this._foregrounds.length);
            this._foregrounds = null;
        }
        this._clickAreaSpr.removeEventListener(MouseEvent.CLICK, this.onMouseClickHandler);
        this._clickAreaSpr = null;
        this.entriesContainer.dispose();
        this.entriesContainer = null;
        this.entriesContainerMask = null;
        this.mapHit = null;
        this.background.dispose();
        this.background = null;
        super.onDispose();
    }
}
}
