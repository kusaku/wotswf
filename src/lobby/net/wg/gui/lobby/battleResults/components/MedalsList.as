package net.wg.gui.lobby.battleResults.components {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.filters.DropShadowFilter;

import net.wg.data.constants.Errors;
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ListEvent;
import scaleform.clik.interfaces.IDataProvider;
import scaleform.clik.interfaces.IListItemRenderer;
import scaleform.gfx.MouseEventEx;

public class MedalsList extends UIComponentEx {

    private static const RENDERER_PADDING:int = 2;

    private static const IS_EPIC_PROP_NAME:String = "isEpic";

    private static const SPECIAL_ICON_PROP_NAME:String = "specialIcon";

    private static const TYPE_MARK_OF_MASTERY:String = "markOfMastery";

    private static const TYPE_MARK_OF_GUN:String = "marksOnGun";

    private static const DROP_SHADOW_COLOR:uint = 0;

    private static const DROP_SHADOW_ALPHA:Number = 0.75;

    private static const DROP_SHADOW_BLUR:Number = 4;

    private static const DROP_SHADOW_ANGLE:Number = 90;

    private static const DROP_SHADOW_DISTANCE:Number = 2;

    private static const DEFAULT_SCALE:Number = 1;

    private static const ALIGN_RIGHT:String = "right";

    private static const ALIGN_CENTER:String = "center";

    private static const PADDINGS:Object = {};

    {
        PADDINGS[TYPE_MARK_OF_GUN] = 40;
    }

    public var _itemRenderer:String = "";

    public var _stripeRenderer:String = "";

    public var _align:String = "left";

    public var _gap:Number = 0;

    public var _colorDodgeMulty:Number = 1.3;

    public var renderersContainer:Sprite;

    public var stripesContainer:Sprite;

    private var _dataProvider:IDataProvider;

    private var _renderers:Vector.<IListItemRenderer>;

    private var _stripes:Vector.<SpecialAchievement>;

    private var _stripeIndexesByRenderer:Vector.<int>;

    public function MedalsList() {
        super();
        this.dataProvider = new DataProvider();
        this._renderers = new Vector.<IListItemRenderer>();
        this._stripes = new Vector.<SpecialAchievement>();
        this._stripeIndexesByRenderer = new Vector.<int>();
        this.stripesContainer = new Sprite();
        addChild(this.stripesContainer);
        this.renderersContainer = new Sprite();
        addChild(this.renderersContainer);
    }

    private static function isDisplaySpecial(param1:Object):Boolean {
        var _loc2_:Boolean = param1[IS_EPIC_PROP_NAME];
        var _loc3_:Boolean = param1[SPECIAL_ICON_PROP_NAME];
        return _loc2_ || _loc3_;
    }

    override protected function configUI():void {
        super.configUI();
        initSize();
        this.renderersContainer.height = height;
        this.renderersContainer.width = width;
        this.renderersContainer.scaleX = this.renderersContainer.scaleY = DEFAULT_SCALE;
        this.stripesContainer.height = height;
        this.stripesContainer.width = width;
        this.stripesContainer.scaleX = this.stripesContainer.scaleY = DEFAULT_SCALE;
        this.updateFilters();
    }

    override protected function draw():void {
        var _loc1_:int = 0;
        if (this._dataProvider != null && isInvalid(InvalidationType.DATA)) {
            this.clear();
            this._stripeIndexesByRenderer.splice(0, this._stripeIndexesByRenderer.length);
            _loc1_ = this._dataProvider.length;
            this.createRenderers(_loc1_);
            this._dataProvider.requestItemRange(0, _loc1_ - 1, this.populateData);
            if (this._renderers.length > 0) {
                this.drawLayout();
            }
        }
    }

    override protected function onDispose():void {
        App.toolTipMgr.hide();
        this.clear();
        if (this._dataProvider != null) {
            this._dataProvider.cleanUp();
            this._dataProvider.removeEventListener(Event.CHANGE, this.onDataProviderChangeHandler);
        }
        this.renderersContainer = null;
        this.stripesContainer = null;
        this._dataProvider = null;
        this._stripes = null;
        this._stripeIndexesByRenderer = null;
        this._renderers = null;
        super.onDispose();
    }

    protected function updateFilters():void {
        var _loc1_:Array = [];
        _loc1_ = _loc1_.concat([this._colorDodgeMulty, 0, 0, 0, 0]);
        _loc1_ = _loc1_.concat([0, this._colorDodgeMulty, 0, 0, 0]);
        _loc1_ = _loc1_.concat([0, 0, this._colorDodgeMulty, 0, 0]);
        _loc1_ = _loc1_.concat([0, 0, 0, 1, 0]);
        var _loc2_:ColorMatrixFilter = new ColorMatrixFilter();
        _loc2_.matrix = _loc1_;
        var _loc3_:DropShadowFilter = new DropShadowFilter(DROP_SHADOW_DISTANCE, DROP_SHADOW_ANGLE, DROP_SHADOW_COLOR, DROP_SHADOW_ALPHA, DROP_SHADOW_BLUR, DROP_SHADOW_BLUR);
        this.renderersContainer.filters = [_loc2_, _loc3_];
        this.stripesContainer.filters = [_loc3_];
    }

    protected function showToolTipByItemData(param1:Object):void {
        var _loc2_:String = this.getTooltipKeyByItemData(param1);
        App.toolTipMgr.showSpecial(_loc2_, null, param1.block, param1.type, param1.rank, param1.customData);
    }

    protected function hideTooltip():void {
        App.toolTipMgr.hide();
    }

    private function getTooltipKeyByItemData(param1:Object):String {
        var _loc2_:String = null;
        var _loc3_:String = param1.type;
        if (_loc3_ == TYPE_MARK_OF_MASTERY) {
            _loc2_ = TOOLTIPS_CONSTANTS.MARK_OF_MASTERY;
        }
        else if (_loc3_ == TYPE_MARK_OF_GUN) {
            _loc2_ = TOOLTIPS_CONSTANTS.BATTLE_STATS_MARKS_ON_GUN_ACHIEVEMENT;
        }
        else {
            _loc2_ = TOOLTIPS_CONSTANTS.BATTLE_STATS_ACHIEVS;
        }
        return _loc2_;
    }

    private function clear():void {
        var _loc3_:SpecialAchievement = null;
        var _loc4_:IListItemRenderer = null;
        var _loc1_:int = this._renderers.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            _loc4_ = this._renderers[_loc2_];
            _loc4_.dispose();
            this.clearRenderer(_loc4_);
            this.renderersContainer.removeChild(DisplayObject(_loc4_));
            _loc2_++;
        }
        this._renderers.splice(0, this._renderers.length);
        _loc1_ = this._stripes.length;
        _loc2_ = 0;
        while (_loc2_ < _loc1_) {
            _loc3_ = this._stripes[_loc2_];
            _loc3_.dispose();
            this.stripesContainer.removeChild(_loc3_);
            _loc2_++;
        }
        this._stripeIndexesByRenderer.splice(0, this._stripeIndexesByRenderer.length);
        this._stripes.splice(0, this._stripes.length);
    }

    private function createRenderers(param1:int):void {
        var _loc3_:IListItemRenderer = null;
        var _loc2_:int = this._renderers.length;
        while (_loc2_ < param1) {
            this._renderers.push(this.createItemRenderer());
            _loc2_++;
        }
        var _loc4_:int = param1;
        while (_loc4_ < _loc2_) {
            _loc3_ = this._renderers[_loc4_];
            this.clearRenderer(_loc3_);
            _loc3_.dispose();
            this.renderersContainer.removeChild(DisplayObject(_loc3_));
            _loc4_++;
        }
        if (param1 < _loc2_) {
            this._renderers.splice(param1, _loc2_ - param1);
        }
    }

    private function drawLayout():void {
        var _loc2_:IListItemRenderer = null;
        var _loc3_:Object = null;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc6_:* = 0;
        var _loc8_:Number = NaN;
        var _loc1_:int = this._renderers.length;
        for each(_loc2_ in this._renderers) {
            _loc3_ = _loc2_.getData();
            App.utils.asserter.assertNotNull(_loc3_, Errors.CANT_NULL);
            _loc5_ = !!PADDINGS.hasOwnProperty(_loc3_.type) ? int(PADDINGS[_loc3_.type]) : 0;
            _loc4_ = _loc4_ + (_loc2_.width + RENDERER_PADDING + _loc5_);
        }
        _loc4_ = _loc4_ - RENDERER_PADDING;
        if (_loc4_ > width) {
            this._gap = (width - _loc4_) / (_loc1_ - 1) ^ 0;
        }
        if (this._align == ALIGN_RIGHT) {
            _loc6_ = int(width - _loc2_.width);
        }
        else if (this._align == ALIGN_CENTER) {
            _loc6_ = width - _loc4_ >> 1;
        }
        var _loc7_:int = 0;
        while (_loc1_ > _loc7_) {
            _loc2_ = this._renderers[_loc7_];
            _loc3_ = _loc2_.getData();
            _loc5_ = !!PADDINGS.hasOwnProperty(_loc3_.type) ? int(PADDINGS[_loc3_.type]) : 0;
            _loc2_.x = _loc6_ - _loc5_ / 2;
            _loc2_.y = height - _loc2_.height >> 1;
            _loc2_.index = _loc7_;
            _loc2_.visible = true;
            _loc8_ = RENDERER_PADDING + _loc5_ + _loc2_.width + this._gap;
            _loc6_ = int(_loc6_ + (this._align == ALIGN_RIGHT ? -_loc8_ : _loc8_));
            _loc7_++;
        }
        this.stripesUpdatePosition();
    }

    private function stripesUpdatePosition():void {
        var _loc2_:SpecialAchievement = null;
        var _loc3_:DisplayObject = null;
        var _loc4_:int = 0;
        var _loc1_:int = this._stripes.length;
        App.utils.asserter.assert(_loc1_ == this._stripeIndexesByRenderer.length, Errors.CANT_EMPTY);
        var _loc5_:int = 0;
        while (_loc5_ < _loc1_) {
            _loc2_ = this._stripes[_loc5_];
            _loc4_ = this._stripeIndexesByRenderer[_loc5_];
            _loc3_ = DisplayObject(this._renderers[_loc4_]);
            _loc2_.x = _loc3_.x + (_loc3_.width - _loc2_.width >> 1);
            _loc2_.y = _loc3_.y + (_loc3_.height - _loc2_.height >> 1);
            _loc2_.visible = true;
            _loc5_++;
        }
    }

    private function createItemRenderer():IListItemRenderer {
        var _loc1_:IListItemRenderer = App.utils.classFactory.getComponent(this._itemRenderer, IListItemRenderer);
        var _loc2_:DisplayObject = _loc1_ as DisplayObject;
        App.utils.asserter.assertNotNull(_loc2_, Errors.CANT_NULL);
        this.renderersContainer.addChild(_loc2_);
        _loc2_.visible = false;
        _loc1_.focusTarget = this;
        this.setupRenderer(_loc1_);
        return _loc1_;
    }

    private function createStripeRenderer():SpecialAchievement {
        var _loc1_:SpecialAchievement = App.utils.classFactory.getComponent(this._stripeRenderer, SpecialAchievement);
        this.stripesContainer.addChild(_loc1_);
        this._stripes.push(_loc1_);
        _loc1_.validateNow();
        _loc1_.visible = false;
        return _loc1_;
    }

    private function setupRenderer(param1:IListItemRenderer):void {
        param1.owner = this;
        param1.focusTarget = this;
        param1.tabEnabled = false;
        param1.doubleClickEnabled = true;
        param1.addEventListener(ButtonEvent.PRESS, this.onRendererEventHandler, false, 0, true);
        param1.addEventListener(ButtonEvent.CLICK, this.onRendererClickHandler, false, 0, true);
        param1.addEventListener(MouseEvent.DOUBLE_CLICK, this.onRendererEventHandler, false, 0, true);
        param1.addEventListener(MouseEvent.ROLL_OVER, this.onRendererEventHandler, false, 0, true);
        param1.addEventListener(MouseEvent.ROLL_OUT, this.onRendererEventHandler, false, 0, true);
    }

    private function clearRenderer(param1:IListItemRenderer):void {
        param1.removeEventListener(ButtonEvent.PRESS, this.onRendererEventHandler);
        param1.removeEventListener(ButtonEvent.CLICK, this.onRendererClickHandler);
        param1.removeEventListener(MouseEvent.DOUBLE_CLICK, this.onRendererEventHandler);
        param1.removeEventListener(MouseEvent.ROLL_OVER, this.onRendererEventHandler);
        param1.removeEventListener(MouseEvent.ROLL_OUT, this.onRendererEventHandler);
    }

    private function populateData(param1:Array):void {
        var _loc2_:IListItemRenderer = null;
        var _loc3_:Object = null;
        var _loc4_:SpecialAchievement = null;
        var _loc5_:int = this._stripes.length;
        var _loc6_:int = 0;
        var _loc7_:int = this._renderers.length;
        var _loc8_:int = 0;
        while (_loc8_ < _loc7_) {
            _loc2_ = this._renderers[_loc8_];
            _loc3_ = param1[_loc8_];
            _loc2_.setData(_loc3_);
            _loc2_.enabled = this.enabled;
            if (this._stripeRenderer != Values.EMPTY_STR) {
                if (isDisplaySpecial(_loc3_)) {
                    this._stripeIndexesByRenderer.push(_loc8_);
                    if (_loc5_ <= _loc6_) {
                        _loc4_ = this.createStripeRenderer();
                    }
                    else {
                        _loc4_ = this._stripes[_loc6_];
                    }
                    _loc4_.data = _loc3_;
                    _loc6_++;
                }
            }
            _loc8_++;
        }
        var _loc9_:int = _loc6_;
        while (_loc9_ < _loc5_) {
            _loc4_ = this._stripes[_loc9_];
            _loc4_.dispose();
            this.stripesContainer.removeChild(_loc4_);
            _loc9_++;
        }
        if (_loc6_ < _loc5_) {
            this._stripes.splice(_loc6_, _loc5_ - _loc6_);
        }
    }

    public function get dataProvider():IDataProvider {
        return this._dataProvider;
    }

    public function set dataProvider(param1:IDataProvider):void {
        if (this._dataProvider == param1) {
            return;
        }
        if (this._dataProvider != null) {
            this._dataProvider.cleanUp();
            this._dataProvider.removeEventListener(Event.CHANGE, this.onDataProviderChangeHandler, false);
        }
        this._dataProvider = param1;
        if (this._dataProvider == null) {
            return;
        }
        this._dataProvider.addEventListener(Event.CHANGE, this.onDataProviderChangeHandler, false, 0, true);
        invalidateData();
    }

    private function onRendererEvent(param1:Event):Boolean {
        var _loc2_:String = param1.type;
        switch (_loc2_) {
            case ButtonEvent.PRESS:
                _loc2_ = ListEvent.ITEM_PRESS;
                break;
            case ButtonEvent.CLICK:
                _loc2_ = ListEvent.ITEM_CLICK;
                break;
            case MouseEvent.ROLL_OVER:
                _loc2_ = ListEvent.ITEM_ROLL_OVER;
                break;
            case MouseEvent.ROLL_OUT:
                _loc2_ = ListEvent.ITEM_ROLL_OUT;
                break;
            case MouseEvent.DOUBLE_CLICK:
                _loc2_ = ListEvent.ITEM_DOUBLE_CLICK;
                break;
            default:
                return true;
        }
        var _loc3_:IListItemRenderer = IListItemRenderer(param1.currentTarget);
        var _loc4_:uint = 0;
        if (param1 is ButtonEvent) {
            _loc4_ = ButtonEvent(param1).controllerIdx;
        }
        else if (param1 is MouseEventEx) {
            _loc4_ = MouseEventEx(param1).mouseIdx;
        }
        var _loc5_:uint = 0;
        if (param1 is ButtonEvent) {
            _loc5_ = ButtonEvent(param1).buttonIdx;
        }
        else if (param1 is MouseEventEx) {
            _loc5_ = MouseEventEx(param1).buttonIdx;
        }
        var _loc6_:Boolean = false;
        if (param1 is ButtonEvent) {
            _loc6_ = ButtonEvent(param1).isKeyboard;
        }
        var _loc7_:int = _loc3_.index;
        var _loc8_:Object = this.dataProvider[_loc7_];
        var _loc9_:ListEvent = new ListEvent(_loc2_, false, true, _loc7_, 0, _loc7_, _loc3_, _loc8_, _loc4_, _loc5_, _loc6_);
        if (_loc2_ == ListEvent.ITEM_ROLL_OVER) {
            this.showToolTipByItemData(_loc8_);
        }
        else if (_loc2_ == ListEvent.ITEM_ROLL_OUT) {
            this.hideTooltip();
        }
        return dispatchEvent(_loc9_);
    }

    private function onRendererEventHandler(param1:Event):Boolean {
        return this.onRendererEvent(param1);
    }

    private function onRendererClickHandler(param1:Event):void {
        var _loc2_:Number = param1.target.index;
        if (isNaN(_loc2_)) {
            return;
        }
        this.onRendererEvent(param1);
    }

    private function onDataProviderChangeHandler(param1:Event):void {
        invalidate();
    }
}
}
