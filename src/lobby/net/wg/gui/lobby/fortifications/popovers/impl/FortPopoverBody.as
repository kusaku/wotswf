package net.wg.gui.lobby.fortifications.popovers.impl {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.gui.lobby.fortifications.cmp.build.impl.OrderInfoCmp;
import net.wg.gui.lobby.fortifications.data.FortBuildingConstants;
import net.wg.gui.lobby.fortifications.data.OrderInfoVO;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class FortPopoverBody extends MovieClip implements IDisposable {

    private static const DEFRES_INFO_STATE:String = "defresInfoState";

    private static const BASE_BUILDING_STATE:String = "baseBuildingState";

    public var orderInfo:OrderInfoCmp;

    public var title:TextField;

    public var description:TextField;

    public function FortPopoverBody() {
        super();
    }

    public function dispose():void {
        this.orderInfo.dispose();
        this.orderInfo = null;
        this.title = null;
        this.description = null;
    }

    public function setData(param1:OrderInfoVO):void {
        if (param1.buildingType == FortBuildingConstants.BASE_BUILDING) {
            gotoAndStop(BASE_BUILDING_STATE);
            this.title.htmlText = param1.title;
            this.description.htmlText = param1.description;
        }
        else {
            gotoAndStop(DEFRES_INFO_STATE);
            this.orderInfo.setData(param1);
        }
        this.updateState(param1.buildingType == FortBuildingConstants.BASE_BUILDING);
    }

    private function updateState(param1:Boolean):void {
        this.title.visible = param1;
        this.description.visible = param1;
    }
}
}
