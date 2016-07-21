package net.wg.gui.lobby.fortifications.cmp.drctn.impl {
import flash.text.TextField;

import net.wg.data.managers.impl.ToolTipParams;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class BuildingDirection extends SoundButtonEx implements IDisposable {

    private static const noneState:String = "none";

    private static const ALPHA_DISABLED:Number = 0.33;

    private static const ALPHA_ENABLED:Number = 1;

    private static const STATE_OPENED_TYPES:Vector.<String> = new <String>["openedLevel1", "openedLevel2", "openedLevel3"];

    private static const STATE_CLOSED:String = "closed";

    public var title:TextField = null;

    private var _modernizationLevel:int = 1;

    private var _uid:int = -1;

    private var _isOpen:Boolean;

    private var _isActive:Boolean;

    private var _disabled:Boolean;

    public function BuildingDirection() {
        super();
        enabled = false;
        _stateMap[noneState] = [""];
        _tooltip = FORTIFICATIONS.BUILDINGDIRECTION_TOOLTIP;
    }

    override protected function configUI():void {
        super.configUI();
        hitMc.alpha = 0;
        toggle = false;
        this.updateState();
    }

    override protected function setState(param1:String):void {
        var _loc2_:String = param1;
        if (!this._isActive) {
            _loc2_ = noneState;
        }
        super.setState(_loc2_);
        _state = param1;
    }

    override protected function getStatePrefixes():Vector.<String> {
        var _loc1_:Vector.<String> = new Vector.<String>();
        if (this._isActive) {
            _loc1_.push(statesDefault);
        }
        else if (this._isOpen) {
            if (this._modernizationLevel > 0 && this._modernizationLevel <= STATE_OPENED_TYPES.length) {
                _loc1_.push(STATE_OPENED_TYPES[this._modernizationLevel - 1]);
            }
            else {
                App.utils.asserter.assert(false, "Button state was not found for upgrade level \"" + this._modernizationLevel + "\"");
            }
        }
        else {
            _loc1_.push(STATE_CLOSED);
        }
        return _loc1_;
    }

    override protected function onDispose():void {
        this.title = null;
        super.onDispose();
    }

    override protected function showTooltip():void {
        var _loc1_:String = null;
        if (tooltip && this._isActive) {
            _loc1_ = this.getTitle();
            App.toolTipMgr.showComplexWithParams(tooltip, new ToolTipParams({"value": _loc1_}, {"value": _loc1_}));
        }
    }

    override protected function updateAfterStateChange():void {
        super.updateAfterStateChange();
        this.title.text = this.getTitle();
    }

    private function updateState():void {
        this.setState(_state || "up");
    }

    private function getTitle():String {
        var _loc1_:int = this._uid - 1;
        if (_loc1_ > -1) {
            return App.utils.locale.makeString(FORTIFICATIONS.BUILDINGDIRECTION_LABEL_ENUM[_loc1_]);
        }
        return "";
    }

    public function set modernizationLevel(param1:int):void {
        this._modernizationLevel = param1;
        this.updateState();
    }

    public function get uid():int {
        return this._uid;
    }

    public function set uid(param1:int):void {
        this._uid = param1;
        this.title.text = this.getTitle();
    }

    public function get isOpen():Boolean {
        return this._isOpen;
    }

    public function set isOpen(param1:Boolean):void {
        this._isOpen = param1;
        this.updateState();
    }

    public function get isActive():Boolean {
        return this._isActive;
    }

    public function set isActive(param1:Boolean):void {
        this._isActive = param1;
        enabled = this._isActive;
        this.updateState();
    }

    public function get disabled():Boolean {
        return this._disabled;
    }

    public function set disabled(param1:Boolean):void {
        this._disabled = param1;
        alpha = !!this._disabled ? Number(ALPHA_DISABLED) : Number(ALPHA_ENABLED);
    }
}
}
