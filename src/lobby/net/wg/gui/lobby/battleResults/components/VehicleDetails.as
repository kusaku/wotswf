package net.wg.gui.lobby.battleResults.components {
import flash.display.MovieClip;
import flash.events.Event;
import flash.text.TextField;

import net.wg.data.constants.Linkages;
import net.wg.gui.lobby.battleResults.data.StatItemVO;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.utils.IClassFactory;
import net.wg.utils.ICommons;
import net.wg.utils.IUtils;

public class VehicleDetails extends UIComponentEx {

    public static const STATE_NORMAL:String = "normal";

    public static const STATE_TIME:String = "time";

    public static const STATE_WIDE:String = "wide";

    private static const WIDE_LBL_WIDTH:int = 300;

    private static const WIDE_VALUES_POS_X:int = 306;

    private static const WIDE_VALUES_POS_Y:int = 0;

    private static const WIDE_VALUES_WIDTH:int = 130;

    private static const WIDE_WIDTH:int = 436;

    private static const TIME_LBL_WIDTH:int = 254;

    private static const TIME_VALUES_POS_X:int = 262;

    private static const TIME_VALUES_POS_Y:int = 2;

    private static const TIME_VALUES_WIDTH:int = 100;

    private static const TIME_WIDTH:int = 362;

    private static const DEFAULT_LBL_WIDTH:int = 300;

    private static const DEFAULT_VALUES_POS_X:int = 302;

    private static const DEFAULT_VALUES_POS_Y:int = 2;

    private static const DEFAULT_VALUES_WIDTH:int = 60;

    private static const DEFAULT_WIDTH:int = 362;

    public var statsLbl:TextField;

    public var statsValuesLbl:TextField;

    private var linesContainer:MovieClip;

    private var lineType:String = "statsLine";

    private var _data:Vector.<StatItemVO>;

    private var _dataDirty:Boolean = false;

    private var _state:String = "normal";

    private var _stateDirty:Boolean = false;

    public function VehicleDetails() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.clearLines();
        this.statsLbl.mouseWheelEnabled = false;
        this.statsValuesLbl.mouseWheelEnabled = false;
    }

    override protected function onDispose():void {
        this.statsLbl = null;
        this.statsValuesLbl = null;
        this.linesContainer = null;
        this.lineType = null;
        this._data = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (this._stateDirty) {
            if (this.state == STATE_WIDE) {
                this.statsLbl.width = WIDE_LBL_WIDTH;
                this.statsValuesLbl.x = WIDE_VALUES_POS_X;
                this.statsValuesLbl.y = WIDE_VALUES_POS_Y;
                this.statsValuesLbl.width = WIDE_VALUES_WIDTH;
                this.lineType = Linkages.BATTLE_RESULTS_STATS_LINE_WIDE;
                width = WIDE_WIDTH;
            }
            else if (this.state == STATE_TIME) {
                this.statsLbl.width = TIME_LBL_WIDTH;
                this.statsValuesLbl.x = TIME_VALUES_POS_X;
                this.statsValuesLbl.y = TIME_VALUES_POS_Y;
                this.statsValuesLbl.width = TIME_VALUES_WIDTH;
                this.lineType = Linkages.BATTLE_RESULTS_STATS_LINE;
                width = TIME_WIDTH;
            }
            else {
                this.statsLbl.width = DEFAULT_LBL_WIDTH;
                this.statsValuesLbl.x = DEFAULT_VALUES_POS_X;
                this.statsValuesLbl.y = DEFAULT_VALUES_POS_Y;
                this.statsValuesLbl.width = DEFAULT_VALUES_WIDTH;
                this.lineType = Linkages.BATTLE_RESULTS_STATS_LINE;
                width = DEFAULT_WIDTH;
            }
            initSize();
            this._stateDirty = false;
        }
        if (this._dataDirty) {
            this.populateStats(this.data);
            this._dataDirty = false;
        }
    }

    private function populateStats(param1:Vector.<StatItemVO>):void {
        var _loc3_:Number = NaN;
        var _loc4_:Number = NaN;
        var _loc5_:StatItemVO = null;
        var _loc6_:MovieClip = null;
        var _loc7_:IUtils = null;
        var _loc8_:ICommons = null;
        var _loc9_:IClassFactory = null;
        var _loc10_:int = 0;
        this.statsLbl.htmlText = "";
        this.statsValuesLbl.htmlText = "";
        this.clearLines();
        if (param1 != null) {
            _loc3_ = 0;
            _loc4_ = param1.length;
            _loc7_ = App.utils;
            _loc8_ = _loc7_.commons;
            _loc9_ = _loc7_.classFactory;
            while (_loc3_ < _loc4_) {
                _loc5_ = param1[_loc3_];
                _loc8_.addBlankLines(_loc5_.label, this.statsLbl, Vector.<TextField>([this.statsValuesLbl]));
                this.statsLbl.htmlText = this.statsLbl.htmlText + _loc5_.label;
                this.statsValuesLbl.htmlText = this.statsValuesLbl.htmlText + _loc5_.value;
                _loc10_ = 3;
                if (Math.floor(this.statsLbl.y + this.statsLbl.textHeight) + _loc10_ < this.statsLbl.height) {
                    _loc6_ = _loc9_.getComponent(this.lineType, MovieClip, {
                        "x": this.statsLbl.x + _loc10_,
                        "y": Math.floor(this.statsLbl.y + this.statsLbl.textHeight) + _loc10_
                    });
                    this.linesContainer.addChild(_loc6_);
                }
                _loc3_++;
            }
        }
        var _loc2_:int = 6;
        height = Math.max(this.statsLbl.textHeight, this.statsValuesLbl.textHeight) + _loc2_;
        dispatchEvent(new Event(Event.RESIZE));
    }

    private function clearLines():void {
        if (this.linesContainer) {
            removeChild(this.linesContainer);
        }
        this.linesContainer = new MovieClip();
        addChild(this.linesContainer);
    }

    public function get data():Vector.<StatItemVO> {
        return this._data;
    }

    public function set data(param1:Vector.<StatItemVO>):void {
        this._data = param1;
        this._dataDirty = true;
        invalidate();
    }

    public function get state():String {
        return this._state;
    }

    public function set state(param1:String):void {
        this._state = param1;
        this._stateDirty = true;
        invalidate();
    }
}
}
