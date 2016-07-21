package net.wg.gui.lobby.fortifications.intelligence.impl {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.data.constants.Values;
import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.lobby.fortifications.data.ClanDescriptionVO;
import net.wg.gui.lobby.fortifications.events.FortIntelClanDescriptionEvent;
import net.wg.infrastructure.base.meta.IFortIntelligenceClanDescriptionMeta;
import net.wg.infrastructure.base.meta.impl.FortIntelligenceClanDescriptionMeta;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.interfaces.IPopOverCaller;

import scaleform.clik.constants.InvalidationType;

public class FortIntelligenceClanDescription extends FortIntelligenceClanDescriptionMeta implements IFortIntelligenceClanDescriptionMeta, IPopOverCaller {

    public var notSelectedTF:TextField = null;

    public var notSelectedBG:MovieClip = null;

    public var descriptionHeader:FortIntelClanDescriptionHeader = null;

    public var descriptionFooter:FortIntelClanDescriptionFooter = null;

    private var _model:ClanDescriptionVO = null;

    public function FortIntelligenceClanDescription() {
        super();
    }

    override protected function setData(param1:ClanDescriptionVO):void {
        this._model = param1;
        invalidateData();
    }

    override protected function configUI():void {
        super.configUI();
        this.descriptionHeader.visible = this.descriptionFooter.visible = false;
        this.descriptionFooter.addEventListener(FortIntelClanDescriptionEvent.OPEN_CALENDAR, this.onDescriptionFooterOpenCalendarHandler);
        this.descriptionFooter.addEventListener(FortIntelClanDescriptionEvent.CLICK_LINK_BTN, this.onDescriptionFooterLinkBtnClickHandler);
        this.descriptionFooter.addEventListener(FortIntelClanDescriptionEvent.ATTACK_DIRECTION, this.onDescriptionFooterAttackDirectionHandler);
        this.descriptionFooter.addEventListener(FortIntelClanDescriptionEvent.HOVER_DIRECTION, this.onDescriptionFooterHoverDirectionHandler);
        this.descriptionFooter.addEventListener(FortIntelClanDescriptionEvent.FOCUS_UP, this.onDescriptionFooterFocusUpHandler);
        this.descriptionHeader.addEventListener(FortIntelClanDescriptionEvent.SHOW_CLAN_INFOTIP, this.onDescriptionHeaderShowClanInfotipHandler);
        this.descriptionHeader.addEventListener(FortIntelClanDescriptionEvent.HIDE_CLAN_INFOTIP, this.onDescriptionHeaderHideClanInfotipHandler);
        this.descriptionHeader.addEventListener(FortIntelClanDescriptionEvent.CHECKBOX_CLICK, this.onDescriptionHeaderCheckBoxClickHandler);
        this.descriptionHeader.addEventListener(FortIntelClanDescriptionEvent.OPEN_CLAN_LIST, this.onDescriptionHeaderOpenClanListHandler);
        this.descriptionHeader.addEventListener(FortIntelClanDescriptionEvent.OPEN_CLAN_STATISTICS, this.onDescriptionHeaderOpenClanStatisticsHandler);
        this.descriptionHeader.addEventListener(FortIntelClanDescriptionEvent.OPEN_CLAN_CARD, this.onDescriptionHeaderOpenClanCardHandler);
        this.descriptionHeader.addEventListener(FortIntelClanDescriptionEvent.FOCUS_DOWN, this.onDescriptionHeaderFocusDownHandler);
    }

    override protected function onDispose():void {
        this.descriptionFooter.removeEventListener(FortIntelClanDescriptionEvent.OPEN_CALENDAR, this.onDescriptionFooterOpenCalendarHandler);
        this.descriptionFooter.removeEventListener(FortIntelClanDescriptionEvent.CLICK_LINK_BTN, this.onDescriptionFooterLinkBtnClickHandler);
        this.descriptionFooter.removeEventListener(FortIntelClanDescriptionEvent.ATTACK_DIRECTION, this.onDescriptionFooterAttackDirectionHandler);
        this.descriptionFooter.removeEventListener(FortIntelClanDescriptionEvent.HOVER_DIRECTION, this.onDescriptionFooterHoverDirectionHandler);
        this.descriptionFooter.removeEventListener(FortIntelClanDescriptionEvent.FOCUS_UP, this.onDescriptionFooterFocusUpHandler);
        this.descriptionHeader.removeEventListener(FortIntelClanDescriptionEvent.SHOW_CLAN_INFOTIP, this.onDescriptionHeaderShowClanInfotipHandler);
        this.descriptionHeader.removeEventListener(FortIntelClanDescriptionEvent.HIDE_CLAN_INFOTIP, this.onDescriptionHeaderHideClanInfotipHandler);
        this.descriptionHeader.removeEventListener(FortIntelClanDescriptionEvent.CHECKBOX_CLICK, this.onDescriptionHeaderCheckBoxClickHandler);
        this.descriptionHeader.removeEventListener(FortIntelClanDescriptionEvent.OPEN_CLAN_LIST, this.onDescriptionHeaderOpenClanListHandler);
        this.descriptionHeader.removeEventListener(FortIntelClanDescriptionEvent.OPEN_CLAN_STATISTICS, this.onDescriptionHeaderOpenClanStatisticsHandler);
        this.descriptionHeader.removeEventListener(FortIntelClanDescriptionEvent.OPEN_CLAN_CARD, this.onDescriptionHeaderOpenClanCardHandler);
        this.descriptionHeader.removeEventListener(FortIntelClanDescriptionEvent.FOCUS_DOWN, this.onDescriptionHeaderFocusDownHandler);
        this.notSelectedTF = null;
        this.notSelectedBG = null;
        this.descriptionHeader.dispose();
        this.descriptionHeader = null;
        this.descriptionFooter.dispose();
        this.descriptionFooter = null;
        this._model = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            this.updateElements();
        }
    }

    public function as_updateBookMark(param1:Boolean):void {
        this.descriptionHeader.checkBox.selected = param1;
    }

    public function getHitArea():DisplayObject {
        return this.descriptionFooter.calendarBtn;
    }

    public function getTargetButton():DisplayObject {
        return this.descriptionFooter.calendarBtn;
    }

    private function updateElements():void {
        if (this._model != null) {
            this.notSelectedTF.visible = this.notSelectedBG.visible = !this._model.isSelected;
            this.descriptionHeader.visible = this.descriptionFooter.visible = this._model.isSelected;
            if (this._model.isSelected) {
                this.descriptionHeader.model = this._model;
                this.descriptionFooter.model = this._model;
            }
            else if (!this._model.haveResults) {
                this.notSelectedTF.text = Values.EMPTY_STR;
            }
            else if (this._model.canAttackDirection && !this._model.isOurFortFrozen) {
                this.notSelectedTF.text = FORTIFICATIONS.FORTINTELLIGENCE_CLANDESCRIPTION_NOTSELECTEDSCREEN_COMMANDER;
            }
            else {
                this.notSelectedTF.text = FORTIFICATIONS.FORTINTELLIGENCE_CLANDESCRIPTION_NOTSELECTEDSCREEN_NOTCOMMANDER;
            }
        }
        else {
            this.notSelectedTF.visible = true;
            this.notSelectedBG.visible = true;
            this.notSelectedTF.text = Values.EMPTY_STR;
        }
    }

    private function onDescriptionFooterOpenCalendarHandler(param1:FortIntelClanDescriptionEvent):void {
        var _loc2_:Object = {"timestamp": (this._model != null ? this._model.selectedDayTimestamp : null)};
        App.popoverMgr.show(this, FORTIFICATION_ALIASES.FORT_DATE_PICKER_POPOVER_ALIAS, _loc2_);
    }

    private function onDescriptionHeaderShowClanInfotipHandler(param1:FortIntelClanDescriptionEvent):void {
        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CLAN_INFO, null, this._model.clanId);
    }

    private function onDescriptionHeaderHideClanInfotipHandler(param1:FortIntelClanDescriptionEvent):void {
        App.toolTipMgr.hide();
    }

    private function onDescriptionHeaderCheckBoxClickHandler(param1:FortIntelClanDescriptionEvent):void {
        onAddRemoveFavoriteS(this.descriptionHeader.checkBox.selected);
    }

    private function onDescriptionFooterLinkBtnClickHandler(param1:FortIntelClanDescriptionEvent):void {
        onOpenCalendarS();
    }

    private function onDescriptionHeaderOpenClanListHandler(param1:FortIntelClanDescriptionEvent):void {
        onOpenClanListS();
    }

    private function onDescriptionHeaderOpenClanStatisticsHandler(param1:FortIntelClanDescriptionEvent):void {
        onOpenClanStatisticsS();
    }

    private function onDescriptionHeaderOpenClanCardHandler(param1:FortIntelClanDescriptionEvent):void {
        onOpenClanCardS();
    }

    private function onDescriptionFooterAttackDirectionHandler(param1:FortIntelClanDescriptionEvent):void {
        var _loc2_:int = param1.data;
        onAttackDirectionS(_loc2_);
    }

    private function onDescriptionFooterHoverDirectionHandler(param1:FortIntelClanDescriptionEvent):void {
        onHoverDirectionS();
    }

    private function onDescriptionFooterFocusUpHandler(param1:FortIntelClanDescriptionEvent):void {
        dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS, this.descriptionHeader));
    }

    private function onDescriptionHeaderFocusDownHandler(param1:FortIntelClanDescriptionEvent):void {
        dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS, this.descriptionFooter));
    }
}
}
