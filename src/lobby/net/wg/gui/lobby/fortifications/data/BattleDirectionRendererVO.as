package net.wg.gui.lobby.fortifications.data {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.lobby.fortifications.data.tankIcon.FortTankIconVO;

public class BattleDirectionRendererVO extends DAAPIDataClass {

    private static const TIMER:String = "timer";

    private static const DIVISION_ICON:String = "divisionIcon";

    private var _description:String = "";

    private var _canJoin:Boolean = false;

    private var _battleInfo:String = "";

    private var _battleHour:String = "";

    private var _battleTypeIcon:String = "";

    private var _fortBattleID:int = -1;

    private var _battleTypeTooltip:String = "";

    private var _battleInfoTooltip:String = "";

    private var _divisionIcon:FortTankIconVO = null;

    private var _timer:FortBattleTimerVO = null;

    public function BattleDirectionRendererVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        switch (param1) {
            case TIMER:
                this._timer = !!param2 ? new FortBattleTimerVO(param2) : null;
                return false;
            case DIVISION_ICON:
                this._divisionIcon = new FortTankIconVO(param2);
                return false;
            default:
                return super.onDataWrite(param1, param2);
        }
    }

    override protected function onDispose():void {
        this._divisionIcon.dispose();
        this._divisionIcon = null;
        super.onDispose();
    }

    public function get description():String {
        return this._description;
    }

    public function set description(param1:String):void {
        this._description = param1;
    }

    public function get canJoin():Boolean {
        return this._canJoin;
    }

    public function set canJoin(param1:Boolean):void {
        this._canJoin = param1;
    }

    public function get battleInfo():String {
        return this._battleInfo;
    }

    public function set battleInfo(param1:String):void {
        this._battleInfo = param1;
    }

    public function get battleHour():String {
        return this._battleHour;
    }

    public function set battleHour(param1:String):void {
        this._battleHour = param1;
    }

    public function get battleTypeIcon():String {
        return this._battleTypeIcon;
    }

    public function set battleTypeIcon(param1:String):void {
        this._battleTypeIcon = param1;
    }

    public function get fortBattleID():int {
        return this._fortBattleID;
    }

    public function set fortBattleID(param1:int):void {
        this._fortBattleID = param1;
    }

    public function get battleTypeTooltip():String {
        return this._battleTypeTooltip;
    }

    public function set battleTypeTooltip(param1:String):void {
        this._battleTypeTooltip = param1;
    }

    public function get battleInfoTooltip():String {
        return this._battleInfoTooltip;
    }

    public function set battleInfoTooltip(param1:String):void {
        this._battleInfoTooltip = param1;
    }

    public function get timer():FortBattleTimerVO {
        return this._timer;
    }

    public function set timer(param1:FortBattleTimerVO):void {
        this._timer = param1;
    }

    public function get divisionIcon():FortTankIconVO {
        return this._divisionIcon;
    }
}
}
