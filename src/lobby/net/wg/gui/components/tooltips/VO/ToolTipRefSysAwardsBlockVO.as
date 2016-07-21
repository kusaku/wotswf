package net.wg.gui.components.tooltips.VO {
import net.wg.data.daapi.base.DAAPIDataClass;

public class ToolTipRefSysAwardsBlockVO extends DAAPIDataClass {

    public var leftTF:String = "";

    public var rightTF:String = "";

    public var iconSource:String = "";

    public function ToolTipRefSysAwardsBlockVO(param1:Object) {
        super(param1);
    }

    override protected function onDispose():void {
        this.leftTF = null;
        this.rightTF = null;
        this.iconSource = null;
        super.onDispose();
    }
}
}
