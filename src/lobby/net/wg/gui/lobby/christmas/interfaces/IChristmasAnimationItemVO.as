package net.wg.gui.lobby.christmas.interfaces {
import net.wg.infrastructure.interfaces.entity.IDisposable;

public interface IChristmasAnimationItemVO extends IDisposable {

    function get toyImage():String;

    function get rankImage():String;
}
}
