package net.wg.gui.lobby.christmas.interfaces {
import net.wg.infrastructure.interfaces.IMovieClip;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public interface IChristmasItemsAnimation extends IMovieClip, IDisposable {

    function setData(param1:Vector.<IChristmasAnimationItemVO>):void;
}
}
