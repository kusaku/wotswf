package net.wg.gui.lobby.modulesPanel.data {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.utils.IUtils;

import org.idmedia.as3commons.util.StringUtils;

public class FittingSelectPopoverVO extends DAAPIDataClass {

    private static const RENDERER_DATA_CLASS_FIELD_NAME:String = "rendererDataClass";

    public var title:String = "";

    public var availableDevices:Array = null;

    public var selectedIndex:int = -1;

    public var minAvailableHeight:int = -1;

    public var width:int = -1;

    public var rendererName:String = "";

    private var _rendererDataClass:Class = null;

    private var _utils:IUtils;

    public function FittingSelectPopoverVO(param1:Object) {
        this._utils = App.utils;
        super(param1);
    }

    override public function fromHash(param1:Object):void {
        var _loc2_:Array = null;
        var _loc3_:Object = null;
        super.fromHash(param1);
        if (this.availableDevices.length > 0) {
            this._utils.asserter.assertNotNull(this._rendererDataClass, "_rendererDataClass" + Errors.CANT_NULL);
            _loc2_ = this.availableDevices;
            this.availableDevices = [];
            for each(_loc3_ in _loc2_) {
                this.availableDevices.push(new this._rendererDataClass(_loc3_));
            }
        }
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:String = null;
        if (param1 == RENDERER_DATA_CLASS_FIELD_NAME) {
            _loc3_ = param2 as String;
            this._utils.asserter.assert(StringUtils.isNotEmpty(_loc3_), param1 + Errors.CANT_EMPTY);
            this._rendererDataClass = this._utils.classFactory.getClass(_loc3_);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        if (this.availableDevices != null) {
            for each(_loc1_ in this.availableDevices) {
                _loc1_.dispose();
            }
            this.availableDevices.splice(0, this.availableDevices.length);
            this.availableDevices = null;
        }
        this._rendererDataClass = null;
        this._utils = null;
        super.onDispose();
    }
}
}
