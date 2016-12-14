package net.wg.gui.lobby.fortifications.cmp.clan.impl {
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.advanced.ClanEmblem;
import net.wg.gui.lobby.fortifications.data.ClanInfoVO;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;

public class ClanInfoCmp extends UIComponentEx {

    public var nameTF:TextField;

    public var emblem:ClanEmblem;

    public var isMyClan:Boolean = true;

    private var _model:ClanInfoVO;

    public function ClanInfoCmp() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        addEventListener(MouseEvent.ROLL_OVER, this.overHandler);
        addEventListener(MouseEvent.ROLL_OUT, this.outHandler);
    }

    override protected function onDispose():void {
        removeEventListener(MouseEvent.ROLL_OVER, this.overHandler);
        removeEventListener(MouseEvent.ROLL_OUT, this.outHandler);
        this.emblem.dispose();
        this.emblem = null;
        this._model = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA) && this._model) {
            this.nameTF.htmlText = this._model.name;
            this.emblem.setImage(this._model.emblem);
        }
    }

    public function get model():ClanInfoVO {
        return this._model;
    }

    public function set model(param1:ClanInfoVO):void {
        this._model = param1;
        invalidateData();
    }

    private function outHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function overHandler(param1:MouseEvent):void {
        if (this._model) {
            if (this.isMyClan) {
                App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CLAN_INFO, null, null);
            }
            else {
                App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CLAN_INFO, null, this._model.id);
            }
        }
    }
}
}
