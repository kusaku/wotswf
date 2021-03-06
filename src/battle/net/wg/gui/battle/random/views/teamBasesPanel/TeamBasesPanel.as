package net.wg.gui.battle.random.views.teamBasesPanel {
import flash.utils.Dictionary;

import net.wg.data.constants.Linkages;
import net.wg.infrastructure.base.meta.ITeamBasesPanelMeta;
import net.wg.infrastructure.base.meta.impl.TeamBasesPanelMeta;
import net.wg.infrastructure.events.ColorSchemeEvent;
import net.wg.infrastructure.managers.IColorSchemeManager;

public class TeamBasesPanel extends TeamBasesPanelMeta implements ITeamBasesPanelMeta {

    private static const RENDERER_HEIGHT:Number = 55;

    private static const ASSERT_MSG:String = "[TeamBasesPanel] Can\'t find teamCaptureBar with id=";

    private static const DEF_MAX_BARS_COUNT:uint = 0;

    private var _captureBars:Vector.<TeamCaptureBar> = null;

    private var _cachedBars:Vector.<TeamCaptureBar> = null;

    private var _capturedBarsIndexesById:Dictionary = null;

    private var _needBarOffset:Boolean = false;

    private var _colorSchemeMgr:IColorSchemeManager = null;

    private var _data_is_cleared:Boolean = false;

    public function TeamBasesPanel() {
        super();
        this._colorSchemeMgr = App.colorSchemeMgr;
        this._captureBars = new Vector.<TeamCaptureBar>();
        this._cachedBars = new Vector.<TeamCaptureBar>();
        var _loc1_:Number = 0;
        while (_loc1_ < DEF_MAX_BARS_COUNT) {
            this.createBar();
            _loc1_++;
        }
    }

    private static function sortBarsFn(param1:TeamCaptureBar, param2:TeamCaptureBar):Number {
        var _loc3_:Number = param1.sortWeight;
        var _loc4_:Number = param2.sortWeight;
        return _loc3_ < _loc4_ ? Number(-1) : _loc3_ > _loc4_ ? Number(1) : Number(0);
    }

    override protected function configUI():void {
        super.configUI();
        this._colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED, this.onColorSchemeMgrSchemasUpdatedHandler);
    }

    override protected function onDispose():void {
        this._colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED, this.onColorSchemeMgrSchemasUpdatedHandler);
        this._colorSchemeMgr = null;
        this.disposeItemsAndData();
        super.onDispose();
    }

    public function as_add(param1:Number, param2:Number, param3:String, param4:String, param5:Number, param6:String, param7:String):void {
        if (this._capturedBarsIndexesById && this._capturedBarsIndexesById[param1]) {
            return;
        }
        if (this._cachedBars.length == 0) {
            this.createBar();
        }
        var _loc8_:TeamCaptureBar = this._cachedBars.pop();
        addChild(_loc8_);
        _loc8_.setData(param1, param2, param3, param4, param5, param6, param7);
        this._captureBars.push(_loc8_);
        this._captureBars.sort(sortBarsFn);
        this.updateBuildIndexByIDCache();
        this.updatePositions();
        _loc8_.visible = true;
    }

    public function as_clear():void {
        this._data_is_cleared = true;
        this.cleanItemsAndData();
    }

    public function as_remove(param1:Number):void {
        var _loc2_:Number = this._capturedBarsIndexesById[param1];
        var _loc3_:TeamCaptureBar = this._captureBars.splice(_loc2_, 1)[0];
        this.removeChild(_loc3_);
        this._cachedBars.push(_loc3_);
        this.updateBuildIndexByIDCache();
        this.updatePositions();
    }

    public function as_setCaptured(param1:Number, param2:String):void {
        if (!this._data_is_cleared) {
            this.getCaptureBarById(param1).updateTitle(param2);
        }
    }

    public function as_setOffsetForEnemyPoints():void {
        this._needBarOffset = true;
    }

    public function as_stopCapture(param1:Number, param2:Number):void {
        if (!this._data_is_cleared) {
            this.getCaptureBarById(param1).stopCapture(param2);
        }
    }

    public function as_updateCaptureData(param1:Number, param2:Number, param3:Number, param4:String, param5:String):void {
        if (!this._data_is_cleared) {
            this.getCaptureBarById(param1).updateCaptureData(param2, true, false, param3, param4, param5);
        }
    }

    private function updateColors():void {
        var _loc1_:Number = this._captureBars.length;
        var _loc2_:Number = 0;
        while (_loc2_ < _loc1_) {
            this._captureBars[_loc2_].updateColors();
            _loc2_++;
        }
    }

    private function cleanCapturedBarsIndexes():void {
        App.utils.data.cleanupDynamicObject(this._capturedBarsIndexesById);
        this._capturedBarsIndexesById = null;
    }

    private function disposeItemsAndData():void {
        this.cleanCapturedBarsIndexes();
        while (this._captureBars.length) {
            this.disposeBar(this._captureBars.pop(), true);
        }
        this._captureBars = null;
        while (this._cachedBars.length) {
            this.disposeBar(this._cachedBars.pop(), false);
        }
        this._cachedBars = null;
    }

    private function cleanItemsAndData():void {
        this.cleanCapturedBarsIndexes();
        var _loc1_:TeamCaptureBar = null;
        while (this._captureBars.length) {
            _loc1_ = this._captureBars.pop();
            this.removeChild(_loc1_);
            this._cachedBars.push(_loc1_);
        }
    }

    private function disposeBar(param1:TeamCaptureBar, param2:Boolean):void {
        param1.dispose();
        if (param2) {
            this.removeChild(param1);
        }
    }

    private function updateBuildIndexByIDCache():void {
        var _loc1_:Number = this._captureBars.length;
        this.cleanCapturedBarsIndexes();
        this._capturedBarsIndexesById = new Dictionary();
        var _loc2_:Number = 0;
        while (_loc2_ < _loc1_) {
            this._capturedBarsIndexesById[this._captureBars[_loc2_].id] = _loc2_;
            _loc2_++;
        }
    }

    private function updatePositions():void {
        var _loc2_:Number = NaN;
        var _loc3_:Number = NaN;
        var _loc1_:Number = this._captureBars.length;
        if (_loc1_ > 0) {
            _loc2_ = this._needBarOffset && this._captureBars[0].colorType == TeamCaptureFeel.COLOR_TYPE_RED ? Number(RENDERER_HEIGHT) : Number(0);
            _loc3_ = 0;
            while (_loc3_ < _loc1_) {
                this._captureBars[_loc3_].y = _loc2_;
                _loc3_++;
                _loc2_ = _loc2_ + RENDERER_HEIGHT;
            }
        }
    }

    private function getCaptureBarById(param1:Number):TeamCaptureBar {
        var _loc3_:Number = NaN;
        var _loc2_:TeamCaptureBar = null;
        if (param1 in this._capturedBarsIndexesById) {
            _loc3_ = this._capturedBarsIndexesById[param1];
            _loc2_ = this._captureBars[_loc3_];
        }
        else {
            App.utils.asserter.assert(false, ASSERT_MSG + param1);
        }
        App.utils.asserter.assertNotNull(_loc2_, ASSERT_MSG + param1);
        return _loc2_;
    }

    private function createBar():void {
        var _loc1_:TeamCaptureBar = App.utils.classFactory.getComponent(Linkages.CAPTURE_BAR_LINKAGE, TeamCaptureBar);
        _loc1_.visible = false;
        _loc1_.x = 0;
        this._cachedBars.push(_loc1_);
    }

    private function onColorSchemeMgrSchemasUpdatedHandler(param1:ColorSchemeEvent):void {
        this.updateColors();
    }
}
}
