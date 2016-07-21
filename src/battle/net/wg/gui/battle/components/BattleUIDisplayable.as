package net.wg.gui.battle.components {
import net.wg.gui.battle.components.interfaces.IBattleDisplayable;
import net.wg.infrastructure.base.BaseDAAPIComponent;

public class BattleUIDisplayable extends BaseDAAPIComponent implements IBattleDisplayable {

    protected var _isCompVisible:Boolean = true;

    public function BattleUIDisplayable() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this._isCompVisible = visible;
    }

    public function setCompVisible(param1:Boolean):void {
        if (this._isCompVisible != param1) {
            this._isCompVisible = param1;
            this.updateVisibility();
        }
    }

    protected function updateVisibility():void {
        visible = this._isCompVisible;
    }
}
}
