package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStaffViewHeaderVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStaffViewStaffVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStaffViewStaticHeaderVO;
import net.wg.infrastructure.base.BaseDAAPIComponent;
import net.wg.infrastructure.exceptions.AbstractException;

public class StaticFormationStaffViewMeta extends BaseDAAPIComponent {

    public var showRecriutmentWindow:Function;

    public var showInviteWindow:Function;

    public var setRecruitmentOpened:Function;

    public var removeMe:Function;

    public var removeMember:Function;

    public var assignOfficer:Function;

    public var assignPrivate:Function;

    private var _staticFormationStaffViewHeaderVO:StaticFormationStaffViewHeaderVO;

    private var _staticFormationStaffViewStaffVO:StaticFormationStaffViewStaffVO;

    private var _staticFormationStaffViewStaticHeaderVO:StaticFormationStaffViewStaticHeaderVO;

    public function StaticFormationStaffViewMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._staticFormationStaffViewHeaderVO) {
            this._staticFormationStaffViewHeaderVO.dispose();
            this._staticFormationStaffViewHeaderVO = null;
        }
        if (this._staticFormationStaffViewStaffVO) {
            this._staticFormationStaffViewStaffVO.dispose();
            this._staticFormationStaffViewStaffVO = null;
        }
        if (this._staticFormationStaffViewStaticHeaderVO) {
            this._staticFormationStaffViewStaticHeaderVO.dispose();
            this._staticFormationStaffViewStaticHeaderVO = null;
        }
        super.onDispose();
    }

    public function showRecriutmentWindowS():void {
        App.utils.asserter.assertNotNull(this.showRecriutmentWindow, "showRecriutmentWindow" + Errors.CANT_NULL);
        this.showRecriutmentWindow();
    }

    public function showInviteWindowS():void {
        App.utils.asserter.assertNotNull(this.showInviteWindow, "showInviteWindow" + Errors.CANT_NULL);
        this.showInviteWindow();
    }

    public function setRecruitmentOpenedS(param1:Boolean):void {
        App.utils.asserter.assertNotNull(this.setRecruitmentOpened, "setRecruitmentOpened" + Errors.CANT_NULL);
        this.setRecruitmentOpened(param1);
    }

    public function removeMeS():void {
        App.utils.asserter.assertNotNull(this.removeMe, "removeMe" + Errors.CANT_NULL);
        this.removeMe();
    }

    public function removeMemberS(param1:Number, param2:String):void {
        App.utils.asserter.assertNotNull(this.removeMember, "removeMember" + Errors.CANT_NULL);
        this.removeMember(param1, param2);
    }

    public function assignOfficerS(param1:Number, param2:String):void {
        App.utils.asserter.assertNotNull(this.assignOfficer, "assignOfficer" + Errors.CANT_NULL);
        this.assignOfficer(param1, param2);
    }

    public function assignPrivateS(param1:Number, param2:String):void {
        App.utils.asserter.assertNotNull(this.assignPrivate, "assignPrivate" + Errors.CANT_NULL);
        this.assignPrivate(param1, param2);
    }

    public function as_setStaticHeaderData(param1:Object):void {
        if (this._staticFormationStaffViewStaticHeaderVO) {
            this._staticFormationStaffViewStaticHeaderVO.dispose();
        }
        this._staticFormationStaffViewStaticHeaderVO = new StaticFormationStaffViewStaticHeaderVO(param1);
        this.setStaticHeaderData(this._staticFormationStaffViewStaticHeaderVO);
    }

    public function as_updateHeaderData(param1:Object):void {
        if (this._staticFormationStaffViewHeaderVO) {
            this._staticFormationStaffViewHeaderVO.dispose();
        }
        this._staticFormationStaffViewHeaderVO = new StaticFormationStaffViewHeaderVO(param1);
        this.updateHeaderData(this._staticFormationStaffViewHeaderVO);
    }

    public function as_updateStaffData(param1:Object):void {
        if (this._staticFormationStaffViewStaffVO) {
            this._staticFormationStaffViewStaffVO.dispose();
        }
        this._staticFormationStaffViewStaffVO = new StaticFormationStaffViewStaffVO(param1);
        this.updateStaffData(this._staticFormationStaffViewStaffVO);
    }

    protected function setStaticHeaderData(param1:StaticFormationStaffViewStaticHeaderVO):void {
        var _loc2_:String = "as_setStaticHeaderData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function updateHeaderData(param1:StaticFormationStaffViewHeaderVO):void {
        var _loc2_:String = "as_updateHeaderData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function updateStaffData(param1:StaticFormationStaffViewStaffVO):void {
        var _loc2_:String = "as_updateStaffData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
