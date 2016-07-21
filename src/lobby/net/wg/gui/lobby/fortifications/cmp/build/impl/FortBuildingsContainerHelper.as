package net.wg.gui.lobby.fortifications.cmp.build.impl {
import net.wg.gui.fortBase.IBuildingVO;
import net.wg.gui.fortBase.IFortBuilding;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class FortBuildingsContainerHelper implements IDisposable {

    private var _buildings:Vector.<IFortBuilding>;

    public function FortBuildingsContainerHelper(param1:Vector.<IFortBuilding>) {
        super();
        this._buildings = param1;
    }

    public function dispose():void {
        this._buildings = null;
    }

    public function updateBuildings(param1:Vector.<IBuildingVO>, param2:Boolean):void {
        var _loc5_:IBuildingVO = null;
        var _loc7_:int = 0;
        var _loc10_:int = 0;
        var _loc16_:int = 0;
        var _loc3_:int = param1.length;
        var _loc4_:Vector.<IFortBuilding> = this._buildings.slice();
        var _loc6_:IFortBuilding = _loc4_[0];
        _loc6_.userCanAddBuilding = param2;
        _loc6_.setData(param1[0]);
        var _loc8_:uint = 1;
        var _loc9_:uint = 2;
        var _loc11_:IFortBuilding = null;
        var _loc12_:Vector.<int> = new Vector.<int>(0);
        var _loc13_:int = _loc8_;
        while (_loc13_ < _loc3_) {
            _loc5_ = param1[_loc13_];
            _loc7_ = _loc5_.direction;
            _loc10_ = _loc8_ + (_loc7_ - 1) * _loc9_ + _loc5_.position;
            _loc11_ = _loc4_[_loc10_];
            _loc4_[_loc10_] = null;
            _loc11_.userCanAddBuilding = param2;
            _loc11_.setData(_loc5_);
            _loc12_.push(_loc7_);
            _loc13_++;
        }
        var _loc14_:uint = _loc4_.length;
        var _loc15_:int = _loc8_;
        while (_loc15_ < _loc14_) {
            _loc11_ = _loc4_[_loc15_];
            if (_loc11_ != null) {
                _loc16_ = (_loc15_ - _loc8_) / _loc9_ + 1;
                if (_loc12_.indexOf(_loc16_) != -1) {
                    _loc11_.setEmptyPlace();
                }
                else {
                    _loc11_.setData(null);
                }
            }
            _loc15_++;
        }
        _loc12_.splice(0, _loc12_.length);
        _loc4_.splice(0, _loc14_);
    }
}
}
