package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.christmas.data.ChestsViewVO;
import net.wg.gui.lobby.quests.data.AwardCarouselItemRendererVO;
import net.wg.infrastructure.base.AbstractView;
import net.wg.infrastructure.exceptions.AbstractException;

public class ChristmasChestsViewMeta extends AbstractView {

    public var onOpenBtnClick:Function;

    public var onCloseWindow:Function;

    public var onPlaySound:Function;

    private var _chestsViewVO:ChestsViewVO;

    private var _vectorAwardCarouselItemRendererVO:Vector.<AwardCarouselItemRendererVO>;

    public function ChristmasChestsViewMeta() {
        super();
    }

    override protected function onDispose():void {
        var _loc1_:AwardCarouselItemRendererVO = null;
        if (this._chestsViewVO) {
            this._chestsViewVO.dispose();
            this._chestsViewVO = null;
        }
        if (this._vectorAwardCarouselItemRendererVO) {
            for each(_loc1_ in this._vectorAwardCarouselItemRendererVO) {
                _loc1_.dispose();
            }
            this._vectorAwardCarouselItemRendererVO.splice(0, this._vectorAwardCarouselItemRendererVO.length);
            this._vectorAwardCarouselItemRendererVO = null;
        }
        super.onDispose();
    }

    public function onOpenBtnClickS():void {
        App.utils.asserter.assertNotNull(this.onOpenBtnClick, "onOpenBtnClick" + Errors.CANT_NULL);
        this.onOpenBtnClick();
    }

    public function onCloseWindowS():void {
        App.utils.asserter.assertNotNull(this.onCloseWindow, "onCloseWindow" + Errors.CANT_NULL);
        this.onCloseWindow();
    }

    public function onPlaySoundS(param1:String):void {
        App.utils.asserter.assertNotNull(this.onPlaySound, "onPlaySound" + Errors.CANT_NULL);
        this.onPlaySound(param1);
    }

    public final function as_setInitData(param1:Object):void {
        var _loc2_:ChestsViewVO = this._chestsViewVO;
        this._chestsViewVO = new ChestsViewVO(param1);
        this.setInitData(this._chestsViewVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setAwardData(param1:Array):void {
        var _loc5_:AwardCarouselItemRendererVO = null;
        var _loc2_:Vector.<AwardCarouselItemRendererVO> = this._vectorAwardCarouselItemRendererVO;
        this._vectorAwardCarouselItemRendererVO = new Vector.<AwardCarouselItemRendererVO>(0);
        var _loc3_:uint = param1.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            this._vectorAwardCarouselItemRendererVO[_loc4_] = new AwardCarouselItemRendererVO(param1[_loc4_]);
            _loc4_++;
        }
        this.setAwardData(this._vectorAwardCarouselItemRendererVO);
        if (_loc2_) {
            for each(_loc5_ in _loc2_) {
                _loc5_.dispose();
            }
            _loc2_.splice(0, _loc2_.length);
        }
    }

    protected function setInitData(param1:ChestsViewVO):void {
        var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setAwardData(param1:Vector.<AwardCarouselItemRendererVO>):void {
        var _loc2_:String = "as_setAwardData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
