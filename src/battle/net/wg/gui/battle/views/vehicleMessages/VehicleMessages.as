package net.wg.gui.battle.views.vehicleMessages {
import flash.display.DisplayObjectContainer;

import net.wg.data.constants.generated.BATTLE_MESSAGES_CONSTS;
import net.wg.gui.battle.views.messages.IMessage;
import net.wg.gui.battle.views.messages.MessageListDAAPI;
import net.wg.gui.battle.views.messages.VO.FadingMessageListSettingsVO;
import net.wg.gui.battle.views.vehicleMessages.vo.VehicleMessageVO;

public class VehicleMessages extends MessageListDAAPI {

    private var _dataQueue:VehicleMessagesVoQueue = null;

    private var _renderersPool:VehicleMessagesPool = null;

    public function VehicleMessages(param1:DisplayObjectContainer) {
        super(param1);
    }

    override public function closeOldestMessage():void {
    }

    override public function as_showGoldMessage(param1:String, param2:String):void {
        this.storeMessage(param1, param2, VehicleMessageVO.COLOR_YELLOW);
    }

    override public function as_showGreenMessage(param1:String, param2:String):void {
        this.storeMessage(param1, param2, VehicleMessageVO.COLOR_GREEN);
    }

    override public function as_showPurpleMessage(param1:String, param2:String):void {
        this.storeMessage(param1, param2, VehicleMessageVO.COLOR_PURPLE);
    }

    override public function as_showRedMessage(param1:String, param2:String):void {
        this.storeMessage(param1, param2, VehicleMessageVO.COLOR_RED);
    }

    override public function as_showSelfMessage(param1:String, param2:String):void {
        this.storeMessage(param1, param2, VehicleMessageVO.COLOR_YELLOW);
    }

    override public function as_showYellowMessage(param1:String, param2:String):void {
        this.storeMessage(param1, param2, VehicleMessageVO.COLOR_YELLOW);
    }

    override protected function setupList(param1:FadingMessageListSettingsVO):void {
        setup(param1);
        maxMessages = param1.maxLinesCount;
        isShowUniqueOnly = param1.showUniqueOnly;
        this.clearPools();
        this._dataQueue = new VehicleMessagesVoQueue();
        this._renderersPool = new VehicleMessagesPool(param1, param1.poolSettings[0].renderer);
        param1.dispose();
    }

    override protected function onDispose():void {
        this.clearPools();
        super.onDispose();
    }

    override protected function onMessageClose(param1:IMessage):void {
        super.onMessageClose(param1);
        this.showNextMessage();
    }

    private function storeMessage(param1:String, param2:String, param3:uint):void {
        this._dataQueue.addMessageData(param1, param2, param3);
        this.showNextMessage();
    }

    private function showNextMessage():void {
        var _loc2_:VehicleMessageVO = null;
        var _loc3_:String = null;
        var _loc4_:int = 0;
        var _loc1_:VehicleMessage = this._renderersPool.createItem();
        if (_loc1_) {
            _loc2_ = this._dataQueue.getNextMessage();
            if (!_loc2_) {
                return;
            }
            _loc3_ = _loc2_.key;
            if (isShowUniqueOnly && isNowShowed(_loc3_)) {
                return;
            }
            _loc1_.markUsed();
            _loc1_.setData(_loc3_, _loc2_.text, true, _loc2_.color);
            _loc4_ = _loc1_.numLines + this.calcShowedLinesCount();
            if (_loc4_ > this._renderersPool.capacity) {
                _loc1_.markUnused();
                return;
            }
            this._dataQueue.shiftNextMessage();
            pushMessage(_loc1_);
            this.showNextMessage();
        }
    }

    private function calcShowedLinesCount():int {
        var _loc2_:VehicleMessage = null;
        var _loc1_:int = 0;
        for each(_loc2_ in messages) {
            if (_loc2_.used) {
                _loc1_ = _loc1_ + _loc2_.numLines;
            }
        }
        return _loc1_;
    }

    private function clearPools():void {
        if (this._dataQueue) {
            this._dataQueue.dispose();
            this._dataQueue = null;
        }
        if (this._renderersPool) {
            this._renderersPool.dispose();
            this._renderersPool = null;
        }
    }

    public function updateStage():void {
        if (this._renderersPool) {
            this._renderersPool.updateStage();
        }
    }

    override protected function rearrangeMessages():void {
        var _loc2_:* = false;
        var _loc3_:VehicleMessage = null;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        var _loc1_:int = messages.length;
        if (_loc1_) {
            _loc2_ = direction == BATTLE_MESSAGES_CONSTS.LIST_DIRECTION_DOWN;
            _loc4_ = y;
            _loc6_ = 0;
            while (_loc6_ < _loc1_) {
                _loc3_ = VehicleMessage(messages[_loc6_]);
                _loc3_.x = x;
                _loc5_ = messageGap + _loc3_.height;
                if (_loc2_) {
                    _loc3_.y = _loc4_;
                    _loc4_ = _loc4_ + _loc5_;
                }
                else {
                    _loc4_ = _loc4_ - _loc5_;
                    _loc3_.y = _loc4_;
                }
                _loc6_++;
            }
        }
    }
}
}
