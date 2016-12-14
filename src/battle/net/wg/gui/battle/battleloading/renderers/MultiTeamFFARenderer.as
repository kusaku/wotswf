package net.wg.gui.battle.battleloading.renderers {
import flash.text.TextField;

import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
import net.wg.data.constants.ColorSchemeNames;

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
        var _loc1_:DAAPIVehicleInfoVO = null;
        super.draw();
        if (isInvalid(InvalidationType.DATA) && data != null) {
            _loc1_ = DAAPIVehicleInfoVO(data);
            this.pointsTF.text = "no points";
        }
    }

    override protected function onDispose():void {
        this.pointsTF = null;
        super.onDispose();
    }
}
}
