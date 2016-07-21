package net.wg.gui.lobby.fortifications.windows {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.SortingInfo;
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.gui.components.controls.SortableTable;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.events.SortableTableListEvent;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.fortifications.data.FortFixedPlayersVO;
import net.wg.infrastructure.base.meta.IFortFixedPlayersWindowMeta;
import net.wg.infrastructure.base.meta.impl.FortFixedPlayersWindowMeta;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.gfx.MouseEventEx;

public class FortFixedPlayersWindow extends FortFixedPlayersWindowMeta implements IFortFixedPlayersWindowMeta {

    private static const UPDATE_TABLE:String = "updateTable";

    private static const INT_TOTAL_MINING:String = "intTotalMining";

    private static const HIMSELF:String = "himself";

    public var playersList:SortableTable = null;

    public var infoIcon:UILoaderAlt = null;

    public var soldierIcon:UILoaderAlt = null;

    public var assignPlayer:ISoundButtonEx = null;

    public var playersCounts:TextField = null;

    public var playerIsAssigned:TextField = null;

    public var toolTipArea:MovieClip = null;

    private var _model:FortFixedPlayersVO = null;

    public function FortFixedPlayersWindow() {
        super();
        this.playerIsAssigned.visible = false;
        this.playerIsAssigned.mouseEnabled = false;
        isModal = false;
        isCentered = true;
    }

    override protected function onClosingApproved():void {
    }

    override protected function onDispose():void {
        this.playersList.removeEventListener(SortableTableListEvent.RENDERER_CLICK, this.onPlayersListRendererClickHandler);
        this.playersList.dispose();
        this.playersList = null;
        this.toolTipArea.removeEventListener(MouseEvent.ROLL_OVER, this.onToolTipAreaRollOverHandler);
        this.toolTipArea.removeEventListener(MouseEvent.ROLL_OUT, this.onToolTipAreaRollOutHandler);
        this.toolTipArea = null;
        this.assignPlayer.removeEventListener(ButtonEvent.CLICK, this.onAssignPlayerClickHandler);
        this.assignPlayer.dispose();
        this.assignPlayer = null;
        this.infoIcon.dispose();
        this.infoIcon = null;
        this.soldierIcon.dispose();
        this.soldierIcon = null;
        this.playersCounts = null;
        this.playerIsAssigned = null;
        this.toolTipArea = null;
        this._model = null;
        super.onDispose();
    }

    override protected function setData(param1:FortFixedPlayersVO):void {
        this._model = param1;
        invalidate(UPDATE_TABLE);
    }

    override protected function draw():void {
        super.draw();
        if (this._model && isInvalid(UPDATE_TABLE)) {
            window.title = this._model.windowTitle;
            this.assignPlayer.label = this._model.buttonLbl;
            this.assignPlayer.enabled = this._model.isEnableBtn;
            this.assignPlayer.visible = this._model.isVisibleBtn;
            if (!this._model.isVisibleBtn && this._model.playerIsAssigned != Values.EMPTY_STR) {
                this.playerIsAssigned.visible = true;
                this.playerIsAssigned.htmlText = this._model.playerIsAssigned;
            }
            else {
                this.playerIsAssigned.visible = false;
            }
            if (this.assignPlayer.visible) {
                this.assignPlayer.tooltip = this._model.btnTooltipData;
                this.assignPlayer.buttonMode = this._model.isEnableBtn;
                this.assignPlayer.useHandCursor = this._model.isEnableBtn;
            }
            this.updateFocus();
            this.playersList.headerDP = new DataProvider(App.utils.data.vectorToArray(this._model.tableHeader));
            this.playersCounts.htmlText = this._model.countLabel;
            this.updateTableList();
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.playersList.uniqKeyForAutoSelect = INT_TOTAL_MINING;
        this.soldierIcon.source = RES_ICONS.MAPS_ICONS_BUTTONS_FOOTHOLD;
        this.toolTipArea.addEventListener(MouseEvent.ROLL_OVER, this.onToolTipAreaRollOverHandler);
        this.toolTipArea.addEventListener(MouseEvent.ROLL_OUT, this.onToolTipAreaRollOutHandler);
        this.playersList.addEventListener(SortableTableListEvent.RENDERER_CLICK, this.onPlayersListRendererClickHandler);
        this.assignPlayer.addEventListener(ButtonEvent.CLICK, this.onAssignPlayerClickHandler);
    }

    override protected function onSetModalFocus(param1:InteractiveObject):void {
        super.onSetModalFocus(param1);
        this.updateFocus();
    }

    public function as_setWindowTitle(param1:String):void {
        window.title = param1;
    }

    private function updateFocus():void {
        if (this.assignPlayer.visible && this.assignPlayer.enabled) {
            setFocus(InteractiveObject(this.assignPlayer));
        }
        else {
            setFocus(window.getCloseBtn());
        }
    }

    private function updateTableList():void {
        this.playersList.listDP = new DataProvider(this._model.rosters);
        this.playersList.sortByField(INT_TOTAL_MINING, SortingInfo.DESCENDING_SORT);
        this.playersList.scrollListToItemByUniqKey(HIMSELF, true);
    }

    private function onPlayersListRendererClickHandler(param1:SortableTableListEvent):void {
        if (param1.buttonIdx == MouseEventEx.RIGHT_BUTTON) {
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.BASE_USER, this, param1.itemData);
        }
        else {
            App.contextMenuMgr.hide();
        }
    }

    private function onAssignPlayerClickHandler(param1:ButtonEvent):void {
        App.eventLogManager.logUIEvent(param1, this._model.buildingId);
        assignToBuildingS();
    }

    private function onToolTipAreaRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(this._model.generalTooltipData);
    }

    private function onToolTipAreaRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }
}
}
