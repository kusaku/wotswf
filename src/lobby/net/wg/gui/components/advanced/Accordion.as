package net.wg.gui.components.advanced {
import flash.display.MovieClip;

import net.wg.data.constants.Linkages;
import net.wg.gui.components.controls.BitmapFill;
import net.wg.gui.components.interfaces.IAccordionItemRenderer;
import net.wg.infrastructure.interfaces.IDynamicContent;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.Button;
import scaleform.clik.events.InputEvent;

public class Accordion extends ButtonBarEx implements IDynamicContent {

    private static const DEFAULT_ITEM_RNDR:String = Linkages.ACCORDION_RDR_UI;

    private static const INVALID_BORDER:String = "border";

    public var view:net.wg.gui.components.advanced.ViewStack = null;

    public var border:MovieClip = null;

    public var texture:BitmapFill = null;

    private var _rowHeight:Number = 33;

    private var _margin:Number = 1;

    private var _paddingTop:Number = 0;

    private var _paddingBottom:Number = 0;

    private var _paddingLeft:Number = 0;

    private var _paddingRight:Number = 0;

    private var _enableHeaderConstraints:Boolean = false;

    private var _showBgForm:Boolean = true;

    private var _backgroundType:String = "gray";

    private var _actualViewWidth:Number;

    private var _actualViewHeight:Number;

    public function Accordion() {
        super();
        tabEnabled = focusable = true;
        itemRendererName = DEFAULT_ITEM_RNDR;
        _direction = DIRECTION_VERTICAL;
    }

    override protected function configUI():void {
        super.configUI();
        this.view.groupRef = this;
        if (this.border) {
            this.border.visible = this._showBgForm;
        }
    }

    override protected function onDispose():void {
        this.view.groupRef = null;
        this.view.dispose();
        this.view = null;
        this.border = null;
        this.texture.dispose();
        this.texture = null;
        if (dataProvider) {
            dataProvider.cleanUp();
            dataProvider = null;
        }
        super.onDispose();
    }

    override protected function draw():void {
        if (isInvalid(InvalidationType.RENDERERS) || isInvalid(InvalidationType.DATA) || isInvalid(InvalidationType.SETTINGS) || isInvalid(InvalidationType.SIZE)) {
            removeChild(container);
            _originalWidth = _width;
            _originalHeight = _height;
            setActualSize(_width, _height);
            setActualScale(1, 1);
            container.scaleX = 1 / scaleX;
            container.scaleY = 1 / scaleY;
            addChild(container);
            updateRenderers();
        }
        if (isInvalid(InvalidationType.DATA)) {
            refreshData();
        }
        if (isInvalid(INVALID_BORDER)) {
            if (this.border) {
                this.border.width = width;
                this.border.height = height;
            }
            if (this.texture) {
                this.texture.setSize(width, height);
            }
        }
        this.drawLayout(width, this.rowHeight);
        this.view.alpha = 1;
    }

    override protected function setupRenderer(param1:Button, param2:uint):void {
        super.setupRenderer(param1, param2);
        if (param1 is IAccordionItemRenderer) {
            IAccordionItemRenderer(param1).enableConstraints = this.enableHeaderConstraints;
        }
        param1.tabEnabled = false;
    }

    override protected function populateRendererData(param1:Button, param2:uint):void {
        super.populateRendererData(param1, param2);
        var _loc3_:Object = _dataProvider.requestItemAt(param2);
        if (_loc3_.hasOwnProperty("enabled")) {
            param1.enabled = _loc3_.enabled;
        }
    }

    private function drawLayout(param1:Number, param2:Number):void {
        var _loc5_:IAccordionItemRenderer = null;
        var _loc6_:Number = NaN;
        var _loc7_:Number = NaN;
        var _loc3_:Number = this.paddingLeft + this.paddingRight + this.margin * 2;
        param1 = param1 - _loc3_;
        var _loc4_:Number = this.margin + this.paddingTop;
        for each(_loc5_ in _renderers) {
            _loc5_.x = Math.round(this.margin + this.paddingLeft);
            _loc5_.y = Math.round(_loc4_);
            _loc4_ = _loc4_ + param2;
            if (selectedRenderer == _loc5_) {
                this.view.y = _loc4_;
                this.view.x = this.margin + this.paddingLeft;
                _loc6_ = height - (this.margin >> 1) - this.paddingTop - this.paddingBottom - _renderers.length * param2;
                _loc7_ = Math.max(0, _loc6_);
                this.view.setActualSize(param1, _loc7_);
                this.view.setActualScale(1, 1);
                this._actualViewWidth = param1;
                this._actualViewHeight = _loc7_;
                _loc4_ = _loc4_ + _loc7_;
            }
            _loc5_.setSize(param1, param2);
        }
    }

    override public function set selectedIndex(param1:int):void {
        this.view.alpha = 0;
        super.selectedIndex = param1;
        invalidate();
    }

    public function get actualViewWidth():Number {
        return this._actualViewWidth;
    }

    public function get actualViewHeight():Number {
        return this._actualViewHeight;
    }

    public function get rowHeight():Number {
        return this._rowHeight;
    }

    public function set rowHeight(param1:Number):void {
        this._rowHeight = param1;
    }

    public function get margin():Number {
        return this._margin;
    }

    public function set margin(param1:Number):void {
        this._margin = param1;
    }

    public function get paddingTop():Number {
        return this._paddingTop;
    }

    public function set paddingTop(param1:Number):void {
        this._paddingTop = param1;
    }

    public function get paddingBottom():Number {
        return this._paddingBottom;
    }

    public function set paddingBottom(param1:Number):void {
        this._paddingBottom = param1;
    }

    public function get paddingLeft():Number {
        return this._paddingLeft;
    }

    public function set paddingLeft(param1:Number):void {
        this._paddingLeft = param1;
    }

    public function get paddingRight():Number {
        return this._paddingRight;
    }

    public function set paddingRight(param1:Number):void {
        this._paddingRight = param1;
    }

    public function get enableHeaderConstraints():Boolean {
        return this._enableHeaderConstraints;
    }

    public function set enableHeaderConstraints(param1:Boolean):void {
        this._enableHeaderConstraints = param1;
    }

    public function get showBackground():Boolean {
        return this._showBgForm;
    }

    public function set showBackground(param1:Boolean):void {
        this._showBgForm = param1;
    }

    public function get backgroundType():String {
        return this._backgroundType;
    }

    public function set backgroundType(param1:String):void {
        this.border.gotoAndStop(param1);
        this._backgroundType = param1;
    }

    override public function handleInput(param1:InputEvent):void {
    }
}
}
