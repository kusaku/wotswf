package net.wg.gui.lobby.battleloading {
import flash.text.TextField;

import net.wg.data.constants.ColorSchemeNames;
import net.wg.gui.lobby.battleloading.vo.VehicleInfoVO;

import scaleform.clik.constants.InvalidationType;

public class MultiTeamFFARenderer extends MultiTeamRenderer {

    public var pointsTF:TextField;

    public function MultiTeamFFARenderer() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.pointsTF.textColor = App.colorSchemeMgr.getRGB(ColorSchemeNames.TEXT_COLOR_GOLD);
    }

    override protected function draw():void {
        var _loc1_:VehicleInfoVO = null;
        super.draw();
        if (isInvalid(InvalidationType.DATA) && data != null) {
            _loc1_ = VehicleInfoVO(data);
            this.pointsTF.text = _loc1_.points.toString();
        }
    }

    override protected function onDispose():void {
        this.pointsTF = null;
        super.onDispose();
    }
}
}
