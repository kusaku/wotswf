package net.wg.gui.battle.views.ribbonsPanel.containers {
import flash.display.Sprite;

import net.wg.data.constants.generated.BATTLE_EFFICIENCY_TYPES;
import net.wg.infrastructure.exceptions.ArgumentException;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class Icons extends Sprite implements IDisposable {

    public var crits:Sprite = null;

    public var assist:Sprite = null;

    public var spotted:Sprite = null;

    public var kill:Sprite = null;

    public var defence:Sprite = null;

    public var damage:Sprite = null;

    public var capture:Sprite = null;

    public var armor:Sprite = null;

    private var _currentIcon:Sprite = null;

    public function Icons() {
        super();
        this.crits.visible = false;
        this.assist.visible = false;
        this.spotted.visible = false;
        this.kill.visible = false;
        this.defence.visible = false;
        this.damage.visible = false;
        this.capture.visible = false;
        this.armor.visible = false;
        this._currentIcon = this.crits;
    }

    public function dispose():void {
        this._currentIcon = null;
        this.crits = null;
        this.assist = null;
        this.spotted = null;
        this.kill = null;
        this.defence = null;
        this.damage = null;
        this.capture = null;
        this.armor = null;
    }

    public function showIcon(param1:String):void {
        this._currentIcon.visible = false;
        switch (param1) {
            case BATTLE_EFFICIENCY_TYPES.CRITS:
                this._currentIcon = this.crits;
                break;
            case BATTLE_EFFICIENCY_TYPES.ASSIST:
                this._currentIcon = this.assist;
                break;
            case BATTLE_EFFICIENCY_TYPES.DETECTION:
                this._currentIcon = this.spotted;
                break;
            case BATTLE_EFFICIENCY_TYPES.DESTRUCTION:
                this._currentIcon = this.kill;
                break;
            case BATTLE_EFFICIENCY_TYPES.DEFENCE:
                this._currentIcon = this.defence;
                break;
            case BATTLE_EFFICIENCY_TYPES.DAMAGE:
                this._currentIcon = this.damage;
                break;
            case BATTLE_EFFICIENCY_TYPES.CAPTURE:
                this._currentIcon = this.capture;
                break;
            case BATTLE_EFFICIENCY_TYPES.ARMOR:
                this._currentIcon = this.armor;
                break;
            default:
                throw new ArgumentException("Icon type value is invalid: " + param1);
        }
        this._currentIcon.visible = true;
    }
}
}
