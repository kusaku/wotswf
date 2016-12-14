package net.wg.gui.lobby.questsWindow.data {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.lobby.quests.data.AwardCarouselItemRendererVO;

import scaleform.clik.data.DataProvider;

public class QuestDataVO extends DAAPIDataClass {

    private static const AWARDS_DATA_PROVIDER_FIELD:String = "awardsDataProvider";

    private static const HEADER_FIELD:String = "header";

    private static const TASK_TO_UNLOCK:String = "taskToUnlock";

    public var awardsDataProvider:DataProvider;

    public var header:HeaderDataVO = null;

    public var award:Array;

    public var requirements:Object = null;

    public var conditions:Object = null;

    public var taskToUnlock:QuestDashlineItemVO = null;

    public function QuestDataVO(param1:Object) {
        this.award = [];
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        switch (param1) {
            case HEADER_FIELD:
                this.header = !!param2 ? new HeaderDataVO(param2) : null;
                return false;
            case TASK_TO_UNLOCK:
                this.taskToUnlock = new QuestDashlineItemVO(param2);
                return false;
            case AWARDS_DATA_PROVIDER_FIELD:
                _loc3_ = param2 as Array;
                App.utils.asserter.assertNotNull(_loc3_, Errors.CANT_NULL);
                this.awardsDataProvider = new DataProvider();
                for each(_loc4_ in _loc3_) {
                    this.awardsDataProvider.push(new AwardCarouselItemRendererVO(_loc4_));
                }
                return false;
            default:
                return true;
        }
    }

    override protected function onDispose():void {
        var _loc1_:AwardCarouselItemRendererVO = null;
        if (this.header != null) {
            this.header.dispose();
            this.header = null;
        }
        if (this.award != null) {
            this.award.splice(0, this.award.length);
            this.award = null;
        }
        if (this.awardsDataProvider) {
            for each(_loc1_ in this.awardsDataProvider) {
                _loc1_.dispose();
            }
            this.awardsDataProvider.cleanUp();
            this.awardsDataProvider = null;
        }
        App.utils.data.cleanupDynamicObject(this.requirements);
        this.requirements = null;
        App.utils.data.cleanupDynamicObject(this.conditions);
        this.conditions = null;
        this.taskToUnlock.dispose();
        this.taskToUnlock = null;
        super.onDispose();
    }
}
}
