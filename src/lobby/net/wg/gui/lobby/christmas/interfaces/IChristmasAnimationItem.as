package net.wg.gui.lobby.christmas.interfaces {
import net.wg.infrastructure.interfaces.ISprite;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public interface IChristmasAnimationItem extends ISprite, IDisposable {

    function setData(param1:IChristmasAnimationItemVO):void;
}
}
