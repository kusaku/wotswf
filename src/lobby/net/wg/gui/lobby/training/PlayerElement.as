package net.wg.gui.lobby.training {
import flash.geom.ColorTransform;
import flash.text.TextField;

import net.wg.data.VO.TrainingRoomRendererVO;
import net.wg.data.constants.UserTags;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.components.controls.UserNameField;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.entity.IUpdatable;

import scaleform.clik.constants.InvalidationType;

public class PlayerElement extends UIComponentEx implements IUpdatable {

    private static const GOLD_COLOR:Number = 16761699;

    private static const NAME_COLOR:Number = 13224374;

    private static const VEHICLE_COLOR:Number = 8092009;

    public var iconLoader:UILoaderAlt = null;

    public var nameField:UserNameField = null;

    public var vehicleField:TextField = null;

    public var vehicleLevelField:TextField = null;

    public var stateField:TextField = null;

    private var _data:TrainingRoomRendererVO = null;

    private var _defColorTrans:ColorTransform = null;

    public function PlayerElement() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this._defColorTrans = this.iconLoader.transform.colorTransform;
    }

    override protected function onDispose():void {
        this.iconLoader.dispose();
        this.iconLoader = null;
        this.nameField.dispose();
        this.nameField = null;
        this.vehicleField = null;
        this.vehicleLevelField = null;
        this.stateField = null;
        this._data = null;
        this._defColorTrans = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:ColorTransform = null;
        if (isInvalid(InvalidationType.DATA)) {
            if (this._data) {
                this.nameField.userVO = this._data;
                this.vehicleField.htmlText = this._data.vShortName;
                this.stateField.text = this._data.stateString;
                this.vehicleLevelField.text = this._data.vLevel;
                this.iconLoader.visible = true;
                if (this.iconLoader.source != this._data.icon) {
                    this.iconLoader.source = this._data.icon;
                }
                enabled = true;
                this.nameField.textColor = NAME_COLOR;
                this.vehicleField.textColor = VEHICLE_COLOR;
                _loc1_ = new ColorTransform();
                if (!enabled) {
                    _loc1_.alphaMultiplier = 0.7;
                    _loc1_.redMultiplier = 0.1;
                    _loc1_.blueMultiplier = 0.1;
                    _loc1_.greenMultiplier = 0.1;
                }
                else if (UserTags.isCurrentPlayer(this._data.tags)) {
                    this.nameField.textColor = GOLD_COLOR;
                    this.vehicleField.textColor = GOLD_COLOR;
                    _loc1_.redOffset = 21;
                    _loc1_.greenOffset = 9;
                    _loc1_.blueMultiplier = 0.51;
                    _loc1_.greenMultiplier = 0.87;
                }
                else {
                    _loc1_ = this._defColorTrans;
                }
                this.iconLoader.transform.colorTransform = _loc1_;
            }
            else {
                this.nameField.userVO = null;
                this.vehicleField.text = "";
                this.vehicleLevelField.text = "";
                this.iconLoader.visible = false;
                enabled = false;
            }
        }
    }

    public function update(param1:Object):void {
        if (param1 && param1 != this._data) {
            this._data = TrainingRoomRendererVO(param1);
            invalidate(InvalidationType.DATA);
        }
    }
}
}
