package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationProfileButtonInfoVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationProfileEmblemVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationProfileWindowVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class StaticFormationProfileWindowMeta extends AbstractWindowView {

    public var actionBtnClickHandler:Function;

    public var onClickHyperLink:Function;

    private var _staticFormationProfileButtonInfoVO:StaticFormationProfileButtonInfoVO;

    private var _staticFormationProfileWindowVO:StaticFormationProfileWindowVO;

    private var _staticFormationProfileEmblemVO:StaticFormationProfileEmblemVO;

    public function StaticFormationProfileWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._staticFormationProfileButtonInfoVO) {
            this._staticFormationProfileButtonInfoVO.dispose();
            this._staticFormationProfileButtonInfoVO = null;
        }
        if (this._staticFormationProfileWindowVO) {
            this._staticFormationProfileWindowVO.dispose();
            this._staticFormationProfileWindowVO = null;
        }
        if (this._staticFormationProfileEmblemVO) {
            this._staticFormationProfileEmblemVO.dispose();
            this._staticFormationProfileEmblemVO = null;
        }
        super.onDispose();
    }

    public function actionBtnClickHandlerS(param1:String):void {
        App.utils.asserter.assertNotNull(this.actionBtnClickHandler, "actionBtnClickHandler" + Errors.CANT_NULL);
        this.actionBtnClickHandler(param1);
    }

    public function onClickHyperLinkS(param1:String):void {
        App.utils.asserter.assertNotNull(this.onClickHyperLink, "onClickHyperLink" + Errors.CANT_NULL);
        this.onClickHyperLink(param1);
    }

    public function as_setData(param1:Object):void {
        if (this._staticFormationProfileWindowVO) {
            this._staticFormationProfileWindowVO.dispose();
        }
        this._staticFormationProfileWindowVO = new StaticFormationProfileWindowVO(param1);
        this.setData(this._staticFormationProfileWindowVO);
    }

    public function as_updateFormationInfo(param1:Object):void {
        if (this._staticFormationProfileEmblemVO) {
            this._staticFormationProfileEmblemVO.dispose();
        }
        this._staticFormationProfileEmblemVO = new StaticFormationProfileEmblemVO(param1);
        this.updateFormationInfo(this._staticFormationProfileEmblemVO);
    }

    public function as_updateActionButton(param1:Object):void {
        if (this._staticFormationProfileButtonInfoVO) {
            this._staticFormationProfileButtonInfoVO.dispose();
        }
        this._staticFormationProfileButtonInfoVO = new StaticFormationProfileButtonInfoVO(param1);
        this.updateActionButton(this._staticFormationProfileButtonInfoVO);
    }

    protected function setData(param1:StaticFormationProfileWindowVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function updateFormationInfo(param1:StaticFormationProfileEmblemVO):void {
        var _loc2_:String = "as_updateFormationInfo" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function updateActionButton(param1:StaticFormationProfileButtonInfoVO):void {
        var _loc2_:String = "as_updateActionButton" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
