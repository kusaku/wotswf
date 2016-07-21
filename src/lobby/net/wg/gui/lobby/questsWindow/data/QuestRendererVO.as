package net.wg.gui.lobby.questsWindow.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class QuestRendererVO extends DAAPIDataClass {

    public var rendererType:int = -1;

    public var isSelectable:Boolean = true;

    public var bckgrImage:String = "";

    public var showBckgrImage:Boolean = false;

    public var tooltip:String = "";

    public var detailsLinkage:String = "";

    public var detailsPyAlias:String = "";

    private var _isNew:Boolean = false;

    private var _status:String = "";

    private var _IGR:Boolean = false;

    private var _taskType:String = "";

    private var _description:String = "";

    private var _timerDescr:String = "";

    private var _tasksCount:int = 0;

    private var _progrBarType:String = "";

    private var _maxProgrVal:Number = 0;

    private var _currentProgrVal:Number = 0;

    private var _isLock:Boolean = false;

    private var _isLocked:Boolean = false;

    private var _questID:String = "";

    private var _progrTooltip:Object = null;

    private var _eventType:int = 0;

    public function QuestRendererVO(param1:Object) {
        super(param1);
    }

    override protected function onDispose():void {
        this._progrTooltip = null;
        super.onDispose();
    }

    public function get isNew():Boolean {
        return this._isNew;
    }

    public function set isNew(param1:Boolean):void {
        this._isNew = param1;
    }

    public function get IGR():Boolean {
        return this._IGR;
    }

    public function set IGR(param1:Boolean):void {
        this._IGR = param1;
    }

    public function get taskType():String {
        return this._taskType;
    }

    public function set taskType(param1:String):void {
        this._taskType = param1;
    }

    public function get description():String {
        return this._description;
    }

    public function set description(param1:String):void {
        this._description = param1;
    }

    public function get timerDescr():String {
        return this._timerDescr;
    }

    public function set timerDescr(param1:String):void {
        this._timerDescr = param1;
    }

    public function get tasksCount():int {
        return this._tasksCount;
    }

    public function set tasksCount(param1:int):void {
        this._tasksCount = param1;
    }

    public function get maxProgrVal():Number {
        return this._maxProgrVal;
    }

    public function set maxProgrVal(param1:Number):void {
        this._maxProgrVal = param1;
    }

    public function get currentProgrVal():Number {
        return this._currentProgrVal;
    }

    public function set currentProgrVal(param1:Number):void {
        this._currentProgrVal = param1;
    }

    public function get progrBarType():String {
        return this._progrBarType;
    }

    public function set progrBarType(param1:String):void {
        this._progrBarType = param1;
    }

    public function get status():String {
        return this._status;
    }

    public function set status(param1:String):void {
        this._status = param1;
    }

    public function get isLock():Boolean {
        return this._isLock;
    }

    public function set isLock(param1:Boolean):void {
        this._isLock = param1;
    }

    public function get isLocked():Boolean {
        return this._isLocked;
    }

    public function set isLocked(param1:Boolean):void {
        this._isLocked = param1;
    }

    public function get questID():String {
        return this._questID;
    }

    public function set questID(param1:String):void {
        this._questID = param1;
    }

    public function get progrTooltip():Object {
        return this._progrTooltip;
    }

    public function set progrTooltip(param1:Object):void {
        this._progrTooltip = param1;
    }

    public function get eventType():int {
        return this._eventType;
    }

    public function set eventType(param1:int):void {
        this._eventType = param1;
    }

    override public function isEquals(param1:DAAPIDataClass):Boolean {
        var _loc2_:QuestRendererVO = param1 as QuestRendererVO;
        if (!_loc2_) {
            return false;
        }
        return this.rendererType == _loc2_.rendererType && this.isSelectable == _loc2_.isSelectable && this.bckgrImage == _loc2_.bckgrImage && this.showBckgrImage == _loc2_.showBckgrImage && this.tooltip == _loc2_.tooltip && this.detailsLinkage == _loc2_.detailsLinkage && this.detailsPyAlias == _loc2_.detailsPyAlias && this._isNew == _loc2_.isNew && this._status == _loc2_.status && this._IGR == _loc2_.IGR && this._taskType == _loc2_.taskType && this._description == _loc2_.description && this._timerDescr == _loc2_.timerDescr && this._tasksCount == _loc2_.tasksCount && this._progrBarType == _loc2_.progrBarType && this._maxProgrVal == _loc2_.maxProgrVal && this._currentProgrVal == _loc2_.currentProgrVal && this._isLock == _loc2_.isLock && this._isLocked == _loc2_.isLocked && this._questID == _loc2_.questID && compare(this.progrTooltip, _loc2_.progrTooltip) && this._eventType == _loc2_.eventType;
    }
}
}
