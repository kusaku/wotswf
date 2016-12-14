package net.wg.gui.lobby.christmas.data {
import flash.utils.Dictionary;

import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.data.TabsVO;
import net.wg.gui.lobby.christmas.data.slots.SlotsStaticDataClassVO;
import net.wg.gui.lobby.christmas.data.slots.SlotsStaticDataVO;
import net.wg.gui.lobby.christmas.interfaces.ICustomizationStaticDataVO;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class MainViewStaticDataVO extends DAAPIDataClass implements ICustomizationStaticDataVO {

    private static const TABS_DATA_FIELD:String = "tabsData";

    private static const SLOTS_VIEW_DATA_FIELD:String = "slotsStaticData";

    public var btnBackDescription:String = "";

    public var switchCameraDelayFrames:int = -1;

    public var btnCloseLabel:String = "";

    public var btnBackLabel:String = "";

    private var _rulesLabelText:String = "";

    private var _rulesLabelTooltip:String = "";

    private var _tabsData:TabsVO = null;

    private var _btnConversionTooltip:String = "";

    private var _slotsStaticData:Dictionary = null;

    public function MainViewStaticDataVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:SlotsStaticDataClassVO = null;
        var _loc5_:Object = null;
        if (param1 == TABS_DATA_FIELD) {
            this._tabsData = new TabsVO(param2);
            return false;
        }
        if (param1 == SLOTS_VIEW_DATA_FIELD && param2 != null) {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, Errors.INVALID_TYPE + "Array");
            this._slotsStaticData = new Dictionary();
            for each(_loc5_ in _loc3_) {
                _loc4_ = new SlotsStaticDataClassVO(_loc5_);
                this._slotsStaticData[_loc4_.linkageClassName] = _loc4_;
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        this._tabsData.dispose();
        this._tabsData = null;
        if (this._slotsStaticData != null) {
            for each(_loc1_ in this._slotsStaticData) {
                _loc1_.dispose();
            }
            App.utils.data.cleanupDynamicObject(this._slotsStaticData);
            this._slotsStaticData = null;
        }
        super.onDispose();
    }

    public function getSlotsStaticData(param1:String):SlotsStaticDataVO {
        if (param1 in this._slotsStaticData) {
            return SlotsStaticDataClassVO(this._slotsStaticData[param1]).data;
        }
        return null;
    }

    public function get rulesLabelText():String {
        return this._rulesLabelText;
    }

    public function set rulesLabelText(param1:String):void {
        this._rulesLabelText = param1;
    }

    public function get rulesLabelTooltip():String {
        return this._rulesLabelTooltip;
    }

    public function set rulesLabelTooltip(param1:String):void {
        this._rulesLabelTooltip = param1;
    }

    public function get tabsData():TabsVO {
        return this._tabsData;
    }

    public function set tabsData(param1:TabsVO):void {
        this._tabsData = param1;
    }

    public function get btnConversionTooltip():String {
        return this._btnConversionTooltip;
    }

    public function set btnConversionTooltip(param1:String):void {
        this._btnConversionTooltip = param1;
    }
}
}
