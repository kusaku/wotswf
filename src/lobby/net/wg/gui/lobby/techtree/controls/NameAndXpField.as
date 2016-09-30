package net.wg.gui.lobby.techtree.controls {
import flash.text.TextField;

import net.wg.gui.lobby.techtree.constants.XpTypeStrings;

import scaleform.clik.constants.InvalidationType;

public class NameAndXpField extends NodeComponent {

    private static const FIRST_COLUMN:int = 0;

    private static const SECOND_COLUMN:int = 1;

    private static const THIRD_COLUMN:int = 2;

    private static const STATES_MAP:Object = {
        "locked": ["locked", "locked", "locked"],
        "normal": ["normal_name", "normal_name_and_xp", "normal_name_and_xp_action"],
        "premium": ["premium_name", "premium_name_and_xp", "premium_name_and_xp_action"]
    };

    public var xpLabel:String = "earnedXPLabel";

    public var changeXpIconToElite:Boolean = false;

    public var nameField:TextField = null;

    public var xpField:TextField = null;

    public var xpIcon:XPIcon = null;

    private var _isInAction:Boolean = false;

    public function NameAndXpField() {
        super();
    }

    override protected function configUI():void {
        mouseEnabled = mouseChildren = false;
        super.configUI();
    }

    override protected function draw():void {
        var _loc1_:String = null;
        var _loc2_:int = 0;
        var _loc3_:String = null;
        if (_owner != null && isInvalid(InvalidationType.DATA)) {
            _loc1_ = this.xpLabel.length > 0 ? _owner.getNamedLabel(this.xpLabel) : "";
            _loc2_ = FIRST_COLUMN;
            if (_loc1_.length > 0 && !_owner.isButtonVisible()) {
                _loc2_ = !!this._isInAction ? int(THIRD_COLUMN) : int(SECOND_COLUMN);
            }
            _loc3_ = STATES_MAP[state][_loc2_];
            if (currentFrameLabel != _loc3_ && _labelHash[_loc3_]) {
                gotoAndStop(_loc3_);
                if (_baseDisposed) {
                    return;
                }
            }
            this.setNameField(_owner.getItemName());
            this.setXpField(_loc1_);
            if (this.changeXpIconToElite) {
                if (_owner.isElite()) {
                    this.setXpIcon(XpTypeStrings.ELITE_XP_TYPE);
                }
                else {
                    this.setXpIcon(XpTypeStrings.EARNED_XP_TYPE);
                }
            }
        }
        super.draw();
    }

    public function setIsInAction(param1:Boolean):void {
        this._isInAction = param1;
    }

    private function setNameField(param1:String):void {
        if (this.nameField != null && param1 != null) {
            this.nameField.htmlText = param1;
        }
    }

    private function setXpField(param1:String):void {
        if (this.xpField != null && param1 != null) {
            this.xpField.text = param1;
        }
    }

    private function setXpIcon(param1:String):void {
        if (this.xpIcon != null) {
            this.xpIcon.type = param1;
            this.xpIcon.validateNow();
        }
    }
}
}
