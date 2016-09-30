package net.wg.gui.lobby.battlequeue {
import flash.events.KeyboardEvent;
import flash.text.TextField;
import flash.ui.Keyboard;

import net.wg.gui.components.controls.ScrollingListEx;
import net.wg.gui.components.icons.BattleTypeIcon;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.infrastructure.base.meta.IBattleQueueMeta;
import net.wg.infrastructure.base.meta.impl.BattleQueueMeta;
import net.wg.utils.ICommons;

import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.InputEvent;

public class BattleQueue extends BattleQueueMeta implements IBattleQueueMeta {

    private static const MIN_POS_Y:int = 80;

    private static const ADDITIONAL_GAP:int = 2;

    private static const INV_TYPE_INFO:String = "InvTypeInfo";

    public var battleIcon:BattleTypeIcon;

    public var titleField:TextField;

    public var descriptionLabel:TextField;

    public var timerLabel:TextField;

    public var playersLabel:TextField;

    public var titleFieldType:TextField;

    public var additionalLabel:TextField;

    public var exitButton:ISoundButtonEx;

    public var startButton:ISoundButtonEx;

    public var listByType:ScrollingListEx;

    private var _typeInfo:BattleQueueTypeInfoVO;

    private var _commons:ICommons;

    public function BattleQueue() {
        super();
        this._commons = App.utils.commons;
    }

    override public function toString():String {
        return "[WG BattleQueue " + name + "]";
    }

    override public function updateStage(param1:Number, param2:Number):void {
        this.x = param1 - this.actualWidth >> 1;
        this.y = Math.min(-parent.y + (param2 - this.actualHeight >> 1), MIN_POS_Y);
    }

    override protected function configUI():void {
        super.configUI();
        this.titleFieldType.visible = false;
        this.listByType.mouseChildren = false;
        this.startButton.addEventListener(ButtonEvent.CLICK, this.onStartButtonClickHandler);
        this.exitButton.addEventListener(ButtonEvent.CLICK, this.onExitButtonClickHandler);
        App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE, KeyboardEvent.KEY_DOWN, this.handleEscape, true);
    }

    override protected function onDispose():void {
        App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE, KeyboardEvent.KEY_DOWN);
        this.listByType.disposeRenderers();
        this.startButton.removeEventListener(ButtonEvent.CLICK, this.onStartButtonClickHandler);
        this.exitButton.removeEventListener(ButtonEvent.CLICK, this.onExitButtonClickHandler);
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
        this.additionalLabel = null;
        this._typeInfo = null;
        this._commons = null;
        super.onDispose();
    }

    override protected function setListByType(param1:BattleQueueListDataVO):void {
        this.titleFieldType.text = param1.title;
        this.titleFieldType.visible = true;
        this.listByType.dataProvider = param1.data;
        this.listByType.visible = true;
    }

    override protected function setTypeInfo(param1:BattleQueueTypeInfoVO):void {
        this._typeInfo = param1;
        invalidate(INV_TYPE_INFO);
    }

    override protected function draw():void {
        super.draw();
        if (this._typeInfo && isInvalid(INV_TYPE_INFO)) {
            this.battleIcon.type = this._typeInfo.iconLabel;
            this.titleField.text = this._typeInfo.title;
            this.descriptionLabel.text = this._typeInfo.description;
            this.additionalLabel.htmlText = this._typeInfo.additional;
            this._commons.updateTextFieldSize(this.descriptionLabel, false);
            this.additionalLabel.y = this.descriptionLabel.y + this.descriptionLabel.height + ADDITIONAL_GAP;
        }
    }

    public function as_setPlayers(param1:String):void {
        this.playersLabel.htmlText = param1;
    }

    public function as_setTimer(param1:String):void {
        this.timerLabel.htmlText = param1;
    }

    public function as_showExit(param1:Boolean):void {
        this.exitButton.visible = param1;
    }

    public function as_showStart(param1:Boolean):void {
        this.startButton.visible = param1;
    }

    private function onExitButtonClickHandler(param1:ButtonEvent):void {
        exitClickS();
    }

    private function onStartButtonClickHandler(param1:ButtonEvent):void {
        startClickS();
    }

    private function handleEscape(param1:InputEvent):void {
        onEscapeS();
    }
}
}
