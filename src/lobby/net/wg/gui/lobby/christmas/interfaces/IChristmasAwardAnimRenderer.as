package net.wg.gui.lobby.christmas.interfaces {
import net.wg.gui.lobby.quests.data.AwardCarouselItemRendererVO;

public interface IChristmasAwardAnimRenderer {

    function setData(param1:AwardCarouselItemRendererVO):void;

    function show():void;

    function hide():void;
}
}
