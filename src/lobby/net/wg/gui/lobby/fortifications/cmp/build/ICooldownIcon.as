package net.wg.gui.lobby.fortifications.cmp.build {
import flash.text.TextField;

import net.wg.infrastructure.interfaces.IUIComponentEx;

public interface ICooldownIcon extends IUIComponentEx {

    function get timeTextField():TextField;

    function set timeTextField(param1:TextField):void;
}
}
