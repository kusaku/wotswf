package net.wg.gui.battle.random.views.stats.components.playersPanel.panelSwitch {
import net.wg.data.constants.BattleAtlasItem;
import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
import net.wg.gui.battle.components.BattleAtlasSprite;
import net.wg.gui.battle.components.BattleUIComponent;
import net.wg.gui.battle.components.buttons.interfaces.IClickButtonHandler;
import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelSwitchEvent;

public class PlayersPanelSwitch extends BattleUIComponent implements IClickButtonHandler {

    private static const DISABLED_ALPHA:Number = 0.5;

    public var bgMC:BattleAtlasSprite = null;

    public var hidenBt:PlayersPanelSwitchButton = null;

    public var shortBt:PlayersPanelSwitchButton = null;

    public var mediumBt:PlayersPanelSwitchButton = null;

    public var longBt:PlayersPanelSwitchButton = null;

    public var fullBt:PlayersPanelSwitchButton = null;

    private var _state:int = 0;

    private var _isInteractive:Boolean = false;

    private var _selectedBt:PlayersPanelSwitchButton = null;

    public function PlayersPanelSwitch() {
        super();
        alpha = DISABLED_ALPHA;
        this._state = PLAYERS_PANEL_STATE.NONE;
        this.hidenBt.tooltipStr = INGAME_GUI.PLAYERS_PANEL_STATE_NONE;
        this.shortBt.tooltipStr = INGAME_GUI.PLAYERS_PANEL_STATE_SHORT;
        this.mediumBt.tooltipStr = INGAME_GUI.PLAYERS_PANEL_STATE_MEDIUM;
        this.longBt.tooltipStr = INGAME_GUI.PLAYERS_PANEL_STATE_MEDIUM2;
        this.fullBt.tooltipStr = INGAME_GUI.PLAYERS_PANEL_STATE_LARGE;
    }

    public function setState(param1:int):void {
        if (param1 == this._state) {
            return;
        }
        if (this._selectedBt) {
            this._selectedBt.selected = false;
        }
        if (param1 == PLAYERS_PANEL_STATE.HIDEN) {
            this._selectedBt = this.hidenBt;
        }
        else if (param1 == PLAYERS_PANEL_STATE.SHORT) {
            this._selectedBt = this.shortBt;
        }
        else if (param1 == PLAYERS_PANEL_STATE.MEDIUM) {
            this._selectedBt = this.mediumBt;
        }
        else if (param1 == PLAYERS_PANEL_STATE.LONG) {
            this._selectedBt = this.longBt;
        }
        else if (param1 == PLAYERS_PANEL_STATE.FULL) {
            this._selectedBt = this.fullBt;
        }
        else {
            throw new Error("setting of invalid state \'" + param1 + "\'");
        }
        this._selectedBt.selected = true;
        this._state = param1;
    }

    public function setIsInteractive(param1:Boolean):void {
        if (this._isInteractive == param1) {
            return;
        }
        alpha = !!param1 ? Number(1) : Number(DISABLED_ALPHA);
        if (param1) {
            this.hidenBt.addClickCallBack(this);
            this.shortBt.addClickCallBack(this);
            this.mediumBt.addClickCallBack(this);
            this.longBt.addClickCallBack(this);
            this.fullBt.addClickCallBack(this);
        }
        this._isInteractive = param1;
    }

    override protected function configUI():void {
        super.configUI();
        this.bgMC.imageName = BattleAtlasItem.PLAYERS_PANEL_SWITCH_BG;
        this.hidenBt.panelState = PLAYERS_PANEL_STATE.HIDEN;
        this.shortBt.panelState = PLAYERS_PANEL_STATE.SHORT;
        this.mediumBt.panelState = PLAYERS_PANEL_STATE.MEDIUM;
        this.longBt.panelState = PLAYERS_PANEL_STATE.LONG;
        this.fullBt.panelState = PLAYERS_PANEL_STATE.FULL;
        if (this._state == PLAYERS_PANEL_STATE.NONE) {
            this.setState(PLAYERS_PANEL_STATE.FULL);
        }
    }

    override protected function onDispose():void {
        this.setIsInteractive(false);
        this.hidenBt.dispose();
        this.shortBt.dispose();
        this.mediumBt.dispose();
        this.longBt.dispose();
        this.fullBt.dispose();
        this.bgMC = null;
        this.hidenBt = null;
        this.shortBt = null;
        this.mediumBt = null;
        this.longBt = null;
        this.fullBt = null;
        this._selectedBt = null;
        super.onDispose();
    }

    public function onButtonClick(param1:Object):void {
        if (param1.name == this.hidenBt.name) {
            this.handleBtClick(PLAYERS_PANEL_STATE.HIDEN);
        }
        else if (param1.name == this.shortBt.name) {
            this.handleBtClick(PLAYERS_PANEL_STATE.SHORT);
        }
        else if (param1.name == this.mediumBt.name) {
            this.handleBtClick(PLAYERS_PANEL_STATE.MEDIUM);
        }
        else if (param1.name == this.longBt.name) {
            this.handleBtClick(PLAYERS_PANEL_STATE.LONG);
        }
        else if (param1.name == this.fullBt.name) {
            this.handleBtClick(PLAYERS_PANEL_STATE.FULL);
        }
    }

    private function handleBtClick(param1:int):void {
        dispatchEvent(new PlayersPanelSwitchEvent(PlayersPanelSwitchEvent.STATE_REQUESTED, param1));
    }
}
}
