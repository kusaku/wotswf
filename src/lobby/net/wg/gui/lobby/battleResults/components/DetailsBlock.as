package net.wg.gui.lobby.battleResults.components {
import flash.display.DisplayObject;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.Aliases;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.lobby.battleResults.data.PersonalDataVO;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IPopOverCaller;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class DetailsBlock extends UIComponentEx implements IPopOverCaller {

    private static const FULL_ALPHA_VALUE:Number = 1;

    private static const TRANSPARENCY_VALUE:Number = 0.4;

    private static const DETAILS_BTN_OFFSET:int = 12;

    private static const MIN_BTNS_WIDTH:int = 80;

    private static const BTNS_VERTICAL_OFFSET:int = 34;

    public var noPremTitleLbl:TextField;

    public var premTitleLbl:TextField;

    public var creditsLbl:TextField;

    public var premCreditsLbl:TextField;

    public var xpTitleLbl:TextField;

    public var xpLbl:TextField;

    public var premXpLbl:TextField;

    public var resTitleLbl:TextField;

    public var resLbl:TextField;

    public var premResLbl:TextField;

    public var getPremBtn:SoundButtonEx = null;

    public var detailedReportBtn:SoundButtonEx;

    public var creditsTitle:TextField;

    private var _currentSelectedVehIdx:int = 0;

    private var _data:PersonalDataVO;

    public function DetailsBlock() {
        super();
    }

    override protected function onDispose():void {
        this.getPremBtn.removeEventListener(ButtonEvent.CLICK, this.onGetPremBtnClickHandler);
        this._data = null;
        this.noPremTitleLbl = null;
        this.premTitleLbl = null;
        this.creditsLbl = null;
        this.premCreditsLbl = null;
        this.xpTitleLbl = null;
        this.xpLbl = null;
        this.premXpLbl = null;
        this.resTitleLbl = null;
        this.resLbl = null;
        this.premResLbl = null;
        this.creditsTitle = null;
        this.getPremBtn.dispose();
        this.getPremBtn = null;
        this.detailedReportBtn.dispose();
        this.detailedReportBtn = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.noPremTitleLbl.text = BATTLE_RESULTS.COMMON_DETAILS_NOPREMTITLE;
        this.premTitleLbl.text = BATTLE_RESULTS.COMMON_DETAILS_PREMTITLE;
        this.creditsTitle.text = BATTLE_RESULTS.COMMON_DETAILS_CREDITSTITLE;
        this.detailedReportBtn.label = BATTLE_RESULTS.COMMON_DETAILS_DETAILEDREPORTBTN;
        this.getPremBtn.label = BATTLE_RESULTS.COMMON_DETAILS_GETPREMBTN;
        this.detailedReportBtn.autoSize = TextFieldAutoSize.CENTER;
        this.getPremBtn.autoSize = TextFieldAutoSize.CENTER;
        this.detailedReportBtn.minWidth = MIN_BTNS_WIDTH;
        this.getPremBtn.minWidth = MIN_BTNS_WIDTH;
        this.getPremBtn.addEventListener(ButtonEvent.CLICK, this.onGetPremBtnClickHandler);
    }

    override protected function draw():void {
        var _loc1_:Number = NaN;
        var _loc2_:Number = NaN;
        var _loc3_:int = 0;
        super.draw();
        if (this._data == null) {
            return;
        }
        if (isInvalid(InvalidationType.SETTINGS)) {
            _loc1_ = !!this.data.isPremium ? Number(TRANSPARENCY_VALUE) : Number(FULL_ALPHA_VALUE);
            _loc2_ = !!this.data.isPremium ? Number(FULL_ALPHA_VALUE) : Number(TRANSPARENCY_VALUE);
            _loc3_ = this.xpTitleLbl.y;
            this.noPremTitleLbl.alpha = _loc1_;
            this.premTitleLbl.alpha = _loc1_;
            this.creditsLbl.alpha = _loc1_;
            this.xpLbl.alpha = _loc1_;
            this.premTitleLbl.alpha = _loc2_;
            this.premCreditsLbl.alpha = _loc2_;
            this.premXpLbl.alpha = _loc2_;
            this.getPremBtn.visible = this._data.hasGetPremBtn;
            if (this.resTitleLbl != null) {
                this.resTitleLbl.text = BATTLE_RESULTS.COMMON_DETAILS_RESOURCE;
                this.resLbl.alpha = _loc1_;
                this.premResLbl.alpha = _loc2_;
                _loc3_ = this.resTitleLbl.y;
            }
            if (this._data.hasGetPremBtn) {
                this.getPremBtn.validateNow();
                this.getPremBtn.x = this.premTitleLbl.x + this.premTitleLbl.width - this.getPremBtn.width ^ 0;
                this.getPremBtn.y = _loc3_ + BTNS_VERTICAL_OFFSET ^ 0;
            }
            this.detailedReportBtn.validateNow();
            this.detailedReportBtn.x = DETAILS_BTN_OFFSET;
            this.detailedReportBtn.y = _loc3_ + BTNS_VERTICAL_OFFSET ^ 0;
        }
        if (isInvalid(InvalidationType.SELECTED_INDEX)) {
            this.xpTitleLbl.htmlText = this.data.xpTitleStrings[this._currentSelectedVehIdx];
            this.xpLbl.htmlText = this.data.xpNoPremValues[this._currentSelectedVehIdx];
            this.premXpLbl.htmlText = this.data.xpPremValues[this._currentSelectedVehIdx];
            this.creditsLbl.htmlText = this.data.creditsNoPremValues[this._currentSelectedVehIdx];
            this.premCreditsLbl.htmlText = this.data.creditsPremValues[this._currentSelectedVehIdx];
            if (this.resTitleLbl != null) {
                this.resLbl.htmlText = this.data.resValues[this._currentSelectedVehIdx];
                this.premResLbl.htmlText = this.data.resPremValues[this._currentSelectedVehIdx];
            }
        }
    }

    public function getHitArea():DisplayObject {
        return this.getPremBtn;
    }

    public function getTargetButton():DisplayObject {
        return this.getPremBtn;
    }

    public function get data():PersonalDataVO {
        return this._data;
    }

    public function set data(param1:PersonalDataVO):void {
        this._data = param1;
        invalidate();
    }

    public function set currentSelectedVehIdx(param1:int):void {
        this._currentSelectedVehIdx = param1;
        invalidate(InvalidationType.SELECTED_INDEX);
    }

    private function onGetPremBtnClickHandler(param1:ButtonEvent):void {
        App.popoverMgr.show(this, Aliases.GET_PREMIUM_POPOVER, this._data.getPremVO);
    }
}
}
