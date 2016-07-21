package net.wg.gui.lobby.fortifications.cmp.drctn.impl {
import flash.display.InteractiveObject;
import flash.utils.Dictionary;

import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
import net.wg.gui.fortBase.IBattleNotifierVO;
import net.wg.gui.fortBase.IBuildingVO;
import net.wg.gui.fortBase.IFortDirectionsContainer;
import net.wg.gui.fortBase.IFortModeVO;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.fortifications.cmp.drctn.IFortBattleNotifier;
import net.wg.gui.lobby.fortifications.data.FunctionalStates;
import net.wg.gui.lobby.fortifications.events.DirectionEvent;
import net.wg.gui.lobby.fortifications.utils.impl.FortCommonUtils;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.clik.events.ButtonEvent;

public class FortDirectionsContainer extends UIComponentEx implements IFortDirectionsContainer {

    public var direction1:BuildingDirection = null;

    public var direction2:BuildingDirection = null;

    public var direction3:BuildingDirection = null;

    public var direction4:BuildingDirection = null;

    public var dirBattleNotifier1:IFortBattleNotifier = null;

    public var dirBattleNotifier2:IFortBattleNotifier = null;

    public var dirBattleNotifier3:IFortBattleNotifier = null;

    public var dirBattleNotifier4:IFortBattleNotifier = null;

    private var _directions:Vector.<BuildingDirection>;

    private var _battleNotifiers:Vector.<IFortBattleNotifier>;

    private var _isInOpenDirMode:Boolean = false;

    public function FortDirectionsContainer() {
        super();
        this._directions = new <BuildingDirection>[this.direction1, this.direction2, this.direction3, this.direction4];
        this._battleNotifiers = new <IFortBattleNotifier>[this.dirBattleNotifier1, this.dirBattleNotifier2, this.dirBattleNotifier3, this.dirBattleNotifier4];
    }

    override protected function configUI():void {
        super.configUI();
        if (this.direction1) {
            this.direction1.uid = FORTIFICATION_ALIASES.FORT_DIRECTION_1;
        }
        if (this.direction2) {
            this.direction2.uid = FORTIFICATION_ALIASES.FORT_DIRECTION_2;
        }
        if (this.direction3) {
            this.direction3.uid = FORTIFICATION_ALIASES.FORT_DIRECTION_3;
        }
        if (this.direction4) {
            this.direction4.uid = FORTIFICATION_ALIASES.FORT_DIRECTION_4;
        }
    }

    override protected function onDispose():void {
        var _loc1_:ISoundButtonEx = null;
        var _loc2_:IDisposable = null;
        for each(_loc1_ in this._directions) {
            _loc1_.removeEventListener(ButtonEvent.CLICK, this.onBuildingDirClickHandler);
            _loc1_.dispose();
        }
        this._directions.splice(0, this._directions.length);
        this._directions = null;
        for each(_loc2_ in this._battleNotifiers) {
            _loc2_.dispose();
        }
        this._battleNotifiers.splice(0, this._battleNotifiers.length);
        this._battleNotifiers = null;
        this.dirBattleNotifier1 = null;
        this.dirBattleNotifier2 = null;
        this.dirBattleNotifier3 = null;
        this.dirBattleNotifier4 = null;
        this.direction1 = null;
        this.direction2 = null;
        this.direction3 = null;
        this.direction4 = null;
        super.onDispose();
    }

    public function getComponentForFocus():InteractiveObject {
        return this;
    }

    public function update(param1:Vector.<IBuildingVO>):void {
        this.updateDirections(param1, this._directions);
    }

    public function updateBattleDirectionNotifiers(param1:Vector.<IBattleNotifierVO>):void {
        var _loc2_:uint = this._battleNotifiers.length;
        var _loc3_:Vector.<IBattleNotifierVO> = new Vector.<IBattleNotifierVO>(_loc2_);
        var _loc4_:uint = param1.length;
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_) {
            _loc3_[param1[_loc5_].direction - 1] = param1[_loc5_];
            _loc5_++;
        }
        var _loc6_:int = 0;
        while (_loc6_ < _loc2_) {
            this._battleNotifiers[_loc6_].setData(_loc3_[_loc6_]);
            _loc6_++;
        }
        _loc3_.splice(0, _loc2_);
    }

    public function updateDirectionsMode(param1:IFortModeVO):void {
        var _loc3_:IFortBattleNotifier = null;
        var _loc4_:Number = NaN;
        var _loc2_:BuildingDirection = null;
        for each(_loc3_ in this._battleNotifiers) {
            _loc3_.updateDirectionsMode(param1);
        }
        _loc4_ = FortCommonUtils.instance.getFunctionalState(param1);
        if (FunctionalStates.ENTER == _loc4_ || FunctionalStates.ENTER_TUTORIAL == _loc4_) {
            for each(_loc2_ in this._directions) {
                if (_loc2_.isOpen) {
                    _loc2_.disabled = true;
                }
                else {
                    _loc2_.isActive = true;
                }
                _loc2_.addEventListener(ButtonEvent.CLICK, this.onBuildingDirClickHandler, false, 0, true);
            }
            this._isInOpenDirMode = true;
        }
        else if (FunctionalStates.LEAVE == _loc4_ || FunctionalStates.LEAVE_TUTORIAL == _loc4_) {
            for each(_loc2_ in this._directions) {
                _loc2_.isActive = false;
                _loc2_.disabled = false;
                _loc2_.removeEventListener(ButtonEvent.CLICK, this.onBuildingDirClickHandler);
            }
            this._isInOpenDirMode = false;
        }
    }

    public function updateTransportMode(param1:IFortModeVO):void {
        var _loc2_:FortBattleNotifier = null;
        var _loc3_:BuildingDirection = null;
        if (!param1.isTutorial || param1.currentMode == FunctionalStates.TRANSPORTING_TUTORIAL_FIRST_STEP) {
            for each(_loc3_ in this._directions) {
                _loc3_.disabled = param1.isEntering;
            }
        }
        for each(_loc2_ in this._battleNotifiers) {
            _loc2_.updateTransportMode(param1);
        }
    }

    protected function updateDirections(param1:Vector.<IBuildingVO>, param2:Vector.<BuildingDirection>):void {
        var _loc4_:int = 0;
        var _loc5_:IBuildingVO = null;
        var _loc12_:BuildingDirection = null;
        var _loc13_:Boolean = false;
        var _loc3_:int = param1.length;
        var _loc6_:uint = 1;
        var _loc7_:Dictionary = new Dictionary();
        var _loc8_:Dictionary = new Dictionary();
        var _loc9_:int = _loc6_;
        while (_loc9_ < _loc3_) {
            _loc5_ = param1[_loc9_];
            _loc4_ = _loc5_.direction - 1;
            _loc7_[_loc4_] = true;
            _loc8_[_loc4_] = _loc5_.directionType;
            _loc9_++;
        }
        var _loc10_:uint = param2.length;
        var _loc11_:int = 0;
        while (_loc11_ < _loc10_) {
            _loc12_ = param2[_loc11_];
            _loc13_ = _loc7_[_loc11_];
            _loc12_.isOpen = _loc13_;
            if (_loc13_) {
                _loc12_.modernizationLevel = _loc8_[_loc11_];
            }
            if (this._isInOpenDirMode) {
                _loc12_.isActive = !_loc13_;
                _loc12_.disabled = _loc13_;
            }
            _loc11_++;
        }
    }

    private function onBuildingDirClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new DirectionEvent(DirectionEvent.OPEN_DIRECTION, BuildingDirection(param1.target).uid, true));
    }
}
}
