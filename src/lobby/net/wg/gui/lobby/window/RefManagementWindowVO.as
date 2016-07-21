package net.wg.gui.lobby.window {
import net.wg.gui.components.advanced.vo.NormalSortingTableHeaderVO;

public class RefManagementWindowVO extends NormalSortingTableHeaderVO {

    public var windowTitle:String = "";

    public var infoHeaderText:String = "";

    public var descriptionText:String = "";

    public var invitedPlayersText:String = "";

    public var invitesManagementLinkText:String = "";

    public var closeBtnLabel:String = "";

    public function RefManagementWindowVO(param1:Object) {
        super(param1);
    }
}
}
