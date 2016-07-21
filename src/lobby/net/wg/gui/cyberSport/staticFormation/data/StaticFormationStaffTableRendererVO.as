package net.wg.gui.cyberSport.staticFormation.data {
import net.wg.data.VO.ExtendedUserVO;
import net.wg.data.daapi.base.DAAPIDataClass;

public class StaticFormationStaffTableRendererVO extends DAAPIDataClass {

    public var orderNumber:String = "";

    public var orderNumberSortValue:int = -1;

    public var userData:ExtendedUserVO;

    public var userDataSortValue:String = "";

    public var memberId:Number = -1.0;

    public var appointment:FormationAppointmentVO;

    public var appointmentSortValue:int;

    public var rating:String = "";

    public var ratingSortValue:Number;

    public var battlesCount:String = "";

    public var battlesCountSortValue:Number;

    public var damageCoef:String = "";

    public var damageCoefSortValue:Number;

    public var avrDamage:String = "";

    public var avrDamageSortValue:Number;

    public var avrAssistDamage:String = "";

    public var avrAssistDamageSortValue:Number;

    public var avrExperience:String = "";

    public var avrExperienceSortValue:Number;

    public var taunt:String = "";

    public var tauntSortValue:Number;

    public var joinDate:String = "";

    public var joinDateSortValue:Number;

    public var removeMemberBtnIcon:String = "";

    public var emptyText:String = "";

    public var removeMemberBtnTooltip:String = "";

    public var canRemoved:Boolean = false;

    public var canPassOwnership:Boolean = false;

    public var canShowContextMenu:Boolean = false;

    public var clubDbID:Number = -1;

    public var statusIcon:String = "";

    public function StaticFormationStaffTableRendererVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == "appointment") {
            this.appointment = new FormationAppointmentVO(param2);
            return false;
        }
        if (param1 == "userData") {
            this.userData = new ExtendedUserVO(param2);
            return false;
        }
        return true;
    }

    override protected function onDispose():void {
        if (this.appointment != null) {
            this.appointment.dispose();
            this.appointment = null;
        }
        if (this.userData != null) {
            this.userData.dispose();
            this.userData = null;
        }
        super.onDispose();
    }
}
}
