package net.wg.gui.lobby.battlequeue {
import flash.events.KeyboardEvent;
import flash.text.TextField;
import flash.ui.Keyboard;

import net.wg.gui.components.controls.ScrollingListEx;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.icons.BattleTypeIcon;
import net.wg.infrastructure.base.meta.IBattleQueueMeta;
import net.wg.infrastructure.base.meta.impl.BattleQueueMeta;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.InputEvent;

public class BattleQueue extends BattleQueueMeta implements IBattleQueueMeta {

    public var battleIcon:BattleTypeIcon;

    public var titleField:TextField;

    public var descriptionLabel:TextField;

    public var timerLabel:TextField;

    public var playersLabel:TextField;

    public var titleFieldType:TextField;

    public var exitButton:SoundButtonEx;

    public var startButton:SoundButtonEx;

    public var listByType:ScrollingListEx;

    public function BattleQueue() {
        super();
    }

    override public function toString():String {
        return "[WG BattleQueue " + name + "]";
    }

    override public function updateStage(param1:Number, param2:Number):void {
        this.x = param1 - this.actualWidth >> 1;
        this.y = Math.min(-parent.y + (param2 - this.actualHeight >> 1), 80);
    }

    override protected function configUI():void {
        this.titleFieldType.visible = false;
        this.listByType.mouseChildren = false;
        this.startButton.addEventListener(ButtonEvent.CLICK, this.onStartClick);
        this.exitButton.addEventListener(ButtonEvent.CLICK, this.onExitButton);
        App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE, KeyboardEvent.KEY_DOWN, this.handleEscape, true);
        super.configUI();
    }

    override protected function onDispose():void {
        App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE, KeyboardEvent.KEY_DOWN);
        this.listByType.disposeRenderers();
        if (this.startButton.hasEventListener(ButtonEvent.CLICK)) {
            this.startButton.removeEventListener(ButtonEvent.CLICK, this.onStartClick);
        }
        if (this.exitButton.hasEventListener(ButtonEvent.CLICK)) {
            this.exitButton.removeEventListener(ButtonEvent.CLICK, this.onExitButton);
        }
        this.battleIcon.dispose();
        this.battleIcon = null;
        this.exitButton.dispose();
        this.exitButton = null;
        this.startButton.dispose();
        this.startButton = null;
        this.listByType.dispose();
        this.listByType = null;
        this.titleField = null;
        this.descriptionLabel = null;
        this.timerLabel = null;
        this.playersLabel = null;
        this.titleFieldType = null;
        super.onDispose();
    }

    public function as_setListByType(param1:Object):void {
        var _loc2_:Array = [];
        var _loc3_:uint = 0;
        while (_loc3_ < param1.data.length) {
            _loc2_.push({
                "type": param1.data[_loc3_][0],
                "count": param1.data[_loc3_][1]
            });
            _loc3_++;
        }
        this.titleFieldType.text = param1.title;
        this.titleFieldType.visible = true;
        this.listByType.visible = true;
        this.listByType.dataProvider = new DataProvider(_loc2_);
    }

    public function as_setPlayers(param1:String):void {
        this.playersLabel.htmlText = param1;
    }

    public function as_setTimer(param1:String, param2:String):void {
        if (param2 != null) {
            param1 = param1 + (" <font color=\"#FFFFFF\">" + param2 + "</font>");
        }
        this.timerLabel.htmlText = param1;
    }

    public function as_setTypeInfo(param1:String, param2:String, param3:String):void {
        this.battleIcon.type = param1;
        this.titleField.text = param2;
        this.descriptionLabel.text = param3;
    }

    public function as_showExit(param1:Boolean):void {
        this.exitButton.visible = param1;
    }

    public function as_showStart(param1:Boolean):void {
        this.startButton.visible = param1;
    }

    private function onExitButton(param1:ButtonEvent):void {
        exitClickS();
    }

    private function onStartClick(param1:ButtonEvent):void {
        startClickS();
    }

    private function handleEscape(param1:InputEvent):void {
        onEscapeS();
    }
}
}
