package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.DirectionVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortCreateDirectionWindowMeta extends AbstractWindowView {

    public var openNewDirection:Function;

    public var closeDirection:Function;

    private var _vectorDirectionVO:Vector.<DirectionVO>;

    public function FortCreateDirectionWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        var _loc1_:DirectionVO = null;
        if (this._vectorDirectionVO) {
            for each(_loc1_ in this._vectorDirectionVO) {
                _loc1_.dispose();
            }
            this._vectorDirectionVO.splice(0, this._vectorDirectionVO.length);
            this._vectorDirectionVO = null;
        }
        super.onDispose();
    }

    public function openNewDirectionS():void {
        App.utils.asserter.assertNotNull(this.openNewDirection, "openNewDirection" + Errors.CANT_NULL);
        this.openNewDirection();
    }

    public function closeDirectionS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.closeDirection, "closeDirection" + Errors.CANT_NULL);
        this.closeDirection(param1);
    }

    public final function as_setDirections(param1:Array):void {
        var _loc5_:DirectionVO = null;
        var _loc2_:Vector.<DirectionVO> = this._vectorDirectionVO;
        this._vectorDirectionVO = new Vector.<DirectionVO>(0);
        var _loc3_:uint = param1.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            this._vectorDirectionVO[_loc4_] = new DirectionVO(param1[_loc4_]);
            _loc4_++;
        }
        this.setDirections(this._vectorDirectionVO);
        if (_loc2_) {
            for each(_loc5_ in _loc2_) {
                _loc5_.dispose();
            }
            _loc2_.splice(0, _loc2_.length);
        }
    }

    protected function setDirections(param1:Vector.<DirectionVO>):void {
        var _loc2_:String = "as_setDirections" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
