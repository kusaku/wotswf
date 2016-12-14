package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.ClanInfoVO;
import net.wg.gui.lobby.fortifications.data.ConnectedDirectionsVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortDeclarationOfWarWindowMeta extends AbstractWindowView {

    public var onDirectonChosen:Function;

    public var onDirectionSelected:Function;

    private var _clanInfoVO:ClanInfoVO;

    private var _clanInfoVO1:ClanInfoVO;

    private var _vectorConnectedDirectionsVO:Vector.<ConnectedDirectionsVO>;

    public function FortDeclarationOfWarWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        var _loc1_:ConnectedDirectionsVO = null;
        if (this._clanInfoVO) {
            this._clanInfoVO.dispose();
            this._clanInfoVO = null;
        }
        if (this._clanInfoVO1) {
            this._clanInfoVO1.dispose();
            this._clanInfoVO1 = null;
        }
        if (this._vectorConnectedDirectionsVO) {
            for each(_loc1_ in this._vectorConnectedDirectionsVO) {
                _loc1_.dispose();
            }
            this._vectorConnectedDirectionsVO.splice(0, this._vectorConnectedDirectionsVO.length);
            this._vectorConnectedDirectionsVO = null;
        }
        super.onDispose();
    }

    public function onDirectonChosenS(param1:int):void {
        App.utils.asserter.assertNotNull(this.onDirectonChosen, "onDirectonChosen" + Errors.CANT_NULL);
        this.onDirectonChosen(param1);
    }

    public function onDirectionSelectedS():void {
        App.utils.asserter.assertNotNull(this.onDirectionSelected, "onDirectionSelected" + Errors.CANT_NULL);
        this.onDirectionSelected();
    }

    public final function as_setupClans(param1:Object, param2:Object):void {
        var _loc3_:ClanInfoVO = this._clanInfoVO;
        this._clanInfoVO = new ClanInfoVO(param1);
        var _loc4_:ClanInfoVO = this._clanInfoVO1;
        this._clanInfoVO1 = new ClanInfoVO(param2);
        this.setupClans(this._clanInfoVO, this._clanInfoVO1);
        if (_loc3_) {
            _loc3_.dispose();
        }
        if (_loc4_) {
            _loc4_.dispose();
        }
    }

    public final function as_setDirections(param1:Array):void {
        var _loc5_:ConnectedDirectionsVO = null;
        var _loc2_:Vector.<ConnectedDirectionsVO> = this._vectorConnectedDirectionsVO;
        this._vectorConnectedDirectionsVO = new Vector.<ConnectedDirectionsVO>(0);
        var _loc3_:uint = param1.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            this._vectorConnectedDirectionsVO[_loc4_] = new ConnectedDirectionsVO(param1[_loc4_]);
            _loc4_++;
        }
        this.setDirections(this._vectorConnectedDirectionsVO);
        if (_loc2_) {
            for each(_loc5_ in _loc2_) {
                _loc5_.dispose();
            }
            _loc2_.splice(0, _loc2_.length);
        }
    }

    protected function setupClans(param1:ClanInfoVO, param2:ClanInfoVO):void {
        var _loc3_:String = "as_setupClans" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc3_);
        throw new AbstractException(_loc3_);
    }

    protected function setDirections(param1:Vector.<ConnectedDirectionsVO>):void {
        var _loc2_:String = "as_setDirections" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
