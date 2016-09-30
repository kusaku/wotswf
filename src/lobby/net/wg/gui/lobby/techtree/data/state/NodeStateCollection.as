package net.wg.gui.lobby.techtree.data.state {
import net.wg.data.constants.generated.NODE_STATE_FLAGS;
import net.wg.gui.lobby.techtree.constants.NamedLabels;
import net.wg.gui.lobby.techtree.constants.NodeEntityType;
import net.wg.gui.lobby.techtree.constants.NodeRendererState;

public class NodeStateCollection {

    private static const ntNodePrimaryStateExcludeFlags:Vector.<uint> = new <uint>[NODE_STATE_FLAGS.ENOUGH_XP, NODE_STATE_FLAGS.ENOUGH_MONEY, NODE_STATE_FLAGS.ELITE, NODE_STATE_FLAGS.CAN_SELL, NODE_STATE_FLAGS.SHOP_ACTION, NODE_STATE_FLAGS.VEHICLE_CAN_BE_CHANGED, NODE_STATE_FLAGS.VEHICLE_RENTAL_IS_OVER];

    private static const researchNodePrimaryStateExcludeFlags:Vector.<uint> = new <uint>[NODE_STATE_FLAGS.ENOUGH_XP, NODE_STATE_FLAGS.ENOUGH_MONEY, NODE_STATE_FLAGS.AUTO_UNLOCKED, NODE_STATE_FLAGS.CAN_SELL, NODE_STATE_FLAGS.SHOP_ACTION, NODE_STATE_FLAGS.VEHICLE_CAN_BE_CHANGED, NODE_STATE_FLAGS.VEHICLE_IN_RENT, NODE_STATE_FLAGS.VEHICLE_RENTAL_IS_OVER];

    private static const restorePrimaryStateExcludeFlags:Vector.<uint> = new <uint>[NODE_STATE_FLAGS.ENOUGH_XP, NODE_STATE_FLAGS.AUTO_UNLOCKED, NODE_STATE_FLAGS.CAN_SELL, NODE_STATE_FLAGS.ELITE, NODE_STATE_FLAGS.SHOP_ACTION, NODE_STATE_FLAGS.VEHICLE_CAN_BE_CHANGED, NODE_STATE_FLAGS.SELECTED, NODE_STATE_FLAGS.VEHICLE_RENTAL_IS_OVER, NODE_STATE_FLAGS.WAS_IN_BATTLE];

    private static const statePrefixes:Array = ["locked_", "next2unlock_", "next4buy_", "premium_", "inventory_", "inventory_cur_", "inventory_prem_", "inventory_prem_cur_", "auto_unlocked_", "installed_", "installed_plocked_", "was_in_battle_sell_", "inRent_", "inRent_purchaseDisabled_", "restore_", "restore_rentAvailable_"];

    private static const animation:AnimationProperties = new AnimationProperties(150, {"alpha": 0}, {"alpha": 1});

    private static const nationNodeStates:Vector.<NodeStateItem> = Vector.<NodeStateItem>([new NodeStateItem(NODE_STATE_FLAGS.LOCKED, new StateProperties(1, NodeRendererState.LOCKED, null, 0, false, null, 0.4)), new NodeStateItem(NODE_STATE_FLAGS.NEXT_2_UNLOCK, new StateProperties(2, NodeRendererState.NEXT2UNLOCK, NamedLabels.XP_COST, NODE_STATE_FLAGS.ENOUGH_XP, true)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED, new StateProperties(3, NodeRendererState.NEXT4BUY, NamedLabels.CREDITS_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, true)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.WAS_IN_BATTLE, new StateProperties(4, NodeRendererState.WAS_IN_BATTLE_SELL, NamedLabels.CREDITS_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, true, animation)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM, new StateProperties(5, NodeRendererState.PREMIUM, NamedLabels.GOLD_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, true)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.WAS_IN_BATTLE, new StateProperties(6, NodeRendererState.PREMIUM, NamedLabels.GOLD_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, true)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.IN_INVENTORY, new StateProperties(7, NodeRendererState.INVENTORY, NamedLabels.CREDITS_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, false)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.WAS_IN_BATTLE, new StateProperties(8, NodeRendererState.INVENTORY, NamedLabels.CREDITS_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, false)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.SELECTED, new StateProperties(9, NodeRendererState.INVENTORY_CUR, NamedLabels.CREDITS_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, false)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.WAS_IN_BATTLE | NODE_STATE_FLAGS.SELECTED, new StateProperties(10, NodeRendererState.INVENTORY_CUR, NamedLabels.CREDITS_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, false)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY, new StateProperties(11, NodeRendererState.INVENTORY_PREM, NamedLabels.CREDITS_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, false)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.WAS_IN_BATTLE, new StateProperties(12, NodeRendererState.INVENTORY_PREM, NamedLabels.CREDITS_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, false)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.SELECTED, new StateProperties(13, NodeRendererState.INVENTORY_PREM_CUR, NamedLabels.CREDITS_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, false)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.WAS_IN_BATTLE | NODE_STATE_FLAGS.SELECTED, new StateProperties(14, NodeRendererState.INVENTORY_PREM_CUR, NamedLabels.CREDITS_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, false)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.VEHICLE_IN_RENT, new StateProperties(15, NodeRendererState.IN_RENT, NamedLabels.GOLD_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, true)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.VEHICLE_IN_RENT | NODE_STATE_FLAGS.PURCHASE_DISABLED, new StateProperties(16, NodeRendererState.IN_RENT, NamedLabels.GOLD_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, true)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.VEHICLE_IN_RENT | NODE_STATE_FLAGS.SELECTED, new StateProperties(17, NodeRendererState.IN_RENT, NamedLabels.GOLD_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, true)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.VEHICLE_IN_RENT | NODE_STATE_FLAGS.SELECTED | NODE_STATE_FLAGS.PURCHASE_DISABLED, new StateProperties(18, NodeRendererState.IN_RENT, NamedLabels.GOLD_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, true)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.VEHICLE_IN_RENT | NODE_STATE_FLAGS.WAS_IN_BATTLE, new StateProperties(19, NodeRendererState.IN_RENT, NamedLabels.GOLD_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, true)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.VEHICLE_IN_RENT | NODE_STATE_FLAGS.WAS_IN_BATTLE | NODE_STATE_FLAGS.PURCHASE_DISABLED, new StateProperties(20, NodeRendererState.IN_RENT, NamedLabels.GOLD_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, true)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.VEHICLE_IN_RENT | NODE_STATE_FLAGS.WAS_IN_BATTLE | NODE_STATE_FLAGS.SELECTED, new StateProperties(21, NodeRendererState.IN_RENT, NamedLabels.GOLD_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, true)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.VEHICLE_IN_RENT | NODE_STATE_FLAGS.WAS_IN_BATTLE | NODE_STATE_FLAGS.SELECTED | NODE_STATE_FLAGS.PURCHASE_DISABLED, new StateProperties(22, NodeRendererState.IN_RENT, NamedLabels.GOLD_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, true)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.SELECTED, new StateProperties(23, NodeRendererState.PREMIUM, NamedLabels.GOLD_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, true)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.WAS_IN_BATTLE | NODE_STATE_FLAGS.SELECTED, new StateProperties(24, NodeRendererState.PREMIUM, NamedLabels.GOLD_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, true)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.PURCHASE_DISABLED, new StateProperties(25, NodeRendererState.IN_RENT_PURCHASE_DISABLED, null, 0, true)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.WAS_IN_BATTLE | NODE_STATE_FLAGS.PURCHASE_DISABLED, new StateProperties(26, NodeRendererState.IN_RENT_PURCHASE_DISABLED, null, 0, true)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.SELECTED | NODE_STATE_FLAGS.PURCHASE_DISABLED, new StateProperties(27, NodeRendererState.IN_RENT_PURCHASE_DISABLED, null, 0, true)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.WAS_IN_BATTLE | NODE_STATE_FLAGS.SELECTED | NODE_STATE_FLAGS.PURCHASE_DISABLED, new StateProperties(28, NodeRendererState.IN_RENT_PURCHASE_DISABLED, null, 0, true)), new NodeStateItem(NODE_STATE_FLAGS.RENT_AVAILABLE | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM, new StateProperties(29, NodeRendererState.RENT_AVAILABLE, NamedLabels.GOLD_PRICE, 0, true)), new NodeStateItem(NODE_STATE_FLAGS.RENT_AVAILABLE | NODE_STATE_FLAGS.ENOUGH_MONEY | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM, new StateProperties(30, NodeRendererState.RENT_AVAILABLE, NamedLabels.GOLD_PRICE, 0, true)), new NodeStateItem(NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM, new StateProperties(31, NodeRendererState.RESTORE, NamedLabels.RESTORE, 0, true)), new NodeStateItem(NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.ENOUGH_MONEY | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM, new StateProperties(32, NodeRendererState.RESTORE, NamedLabels.RESTORE, 0, true)), new NodeStateItem(NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.RENT_AVAILABLE | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM, new StateProperties(33, NodeRendererState.RENT_AVAILABLE, NamedLabels.RESTORE, 0, true)), new NodeStateItem(NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.RENT_AVAILABLE | NODE_STATE_FLAGS.ENOUGH_MONEY | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM, new StateProperties(34, NodeRendererState.RENT_AVAILABLE, NamedLabels.RESTORE, NODE_STATE_FLAGS.ENOUGH_MONEY, true)), new NodeStateItem(NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.VEHICLE_IN_RENT | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM, new StateProperties(35, NodeRendererState.RENT_AVAILABLE, NamedLabels.RESTORE, NODE_STATE_FLAGS.ENOUGH_MONEY, true)), new NodeStateItem(NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.VEHICLE_IN_RENT | NODE_STATE_FLAGS.ENOUGH_MONEY | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM, new StateProperties(36, NodeRendererState.RENT_AVAILABLE, NamedLabels.RESTORE, NODE_STATE_FLAGS.ENOUGH_MONEY, true)), new NodeStateItem(NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.VEHICLE_IN_RENT | NODE_STATE_FLAGS.ENOUGH_MONEY | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY, new StateProperties(37, NodeRendererState.RENT_AVAILABLE, NamedLabels.RESTORE, NODE_STATE_FLAGS.ENOUGH_MONEY, true)), new NodeStateItem(NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.VEHICLE_IN_RENT | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY, new StateProperties(38, NodeRendererState.RENT_AVAILABLE, NamedLabels.RESTORE, 0, true)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.PURCHASE_DISABLED, new StateProperties(39, NodeRendererState.INVENTORY_PREM, null, 0, false)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.WAS_IN_BATTLE | NODE_STATE_FLAGS.PURCHASE_DISABLED, new StateProperties(40, NodeRendererState.INVENTORY_PREM, null, 0, false)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.SELECTED | NODE_STATE_FLAGS.PURCHASE_DISABLED, new StateProperties(41, NodeRendererState.INVENTORY_PREM_CUR, null, 0, false)), new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.WAS_IN_BATTLE | NODE_STATE_FLAGS.SELECTED | NODE_STATE_FLAGS.PURCHASE_DISABLED, new StateProperties(42, NodeRendererState.INVENTORY_PREM_CUR, null, 0, false))]);

    private static const itemStates:Vector.<ResearchStateItem> = Vector.<ResearchStateItem>([new ResearchStateItem(NODE_STATE_FLAGS.LOCKED, new StateProperties(1, NodeRendererState.LOCKED, null, 0, true)), new ResearchStateItem(NODE_STATE_FLAGS.NEXT_2_UNLOCK, new StateProperties(2, NodeRendererState.NEXT2UNLOCK, NamedLabels.XP_COST, NODE_STATE_FLAGS.ENOUGH_XP, true)), new UnlockedStateItem(new StateProperties(3, NodeRendererState.NEXT4BUY), new StateProperties(4, NodeRendererState.AUTO_UNLOCKED), new StateProperties(5, NodeRendererState.NEXT4BUY), new StateProperties(6, NodeRendererState.NEXT4BUY, NamedLabels.CREDITS_PRICE, NODE_STATE_FLAGS.ENOUGH_MONEY, true)), new InventoryStateItem(new StateProperties(7, NodeRendererState.NEXT4BUY), new StateProperties(8, NodeRendererState.AUTO_UNLOCKED), new StateProperties(9, NodeRendererState.INVENTORY), new StateProperties(10, NodeRendererState.INVENTORY)), new ResearchStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.INSTALLED, new StateProperties(11, NodeRendererState.INSTALLED, null, NODE_STATE_FLAGS.ENOUGH_MONEY)), new ResearchStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.INSTALLED, new StateProperties(12, NodeRendererState.INSTALLED, null, NODE_STATE_FLAGS.ENOUGH_MONEY)), new ResearchStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.VEHICLE_IN_RENT | NODE_STATE_FLAGS.ELITE | NODE_STATE_FLAGS.PREMIUM, new StateProperties(13, NodeRendererState.IN_RENT, null, NODE_STATE_FLAGS.ENOUGH_MONEY)), new ResearchStateItem(NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM, new StateProperties(14, NodeRendererState.RESTORE, null)), new ResearchStateItem(NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.ENOUGH_MONEY | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM, new StateProperties(15, NodeRendererState.RESTORE, null, NODE_STATE_FLAGS.ENOUGH_MONEY)), new ResearchStateItem(NODE_STATE_FLAGS.RENT_AVAILABLE | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM, new StateProperties(16, NodeRendererState.RENT_AVAILABLE, null)), new ResearchStateItem(NODE_STATE_FLAGS.RENT_AVAILABLE | NODE_STATE_FLAGS.ENOUGH_MONEY | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM, new StateProperties(17, NodeRendererState.RENT_AVAILABLE, null, NODE_STATE_FLAGS.ENOUGH_MONEY)), new ResearchStateItem(NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.RENT_AVAILABLE | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM, new StateProperties(18, NodeRendererState.RENT_AVAILABLE, null)), new ResearchStateItem(NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.RENT_AVAILABLE | NODE_STATE_FLAGS.ENOUGH_MONEY | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM, new StateProperties(19, NodeRendererState.RENT_AVAILABLE, null, NODE_STATE_FLAGS.ENOUGH_MONEY)), new ResearchStateItem(NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.VEHICLE_IN_RENT | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM, new StateProperties(20, NodeRendererState.RENT_AVAILABLE, null, NODE_STATE_FLAGS.ENOUGH_MONEY)), new ResearchStateItem(NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.VEHICLE_IN_RENT | NODE_STATE_FLAGS.ENOUGH_MONEY | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM, new StateProperties(21, NodeRendererState.RENT_AVAILABLE, null, NODE_STATE_FLAGS.ENOUGH_MONEY))]);

    private static const STATE_PREFIX_LOCKED:String = "locked_";

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
                if ((param2 & NODE_STATE_FLAGS.RESTORE_AVAILABLE) > 0 || (param2 & NODE_STATE_FLAGS.RENT_AVAILABLE) > 0) {
                    _loc4_ = getNTNodeStateProps(param2, restorePrimaryStateExcludeFlags);
                }
                else {
                    _loc4_ = getNTNodeStateProps(param2, ntNodePrimaryStateExcludeFlags);
                }
                break;
            case NodeEntityType.RESEARCH_ITEM:
                _loc4_ = getResearchNodeStateProps(param2, param3.rootState, param3.isParentUnlocked);
        }
        if (_loc4_ == null) {
            _loc4_ = new StateProperties(0, NodeRendererState.LOCKED);
        }
        return _loc4_;
    }

    public static function getStatePrefix(param1:Number):String {
        var _loc2_:String = statePrefixes[param1];
        return _loc2_ != null ? _loc2_ : STATE_PREFIX_LOCKED;
    }

    public static function isRedrawNTLines(param1:Number):Boolean {
        return (param1 & NODE_STATE_FLAGS.UNLOCKED) > 0 || (param1 & NODE_STATE_FLAGS.NEXT_2_UNLOCK) > 0 || (param1 & NODE_STATE_FLAGS.IN_INVENTORY) > 0;
    }

    public static function isRedrawResearchLines(param1:Number):Boolean {
        return (param1 & NODE_STATE_FLAGS.UNLOCKED) > 0 || (param1 & NODE_STATE_FLAGS.NEXT_2_UNLOCK) > 0;
    }

    private static function getNTNodeStateProps(param1:Number, param2:Vector.<uint>):StateProperties {
        var _loc3_:NodeStateItem = null;
        var _loc4_:Number = excludeFlags(param1, param2);
        var _loc5_:Number = nationNodeStates.length;
        var _loc6_:Number = 0;
        while (_loc6_ < _loc5_) {
            _loc3_ = nationNodeStates[_loc6_];
            if (_loc4_ == _loc3_.getState()) {
                return _loc3_.getProps();
            }
            _loc6_++;
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

    private static function getResearchNodePrimaryState(param1:Number):Number {
        return excludeFlags(param1, researchNodePrimaryStateExcludeFlags);
    }
}
}
