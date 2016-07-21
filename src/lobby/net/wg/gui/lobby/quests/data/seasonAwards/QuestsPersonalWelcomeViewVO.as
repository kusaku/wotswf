package net.wg.gui.lobby.quests.data.seasonAwards {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class QuestsPersonalWelcomeViewVO extends DAAPIDataClass {

    private static const BLOCK_DATA:String = "blockData";

    public var buttonLbl:String = "";

    public var titleText:String = "";

    public var blockData:Vector.<TextBlockWelcomeViewVO> = null;

    public var announcementIcon:String = "";

    public var announcementText:String = "";

    public var showAnnouncement:Boolean = false;

    public var background:String = "";

    public function QuestsPersonalWelcomeViewVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        if (param1 == BLOCK_DATA && param2 != null) {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, BLOCK_DATA + Errors.CANT_NULL);
            this.blockData = new Vector.<TextBlockWelcomeViewVO>(0);
            for each(_loc4_ in _loc3_) {
                this.blockData.push(new TextBlockWelcomeViewVO(_loc4_));
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        this.buttonLbl = null;
        this.titleText = null;
        for each(_loc1_ in this.blockData) {
            _loc1_.dispose();
        }
        this.blockData.splice(0, this.blockData.length);
        this.blockData = null;
        super.onDispose();
    }
}
}
