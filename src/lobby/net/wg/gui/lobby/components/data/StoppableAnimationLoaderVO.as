package net.wg.gui.lobby.components.data {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.lobby.components.interfaces.IStoppableAnimationLoaderVO;

public class StoppableAnimationLoaderVO extends DAAPIDataClass implements IStoppableAnimationLoaderVO {

    public var image:String = "";

    public var animationPath:String = "";

    public var animationLinkage:String = "";

    public function StoppableAnimationLoaderVO(param1:Object) {
        super(param1);
    }

    public function get anmImage():String {
        return this.image;
    }

    public function get anmLinkage():String {
        return this.animationLinkage;
    }

    public function get anmPath():String {
        return this.animationPath;
    }
}
}
