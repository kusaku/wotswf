package net.wg.gui.lobby.techtree.data.vo {
import net.wg.gui.lobby.techtree.interfaces.IValueObject;
import net.wg.utils.ILocale;

public class VehGlobalStats implements IValueObject {

    private static const MIN_SOURCE_ARRAY_LEN:uint = 6;

    private static const SOURCE_ARRAY_ENABLE_INSTALL_ITEMS_INDEX:uint = 0;

    private static const SOURCE_ARRAY_STATUS_INDEX:uint = 1;

    private static const SOURCE_ARRAY_EXTRA_INFO_INDEX:uint = 2;

    private static const SOURCE_ARRAY_FREE_XP_INDEX:uint = 3;

    private static const SOURCE_ARRAY_HAS_NATION_TREE_INDEX:uint = 4;

    private static const SOURCE_ARRAY_WARNING_INDEX:uint = 5;

    public var enableInstallItems:Boolean;

    public var statusString:String;

    public var extraInfo:ExtraInformation;

    public var freeXP:Number;

    public var hasNationTree:Boolean;

    public var warningMessage:String;

    public function VehGlobalStats(param1:Boolean = false, param2:String = null, param3:ExtraInformation = null, param4:Number = 0, param5:Boolean = false) {
        super();
        this.enableInstallItems = param1;
        this.statusString = param2;
        this.extraInfo = param3;
        this.freeXP = param4;
        this.hasNationTree = param5;
    }

    public function dispose():void {
        this.extraInfo = null;
    }

    public function fromArray(param1:Array, param2:ILocale):void {
        if (param1.length >= MIN_SOURCE_ARRAY_LEN) {
            this.enableInstallItems = param1[SOURCE_ARRAY_ENABLE_INSTALL_ITEMS_INDEX];
            this.statusString = param1[SOURCE_ARRAY_STATUS_INDEX];
            this.extraInfo = new ExtraInformation();
            this.extraInfo.fromArray(param1[SOURCE_ARRAY_EXTRA_INFO_INDEX], param2);
            this.freeXP = !isNaN(param1[SOURCE_ARRAY_FREE_XP_INDEX]) ? Number(param1[SOURCE_ARRAY_FREE_XP_INDEX]) : Number(0);
            this.hasNationTree = param1[SOURCE_ARRAY_HAS_NATION_TREE_INDEX];
            this.warningMessage = param1[SOURCE_ARRAY_WARNING_INDEX];
        }
    }

    public function fromObject(param1:Object, param2:ILocale):void {
        if (param1 == null) {
            return;
        }
        if (param1.enableInstallItems != null) {
            this.enableInstallItems = param1.enableInstallItems;
        }
        this.statusString = param1.statusString;
        this.extraInfo = new ExtraInformation();
        if (param1.extraInfo != null) {
            this.extraInfo.fromObject(param1.extraInfo, param2);
        }
        this.freeXP = !isNaN(param1.freeXP) ? Number(param1.freeXP) : Number(0);
        if (param1.hasNationTree != null) {
            this.hasNationTree = param1.hasNationTree;
        }
        if (param1.warningMessage != null) {
            this.warningMessage = param1.warningMessage;
        }
    }

    public function toString():String {
        return "[VehGlobalStats: enableInstallItems = " + this.enableInstallItems + ", statusString = " + this.statusString + ", extraInfo = " + this.extraInfo + ", freeXP = " + this.freeXP + ", hasNationTree = " + this.hasNationTree + ", warningMessage = " + this.warningMessage + "]";
    }
}
}
