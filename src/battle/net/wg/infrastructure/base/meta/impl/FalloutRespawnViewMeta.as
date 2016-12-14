package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.battle.components.BattleDisplayable;
import net.wg.gui.battle.views.falloutRespawnView.VO.FalloutRespawnViewVO;
import net.wg.gui.battle.views.falloutRespawnView.VO.VehicleSlotVO;
import net.wg.gui.battle.views.falloutRespawnView.VO.VehicleStateVO;
import net.wg.infrastructure.exceptions.AbstractException;

public class FalloutRespawnViewMeta extends BattleDisplayable {

    public var onVehicleSelected:Function;

    public var onPostmortemBtnClick:Function;

    private var _falloutRespawnViewVO:FalloutRespawnViewVO;

    private var _vectorVehicleSlotVO:Vector.<VehicleSlotVO>;

    private var _vectorVehicleStateVO:Vector.<VehicleStateVO>;

    private var _vectorVehicleStateVO1:Vector.<VehicleStateVO>;

    public function FalloutRespawnViewMeta() {
        super();
    }

    override protected function onDispose():void {
        var _loc1_:VehicleSlotVO = null;
        var _loc2_:VehicleStateVO = null;
        var _loc3_:VehicleStateVO = null;
        if (this._falloutRespawnViewVO) {
            this._falloutRespawnViewVO.dispose();
            this._falloutRespawnViewVO = null;
        }
        if (this._vectorVehicleSlotVO) {
            for each(_loc1_ in this._vectorVehicleSlotVO) {
                _loc1_.dispose();
            }
            this._vectorVehicleSlotVO.splice(0, this._vectorVehicleSlotVO.length);
            this._vectorVehicleSlotVO = null;
        }
        if (this._vectorVehicleStateVO) {
            for each(_loc2_ in this._vectorVehicleStateVO) {
                _loc2_.dispose();
            }
            this._vectorVehicleStateVO.splice(0, this._vectorVehicleStateVO.length);
            this._vectorVehicleStateVO = null;
        }
        if (this._vectorVehicleStateVO1) {
            for each(_loc3_ in this._vectorVehicleStateVO1) {
                _loc3_.dispose();
            }
            this._vectorVehicleStateVO1.splice(0, this._vectorVehicleStateVO1.length);
            this._vectorVehicleStateVO1 = null;
        }
        super.onDispose();
    }

    public function onVehicleSelectedS(param1:int):void {
        App.utils.asserter.assertNotNull(this.onVehicleSelected, "onVehicleSelected" + Errors.CANT_NULL);
        this.onVehicleSelected(param1);
    }

    public function onPostmortemBtnClickS():void {
        App.utils.asserter.assertNotNull(this.onPostmortemBtnClick, "onPostmortemBtnClick" + Errors.CANT_NULL);
        this.onPostmortemBtnClick();
    }

    public final function as_initializeComponent(param1:Object, param2:Array):void {
        var _loc7_:VehicleSlotVO = null;
        var _loc3_:FalloutRespawnViewVO = this._falloutRespawnViewVO;
        this._falloutRespawnViewVO = new FalloutRespawnViewVO(param1);
        var _loc4_:Vector.<VehicleSlotVO> = this._vectorVehicleSlotVO;
        this._vectorVehicleSlotVO = new Vector.<VehicleSlotVO>(0);
        var _loc5_:uint = param2.length;
        var _loc6_:int = 0;
        while (_loc6_ < _loc5_) {
            this._vectorVehicleSlotVO[_loc6_] = new VehicleSlotVO(param2[_loc6_]);
            _loc6_++;
        }
        this.initializeComponent(this._falloutRespawnViewVO, this._vectorVehicleSlotVO);
        if (_loc3_) {
            _loc3_.dispose();
        }
        if (_loc4_) {
            for each(_loc7_ in _loc4_) {
                _loc7_.dispose();
            }
            _loc4_.splice(0, _loc4_.length);
        }
    }

    public final function as_updateTimer(param1:String, param2:Array):void {
        var _loc6_:VehicleStateVO = null;
        var _loc3_:Vector.<VehicleStateVO> = this._vectorVehicleStateVO;
        this._vectorVehicleStateVO = new Vector.<VehicleStateVO>(0);
        var _loc4_:uint = param2.length;
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_) {
            this._vectorVehicleStateVO[_loc5_] = new VehicleStateVO(param2[_loc5_]);
            _loc5_++;
        }
        this.updateTimer(param1, this._vectorVehicleStateVO);
        if (_loc3_) {
            for each(_loc6_ in _loc3_) {
                _loc6_.dispose();
            }
            _loc3_.splice(0, _loc3_.length);
        }
    }

    public final function as_update(param1:String, param2:Array):void {
        var _loc6_:VehicleStateVO = null;
        var _loc3_:Vector.<VehicleStateVO> = this._vectorVehicleStateVO1;
        this._vectorVehicleStateVO1 = new Vector.<VehicleStateVO>(0);
        var _loc4_:uint = param2.length;
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_) {
            this._vectorVehicleStateVO1[_loc5_] = new VehicleStateVO(param2[_loc5_]);
            _loc5_++;
        }
        this.update(param1, this._vectorVehicleStateVO1);
        if (_loc3_) {
            for each(_loc6_ in _loc3_) {
                _loc6_.dispose();
            }
            _loc3_.splice(0, _loc3_.length);
        }
    }

    protected function initializeComponent(param1:FalloutRespawnViewVO, param2:Vector.<VehicleSlotVO>):void {
        var _loc3_:String = "as_initializeComponent" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc3_);
        throw new AbstractException(_loc3_);
    }

    protected function updateTimer(param1:String, param2:Vector.<VehicleStateVO>):void {
        var _loc3_:String = "as_updateTimer" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc3_);
        throw new AbstractException(_loc3_);
    }

    protected function update(param1:String, param2:Vector.<VehicleStateVO>):void {
        var _loc3_:String = "as_update" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc3_);
        throw new AbstractException(_loc3_);
    }
}
}
