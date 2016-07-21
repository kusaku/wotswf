package net.wg.gui.lobby.techtree.data.state {
import net.wg.gui.lobby.techtree.constants.NamedLabels;
import net.wg.gui.lobby.techtree.constants.NodeEntityType;
import net.wg.gui.lobby.techtree.constants.NodeState;

public class NodeStateCollection {

    private static const ntNodePrimaryStateExcludeFlags:Vector.<uint> = new <uint>[NodeState.ENOUGH_XP, NodeState.ENOUGH_MONEY, NodeState.ELITE, NodeState.CAN_SELL, NodeState.SHOP_ACTION, NodeState.VEHICLE_CAN_BE_CHANGED, NodeState.VEHICLE_RENTAL_IS_OVER];

    private static const researchNodePrimaryStateExcludeFlags:Vector.<uint> = new <uint>[NodeState.ENOUGH_XP, NodeState.ENOUGH_MONEY, NodeState.AUTO_UNLOCKED, NodeState.CAN_SELL, NodeState.SHOP_ACTION, NodeState.VEHICLE_CAN_BE_CHANGED, NodeState.VEHICLE_IN_RENT, NodeState.VEHICLE_RENTAL_IS_OVER];

    private static const statePrefixes:Array = ["locked_", "next2unlock_", "next4buy_", "premium_", "inventory_", "inventory_cur_", "inventory_prem_", "inventory_prem_cur_", "auto_unlocked_", "installed_", "installed_plocked_", "was_in_battle_sell_", "inRent_", "inRent_purchaseDisabled_"];

    private static const animation:AnimationProperties = new AnimationProperties(150, {"alpha": 0}, {"alpha": 1});

    private static const nationNodeStates:Vector.<NodeStateItem> = Vector.<NodeStateItem>([new NodeStateItem(NodeState.LOCKED, new StateProperties(1, 0, null, 0, false, null, 0.4)), new NodeStateItem(NodeState.NEXT_2_UNLOCK, new StateProperties(2, 1, NamedLabels.XP_COST, NodeState.ENOUGH_XP, true)), new NodeStateItem(NodeState.UNLOCKED, new StateProperties(3, 2, NamedLabels.CREDITS_PRICE, NodeState.ENOUGH_MONEY, true)), new NodeStateItem(NodeState.UNLOCKED | NodeState.WAS_IN_BATTLE, new StateProperties(4, 11, NamedLabels.CREDITS_PRICE, NodeState.ENOUGH_MONEY, true, animation)), new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM, new StateProperties(5, 3, NamedLabels.GOLD_PRICE, NodeState.ENOUGH_MONEY, true)), new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.WAS_IN_BATTLE, new StateProperties(6, 3, NamedLabels.GOLD_PRICE, NodeState.ENOUGH_MONEY, true)), new NodeStateItem(NodeState.UNLOCKED | NodeState.IN_INVENTORY, new StateProperties(7, 4, NamedLabels.CREDITS_PRICE, NodeState.ENOUGH_MONEY, false)), new NodeStateItem(NodeState.UNLOCKED | NodeState.IN_INVENTORY | NodeState.WAS_IN_BATTLE, new StateProperties(8, 4, NamedLabels.CREDITS_PRICE, NodeState.ENOUGH_MONEY, false)), new NodeStateItem(NodeState.UNLOCKED | NodeState.IN_INVENTORY | NodeState.SELECTED, new StateProperties(9, 5, NamedLabels.CREDITS_PRICE, NodeState.ENOUGH_MONEY, false)), new NodeStateItem(NodeState.UNLOCKED | NodeState.IN_INVENTORY | NodeState.WAS_IN_BATTLE | NodeState.SELECTED, new StateProperties(10, 5, NamedLabels.CREDITS_PRICE, NodeState.ENOUGH_MONEY, false)), new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.IN_INVENTORY, new StateProperties(11, 6, NamedLabels.CREDITS_PRICE, NodeState.ENOUGH_MONEY, false)), new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.IN_INVENTORY | NodeState.WAS_IN_BATTLE, new StateProperties(12, 6, NamedLabels.CREDITS_PRICE, NodeState.ENOUGH_MONEY, false)), new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.IN_INVENTORY | NodeState.SELECTED, new StateProperties(13, 7, NamedLabels.CREDITS_PRICE, NodeState.ENOUGH_MONEY, false)), new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.IN_INVENTORY | NodeState.WAS_IN_BATTLE | NodeState.SELECTED, new StateProperties(14, 7, NamedLabels.CREDITS_PRICE, NodeState.ENOUGH_MONEY, false)), new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.IN_INVENTORY | NodeState.VEHICLE_IN_RENT, new StateProperties(15, 12, NamedLabels.GOLD_PRICE, NodeState.ENOUGH_MONEY, true)), new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.IN_INVENTORY | NodeState.VEHICLE_IN_RENT | NodeState.SELECTED, new StateProperties(16, 12, NamedLabels.GOLD_PRICE, NodeState.ENOUGH_MONEY, true)), new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.IN_INVENTORY | NodeState.VEHICLE_IN_RENT | NodeState.WAS_IN_BATTLE, new StateProperties(17, 12, NamedLabels.GOLD_PRICE, NodeState.ENOUGH_MONEY, true)), new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.IN_INVENTORY | NodeState.VEHICLE_IN_RENT | NodeState.WAS_IN_BATTLE | NodeState.SELECTED, new StateProperties(18, 12, NamedLabels.GOLD_PRICE, NodeState.ENOUGH_MONEY, true)), new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.SELECTED, new StateProperties(19, 3, NamedLabels.GOLD_PRICE, NodeState.ENOUGH_MONEY, true)), new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.WAS_IN_BATTLE | NodeState.SELECTED, new StateProperties(20, 3, NamedLabels.GOLD_PRICE, NodeState.ENOUGH_MONEY, true)), new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.PURCHASE_DISABLED, new StateProperties(21, 13, null, 0, true)), new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.WAS_IN_BATTLE | NodeState.PURCHASE_DISABLED, new StateProperties(22, 13, null, 0, true)), new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.SELECTED | NodeState.PURCHASE_DISABLED, new StateProperties(23, 13, null, 0, true)), new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.WAS_IN_BATTLE | NodeState.SELECTED | NodeState.PURCHASE_DISABLED, new StateProperties(24, 13, null, 0, true))]);

    private static const itemStates:Vector.<ResearchStateItem> = Vector.<ResearchStateItem>([new ResearchStateItem(NodeState.LOCKED, new StateProperties(1, 0, null, 0, true)), new ResearchStateItem(NodeState.NEXT_2_UNLOCK, new StateProperties(2, 1, NamedLabels.XP_COST, NodeState.ENOUGH_XP, true)), new UnlockedStateItem(new StateProperties(3, 2), new StateProperties(4, 8), new StateProperties(5, 2), new StateProperties(6, 2, NamedLabels.CREDITS_PRICE, NodeState.ENOUGH_MONEY, true)), new InventoryStateItem(new StateProperties(7, 2), new StateProperties(8, 8), new StateProperties(9, 4), new StateProperties(10, 4)), new ResearchStateItem(NodeState.UNLOCKED | NodeState.INSTALLED, new StateProperties(11, 9, null, NodeState.ENOUGH_MONEY)), new ResearchStateItem(NodeState.UNLOCKED | NodeState.IN_INVENTORY | NodeState.INSTALLED, new StateProperties(12, 9, null, NodeState.ENOUGH_MONEY)), new ResearchStateItem(NodeState.UNLOCKED | NodeState.VEHICLE_IN_RENT | NodeState.ELITE | NodeState.PREMIUM, new StateProperties(13, 12, null, NodeState.ENOUGH_MONEY))]);

    public function NodeStateCollection() {
        super();
    }

    public static function getStateProps(param1:uint, param2:Number, param3:Object):StateProperties {
        var _loc4_:StateProperties = null;
        switch (param1) {
            case NodeEntityType.NATION_TREE:
            case NodeEntityType.TOP_VEHICLE:
            case NodeEntityType.NEXT_VEHICLE:
            case NodeEntityType.RESEARCH_ROOT:
                _loc4_ = getNTNodeStateProps(param2);
                break;
            case NodeEntityType.RESEARCH_ITEM:
                _loc4_ = getResearchNodeStateProps(param2, param3.rootState, param3.isParentUnlocked);
        }
        if (_loc4_ == null) {
            _loc4_ = new StateProperties(0, 0);
        }
        return _loc4_;
    }

    public static function getStatePrefix(param1:Number):String {
        var _loc2_:String = statePrefixes[param1];
        return _loc2_ != null ? _loc2_ : "locked_";
    }

    public static function isRedrawNTLines(param1:Number):Boolean {
        return (param1 & NodeState.UNLOCKED) > 0 || (param1 & NodeState.NEXT_2_UNLOCK) > 0 || (param1 & NodeState.IN_INVENTORY) > 0;
    }

    public static function isRedrawResearchLines(param1:Number):Boolean {
        return (param1 & NodeState.UNLOCKED) > 0 || (param1 & NodeState.NEXT_2_UNLOCK) > 0;
    }

    private static function getNTNodeStateProps(param1:Number):StateProperties {
        var _loc2_:NodeStateItem = null;
        var _loc3_:Number = getNTNodePrimaryState(param1);
        var _loc4_:Number = nationNodeStates.length;
        var _loc5_:Number = 0;
        while (_loc5_ < _loc4_) {
            _loc2_ = nationNodeStates[_loc5_];
            if (_loc3_ == _loc2_.getState()) {
                return _loc2_.getProps();
            }
            _loc5_++;
        }
        return nationNodeStates[0].getProps();
    }

    private static function getResearchNodeStateProps(param1:Number, param2:Number, param3:Boolean):StateProperties {
        var _loc4_:ResearchStateItem = null;
        var _loc5_:Number = getResearchNodePrimaryState(param1);
        var _loc6_:Number = itemStates.length;
        var _loc7_:Number = 0;
        while (_loc7_ < _loc6_) {
            _loc4_ = itemStates[_loc7_];
            if (_loc5_ == _loc4_.getState()) {
                return _loc4_.resolveProps(param1, param2, param3);
            }
            _loc7_++;
        }
        return itemStates[0].getProps();
    }

    private static function excludeFlags(param1:Number, param2:Vector.<uint>):Number {
        var _loc4_:uint = 0;
        var _loc3_:Number = param1;
        for each(_loc4_ in param2) {
            if ((param1 & _loc4_) > 0) {
                _loc3_ = _loc3_ ^ _loc4_;
            }
        }
        return _loc3_;
    }

    private static function getNTNodePrimaryState(param1:Number):Number {
        return excludeFlags(param1, ntNodePrimaryStateExcludeFlags);
    }

    private static function getResearchNodePrimaryState(param1:Number):Number {
        return excludeFlags(param1, researchNodePrimaryStateExcludeFlags);
    }
}
}
