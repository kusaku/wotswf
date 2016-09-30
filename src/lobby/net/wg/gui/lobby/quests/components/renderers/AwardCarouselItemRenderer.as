package net.wg.gui.lobby.quests.components.renderers {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.gui.components.controls.Image;
import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
import net.wg.gui.lobby.quests.data.AwardCarouselItemRendererVO;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.managers.ITooltipMgr;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.core.UIComponent;

public class AwardCarouselItemRenderer extends UIComponentEx implements IScrollerItemRenderer {

    public var img:Image;

    public var txtLabel:TextField;

    public var txtCounter:TextField;

    public var hitMc:Sprite;

    private var _index:uint = 0;

    private var _owner:UIComponent;

    private var _data:AwardCarouselItemRendererVO;

    private var _toolTipMgr:ITooltipMgr;

    public function AwardCarouselItemRenderer() {
        super();
    }

    override protected function onDispose():void {
        this.img.removeEventListener(Event.CHANGE, this.onImgChangeHandler);
        this.img.dispose();
        this.img = null;
        this.txtLabel = null;
        this.txtCounter = null;
        this._data = null;
        this._toolTipMgr = null;
        this._owner = null;
        this.hitMc = null;
        removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverHandler);
        removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
        super.onDispose();
    }

    override protected function initialize():void {
        super.initialize();
        this.hitMc.visible = false;
        hitArea = this.hitMc;
    }

    override protected function configUI():void {
        super.configUI();
        this.txtCounter.autoSize = TextFieldAutoSize.LEFT;
        this.txtLabel.mouseEnabled = false;
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverHandler);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
    }

    private function updatePosition():void {
        if (this.img.scaleX != this._data.scaleImg || this.img.scaleY != this._data.scaleImg) {
            this.img.scaleX = this.img.scaleY = this._data.scaleImg;
        }
        this.img.x = width - this.img.width - this.txtCounter.width >> 1;
        this.img.y = height - this.img.height >> 1;
        this.txtCounter.x = this.img.x + this.img.width;
        this.txtCounter.y = height >> 1;
        var _loc1_:Number = Math.max(this.img.width, this.txtLabel.textWidth);
        var _loc2_:Number = Math.max(this.img.height, this.txtLabel.textHeight);
        this.hitMc.graphics.clear();
        this.hitMc.graphics.beginFill(16711680, 0);
        this.hitMc.graphics.drawRect(width - _loc1_ >> 1, height - _loc2_ >> 1, _loc1_, _loc2_);
        this.hitMc.graphics.endFill();
    }

    public function measureSize(param1:Point = null):Point {
        return null;
    }

    public function get index():uint {
        return this._index;
    }

    public function set index(param1:uint):void {
        this._index = param1;
    }

    public function get data():Object {
        return this._data;
    }

    public function set data(param1:Object):void {
        if (this._data != null) {
            this.img.removeEventListener(Event.CHANGE, this.onImgChangeHandler);
        }
        this._data = AwardCarouselItemRendererVO(param1);
        var _loc2_:* = this._data != null;
        if (_loc2_) {
            this.txtLabel.htmlText = this._data.label;
            this.txtCounter.htmlText = this._data.counter;
            this.img.source = this._data.imgSource;
            this.img.addEventListener(Event.CHANGE, this.onImgChangeHandler);
            this.updatePosition();
        }
        this.txtLabel.visible = this.txtCounter.visible = this.img.visible = _loc2_;
        mouseEnabled = _loc2_;
    }

    public function get owner():UIComponent {
        return this._owner;
    }

    public function set owner(param1:UIComponent):void {
        this._owner = param1;
    }

    public function get selected():Boolean {
        return false;
    }

    public function set selected(param1:Boolean):void {
    }

    public function set tooltipDecorator(param1:ITooltipMgr):void {
        this._toolTipMgr = param1;
    }

    private function onImgChangeHandler(param1:Event):void {
        this.updatePosition();
    }

    private function onMouseOverHandler(param1:MouseEvent):void {
        if (this._data.isSpecial) {
            this._toolTipMgr.showSpecial.apply(this, [this._data.specialAlias, null].concat(this._data.specialArgs));
        }
        else if (StringUtils.isNotEmpty(this._data.tooltip)) {
            this._toolTipMgr.showComplex(this._data.tooltip);
        }
    }

    private function onMouseOutHandler(param1:MouseEvent):void {
        this._toolTipMgr.hide();
    }
}
}
