package net.wg.gui.lobby.profile.data {
public class ProfileDossierInfoVO extends ProfileCommonInfoVO {

    public var maxXPByVehicle:String = "";

    public var marksOfMastery:int;

    public var totalUserVehiclesCount:uint;

    public function ProfileDossierInfoVO(param1:Object) {
        super(param1);
    }

    public function getMarksOfMasteryCountStr():String {
        return App.utils.locale.integer(this.marksOfMastery);
    }
}
}
