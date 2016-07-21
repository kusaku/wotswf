package net.wg.gui.lobby.hangar.maintenance.data {
import net.wg.gui.events.ShellRendererEvent;
import net.wg.gui.lobby.hangar.ammunitionPanel.data.ShellButtonVO;

public class MaintenanceShellVO extends ShellButtonVO {

    private static const USER_COUNT_FIELD:String = "userCount";

    public var step:int;

    public var goldShellsForCredits:Boolean;

    public var prices:Array = null;

    public var actionPriceData:Object = null;

    public var currency:String = "";

    public var ammoName:String = "";

    public var tableName:String = "";

    public var maxAmmo:int;

    public var list:Array = null;

    public var possibleMax:int;

    public var totalLoaded:int;

    public var userCredits:Object = null;

    private var _userCount:int = -1;

    public function MaintenanceShellVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == USER_COUNT_FIELD) {
            this.setUserCount(int(param2));
            return false;
        }
        return true;
    }

    override protected function onDispose():void {
        if (this.prices) {
            this.prices.splice(0);
            this.prices = null;
        }
        if (this.list) {
            this.list.splice(0);
            this.list = null;
        }
        App.utils.data.cleanupDynamicObject(this.actionPriceData);
        this.actionPriceData = null;
        App.utils.data.cleanupDynamicObject(this.userCredits);
        this.userCredits = null;
        super.onDispose();
    }

    public function setUserCount(param1:int):void {
        this._userCount = param1;
        dispatchEvent(new ShellRendererEvent(ShellRendererEvent.USER_COUNT_CHANGED));
    }

    public function get userCount():int {
        return this._userCount;
    }

    public function set userCount(param1:int):void {
        var _loc2_:MaintenanceShellVO = null;
        var _loc4_:MaintenanceShellVO = null;
        if (this._userCount == param1) {
            return;
        }
        this._userCount = param1;
        var _loc3_:int = this.userCount;
        for each(_loc2_ in this.list) {
            _loc3_ = _loc3_ + _loc2_.userCount;
            if (_loc4_ == null || _loc2_.userCount > _loc4_.userCount) {
                _loc4_ = _loc2_;
            }
        }
        if (_loc3_ > this.maxAmmo) {
            this._userCount = this._userCount - (_loc3_ - this.maxAmmo);
            _loc3_ = _loc3_ - (_loc3_ - this.maxAmmo);
        }
        var _loc5_:int = _loc3_ - this.maxAmmo;
        _loc5_ = _loc5_ > 0 ? int(_loc5_) : 0;
        this.possibleMax = this.maxAmmo - _loc3_ + _loc5_ + this.userCount;
        for each(_loc2_ in this.list) {
            _loc2_.possibleMax = this.maxAmmo - _loc3_ + _loc5_ + _loc2_.userCount;
            _loc2_.setUserCount(_loc2_.userCount - (_loc2_ == _loc4_ ? _loc5_ : 0));
            _loc2_.userCredits = this.userCredits;
        }
        dispatchEvent(new ShellRendererEvent(ShellRendererEvent.USER_COUNT_CHANGED));
    }

    public function get price():int {
        var _loc1_:int = this.currency == "credits" ? 0 : 1;
        return this.prices[_loc1_];
    }

    public function get buyShellsCount():int {
        var _loc1_:int = count - this.userCount + inventoryCount;
        return _loc1_ < 0 ? int(-_loc1_) : 0;
    }
}
}
