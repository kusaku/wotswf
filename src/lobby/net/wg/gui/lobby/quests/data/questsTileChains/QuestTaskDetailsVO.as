package net.wg.gui.lobby.quests.data.questsTileChains {
import net.wg.data.daapi.base.DAAPIDataClass;

public class QuestTaskDetailsVO extends DAAPIDataClass {

    public var taskID:Number = -1;

    public var headerText:String = "";

    public var conditionsText:String = "";

    public var isApplyBtnVisible:Boolean = false;

    public var isApplyBtnEnabled:Boolean = false;

    public var isCancelBtnVisible:Boolean = false;

    public var btnLabel:String = "";

    public var btnToolTip:String = "";

    public var taskDescriptionText:String = "";

    public var mainAwards:Array;

    public var addAwards:Array;

    public function QuestTaskDetailsVO(param1:Object) {
        this.mainAwards = [];
        this.addAwards = [];
        super(param1);
    }

    override protected function onDispose():void {
        if (this.mainAwards) {
            this.mainAwards.splice(0, this.mainAwards.length);
            this.mainAwards = null;
        }
        if (this.addAwards) {
            this.addAwards.splice(0, this.addAwards.length);
            this.addAwards = null;
        }
        super.onDispose();
    }
}
}
