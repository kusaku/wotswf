package net.wg.gui.data {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.lobby.quests.data.AwardCarouselItemRendererVO;

import scaleform.clik.data.DataProvider;

public class MissionAwardWindowVO extends DAAPIDataClass {

    private static const AWARDS_FIELD:String = "awards";

    public var windowTitle:String = "";

    public var backImage:String = "";

    public var ribbonImage:String = "";

    public var header:String = "";

    public var description:String = "";

    public var currentQuestHeader:String = "";

    public var currentQuestConditions:String = "";

    public var nextQuestHeader:String = "";

    public var nextQuestConditions:String = "";

    public var additionalStatusText:String = "";

    public var additionalStatusIcon:String = "";

    public var mainStatusText:String = "";

    public var mainStatusIcon:String = "";

    public var availableText:String = "";

    public var nextButtonText:String = "";

    public var nextButtonTooltip:String = "";

    public var isPersonalQuest:Boolean = false;

    public var availableNextQuest:Boolean = false;

    public var isLastQuest:Boolean = false;

    public var awards:DataProvider;

    public var conditions:Object = null;

    public function MissionAwardWindowVO(param1:Object) {
        this.awards = new DataProvider();
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        if (param1 == AWARDS_FIELD) {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, Errors.CANT_NULL);
            for each(_loc4_ in _loc3_) {
                this.awards.push(new AwardCarouselItemRendererVO(_loc4_));
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        this.awards.splice(0, this.awards.length);
        this.awards = null;
        App.utils.data.cleanupDynamicObject(this.conditions);
        this.conditions = null;
        super.onDispose();
    }
}
}
