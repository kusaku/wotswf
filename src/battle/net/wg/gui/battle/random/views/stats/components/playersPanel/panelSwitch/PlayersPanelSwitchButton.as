package net.wg.gui.battle.random.views.stats.components.playersPanel.panelSwitch {
import net.wg.data.constants.BattleAtlasItem;
import net.wg.data.constants.InteractiveStates;
import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
import net.wg.gui.battle.components.BattleAtlasSprite;
import net.wg.gui.battle.components.buttons.BattleToolTipButton;

public class PlayersPanelSwitchButton extends BattleToolTipButton {

    private static const FRAME_NAME_SEPARATOR:String = "_";

    public var typeSP:BattleAtlasSprite = null;

    private var _selected:Boolean = false;

    private var _type:int = 0;

    public function PlayersPanelSwitchButton() {
        super();
        this._type = PLAYERS_PANEL_STATE.NONE;
    }

    public function get selected():Boolean {
        return this._selected;
    }

    public function set selected(param1:Boolean):void {
        if (this._selected == param1) {
            return;
        }
        this._selected = param1;
        state = _buttonState;
    }

    public function get panelState():int {
        return this._type;
    }

    public function set panelState(param1:int):void {
        if (this._type == param1) {
            return;
        }
        this._type = param1;
        var _loc2_:String = this.getStateImageName(param1);
        if (_loc2_) {
            this.typeSP.imageName = _loc2_;
        }
    }

    override protected function getFrameLabel(param1:String):String {
        return !!this._selected ? InteractiveStates.SELECTED + FRAME_NAME_SEPARATOR + param1 : param1;
    }

    override protected function onDispose():void {
        this.typeSP = null;
        super.onDispose();
    }

    private function getStateImageName(param1:int):String {
        switch (param1) {
            case PLAYERS_PANEL_STATE.HIDEN:
                return BattleAtlasItem.PLAYERS_PANEL_SWITCH_BT_HIDDEN;
            case PLAYERS_PANEL_STATE.SHORT:
                return BattleAtlasItem.PLAYERS_PANEL_SWITCH_BT_SHORT;
            case PLAYERS_PANEL_STATE.MEDIUM:
                return BattleAtlasItem.PLAYERS_PANEL_SWITCH_BT_MEDIUM;
            case PLAYERS_PANEL_STATE.LONG:
                return BattleAtlasItem.PLAYERS_PANEL_SWITCH_BT_LONG;
            case PLAYERS_PANEL_STATE.FULL:
                return BattleAtlasItem.PLAYERS_PANEL_SWITCH_BT_FULL;
            default:
                return null;
        }
    }
}
}
