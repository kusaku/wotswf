package net.wg.gui.crewOperations {
import flash.display.Graphics;
import flash.display.MovieClip;
import flash.events.Event;
import flash.text.TextField;

import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.infrastructure.interfaces.entity.IUpdatable;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.core.UIComponent;
import scaleform.clik.events.ButtonEvent;

public class CrewOperationsIRenderer extends UIComponent implements IUpdatable {

    private static const OFFSET_BETWEEN_TEXT_AND_BUTTON:uint = 16;

    public var iconLoader:UILoaderAlt;

    public var title:TextField;

    public var description:TextField;

    public var footer:CrewOperationsIRFooter;

    private var _data:CrewOperationInfoVO;

    private var _myHitArea:MovieClip;

    public function CrewOperationsIRenderer() {
        this._myHitArea = new MovieClip();
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.description.mouseEnabled = false;
        this.footer.button.addEventListener(ButtonEvent.CLICK, this.onFooterButtonClickHandler, false, 0, true);
        addChildAt(this._myHitArea, 0);
        hitArea = this._myHitArea;
    }

    override protected function draw():void {
        var _loc1_:Graphics = null;
        super.draw();
        if (this._data && isInvalid(InvalidationType.DATA)) {
            this.title.text = this._data.title;
            this.description.text = this._data.description;
            App.utils.commons.updateTextFieldSize(this.description, false);
            this.iconLoader.source = this._data.iconPath;
            this.footer.data = this._data;
            this.footer.validateNow();
            this.footer.y = this.description.y + this.description.height + OFFSET_BETWEEN_TEXT_AND_BUTTON - this.footer.button.y;
            _height = this.footer.y + this.footer.height;
            this._myHitArea.mouseEnabled = false;
            _loc1_ = this._myHitArea.graphics;
            _loc1_.clear();
            _loc1_.beginFill(0, 0);
            _loc1_.drawRect(0, 0, _width, _height);
            _loc1_.endFill();
            dispatchEvent(new Event(Event.RESIZE, true));
        }
    }

    override protected function onDispose():void {
        this._data = null;
        this.footer.button.removeEventListener(ButtonEvent.CLICK, this.onFooterButtonClickHandler, false);
        this.footer.dispose();
        this.footer = null;
        this.description = null;
        this.title = null;
        this.iconLoader.dispose();
        this.iconLoader = null;
        this._myHitArea.stop();
        removeChild(this._myHitArea);
        this._myHitArea = null;
        super.onDispose();
    }

    public function update(param1:Object):void {
        this._data = CrewOperationInfoVO(param1);
        invalidateData();
    }

    private function onFooterButtonClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new CrewOperationEvent(CrewOperationEvent.OPERATION_CHANGED, this._data.id, true));
    }
}
}
