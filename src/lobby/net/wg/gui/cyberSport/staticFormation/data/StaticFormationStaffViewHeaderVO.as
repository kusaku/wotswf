package net.wg.gui.cyberSport.staticFormation.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class StaticFormationStaffViewHeaderVO extends DAAPIDataClass {

    public var lblDescriptionVisible:Boolean = false;

    public var btnInviteVisible:Boolean = false;

    public var btnInviteEnable:Boolean = false;

    public var btnRecruitmentVisible:Boolean = false;

    public var btnRemoveVisible:Boolean = false;

    public var cbOpenedVisible:Boolean = false;

    public var lblStaffedVisible:Boolean = false;

    public var isRecruitmentOpened:Boolean = false;

    public var isCheckBoxPressed:Boolean = false;

    public var showInviteBtnAnimation:Boolean = false;

    public var btnInviteTooltip:String = "";

    public function StaticFormationStaffViewHeaderVO(param1:Object) {
        super(param1);
    }
}
}
