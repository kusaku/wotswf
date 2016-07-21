package net.wg.gui.cyberSport.views.unit {
import flash.display.Sprite;

import net.wg.data.constants.Values;
import net.wg.gui.lobby.fortifications.battleRoom.LegionariesDataProvider;

import scaleform.clik.constants.InvalidationType;

public class StaticFormationWaitListSection extends WaitListSection {

    public var separator:Sprite;

    private var _isRankedMode:Boolean = false;

    public function StaticFormationWaitListSection() {
        super();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            this.separator.visible = this.isCloseRoomButtonVisible();
        }
    }

    override protected function isCloseRoomButtonVisible():Boolean {
        var _loc1_:Boolean = !!_rallyData ? Boolean(_rallyData.isCommander) : false;
        return _loc1_ && !this._isRankedMode;
    }

    override protected function onDispose():void {
        this.separator = null;
        super.onDispose();
    }

    override protected function initializeDP():void {
        candidatesDP = new LegionariesDataProvider();
    }

    override protected function updateControls():void {
        lblTeamAvailability.htmlText = !!_rallyData ? _rallyData.statusLbl : Values.EMPTY_STR;
        btnCloseRoom.label = _rallyData && _rallyData.statusValue ? CYBERSPORT.STATICFORMATION_UNITVIEW_CLOSEROOM_BUTTON : CYBERSPORT.STATICFORMATION_UNITVIEW_OPENROOM_BUTTON;
    }

    public function setRankedMode(param1:Boolean):void {
        this._isRankedMode = param1;
        invalidateData();
    }
}
}
