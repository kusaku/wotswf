package net.wg.gui.rally.vo {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.interfaces.IExtendedUserVO;
import net.wg.gui.interfaces.IRallyCandidateVO;
import net.wg.gui.rally.interfaces.IRallySlotVO;
import net.wg.gui.rally.interfaces.IRallyVO;
import net.wg.infrastructure.interfaces.IDAAPIDataClass;

public class RallyShortVO extends DAAPIDataClass implements IRallyVO {

    private static const SLOTS_FIELD:String = "slots";

    public var isFreezed:Boolean;

    public var slots:Vector.<IRallySlotVO>;

    private var _hasRestrictions:Boolean;

    private var _description:String = "";

    private var _isCommander:Boolean = false;

    private var _statusValue:Boolean;

    private var _statusLbl:String = "";

    public function RallyShortVO(param1:Object) {
        super(param1);
    }

    override protected function onDispose():void {
        var _loc1_:IRallySlotVO = null;
        if (this.slots) {
            _loc1_ = null;
            while (this.slots.length) {
                _loc1_ = this.slots.pop();
                _loc1_.dispose();
            }
            this.slots = null;
        }
        super.onDispose();
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == SLOTS_FIELD) {
            this.initSlotsVO(param2);
            return false;
        }
        return true;
    }

    override protected function onDataRead(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:IDAAPIDataClass = null;
        if (param1 == SLOTS_FIELD) {
            _loc3_ = [];
            for each(_loc4_ in this.slots) {
                _loc3_.push(_loc4_.toHash());
            }
            param2[param1] = _loc3_;
            return false;
        }
        return true;
    }

    public function addSlot(param1:IRallySlotVO):void {
        if (this.slots == null) {
            this.slots = new Vector.<IRallySlotVO>();
        }
        this.slots.push(param1);
    }

    public function clearSlots():void {
        if (this.slots) {
            this.slots.splice(0, this.slots.length);
        }
    }

    public function hasSlotsData():Boolean {
        return this.slots != null;
    }

    public function isAvailable():Boolean {
        return this.slots != null && this.slots.length > 0;
    }

    protected function initSlotsVO(param1:Object):void {
        var _loc3_:Object = null;
        var _loc4_:RallySlotVO = null;
        this.slots = new Vector.<IRallySlotVO>();
        var _loc2_:Array = param1 as Array;
        App.utils.asserter.assertNotNull(_loc2_, "Item \'slotsRaw\' must be Array");
        for each(_loc3_ in _loc2_) {
            _loc4_ = new RallySlotVO(_loc3_);
            this.slots.push(_loc4_);
        }
    }

    public function get slotsArray():Array {
        var _loc1_:Array = null;
        var _loc2_:int = 0;
        if (this.slots != null) {
            _loc1_ = new Array(this.slots.length);
            _loc2_ = this.slots.length;
            while (_loc2_--) {
                _loc1_[_loc2_] = this.slots[_loc2_];
            }
            return _loc1_;
        }
        return [];
    }

    public function get commander():IRallyCandidateVO {
        var _loc2_:IRallySlotVO = null;
        var _loc1_:IRallyCandidateVO = null;
        if (this.slots) {
            _loc2_ = IRallySlotVO(this.slots[0]);
            if (_loc2_.player) {
                _loc1_ = _loc2_.player;
            }
        }
        return _loc1_;
    }

    public function get commanderExtendedUserVO():IExtendedUserVO {
        var _loc1_:IExtendedUserVO = this.commander as IExtendedUserVO;
        App.utils.asserter.assertNotNull(_loc1_, "Item \'commanderExtendedUserVO\' must be IExtendedUserVO");
        return _loc1_;
    }

    public function get description():String {
        return this._description;
    }

    public function set description(param1:String):void {
        this._description = param1;
    }

    public function get isCommander():Boolean {
        return this._isCommander;
    }

    public function set isCommander(param1:Boolean):void {
        this._isCommander = param1;
    }

    public function get statusValue():Boolean {
        return this._statusValue;
    }

    public function set statusValue(param1:Boolean):void {
        this._statusValue = param1;
    }

    public function get statusLbl():String {
        return this._statusLbl;
    }

    public function set statusLbl(param1:String):void {
        this._statusLbl = param1;
    }

    public function get hasRestrictions():Boolean {
        var _loc1_:Boolean = false;
        var _loc2_:int = 0;
        var _loc3_:IRallySlotVO = null;
        var _loc4_:* = undefined;
        var _loc5_:Boolean = false;
        if (this.slots) {
            _loc1_ = false;
            _loc2_ = 1;
            _loc5_ = false;
            while (_loc2_ < this.slots.length) {
                _loc3_ = IRallySlotVO(this.slots[_loc2_]);
                _loc5_ = false;
                for each(_loc4_ in _loc3_.restrictions) {
                    _loc5_ = _loc5_ || _loc4_ != null;
                }
                _loc1_ = _loc1_ || _loc5_ && !_loc3_.isClosed;
                if (_loc1_) {
                    break;
                }
                _loc2_++;
            }
        }
        return _loc1_;
    }

    public function set hasRestrictions(param1:Boolean):void {
        this._hasRestrictions = param1;
    }
}
}
