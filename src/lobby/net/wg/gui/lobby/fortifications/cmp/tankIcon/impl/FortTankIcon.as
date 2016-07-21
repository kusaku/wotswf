package net.wg.gui.lobby.fortifications.cmp.tankIcon.impl {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.Values;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.events.UILoaderEvent;
import net.wg.gui.lobby.fortifications.data.tankIcon.FortTankIconVO;
import net.wg.infrastructure.interfaces.ISpriteEx;

public class FortTankIcon extends MovieClip implements ISpriteEx {

    private static const LVL_ICON_CENTER_OFFSET:uint = 73;

    public var hitAreaMC:MovieClip = null;

    public var alertIcon:MovieClip = null;

    public var valueTF:TextField = null;

    public var tankIconLoader:UILoaderAlt = null;

    public var lvlIconLoader:UILoaderAlt = null;

    private var _model:FortTankIconVO = null;

    public function FortTankIcon() {
        super();
        this.alertIcon.visible = false;
        this.tankIconLoader.autoSize = false;
        this.lvlIconLoader.autoSize = false;
        this.lvlIconLoader.visible = false;
    }

    public function dispose():void {
        this.tankIconLoader.removeEventListener(UILoaderEvent.COMPLETE, this.onTankIconLoadCompleteHandler);
        this.lvlIconLoader.removeEventListener(UILoaderEvent.COMPLETE, this.onLvlIconLoadCompleteHandler);
        removeEventListener(MouseEvent.ROLL_OVER, this.onMouseRollOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT, this.onMouseRollOutHandler);
        removeEventListener(MouseEvent.CLICK, this.onMouseClickHandler);
        this.tankIconLoader.dispose();
        this.lvlIconLoader.dispose();
        this.tankIconLoader = null;
        this.lvlIconLoader = null;
        this.hitAreaMC = null;
        this.alertIcon = null;
        this.valueTF = null;
        this._model = null;
    }

    public function update(param1:Object):void {
        this._model = FortTankIconVO(param1);
        this.alertIcon.visible = this._model.showAlert;
        this.valueTF.htmlText = this._model.valueText;
        this.tankIconLoader.source = this._model.tankIconSource;
        this.lvlIconLoader.source = this._model.lvlIconSource;
        this.tankIconLoader.addEventListener(UILoaderEvent.COMPLETE, this.onTankIconLoadCompleteHandler);
        this.lvlIconLoader.addEventListener(UILoaderEvent.COMPLETE, this.onLvlIconLoadCompleteHandler);
        if (this._model.divisionID != Values.DEFAULT_INT) {
            addEventListener(MouseEvent.ROLL_OVER, this.onMouseRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT, this.onMouseRollOutHandler);
            addEventListener(MouseEvent.CLICK, this.onMouseClickHandler);
        }
    }

    private function onLvlIconLoadCompleteHandler(param1:UILoaderEvent):void {
        this.lvlIconLoader.removeEventListener(UILoaderEvent.COMPLETE, this.onLvlIconLoadCompleteHandler);
        this.lvlIconLoader.x = LVL_ICON_CENTER_OFFSET - Math.round(this.lvlIconLoader.width / 2);
        this.lvlIconLoader.visible = true;
    }

    private function onTankIconLoadCompleteHandler(param1:UILoaderEvent):void {
        this.tankIconLoader.removeEventListener(UILoaderEvent.COMPLETE, this.onTankIconLoadCompleteHandler);
        if (this.alertIcon.visible) {
            this.hitAreaMC.x = 0;
            this.hitAreaMC.width = this.tankIconLoader.x + this.tankIconLoader.width;
        }
        else {
            this.hitAreaMC.x = this.valueTF.x;
            this.hitAreaMC.width = this.tankIconLoader.x + this.tankIconLoader.width - this.valueTF.x;
        }
    }

    private function onMouseRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.FORT_DIVISION, null, this._model.divisionID, this._model.showAlert);
    }

    private function onMouseRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onMouseClickHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }
}
}
