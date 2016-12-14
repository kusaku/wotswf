package net.wg.gui.lobby.christmas.interfaces {
import net.wg.gui.lobby.christmas.ChristmasChestsView;
import net.wg.gui.lobby.quests.data.AwardCarouselItemRendererVO;
import net.wg.infrastructure.interfaces.IUIComponentEx;

public interface IChestAwardRibbon extends IUIComponentEx {

    function setAwards(param1:Vector.<AwardCarouselItemRendererVO>):void;

    function show():void;

    function hide():void;

    function setOwner(param1:ChristmasChestsView):void;
}
}
