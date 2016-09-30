package net.wg.gui.lobby.questsWindow.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class QuestsDataVO extends DAAPIDataClass {

    private static const QUESTS_FIELD_NAME:String = "quests";

    public var quests:Vector.<QuestRendererVO>;

    public var totalTasks:int = -1;

    public var isSortable:Boolean = false;

    public var rendererType:String = "QuestRenderer_UI";

    public function QuestsDataVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        switch (param1) {
            case QUESTS_FIELD_NAME:
                this.quests = Vector.<QuestRendererVO>(App.utils.data.convertVOArrayToVector(param1, param2, QuestRendererVO));
                return false;
            default:
                return super.onDataWrite(param1, param2);
        }
    }

    override protected function onDispose():void {
        var _loc1_:QuestRendererVO = null;
        if (this.quests != null) {
            for each(_loc1_ in this.quests) {
                _loc1_.dispose();
            }
            this.quests.fixed = false;
            this.quests.splice(0, this.quests.length);
            this.quests = null;
        }
        super.onDispose();
    }

    public function getQuestsLength():uint {
        return this.quests != null ? uint(this.quests.length) : uint(0);
    }

    public function hasQuests():Boolean {
        return this.getQuestsLength() > 0;
    }

    override public function isEquals(param1:DAAPIDataClass):Boolean {
        var _loc2_:QuestsDataVO = param1 as QuestsDataVO;
        if (!_loc2_) {
            return false;
        }
        return this.totalTasks == _loc2_.totalTasks && this.isSortable == _loc2_.isSortable && this.isQuestsEquals(_loc2_.quests);
    }

    private function isQuestsEquals(param1:Vector.<QuestRendererVO>):Boolean {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        if (!this.quests && !param1) {
            return true;
        }
        if (this.quests && !param1 || !this.quests && param1) {
            return false;
        }
        if (param1 && this.quests.length == param1.length) {
            _loc2_ = this.quests.length;
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                if (!this.quests[_loc3_].isEquals(param1[_loc3_])) {
                    return false;
                }
                _loc3_++;
            }
            return true;
        }
        return false;
    }
}
}
