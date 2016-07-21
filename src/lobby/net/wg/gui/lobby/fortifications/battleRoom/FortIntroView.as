package net.wg.gui.lobby.fortifications.battleRoom {
import flash.display.InteractiveObject;
import flash.text.TextField;

import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.fortifications.data.battleRoom.IntroViewVO;
import net.wg.gui.rally.events.RallyViewsEvent;
import net.wg.infrastructure.base.meta.IFortIntroMeta;
import net.wg.infrastructure.base.meta.impl.FortIntroMeta;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class FortIntroView extends FortIntroMeta implements IFortIntroMeta {

    public var fortBattleTitleLbl:TextField = null;

    public var fortBattleDescrLbl:TextField = null;

    public var additionalText:TextField = null;

    public var fortBattleBtn:ISoundButtonEx = null;

    private var _model:IntroViewVO = null;

    public function FortIntroView() {
        super();
        visible = false;
    }

    override public function canShowAutomatically():Boolean {
        return false;
    }

    override public function getComponentForFocus():InteractiveObject {
        return listRoomBtn;
    }

    override protected function setIntroData(param1:IntroViewVO):void {
        this._model = param1;
        invalidateData();
    }

    override protected function draw():void {
        super.draw();
        if (this._model != null && isInvalid(InvalidationType.DATA)) {
            this.updateIntroData();
            visible = true;
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.fortBattleBtn.mouseEnabledOnDisabled = true;
        titleLbl.text = FORTIFICATIONS.SORTIE_INTROVIEW_TITLE;
        descrLbl.text = FORTIFICATIONS.SORTIE_INTROVIEW_DESCR;
        listRoomTitleLbl.text = FORTIFICATIONS.SORTIE_INTROVIEW_SORTIE_TITLE;
        listRoomDescrLbl.text = FORTIFICATIONS.SORTIE_INTROVIEW_SORTIE_DESCR;
        listRoomBtn.label = FORTIFICATIONS.SORTIE_INTROVIEW_SORTIE_BTNTITLE;
    }

    override protected function onDispose():void {
        this.fortBattleBtn.removeEventListener(ButtonEvent.CLICK, this.onFortBattleBtnClickHandler);
        this.fortBattleBtn.dispose();
        this.fortBattleBtn = null;
        this.fortBattleTitleLbl = null;
        this.fortBattleDescrLbl = null;
        this.additionalText = null;
        this._model = null;
        super.onDispose();
    }

    private function updateIntroData():void {
        listRoomBtn.tooltip = this._model.listRoomBtnBtnTooltip;
        this.fortBattleTitleLbl.text = this._model.fortBattleTitle;
        this.fortBattleDescrLbl.text = this._model.fortBattleDescr;
        this.additionalText.htmlText = this._model.additionalText;
        var _loc1_:Boolean = this._model.enableBtn;
        this.fortBattleBtn.enabled = _loc1_;
        this.fortBattleBtn.label = this._model.fortBattleBtnTitle;
        this.fortBattleBtn.tooltip = this._model.fortBattleBtnTooltip;
        this.fortBattleBtn.validateNow();
        if (_loc1_) {
            this.fortBattleBtn.addEventListener(ButtonEvent.CLICK, this.onFortBattleBtnClickHandler);
        }
        else {
            this.fortBattleBtn.removeEventListener(ButtonEvent.CLICK, this.onFortBattleBtnClickHandler);
        }
        this.additionalText.x = this.fortBattleBtn.x + (this.fortBattleBtn.width >> 1) - (this.additionalText.width >> 1);
    }

    override protected function showListRoom(param1:ButtonEvent):void {
        var _loc2_:String = param1.target == this.fortBattleBtn ? FORTIFICATION_ALIASES.FORT_CLAN_BATTLE_LIST_VIEW_UI : FORTIFICATION_ALIASES.FORT_BATTLE_ROOM_LIST_VIEW_UI;
        var _loc3_:Object = {
            "alias": _loc2_,
            "itemId": Number.NaN,
            "peripheryID": 0,
            "slotIndex": -1
        };
        dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LOAD_VIEW_REQUEST, _loc3_));
    }

    private function onFortBattleBtnClickHandler(param1:ButtonEvent):void {
        this.showListRoom(param1);
    }
}
}
