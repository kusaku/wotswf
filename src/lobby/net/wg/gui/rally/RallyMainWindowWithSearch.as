package net.wg.gui.rally {
import flash.display.InteractiveObject;
import flash.display.MovieClip;

import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
import net.wg.gui.cyberSport.interfaces.ICSAutoSearchMainView;
import net.wg.gui.cyberSport.views.events.SCUpdateFocusEvent;
import net.wg.gui.cyberSport.vo.AutoSearchVO;
import net.wg.infrastructure.base.meta.impl.RallyMainWindowWithSearchMeta;

public class RallyMainWindowWithSearch extends RallyMainWindowWithSearchMeta {

    private static const UPDATE_AUTO_SEARCH_MODEL:String = "autoSearchModel";

    private static const UPDATE_AUTO_SEARCH_BUTTONS:String = "updateAutoSearchButtons";

    public var autoSearch:ICSAutoSearchMainView;

    private var _autoSearchModel:AutoSearchVO;

    private var _lastFocusedElementUnderAS:InteractiveObject;

    private var _waitingPlayers:Boolean = false;

    private var _searchEnemy:Boolean = false;

    private var _updatedBtns:Boolean = true;

    public function RallyMainWindowWithSearch() {
        super();
        this.autoSearch.visible = false;
        isCentered = true;
    }

    override public function as_loadView(param1:String, param2:String):void {
        this._lastFocusedElementUnderAS = null;
        super.as_loadView(param1, param2);
    }

    public function as_autoSearchEnableBtn(param1:Boolean):void {
        this.autoSearch.enableButtons(param1);
    }

    public function as_hideAutoSearch():void {
        this.hideAutoSearch();
    }

    public function as_changeAutoSearchState(param1:Object):void {
        if (param1 == null) {
            return;
        }
        this._autoSearchModel = new AutoSearchVO(param1);
        invalidate(UPDATE_AUTO_SEARCH_MODEL);
    }

    public function as_changeAutoSearchBtnsState(param1:Boolean, param2:Boolean):void {
        this._updatedBtns = false;
        this._waitingPlayers = param1;
        this._searchEnemy = param2;
        invalidate(UPDATE_AUTO_SEARCH_BUTTONS);
    }

    override protected function onBeforeDispose():void {
        this.autoSearch.stopTimer();
        this.autoSearch.removeEventListener(SCUpdateFocusEvent.UPDATE_FOCUS, this.onAutoSearchUpdateFocusHandler);
        this.autoSearch.removeEventListener(SCUpdateFocusEvent.CLEAR_FOCUS, this.onAutoSearchClearFocusHandler);
        removeEventListener(CSComponentEvent.SHOW_AUTO_SEARCH_VIEW, this.onShowAutoSearchViewHandler);
        removeEventListener(CSComponentEvent.AUTO_SEARCH_APPLY_BTN, this.onAutoSearchApplyBtnHandler);
        removeEventListener(CSComponentEvent.AUTO_SEARCH_CANCEL_BTN, this.onAutoSearchCancelBtnHandler);
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        this._lastFocusedElementUnderAS = null;
        this.autoSearch.dispose();
        this.autoSearch = null;
        if (this._autoSearchModel) {
            this._autoSearchModel.dispose();
            this._autoSearchModel = null;
        }
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.autoSearch.addEventListener(SCUpdateFocusEvent.UPDATE_FOCUS, this.onAutoSearchUpdateFocusHandler);
        this.autoSearch.addEventListener(SCUpdateFocusEvent.CLEAR_FOCUS, this.onAutoSearchClearFocusHandler);
        addEventListener(CSComponentEvent.SHOW_AUTO_SEARCH_VIEW, this.onShowAutoSearchViewHandler);
        addEventListener(CSComponentEvent.AUTO_SEARCH_APPLY_BTN, this.onAutoSearchApplyBtnHandler);
        addEventListener(CSComponentEvent.AUTO_SEARCH_CANCEL_BTN, this.onAutoSearchCancelBtnHandler);
        invalidate(UPDATE_AUTO_SEARCH_MODEL);
    }

    private function onAutoSearchUpdateFocusHandler(param1:SCUpdateFocusEvent):void {
        updateFocus();
    }

    private function onAutoSearchClearFocusHandler(param1:SCUpdateFocusEvent):void {
        setFocus(!!this._lastFocusedElementUnderAS ? this._lastFocusedElementUnderAS : this);
    }

    override protected function draw():void {
        if (isInvalid(UPDATE_AUTO_SEARCH_MODEL) && this._autoSearchModel) {
            this.autoSearch.setData(this._autoSearchModel);
            this.autoSearch.visible = true;
        }
        super.draw();
        if (!this._updatedBtns && isInvalid(UPDATE_AUTO_SEARCH_BUTTONS) && this._autoSearchModel) {
            this._updatedBtns = true;
            this.autoSearch.changeButtonsState(this._waitingPlayers, this._searchEnemy);
        }
    }

    override protected function registerCurrentView(param1:MovieClip, param2:String):void {
        super.registerCurrentView(param1, param2);
        this.memberLastFocusOnView();
    }

    protected function hideAutoSearch():void {
        this.autoSearch.stopTimer();
        this.autoSearch.removeForm();
        this.autoSearch.visible = false;
        this._autoSearchModel = null;
        setFocus(!!this._lastFocusedElementUnderAS ? this._lastFocusedElementUnderAS : this);
    }

    private function memberLastFocusOnView():void {
        if (hasFocus && !this.autoSearch.hasForm) {
            this._lastFocusedElementUnderAS = lastFocusedElement;
        }
    }

    protected function autoSearchUpdateFocus():void {
        var _loc1_:InteractiveObject = this.autoSearch.getComponentForFocus();
        if (_loc1_ != null) {
            setFocus(_loc1_);
        }
    }

    private function onAutoSearchCancelBtnHandler(param1:CSComponentEvent):void {
        autoSearchCancelS(param1.data.toString());
    }

    private function onAutoSearchApplyBtnHandler(param1:CSComponentEvent):void {
        autoSearchApplyS(param1.data.toString());
    }

    private function onShowAutoSearchViewHandler(param1:CSComponentEvent):void {
        onAutoMatchS(param1.data.state.toString(), param1.data.cmpDescr);
    }
}
}
