package net.wg.gui.lobby.fortifications.cmp.main {
import net.wg.gui.components.controls.BitmapFill;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.slotsPanel.ISlotsPanel;
import net.wg.gui.lobby.fortifications.cmp.base.IFilledBar;
import net.wg.gui.lobby.fortifications.cmp.orders.ICheckBoxIcon;
import net.wg.infrastructure.interfaces.IUIComponentEx;
import net.wg.infrastructure.interfaces.entity.IFocusContainer;

public interface IMainFooter extends IFilledBar, IFocusContainer {

    function get leaveModeBtn():SoundButtonEx;

    function set leaveModeBtn(param1:SoundButtonEx):void;

    function get ordersPanel():ISlotsPanel;

    function set ordersPanel(param1:ISlotsPanel):void;

    function get intelligenceButton():SoundButtonEx;

    function set intelligenceButton(param1:SoundButtonEx):void;

    function get sortieBtn():SoundButtonEx;

    function set sortieBtn(param1:SoundButtonEx):void;

    function get footerBitmapFill():BitmapFill;

    function set footerBitmapFill(param1:BitmapFill):void;

    function get orderSelector():ICheckBoxIcon;

    function get tutorialArrowIntelligence():IUIComponentEx;

    function set tutorialArrowIntelligence(param1:IUIComponentEx):void;
}
}
