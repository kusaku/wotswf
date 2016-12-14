package net.wg.gui.lobby.components {
import flash.display.MovieClip;

import net.wg.gui.lobby.components.interfaces.IStoppableAnimationItem;
import net.wg.gui.lobby.components.interfaces.IStoppableAnimationVO;

public class BaseAwardWindowAnimation extends MovieClip implements IStoppableAnimationItem {

    public function BaseAwardWindowAnimation() {
        super();
        stop();
    }

    public final function dispose():void {
        this.onDispose();
    }

    public function endAnimation():void {
        gotoAndStop(totalFrames);
    }

    public function playAnimation():void {
        play();
    }

    public function setData(param1:IStoppableAnimationVO):void {
    }

    protected function onDispose():void {
    }
}
}
