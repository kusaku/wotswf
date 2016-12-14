package net.wg.gui.lobby.christmas {
import flash.display.DisplayObject;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFormatAlign;

import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.lobby.christmas.interfaces.IChristmasButton;
import net.wg.infrastructure.managers.counter.CounterProps;
import net.wg.utils.ICounterManager;
import net.wg.utils.ICounterProps;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;

public class ChristmasButton extends SoundButtonEx implements IChristmasButton {

    private static const COUNTER_PROPS:ICounterProps = new CounterProps(0, 0, TextFormatAlign.LEFT);

    private static const XMAS_SOUND_TYPE:String = "xmasButton";

    private static const MIN_HEIGHT:int = 120;

    private static const LABEL_TOP_PADDING:int = -26;

    private static const COUNTER_H_OFFSET:int = -50;

    private static const COUNTER_V_OFFSET:int = 34;

    public var labelTF:TextField = null;

    public var icon:DisplayObject = null;

    public var bg:DisplayObject = null;

    private var _counterManager:ICounterManager = null;

    private var _iconTopPadding:int = 0;

    public function ChristmasButton() {
        super();
    }

    override protected function initialize():void {
        super.initialize();
        soundType = XMAS_SOUND_TYPE;
        this._counterManager = App.utils.counterManager;
    }

    override protected function onDispose():void {
        this._counterManager.removeCounter(this);
        this._counterManager = null;
        this.labelTF = null;
        this.icon = null;
        this.bg = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            this.labelTF.htmlText = label;
            App.utils.commons.updateTextFieldSize(this.labelTF, true, true);
            invalidateSize();
        }
        if (isInvalid(InvalidationType.SIZE)) {
            this.bg.x = width - this.bg.width ^ 0;
            this.bg.y = 0;
            this.icon.x = width - this.icon.width >> 1;
            this.icon.y = (height - this.icon.height >> 1) + this._iconTopPadding;
            this.labelTF.x = width - this.labelTF.width >> 1;
            this.labelTF.y = this.icon.y + this.icon.height + LABEL_TOP_PADDING ^ 0;
            if (this._counterManager.containsCounter(this)) {
                this._counterManager.updateCounterOffset(this, new Point(-this.icon.x + COUNTER_H_OFFSET, this.icon.y + COUNTER_V_OFFSET));
            }
        }
    }

    override protected function showTooltip():void {
        if (StringUtils.isNotEmpty(tooltip)) {
            App.toolTipMgr.showSpecial(tooltip, null);
        }
    }

    public function setCounter(param1:String):void {
        if (StringUtils.isNotEmpty(param1)) {
            this._counterManager.setCounter(this, param1, COUNTER_PROPS);
            invalidateSize();
        }
        else {
            this._counterManager.removeCounter(this);
        }
    }

    public function updateLayout(param1:int, param2:int):void {
        hitMc.width = param1;
        if (param2 < MIN_HEIGHT) {
            this._iconTopPadding = param2 - MIN_HEIGHT;
            param2 = MIN_HEIGHT;
        }
        hitMc.height = param2;
        setSize(param1, param2);
        validateNow();
    }
}
}
