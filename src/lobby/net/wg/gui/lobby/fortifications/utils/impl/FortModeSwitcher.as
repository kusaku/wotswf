package net.wg.gui.lobby.fortifications.utils.impl {
import flash.display.DisplayObject;

import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.cmp.IFortMainView;
import net.wg.gui.lobby.fortifications.data.FortModeElementProperty;
import net.wg.gui.lobby.fortifications.data.FortModeStateVO;
import net.wg.gui.lobby.fortifications.utils.IFortCommonUtils;
import net.wg.gui.lobby.fortifications.utils.IFortModeSwitcher;
import net.wg.utils.ITweenAnimator;

public class FortModeSwitcher implements IFortModeSwitcher {

    private static const DONT_MOVE:uint = 0;

    private static const MOVE_DOWN:uint = 2;

    private var _mainView:IFortMainView = null;

    private var _startDescrTextY:Number = 0;

    public function FortModeSwitcher() {
        super();
    }

    private static function fadeSomeElementSimply(param1:FortModeElementProperty, param2:DisplayObject):void {
        getFortCommonUtils().fadeSomeElementSimply(param1.isVisible, param1.isAnimated, param2);
    }

    private static function moveElementSimply(param1:uint, param2:Number, param3:DisplayObject):void {
        if (param1 != DONT_MOVE) {
            getFortCommonUtils().moveElementSimply(param1 == MOVE_DOWN, param2, param3);
        }
    }

    private static function getFortCommonUtils():IFortCommonUtils {
        return FortCommonUtils.instance;
    }

    private static function getTweenAnimator():ITweenAnimator {
        return App.utils.tweenAnimator;
    }

    public function applyMode(param1:FortModeStateVO):void {
        this.removeAllAnims();
        this._mainView.gotoAndPlay(param1.mode);
        this._mainView.header.gotoAndPlay(param1.mode);
        this._mainView.header.updateControls();
        this._mainView.footer.updateControls();
        this.applyStepEffects(param1);
    }

    public function dispose():void {
        this.removeAllAnims();
        this._mainView = null;
    }

    public function init(param1:IFortMainView):void {
        App.utils.asserter.assertNotNull(param1, param1.name + Errors.CANT_NULL);
        this._mainView = param1;
        if (this._mainView.header && this._mainView.header.vignetteYellow && this._mainView.header.vignetteYellow.descrText) {
            this._startDescrTextY = this._mainView.header.vignetteYellow.descrText.y;
        }
    }

    private function applyStepEffects(param1:FortModeStateVO):void {
        fadeSomeElementSimply(param1.getYellowVignette(), this._mainView.header.vignetteYellow);
        moveElementSimply(param1.descrTextMove, this._startDescrTextY, this._mainView.header.vignetteYellow.descrText);
        fadeSomeElementSimply(param1.getClanInfo(), DisplayObject(this._mainView.header.clanInfo));
        fadeSomeElementSimply(param1.getClanListBtn(), DisplayObject(this._mainView.header.clanListBtn));
        fadeSomeElementSimply(param1.getCalendarBtn(), DisplayObject(this._mainView.header.calendarBtn));
        fadeSomeElementSimply(param1.getSettingBtn(), DisplayObject(this._mainView.header.settingBtn));
        fadeSomeElementSimply(param1.getTransportToggle(), DisplayObject(this._mainView.header.transportBtn));
        fadeSomeElementSimply(param1.getStatsBtn(), DisplayObject(this._mainView.header.statsBtn));
        fadeSomeElementSimply(param1.getClanProfileBtn(), DisplayObject(this._mainView.header.clanProfileBtn));
        fadeSomeElementSimply(param1.getInfoTF(), this._mainView.header.infoTF);
        fadeSomeElementSimply(param1.getTimeAlert(), this._mainView.header.timeAlert);
        this._mainView.header.title.htmlText = param1.stateTexts.headerTitle;
        fadeSomeElementSimply(param1.getTotalDepotQuantity(), this._mainView.header.totalDepotQuantityText);
        if (param1.getTutorialArrow().isVisible && param1.getTutorialArrow().isAnimated) {
            this.startArrowBlinking();
        }
        else {
            this.stopArrowBlinking();
        }
        if (!param1.getYellowVignette().isAnimated || param1.getYellowVignette().isVisible) {
            this._mainView.header.vignetteYellow.descrText.htmlText = param1.stateTexts.descrText;
        }
        fadeSomeElementSimply(param1.getFooterBitmapFill(), this._mainView.footer.footerBitmapFill);
        fadeSomeElementSimply(param1.getOrdersPanel(), DisplayObject(this._mainView.footer.ordersPanel));
        fadeSomeElementSimply(param1.getOrderSelector(), DisplayObject(this._mainView.footer.orderSelector));
        fadeSomeElementSimply(param1.getSortieBtn(), this._mainView.footer.sortieBtn);
        fadeSomeElementSimply(param1.getIntelligenceButton(), this._mainView.footer.intelligenceButton);
        fadeSomeElementSimply(param1.getLeaveModeBtn(), this._mainView.footer.leaveModeBtn);
    }

    private function startArrowBlinking():void {
        getFortCommonUtils().updateTutorialArrow(true, DisplayObject(this._mainView.header.tutorialArrowTransport));
    }

    private function stopArrowBlinking():void {
        getFortCommonUtils().updateTutorialArrow(false, DisplayObject(this._mainView.header.tutorialArrowTransport));
    }

    private function removeAllAnims():void {
        this.stopArrowBlinking();
        var _loc1_:ITweenAnimator = getTweenAnimator();
        _loc1_.removeAnims(DisplayObject(this._mainView.header.vignetteYellow));
        _loc1_.removeAnims(DisplayObject(this._mainView.header.vignetteYellow.descrText));
        _loc1_.removeAnims(DisplayObject(this._mainView.header.clanListBtn));
        _loc1_.removeAnims(DisplayObject(this._mainView.header.calendarBtn));
        _loc1_.removeAnims(DisplayObject(this._mainView.header.settingBtn));
        _loc1_.removeAnims(DisplayObject(this._mainView.header.transportBtn));
        _loc1_.removeAnims(DisplayObject(this._mainView.header.statsBtn));
        _loc1_.removeAnims(DisplayObject(this._mainView.header.clanInfo));
        _loc1_.removeAnims(DisplayObject(this._mainView.header.clanProfileBtn));
        _loc1_.removeAnims(this._mainView.header.totalDepotQuantityText);
        _loc1_.removeAnims(this._mainView.footer.footerBitmapFill);
        _loc1_.removeAnims(DisplayObject(this._mainView.footer.ordersPanel));
        _loc1_.removeAnims(DisplayObject(this._mainView.footer.orderSelector));
        _loc1_.removeAnims(this._mainView.footer.sortieBtn);
        _loc1_.removeAnims(this._mainView.footer.intelligenceButton);
        _loc1_.removeAnims(this._mainView.footer.leaveModeBtn);
    }
}
}
