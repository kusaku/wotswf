package net.wg.gui.cyberSport.staticFormation.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class InvitesAndRequestsItemVO extends DAAPIDataClass {

    public var id:int = -1;

    public var name:String = "";

    public var rating:int = 0;

    public var status:String = "";

    public var showProgressIndicator:Boolean = false;

    public var showAcceptBtn:Boolean = false;

    public var showRejectBtn:Boolean = false;

    public function InvitesAndRequestsItemVO(param1:Object) {
        super(param1);
    }
}
}
