package net.wg.gui.lobby.fortifications.cmp.build {
import net.wg.gui.fortBase.IBuildingBaseVO;
import net.wg.gui.lobby.fortifications.cmp.build.impl.IndicatorLabels;
import net.wg.infrastructure.interfaces.IUIComponentEx;

import scaleform.clik.controls.StatusIndicator;

public interface IBuildingIndicator extends IUIComponentEx {

    function applyVOData(param1:IBuildingBaseVO):void;

    function get labels():IndicatorLabels;

    function set labels(param1:IndicatorLabels):void;

    function get defResIndicatorComponent():StatusIndicator;

    function get playAnimation():Boolean;

    function set playAnimation(param1:Boolean):void;

    function set showBars(param1:Boolean):void;
}
}
