package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.cyberSport.staticFormation.data.LadderStateDataVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationLadderViewHeaderVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationLadderViewIconsVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationLadderViewLadderVO;
import net.wg.infrastructure.base.BaseDAAPIComponent;
import net.wg.infrastructure.exceptions.AbstractException;

public class StaticFormationLadderViewMeta extends BaseDAAPIComponent {

    public var showFormationProfile:Function;

    public var updateClubIcons:Function;

    private var _ladderStateDataVO:LadderStateDataVO;

    private var _staticFormationLadderViewHeaderVO:StaticFormationLadderViewHeaderVO;

    private var _staticFormationLadderViewIconsVO:StaticFormationLadderViewIconsVO;

    private var _staticFormationLadderViewLadderVO:StaticFormationLadderViewLadderVO;

    public function StaticFormationLadderViewMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._ladderStateDataVO) {
            this._ladderStateDataVO.dispose();
            this._ladderStateDataVO = null;
        }
        if (this._staticFormationLadderViewHeaderVO) {
            this._staticFormationLadderViewHeaderVO.dispose();
            this._staticFormationLadderViewHeaderVO = null;
        }
        if (this._staticFormationLadderViewIconsVO) {
            this._staticFormationLadderViewIconsVO.dispose();
            this._staticFormationLadderViewIconsVO = null;
        }
        if (this._staticFormationLadderViewLadderVO) {
            this._staticFormationLadderViewLadderVO.dispose();
            this._staticFormationLadderViewLadderVO = null;
        }
        super.onDispose();
    }

    public function showFormationProfileS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.showFormationProfile, "showFormationProfile" + Errors.CANT_NULL);
        this.showFormationProfile(param1);
    }

    public function updateClubIconsS(param1:Array):void {
        App.utils.asserter.assertNotNull(this.updateClubIcons, "updateClubIcons" + Errors.CANT_NULL);
        this.updateClubIcons(param1);
    }

    public final function as_updateHeaderData(param1:Object):void {
        var _loc2_:StaticFormationLadderViewHeaderVO = this._staticFormationLadderViewHeaderVO;
        this._staticFormationLadderViewHeaderVO = new StaticFormationLadderViewHeaderVO(param1);
        this.updateHeaderData(this._staticFormationLadderViewHeaderVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_updateLadderData(param1:Object):void {
        var _loc2_:StaticFormationLadderViewLadderVO = this._staticFormationLadderViewLadderVO;
        this._staticFormationLadderViewLadderVO = new StaticFormationLadderViewLadderVO(param1);
        this.updateLadderData(this._staticFormationLadderViewLadderVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setLadderState(param1:Object):void {
        var _loc2_:LadderStateDataVO = this._ladderStateDataVO;
        this._ladderStateDataVO = new LadderStateDataVO(param1);
        this.setLadderState(this._ladderStateDataVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_onUpdateClubIcons(param1:Object):void {
        var _loc2_:StaticFormationLadderViewIconsVO = this._staticFormationLadderViewIconsVO;
        this._staticFormationLadderViewIconsVO = new StaticFormationLadderViewIconsVO(param1);
        this.onUpdateClubIcons(this._staticFormationLadderViewIconsVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function updateHeaderData(param1:StaticFormationLadderViewHeaderVO):void {
        var _loc2_:String = "as_updateHeaderData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function updateLadderData(param1:StaticFormationLadderViewLadderVO):void {
        var _loc2_:String = "as_updateLadderData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setLadderState(param1:LadderStateDataVO):void {
        var _loc2_:String = "as_setLadderState" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function onUpdateClubIcons(param1:StaticFormationLadderViewIconsVO):void {
        var _loc2_:String = "as_onUpdateClubIcons" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
