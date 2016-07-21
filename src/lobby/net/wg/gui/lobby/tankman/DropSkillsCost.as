package net.wg.gui.lobby.tankman {
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class DropSkillsCost implements IDisposable {

    public var credits:int;

    public var gold:int;

    public var xpReuseFraction:Number;

    public var id:int;

    public var actionPriceDataVo:ActionPriceVO;

    public function DropSkillsCost() {
        super();
    }

    public static function parseFromObject(param1:Object):DropSkillsCost {
        var _loc2_:DropSkillsCost = new DropSkillsCost();
        _loc2_.gold = param1.gold;
        _loc2_.credits = param1.credits;
        _loc2_.xpReuseFraction = param1.xpReuseFraction;
        _loc2_.actionPriceDataVo = !!param1.action ? new ActionPriceVO(param1.action) : null;
        return _loc2_;
    }

    public final function dispose():void {
        if (this.actionPriceDataVo) {
            this.actionPriceDataVo.dispose();
        }
        this.actionPriceDataVo = null;
    }
}
}
