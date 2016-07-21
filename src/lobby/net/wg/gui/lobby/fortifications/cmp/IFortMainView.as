package net.wg.gui.lobby.fortifications.cmp {
import net.wg.gui.fortBase.IFortLandscapeCmp;
import net.wg.gui.lobby.fortifications.cmp.main.IMainFooter;
import net.wg.gui.lobby.fortifications.cmp.main.IMainHeader;
import net.wg.infrastructure.base.meta.IFortMainViewMeta;
import net.wg.infrastructure.interfaces.IUIComponentEx;
import net.wg.infrastructure.interfaces.IViewStackContent;

public interface IFortMainView extends IUIComponentEx, IViewStackContent, IFortMainViewMeta {

    function get header():IMainHeader;

    function set header(param1:IMainHeader):void;

    function get footer():IMainFooter;

    function set footer(param1:IMainFooter):void;

    function get buildings():IFortLandscapeCmp;

    function set buildings(param1:IFortLandscapeCmp):void;
}
}
