package net.wg.infrastructure.managers.impl {
import flash.display.DisplayObject;
import flash.display.Stage;
import flash.events.MouseEvent;

import net.wg.data.constants.Errors;
import net.wg.gui.components.controls.DropDownListItemRendererSound;
import net.wg.infrastructure.base.interfaces.IAbstractPopOverView;
import net.wg.infrastructure.base.meta.IPopoverManagerMeta;
import net.wg.infrastructure.base.meta.impl.PopoverManagerMeta;
import net.wg.infrastructure.exceptions.NullPointerException;
import net.wg.infrastructure.interfaces.IClosePopoverCallback;
import net.wg.infrastructure.interfaces.IContextMenu;
import net.wg.infrastructure.interfaces.IPopOverCaller;
import net.wg.infrastructure.interfaces.IPopoverWrapper;
import net.wg.infrastructure.managers.IPopoverManager;

public class PopoverManager extends PopoverManagerMeta implements IPopoverManagerMeta, IPopoverManager {

    private var _stage:Stage;

    private var _popoverCaller:IPopOverCaller;

    private var _client:IClosePopoverCallback = null;

    public function PopoverManager(param1:Stage) {
        super();
        this._stage = param1;
    }

    public function as_onPopoverDestroy():void {
        if (this._popoverCaller) {
            this._stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onStageMouseDownHandler);
            if (this._client != null) {
                this._client.onPopoverClose();
            }
            this._popoverCaller = null;
        }
    }

    public final function dispose():void {
        this._popoverCaller = null;
        this._client = null;
        this._stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onStageMouseDownHandler);
        this._stage = null;
    }

    public function hide():void {
        requestHidePopoverS();
    }

    public function show(param1:IPopOverCaller, param2:String, param3:Object = null, param4:IClosePopoverCallback = null):void {
        App.utils.asserter.assertNotNull(param1, "popoverCaller" + Errors.CANT_NULL, NullPointerException);
        App.utils.asserter.assertNotNull(param2, "alias" + Errors.CANT_NULL, NullPointerException);
        if (this._popoverCaller == param1) {
            this.hide();
            return;
        }
        this._stage.addEventListener(MouseEvent.MOUSE_DOWN, this.onStageMouseDownHandler, false, 0, true);
        this._popoverCaller = param1;
        this._client = param4;
        requestShowPopoverS(param2, param3);
        if (this._client) {
            this._client.onPopoverOpen();
        }
    }

    public function get popoverCaller():IPopOverCaller {
        return this._popoverCaller;
    }

    private function onStageMouseDownHandler(param1:MouseEvent):void {
        App.utils.asserter.assertNotNull(this._popoverCaller, this + " _lastPopoverCaller have not to be NULL!", NullPointerException);
        if (!(param1.target is DisplayObject)) {
            return;
        }
        var _loc2_:DisplayObject = DisplayObject(param1.target);
        var _loc3_:DisplayObject = this._popoverCaller.getHitArea();
        while (_loc2_) {
            if (_loc2_ == this._popoverCaller.getTargetButton() || _loc2_ == _loc3_ || _loc2_ is IPopoverWrapper || _loc2_ is IAbstractPopOverView || _loc2_ is IContextMenu || _loc2_ is DropDownListItemRendererSound) {
                return;
            }
            _loc2_ = _loc2_.parent;
        }
        this.hide();
    }
}
}
