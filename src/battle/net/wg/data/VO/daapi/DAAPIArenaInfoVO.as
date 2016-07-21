package net.wg.data.VO.daapi {
import net.wg.data.daapi.base.DAAPIDataClass;

public class DAAPIArenaInfoVO extends DAAPIDataClass {

    public var mapName:String = "";

    public var allyTeamName:String = "";

    public var enemyTeamName:String = "";

    public var battleTypeFrameLabel:String = "";

    public var mapIcon:String = "";

    public var battleTypeLocaleStr:String = "";

    public var winText:String = "";

    protected var questTipsVO:DAAPIQuestTipsVO = null;

    private const COND_ITEMS_FIELD_NAME:String = "questsTipStr";

    public function DAAPIArenaInfoVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        switch (param1) {
            case this.COND_ITEMS_FIELD_NAME:
                this.questTipsVO = new DAAPIQuestTipsVO(param2);
                return false;
            default:
                return super.onDataWrite(param1, param2);
        }
    }

    override protected function onDispose():void {
        if (this.questTipsVO) {
            this.questTipsVO.dispose();
            this.questTipsVO = null;
        }
        super.onDispose();
    }

    public function getQuestTipsMainCondition():String {
        return !!this.questTipsVO ? this.questTipsVO.mainCondition : null;
    }

    public function getQuestTipsAdditionalCondition():String {
        return !!this.questTipsVO ? this.questTipsVO.additionalCondition : null;
    }

    public function getQuestTipsTitle():String {
        return !!this.questTipsVO ? this.questTipsVO.title : null;
    }
}
}
