package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.FortWelcomeViewVO;
import net.wg.infrastructure.base.BaseDAAPIComponent;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortWelcomeInfoViewMeta extends BaseDAAPIComponent {

    public var onCreateBtnClick:Function;

    public var onNavigate:Function;

    public var openClanResearch:Function;

    private var _fortWelcomeViewVO:FortWelcomeViewVO;

    public function FortWelcomeInfoViewMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._fortWelcomeViewVO) {
            this._fortWelcomeViewVO.dispose();
            this._fortWelcomeViewVO = null;
        }
        super.onDispose();
    }

    public function onCreateBtnClickS():void {
        App.utils.asserter.assertNotNull(this.onCreateBtnClick, "onCreateBtnClick" + Errors.CANT_NULL);
        this.onCreateBtnClick();
    }

    public function onNavigateS(param1:String):void {
        App.utils.asserter.assertNotNull(this.onNavigate, "onNavigate" + Errors.CANT_NULL);
        this.onNavigate(param1);
    }

    public function openClanResearchS():void {
        App.utils.asserter.assertNotNull(this.openClanResearch, "openClanResearch" + Errors.CANT_NULL);
        this.openClanResearch();
    }

    public final function as_setCommonData(param1:Object):void {
        var _loc2_:FortWelcomeViewVO = this._fortWelcomeViewVO;
        this._fortWelcomeViewVO = new FortWelcomeViewVO(param1);
        this.setCommonData(this._fortWelcomeViewVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setCommonData(param1:FortWelcomeViewVO):void {
        var _loc2_:String = "as_setCommonData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
