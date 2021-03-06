package net.wg.infrastructure.managers.impl.TooltipMgr {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.utils.Dictionary;

import net.wg.data.constants.Errors;
import net.wg.data.constants.Linkages;
import net.wg.data.constants.generated.EVENT_LOG_CONSTANTS;
import net.wg.data.managers.IToolTipParams;
import net.wg.data.managers.ITooltipProps;
import net.wg.infrastructure.base.meta.IToolTipMgrMeta;
import net.wg.infrastructure.base.meta.impl.ToolTipMgrMeta;
import net.wg.infrastructure.exceptions.AbstractException;
import net.wg.infrastructure.interfaces.IReusable;
import net.wg.infrastructure.interfaces.IToolTip;
import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.infrastructure.managers.ITooltipFormatter;
import net.wg.infrastructure.managers.ITooltipMgr;
import net.wg.utils.IAssertable;
import net.wg.utils.IScheduler;
import net.wg.utils.IUtils;

public class ToolTipManagerBase extends ToolTipMgrMeta implements ITooltipMgr, IToolTipMgrMeta {

    private static const SCHEDULE_TIME:uint = 100;

    private var _container:DisplayObjectContainer = null;

    private var _currentTooltip:DisplayObject = null;

    private var _isCurrentTooltipCached:Boolean;

    private var _props:ITooltipProps = null;

    private var _cachedComponents:Dictionary;

    public function ToolTipManagerBase(param1:DisplayObjectContainer) {
        super();
        this._container = param1;
        this._cachedComponents = new Dictionary();
    }

    override protected function onDispose():void {
        var _loc1_:DisplayObject = null;
        this.hide();
        this._container = null;
        this._props = null;
        for each(_loc1_ in this._cachedComponents) {
            if (_loc1_ is IDisposable) {
                IDisposable(_loc1_).dispose();
            }
        }
        App.utils.data.cleanupDynamicObject(this._cachedComponents);
        super.onDispose();
    }

    public function as_show(param1:Object, param2:String):void {
        var _loc3_:IUtils = null;
        var _loc4_:IAssertable = null;
        this.hide();
        if (App.instance) {
            _loc4_ = App.utils.asserter;
            _loc4_.assertNotNull(this._props, "_props" + Errors.CANT_NULL);
            _loc3_ = App.utils;
            if (this._props.showDelay != 0) {
                _loc3_.scheduler.scheduleTask(this.hide, this._props.showDelay);
            }
            this._currentTooltip = this.getCachedComponent(param2);
            this._isCurrentTooltipCached = true;
            if (this._currentTooltip == null) {
                this._currentTooltip = DisplayObject(_loc3_.classFactory.getComponent(param2, DisplayObject, this._props));
                this._isCurrentTooltipCached = false;
            }
            if (this._currentTooltip != null) {
                IToolTip(this._currentTooltip).build(param1, this._props);
                this.callLogEvent(EVENT_LOG_CONSTANTS.EVENT_TYPE_ON_TOOLTIP_SHOW);
                this._container.addChild(this._currentTooltip);
            }
        }
        this._props = null;
    }

    public function getDefaultTooltipProps():ITooltipProps {
        throw new AbstractException("AbstractApplication.getManagedContainer" + Errors.ABSTRACT_INVOKE);
    }

    public function getNewFormatter():ITooltipFormatter {
        return new TooltipFormatter();
    }

    public function hide():void {
        if (this._currentTooltip != null) {
            this.callLogEvent(EVENT_LOG_CONSTANTS.EVENT_TYPE_ON_TOOLTIP_HIDE);
            if (this._isCurrentTooltipCached) {
                IReusable(this._currentTooltip).cleanUp();
            }
            else {
                IDisposable(this._currentTooltip).dispose();
            }
            this._container.removeChild(this._currentTooltip);
            this._currentTooltip = null;
        }
        this.cancelTasks();
    }

    public function show(param1:String, param2:ITooltipProps = null):void {
        this.cancelTasks();
        this._props = this.prepareProperties(param2);
        this.rescheduleTask(this.as_show, param1, Linkages.TOOL_TIP_COMPLEX);
    }

    public function showComplex(param1:String, param2:ITooltipProps = null):void {
        this.cancelTasks();
        this._props = this.prepareProperties(param2);
        this.rescheduleTask(onCreateComplexTooltipS, param1, this._props.type);
    }

    public function showComplexWithParams(param1:String, param2:IToolTipParams, param3:ITooltipProps = null):void {
        if (!param2) {
            return;
        }
        var _loc4_:ITooltipFormatter = this.getNewFormatter();
        if (param2.header) {
            _loc4_.addHeader(App.utils.locale.makeString(param1 + "/header", param2.header));
        }
        if (param2.body) {
            _loc4_.addBody(App.utils.locale.makeString(param1 + "/body", param2.body));
        }
        if (param2.note) {
            _loc4_.addNote(App.utils.locale.makeString(param1 + "/note", param2.note));
        }
        var _loc5_:String = _loc4_.make();
        if (_loc5_.length > 0) {
            App.toolTipMgr.showComplex(_loc5_);
        }
    }

    public function showLocal(param1:String, param2:Object, param3:ITooltipProps = null):void {
        this.cancelTasks();
        this._props = this.prepareProperties(param3);
        App.utils.scheduler.scheduleTask(this.as_show, SCHEDULE_TIME, param2, param1);
    }

    public function showSpecial(param1:String, param2:ITooltipProps, ...rest):void {
        this.cancelTasks();
        this._props = this.prepareProperties(param2);
        App.utils.scheduler.scheduleTask(onCreateTypedTooltipS, SCHEDULE_TIME, param1, rest, this._props.type);
    }

    protected function cacheComponent(param1:String, param2:DisplayObject):void {
        App.utils.asserter.assertNull(this._cachedComponents[param1], "Item \'" + param1 + "\' already cached!");
        this._cachedComponents[param1] = param2;
    }

    protected function getCachedComponent(param1:String):DisplayObject {
        return this._cachedComponents[param1];
    }

    private function prepareProperties(param1:ITooltipProps):ITooltipProps {
        if (param1 == null) {
            return this.getDefaultTooltipProps();
        }
        return param1;
    }

    private function cancelTasks():void {
        var _loc1_:IScheduler = App.utils.scheduler;
        _loc1_.cancelTask(onCreateTypedTooltipS);
        _loc1_.cancelTask(onCreateComplexTooltipS);
        _loc1_.cancelTask(this.as_show);
    }

    private function rescheduleTask(param1:Function, param2:String, param3:String):void {
        App.utils.scheduler.scheduleTask(param1, SCHEDULE_TIME, param2, param3);
    }

    private function callLogEvent(param1:String):void {
        App.eventLogManager.logUIElementTooltip(this._currentTooltip, param1, 0);
    }
}
}
