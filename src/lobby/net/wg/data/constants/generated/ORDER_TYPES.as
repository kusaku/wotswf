package net.wg.data.constants.generated {
public class ORDER_TYPES {

    public static const REQUISITION:String = "requisition";

    public static const EVACUATION:String = "evacuation";

    public static const HEAVY_TRUCKS:String = "heavyTrucks";

    public static const MILITARY_MANEUVERS:String = "militaryManeuvers";

    public static const ADDITIONAL_BRIEFING:String = "additionalBriefing";

    public static const TACTICAL_TRAINING:String = "tacticalTraining";

    public static const BATTLE_PAYMENTS:String = "battlePayments";

    public static const SPECIAL_MISSION:String = "specialMission";

    public static const ARTILLERY:String = "artillery";

    public static const BOMBER:String = "bomber";

    public static const EMPTY_ORDER:String = "emptyOrder";

    public static const FORT_CONSUMABLES_ACTIVE_TYPE:Array = [ARTILLERY, BOMBER];

    public static const FORT_CONSUMABLES_ORDER_GROUP:Array = [FORT_CONSUMABLES_ACTIVE_TYPE];

    public static const FORT_GENERAL_ACTIVE_TYPE:Array = [HEAVY_TRUCKS, MILITARY_MANEUVERS, ADDITIONAL_BRIEFING, TACTICAL_TRAINING, BATTLE_PAYMENTS, SPECIAL_MISSION];

    public static const FORT_GENERAL_PASSIVE_TYPE:Array = [REQUISITION, EVACUATION];

    public static const FORT_GENERAL_ORDER_GROUP:Array = [FORT_GENERAL_PASSIVE_TYPE, FORT_GENERAL_ACTIVE_TYPE];

    public static const FORT_ORDER_ALL_GROUP:Number = 0;

    public static const FORT_ORDER_GENERAL_GROUP:Number = 1;

    public static const FORT_ORDER_CONSUMABLES_GROUP:Number = 2;

    public static const FORT_ORDER_GENERAL_ACTIVE_TYPE:Number = 1;

    public static const FORT_ORDER_GENERAL_PASSIVE_TYPE:Number = 2;

    public static const FORT_ORDER_CONSUMABLES_ACTIVE_TYPE:Number = 3;

    public static const FORT_ORDER_CONSUMABLES_PASSIVE_TYPE:Number = 4;

    public function ORDER_TYPES() {
        super();
    }
}
}
