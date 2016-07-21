package net.wg.gui.lobby.fortifications.utils.impl {
import flash.display.DisplayObject;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;

import net.wg.data.constants.Errors;
import net.wg.gui.fortBase.IFortBuilding;
import net.wg.gui.fortBase.IFortModeVO;
import net.wg.gui.fortBase.ITransportingHandler;
import net.wg.gui.lobby.fortifications.data.FortModeVO;
import net.wg.gui.lobby.fortifications.utils.ITransportingHelper;
import net.wg.utils.IAssertable;
import net.wg.utils.ICommons;

public class TransportingHelper implements ITransportingHelper {

    private var _buildings:Vector.<IFortBuilding> = null;

    private var _buildToExport:IFortBuilding = null;

    private var _buildToImport:IFortBuilding = null;

    private var _transportingHandler:ITransportingHandler = null;

    private var _commons:ICommons = null;

    private var _asserter:IAssertable = null;

    public function TransportingHelper(param1:Vector.<IFortBuilding>, param2:ITransportingHandler) {
        super();
        this._commons = App.utils.commons;
        this._asserter = App.utils.asserter;
        this._asserter.assertNotNull(param1, "buildings" + Errors.CANT_NULL);
        this._asserter.assertNotNull(param2, "transportingHandler" + Errors.CANT_NULL);
        this._buildings = param1;
        this._transportingHandler = param2;
    }

    public function dispose():void {
        this.removeAllTransportingListeners();
        this._transportingHandler = null;
        this._buildings = null;
        this._buildToExport = null;
        this._buildToImport = null;
        this._commons = null;
        this._asserter = null;
    }

    public function getModeVO(param1:Boolean, param2:Boolean):IFortModeVO {
        var _loc3_:IFortModeVO = new FortModeVO();
        _loc3_.isEntering = param1;
        _loc3_.isTutorial = param2;
        return _loc3_;
    }

    public function updateTransportMode(param1:IFortModeVO):void {
        var _loc2_:IFortBuilding = null;
        if (param1.isEntering) {
            this.initTransportingEntering();
        }
        else {
            this._buildToExport = null;
            this._buildToImport = null;
            this.removeAllTransportingListeners();
        }
        for each(_loc2_ in this._buildings) {
            _loc2_.updateTransportMode(param1);
        }
    }

    private function initTransportingEntering():void {
        var _loc1_:Vector.<IEventDispatcher> = this.getExportAvailableBuildingsHitArea();
        this._commons.addMultipleHandlers(_loc1_, MouseEvent.CLICK, this.onExportingClickHandler);
        _loc1_.splice(0, _loc1_.length);
    }

    private function removeAllTransportingListeners():void {
        var _loc1_:Vector.<IEventDispatcher> = this.getAllBuildingsHitArea();
        this._commons.removeMultipleHandlers(_loc1_, MouseEvent.CLICK, this.onExportingClickHandler);
        this._commons.removeMultipleHandlers(_loc1_, MouseEvent.CLICK, this.onImportClickHandler);
        App.stage.removeEventListener(MouseEvent.CLICK, this.onStageClickHandler);
        _loc1_.splice(0, _loc1_.length);
    }

    private function getAllBuildingsHitArea():Vector.<IEventDispatcher> {
        var _loc2_:IFortBuilding = null;
        var _loc1_:Vector.<IEventDispatcher> = new Vector.<IEventDispatcher>();
        for each(_loc2_ in this._buildings) {
            if (_loc2_.isAvailable()) {
                _loc1_.push(_loc2_.getCustomHitArea());
            }
        }
        return _loc1_;
    }

    private function getExportAvailableBuildingsHitArea():Vector.<IEventDispatcher> {
        var _loc2_:IFortBuilding = null;
        var _loc1_:Vector.<IEventDispatcher> = new Vector.<IEventDispatcher>();
        for each(_loc2_ in this._buildings) {
            if (_loc2_.isAvailable()) {
                if (_loc2_.isExportAvailable()) {
                    _loc1_.push(_loc2_.getCustomHitArea());
                }
            }
        }
        return _loc1_;
    }

    private function getImportAvailableBuildingsHitArea():Vector.<IEventDispatcher> {
        var _loc2_:IFortBuilding = null;
        var _loc1_:Vector.<IEventDispatcher> = new Vector.<IEventDispatcher>();
        for each(_loc2_ in this._buildings) {
            if (_loc2_.isAvailable()) {
                if (_loc2_.isImportAvailable()) {
                    _loc1_.push(_loc2_.getCustomHitArea());
                }
            }
        }
        return _loc1_;
    }

    private function onStageClickHandler(param1:MouseEvent):void {
        var _loc2_:DisplayObject = DisplayObject(param1.target);
        while (_loc2_ != null) {
            if (_loc2_ is IFortBuilding) {
                return;
            }
            _loc2_ = _loc2_.parent;
        }
        this._transportingHandler.onStartExporting();
        this.updateTransportMode(this.getModeVO(false, false));
        this.updateTransportMode(this.getModeVO(true, false));
    }

    private function onExportingClickHandler(param1:MouseEvent):void {
        var _loc2_:Vector.<IEventDispatcher> = null;
        var _loc3_:IFortBuilding = null;
        if (this._commons.isLeftButton(param1)) {
            _loc2_ = this.getAllBuildingsHitArea();
            this._commons.removeMultipleHandlers(_loc2_, MouseEvent.CLICK, this.onExportingClickHandler);
            _loc2_.splice(0, _loc2_.length);
            this._buildToExport = IFortBuilding(param1.currentTarget.parent);
            for each(_loc3_ in this._buildings) {
                if (_loc3_.isAvailable()) {
                    _loc3_.nextTransportingStep(this._buildToExport == _loc3_);
                }
            }
            this._transportingHandler.onStartImporting();
            _loc2_ = this.getImportAvailableBuildingsHitArea();
            this._commons.addMultipleHandlers(_loc2_, MouseEvent.CLICK, this.onImportClickHandler);
            App.stage.addEventListener(MouseEvent.CLICK, this.onStageClickHandler);
            _loc2_.splice(0, _loc2_.length);
        }
    }

    private function onImportClickHandler(param1:MouseEvent):void {
        var _loc2_:IFortBuilding = null;
        if (this._commons.isLeftButton(param1)) {
            this._asserter.assertNotNull(this._buildToExport, "_buildToExport" + Errors.CANT_NULL);
            _loc2_ = IFortBuilding(param1.currentTarget.parent);
            if (_loc2_ != this._buildToExport) {
                this._buildToImport = _loc2_;
                this._buildToExport.exportArrow.hide();
                this._buildToImport.importArrow.hide();
                this._transportingHandler.onTransportingSuccess(this._buildToExport, this._buildToImport);
                App.stage.removeEventListener(MouseEvent.CLICK, this.onStageClickHandler);
            }
        }
    }
}
}
