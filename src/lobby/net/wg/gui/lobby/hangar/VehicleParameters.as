package net.wg.gui.lobby.hangar {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import net.wg.data.ListDAAPIDataProvider;
import net.wg.data.constants.Directions;
import net.wg.data.constants.Linkages;
import net.wg.data.constants.generated.HANGAR_ALIASES;
import net.wg.gui.components.controls.ScrollingListEx;
import net.wg.gui.events.ListEventEx;
import net.wg.gui.lobby.components.data.VehParamVO;
import net.wg.gui.lobby.hangar.interfaces.IVehicleParameters;
import net.wg.infrastructure.base.meta.impl.VehicleParametersMeta;
import net.wg.utils.helpLayout.HelpLayoutVO;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.interfaces.IDataProvider;
import scaleform.clik.interfaces.IListItemRenderer;
import scaleform.clik.utils.Padding;

public class VehicleParameters extends VehicleParametersMeta implements IVehicleParameters {

    private static const BG_MARGIN:int = 20;

    private static const SB_PADDING:Padding = new Padding(0, 0, 0, 7);

    private static const HELP_LAYOUT_W_CORRECTION:int = -1;

    private static const RENDERER_HEIGHT:int = 24;

    private static const INVALID_LISTENERS:String = "invalidListeners";

    public var paramsList:ScrollingListEx = null;

    public var bg:Sprite = null;

    public var rendererBG:Sprite = null;

    private var _dataProvider:IDataProvider = null;

    private var _helpLayoutId:String = null;

    private var _helpLayoutW:Number = 0;

    private var _rendererLnk:String = null;

    private var _isParamsAnimated:Boolean = true;

    private var _hasListeners:Boolean = false;

    public function VehicleParameters() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        App.utils.helpLayout.registerComponent(this);
        this.paramsList.scrollBar = Linkages.SCROLL_BAR;
        this.paramsList.smartScrollBar = true;
        this.paramsList.widthAutoResize = false;
        this.paramsList.sbPadding = SB_PADDING;
        mouseEnabled = false;
        this.bg.mouseChildren = this.bg.mouseEnabled = false;
        this.hideRendererBG();
    }

    override protected function onDispose():void {
        this._dataProvider.removeEventListener(Event.CHANGE, this.onDataProviderChangeHandler);
        if (this._hasListeners) {
            this.removeListeners();
        }
        this.bg = null;
        this.rendererBG = null;
        this.paramsList.dispose();
        this.paramsList = null;
        this._dataProvider.cleanUp();
        this._dataProvider = null;
        super.onDispose();
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this._dataProvider = new ListDAAPIDataProvider(VehParamVO);
        this._dataProvider.addEventListener(Event.CHANGE, this.onDataProviderChangeHandler);
        this.paramsList.dataProvider = this._dataProvider;
    }

    override protected function draw():void {
        var _loc1_:int = 0;
        var _loc2_:* = false;
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.paramsList.validateNow();
            this.paramsList.rowHeight = RENDERER_HEIGHT;
            _loc1_ = RENDERER_HEIGHT * this._dataProvider.length;
            _loc2_ = _loc1_ > height - BG_MARGIN;
            if (this._rendererLnk != HANGAR_ALIASES.VEH_PARAMS_RENDERER_UI) {
                mouseChildren = _loc2_;
                this.paramsList.mouseChildren = _loc2_;
                this.paramsList.mouseEnabled = _loc2_;
            }
            if (_loc2_) {
                _loc1_ = RENDERER_HEIGHT * ((height - BG_MARGIN) / RENDERER_HEIGHT ^ 0);
            }
            this.paramsList.height = _loc1_;
            this.bg.height = _loc1_ + BG_MARGIN;
        }
        if (isInvalid(INVALID_LISTENERS)) {
            if (!this._hasListeners && this._rendererLnk == HANGAR_ALIASES.VEH_PARAMS_RENDERER_UI) {
                this.paramsList.addEventListener(MouseEvent.MOUSE_WHEEL, this.onParamsListMouseWheelHandler);
                this.paramsList.scrollBar.addEventListener(MouseEvent.MOUSE_DOWN, this.onParamsListScrollBarMouseDownHandler);
                this.paramsList.scrollBar.addEventListener(MouseEvent.ROLL_OVER, this.onParamsListScrollBarRollOverHandler);
                this.paramsList.addEventListener(ListEventEx.ITEM_CLICK, this.onParamsListItemClickHandler);
                this.paramsList.addEventListener(ListEventEx.ITEM_ROLL_OVER, this.onParamsListItemRollOverHandler);
                this.paramsList.addEventListener(MouseEvent.ROLL_OUT, this.onParamsListRollOutHandler);
                this._hasListeners = true;
            }
            else if (this._rendererLnk != HANGAR_ALIASES.VEH_PARAMS_RENDERER_UI) {
                this.removeListeners();
            }
        }
    }

    public function as_getDP():Object {
        return this._dataProvider;
    }

    public function as_setIsParamsAnimated(param1:Boolean):void {
        this._isParamsAnimated = param1;
        invalidate(INVALID_LISTENERS);
    }

    public function as_setRendererLnk(param1:String):void {
        if (this._rendererLnk != param1) {
            this._rendererLnk = param1;
            this.paramsList.itemRenderer = App.utils.classFactory.getClass(this._rendererLnk);
            if (this._rendererLnk == HANGAR_ALIASES.VEH_PARAMS_RENDERER_UI) {
                mouseChildren = true;
                this.paramsList.mouseChildren = true;
                this.paramsList.mouseEnabled = false;
            }
            this.paramsList.scrollToIndex(0);
            invalidateSize();
            invalidate(INVALID_LISTENERS);
        }
    }

    public function getHelpLayoutWidth():Number {
        return width;
    }

    public function getLayoutProperties():Vector.<HelpLayoutVO> {
        if (StringUtils.isEmpty(this._helpLayoutId)) {
            this._helpLayoutId = name + "_" + Math.random();
        }
        var _loc1_:HelpLayoutVO = new HelpLayoutVO();
        _loc1_.x = 0;
        _loc1_.y = 0;
        _loc1_.width = this._helpLayoutW + HELP_LAYOUT_W_CORRECTION;
        _loc1_.height = this.bg.height;
        _loc1_.extensibilityDirection = Directions.RIGHT;
        _loc1_.message = LOBBY_HELP.HANGAR_VEHICLE_PARAMETERS;
        _loc1_.id = this._helpLayoutId;
        _loc1_.scope = this;
        return new <HelpLayoutVO>[_loc1_];
    }

    public function showHelpLayoutEx(param1:Number, param2:Number):void {
        this._helpLayoutW = param2;
    }

    private function removeListeners():void {
        this.paramsList.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onParamsListMouseWheelHandler);
        this.paramsList.scrollBar.removeEventListener(MouseEvent.MOUSE_DOWN, this.onParamsListScrollBarMouseDownHandler);
        this.paramsList.scrollBar.removeEventListener(MouseEvent.ROLL_OVER, this.onParamsListScrollBarRollOverHandler);
        this.paramsList.removeEventListener(ListEventEx.ITEM_CLICK, this.onParamsListItemClickHandler);
        this.paramsList.removeEventListener(ListEventEx.ITEM_ROLL_OVER, this.onParamsListItemRollOverHandler);
        this.paramsList.removeEventListener(MouseEvent.ROLL_OUT, this.onParamsListRollOutHandler);
        this._hasListeners = false;
    }

    private function hideRendererBG():void {
        if (this.rendererBG.visible) {
            this.rendererBG.visible = false;
        }
    }

    private function onParamsListItemRollOverHandler(param1:ListEventEx):void {
        var _loc4_:* = 0;
        var _loc5_:int = 0;
        var _loc6_:IListItemRenderer = null;
        var _loc7_:Boolean = false;
        var _loc8_:int = 0;
        var _loc9_:String = null;
        var _loc2_:VehParamVO = VehParamVO(param1.itemData);
        var _loc3_:String = _loc2_.state;
        if (_loc3_ == HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_SIMPLE_TOP || _loc3_ == HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_SIMPLE_BOTTOM) {
            _loc4_ = int(RENDERER_HEIGHT);
            _loc5_ = param1.itemRenderer.y;
            _loc6_ = null;
            _loc7_ = true;
            _loc8_ = param1.index - this.paramsList.scrollPosition;
            _loc9_ = _loc2_.paramID;
            if (_loc8_ > 0) {
                _loc6_ = this.paramsList.getRendererAt(_loc8_ - 1);
                if (_loc9_ == VehParamVO(_loc6_.getData()).paramID) {
                    _loc5_ = _loc6_.y;
                    _loc4_ = RENDERER_HEIGHT << 1;
                    _loc7_ = false;
                }
            }
            if (_loc7_ && _loc8_ < this.paramsList.renderersCount - 1) {
                _loc6_ = this.paramsList.getRendererAt(_loc8_ + 1);
                if (_loc9_ == VehParamVO(_loc6_.getData()).paramID) {
                    _loc4_ = RENDERER_HEIGHT << 1;
                }
            }
            this.rendererBG.y = _loc5_ + this.paramsList.y;
            this.rendererBG.height = _loc4_;
            this.rendererBG.visible = true;
        }
        else {
            this.hideRendererBG();
        }
    }

    private function onParamsListRollOutHandler(param1:MouseEvent):void {
        this.hideRendererBG();
    }

    private function onParamsListScrollBarRollOverHandler(param1:MouseEvent):void {
        this.hideRendererBG();
    }

    private function onParamsListScrollBarMouseDownHandler(param1:MouseEvent):void {
        this.hideRendererBG();
        if (this._isParamsAnimated) {
            onListScrollS();
        }
    }

    private function onParamsListMouseWheelHandler(param1:MouseEvent):void {
        this.hideRendererBG();
        if (this._isParamsAnimated) {
            onListScrollS();
        }
    }

    private function onParamsListItemClickHandler(param1:ListEventEx):void {
        App.toolTipMgr.hide();
        this.hideRendererBG();
        onParamClickS(VehParamVO(param1.itemData).paramID);
    }

    private function onDataProviderChangeHandler(param1:Event):void {
        if (this._dataProvider.length > 0 && this.paramsList.renderersCount > 0) {
            invalidateSize();
        }
    }
}
}
