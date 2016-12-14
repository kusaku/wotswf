package net.wg.gui.lobby.christmas.controls {
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.gui.components.controls.Image;
import net.wg.gui.lobby.christmas.event.ChristmasAwardRendererEvent;
import net.wg.gui.lobby.quests.data.AwardCarouselItemRendererVO;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.managers.ITooltipMgr;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;

public class ChristmasAwardRenderer extends UIComponentEx {

    public var countTF:TextField = null;

    public var image:Image = null;

    private var _toolTipMgr:ITooltipMgr;

    private var _model:AwardCarouselItemRendererVO = null;

    public function ChristmasAwardRenderer() {
        super();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            if (StringUtils.isNotEmpty(this._model.counter)) {
                this.countTF.htmlText = this._model.counter;
            }
            this.image.addEventListener(Event.CHANGE, this.onImageChangeHandler);
            this.image.source = this._model.imgSource;
        }
    }

    override protected function configUI():void {
        super.configUI();
        this._toolTipMgr = App.toolTipMgr;
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverHandler);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
    }

    override protected function onDispose():void {
        this.image.removeEventListener(Event.CHANGE, this.onImageChangeHandler);
        removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverHandler);
        removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
        this._toolTipMgr = null;
        this.countTF = null;
        this.image.dispose();
        this.image = null;
        this._model = null;
        super.onDispose();
    }

    public function setData(param1:AwardCarouselItemRendererVO):void {
        this._model = param1;
        if (this.image != null) {
            this.image.removeEventListener(Event.CHANGE, this.onImageChangeHandler);
        }
        invalidateData();
    }

    private function layoutComponents():void {
        this.image.x = width - this.image.width >> 1;
        this.image.y = height - this.image.height >> 1;
        dispatchEvent(new ChristmasAwardRendererEvent(ChristmasAwardRendererEvent.RENDERER_READY));
    }

    private function onImageChangeHandler(param1:Event):void {
        this.image.removeEventListener(Event.CHANGE, this.onImageChangeHandler);
        this.layoutComponents();
    }

    private function onMouseOverHandler(param1:MouseEvent):void {
        if (this._model.isSpecial) {
            this._toolTipMgr.showSpecial.apply(this, [this._model.specialAlias, null].concat(this._model.specialArgs));
        }
        else if (StringUtils.isNotEmpty(this._model.tooltip)) {
            this._toolTipMgr.showComplex(this._model.tooltip);
        }
    }

    private function onMouseOutHandler(param1:MouseEvent):void {
        this._toolTipMgr.hide();
    }
}
}
