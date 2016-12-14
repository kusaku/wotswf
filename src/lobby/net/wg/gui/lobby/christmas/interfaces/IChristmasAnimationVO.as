package net.wg.gui.lobby.christmas.interfaces {
import net.wg.gui.lobby.components.interfaces.IStoppableAnimationVO;

public interface IChristmasAnimationVO extends IStoppableAnimationVO {

    function get mainItem():IChristmasAnimationItemVO;

    function get additionalItems():Vector.<IChristmasAnimationItemVO>;
}
}
