package net.wg.gui.data {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.lobby.components.data.StoppableAnimationLoaderVO;

public class AwardWindowAnimationVO extends DataClassItemVO {

    private var _animationData:StoppableAnimationLoaderVO = null;

    public function AwardWindowAnimationVO(param1:Object) {
        super(param1);
    }

    override public function fromHash(param1:Object):void {
        super.fromHash(param1);
        var _loc2_:DAAPIDataClass = voData;
        if (_loc2_ != null) {
            this._animationData = StoppableAnimationLoaderVO(_loc2_);
        }
    }

    override protected function onDispose():void {
        this._animationData = null;
        super.onDispose();
    }

    public function get animationData():StoppableAnimationLoaderVO {
        return this._animationData;
    }
}
}
