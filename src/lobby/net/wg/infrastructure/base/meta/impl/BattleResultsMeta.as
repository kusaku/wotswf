package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.cyberSport.controls.data.CSAnimationVO;
import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class BattleResultsMeta extends AbstractWindowView {

    public var saveSorting:Function;

    public var showEventsWindow:Function;

    public var getClanEmblem:Function;

    public var getTeamEmblem:Function;

    public var startCSAnimationSound:Function;

    public var onResultsSharingBtnPress:Function;

    public var onTeamCardClick:Function;

    public var showUnlockWindow:Function;

    private var _battleResultsVO:BattleResultsVO;

    private var _cSAnimationVO:CSAnimationVO;

    public function BattleResultsMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._battleResultsVO) {
            this._battleResultsVO.dispose();
            this._battleResultsVO = null;
        }
        if (this._cSAnimationVO) {
            this._cSAnimationVO.dispose();
            this._cSAnimationVO = null;
        }
        super.onDispose();
    }

    public function saveSortingS(param1:String, param2:String, param3:int):void {
        App.utils.asserter.assertNotNull(this.saveSorting, "saveSorting" + Errors.CANT_NULL);
        this.saveSorting(param1, param2, param3);
    }

    public function showEventsWindowS(param1:String, param2:int):void {
        App.utils.asserter.assertNotNull(this.showEventsWindow, "showEventsWindow" + Errors.CANT_NULL);
        this.showEventsWindow(param1, param2);
    }

    public function getClanEmblemS(param1:String, param2:Number):void {
        App.utils.asserter.assertNotNull(this.getClanEmblem, "getClanEmblem" + Errors.CANT_NULL);
        this.getClanEmblem(param1, param2);
    }

    public function getTeamEmblemS(param1:String, param2:Number, param3:Boolean):void {
        App.utils.asserter.assertNotNull(this.getTeamEmblem, "getTeamEmblem" + Errors.CANT_NULL);
        this.getTeamEmblem(param1, param2, param3);
    }

    public function startCSAnimationSoundS():void {
        App.utils.asserter.assertNotNull(this.startCSAnimationSound, "startCSAnimationSound" + Errors.CANT_NULL);
        this.startCSAnimationSound();
    }

    public function onResultsSharingBtnPressS():void {
        App.utils.asserter.assertNotNull(this.onResultsSharingBtnPress, "onResultsSharingBtnPress" + Errors.CANT_NULL);
        this.onResultsSharingBtnPress();
    }

    public function onTeamCardClickS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.onTeamCardClick, "onTeamCardClick" + Errors.CANT_NULL);
        this.onTeamCardClick(param1);
    }

    public function showUnlockWindowS(param1:int, param2:String):void {
        App.utils.asserter.assertNotNull(this.showUnlockWindow, "showUnlockWindow" + Errors.CANT_NULL);
        this.showUnlockWindow(param1, param2);
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:BattleResultsVO = this._battleResultsVO;
        this._battleResultsVO = new BattleResultsVO(param1);
        this.setData(this._battleResultsVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setAnimation(param1:Object):void {
        var _loc2_:CSAnimationVO = this._cSAnimationVO;
        this._cSAnimationVO = new CSAnimationVO(param1);
        this.setAnimation(this._cSAnimationVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:BattleResultsVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setAnimation(param1:CSAnimationVO):void {
        var _loc2_:String = "as_setAnimation" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
