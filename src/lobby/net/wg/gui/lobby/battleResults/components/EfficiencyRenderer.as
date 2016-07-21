package net.wg.gui.lobby.battleResults.components {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFormat;

import net.wg.data.VO.UserVO;
import net.wg.data.constants.generated.BATTLE_EFFICIENCY_TYPES;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.components.controls.UserNameField;
import net.wg.gui.events.FinalStatisticEvent;

import scaleform.clik.core.UIComponent;
import scaleform.clik.data.ListData;
import scaleform.clik.interfaces.IListItemRenderer;

public class EfficiencyRenderer extends UIComponent implements IListItemRenderer {

    public var fakeBg:MovieClip;

    public var playerName:UserNameField;

    public var vehicleIcon:UILoaderAlt;

    public var groupLabelTF:TextField = null;

    public var baseNameTF:TextField = null;

    public var vehicleName:TextField;

    public var killIcon:EfficiencyIconRenderer;

    public var damageIcon:EfficiencyIconRenderer;

    public var critsIcon:EfficiencyIconRenderer;

    public var evilIcon:EfficiencyIconRenderer;

    public var spottedIcon:EfficiencyIconRenderer;

    public var armorIcon:EfficiencyIconRenderer;

    public var baseCaptureIcon:EfficiencyIconRenderer;

    public var baseDefenceIcon:EfficiencyIconRenderer;

    public var deadBg:MovieClip;

    protected var _owner:UIComponent = null;

    protected var _index:uint = 0;

    protected var _selectable:Boolean = false;

    protected var _selected:Boolean = false;

    private var _data:Object;

    private var _dataDirty:Boolean = false;

    private var _isMouseOver:Boolean = false;

    private var _icons:Vector.<EfficiencyIconRenderer>;

    private var _iconsLength:uint = 0;

    private var _defenceIconX:int = 0;

    public function EfficiencyRenderer() {
        super();
        this._icons = new <EfficiencyIconRenderer>[this.killIcon, this.damageIcon, this.critsIcon, this.evilIcon, this.spottedIcon, this.armorIcon, this.baseCaptureIcon, this.baseDefenceIcon];
        this._iconsLength = this._icons.length;
        this._defenceIconX = this.baseDefenceIcon.x;
    }

    private static function getVehIconFilter():ColorMatrixFilter {
        var _loc1_:ColorMatrixFilter = new ColorMatrixFilter();
        var _loc2_:Array = [0.4, 0, 0, 0, 0];
        var _loc3_:Array = [0, 0.4, 0, 0, 0];
        var _loc4_:Array = [0, 0, 0.4, 0, 0];
        var _loc5_:Array = [0, 0, 0, 1, 0];
        var _loc6_:Array = [];
        _loc6_ = _loc6_.concat(_loc2_);
        _loc6_ = _loc6_.concat(_loc3_);
        _loc6_ = _loc6_.concat(_loc4_);
        _loc6_ = _loc6_.concat(_loc5_);
        _loc1_.matrix = _loc6_;
        return _loc1_;
    }

    override protected function configUI():void {
        var _loc1_:EfficiencyIconRenderer = null;
        super.configUI();
        focusTarget = this.owner;
        _focusable = tabEnabled = tabChildren = false;
        mouseChildren = true;
        var _loc2_:int = 0;
        while (_loc2_ < this._iconsLength) {
            _loc1_ = this._icons[_loc2_];
            _loc1_.visible = false;
            _loc1_.addEventListener(MouseEvent.ROLL_OVER, this.onIconRollHandler);
            _loc1_.addEventListener(MouseEvent.ROLL_OUT, this.onIconRollHandler);
            _loc2_++;
        }
    }

    override protected function onDispose():void {
        var _loc1_:EfficiencyIconRenderer = null;
        var _loc2_:int = 0;
        while (_loc2_ < this._iconsLength) {
            _loc1_ = this._icons[_loc2_];
            _loc1_.removeEventListener(MouseEvent.ROLL_OVER, this.onIconRollHandler);
            _loc1_.removeEventListener(MouseEvent.ROLL_OUT, this.onIconRollHandler);
            _loc1_.dispose();
            _loc2_++;
        }
        this._icons.splice(0, this._iconsLength);
        this._icons = null;
        this.playerName.dispose();
        this.vehicleIcon.dispose();
        this.groupLabelTF = null;
        this.baseNameTF = null;
        this.fakeBg = null;
        this._data = null;
        this._owner = null;
        this.playerName = null;
        this.vehicleIcon = null;
        this.vehicleName = null;
        this.killIcon = null;
        this.damageIcon = null;
        this.critsIcon = null;
        this.evilIcon = null;
        this.spottedIcon = null;
        this.armorIcon = null;
        this.baseCaptureIcon = null;
        this.baseDefenceIcon = null;
        this.deadBg = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (this._dataDirty) {
            if (this._data != null) {
                if (this._data.groupLabel) {
                    this.setGroupLabelData();
                }
                else if (!this._data.groupLabel && !this._data.baseLabel) {
                    this.setTechniquesData();
                    this.checkMouseOverOnScroll();
                }
                else {
                    this.setBasesData();
                    this.checkMouseOverOnScroll();
                }
            }
            this.visible = this._data != null;
            this._dataDirty = false;
        }
    }

    public function getData():Object {
        return this._data;
    }

    public function setData(param1:Object):void {
        this._data = param1;
        if (param1 != null) {
            if (this._data.hoveredKind) {
                this._data.hoveredKind = null;
            }
        }
        this._dataDirty = true;
        mouseEnabled = false;
        invalidate();
    }

    public function setListData(param1:ListData):void {
        this.index = param1.index;
        this.selected = param1.selected;
    }

    private function setGroupLabelData():void {
        this.hideIcons();
        this.vehicleIcon.visible = false;
        this.deadBg.visible = false;
        this.fakeBg.visible = false;
        this.vehicleName.visible = false;
        this.playerName.visible = false;
        this.baseNameTF.visible = false;
        this.groupLabelTF.visible = true;
        this.groupLabelTF.htmlText = this._data.groupLabel;
    }

    private function setTechniquesData():void {
        this.groupLabelTF.visible = false;
        this.playerName.visible = true;
        this.playerName.textColor = 13224374;
        this.vehicleName.textColor = 13224374;
        this.vehicleIcon.visible = !this._data.isFake;
        this.deadBg.visible = false;
        this.fakeBg.visible = this._data.isFake;
        this.vehicleName.visible = !this._data.isFake;
        this.killIcon.visible = !this._data.isFake;
        this.armorIcon.visible = !this._data.isFake && !this._data.isAlly;
        this.damageIcon.visible = !this._data.isFake && !this._data.isAlly;
        this.critsIcon.visible = !this._data.isFake && !this._data.isAlly;
        this.evilIcon.visible = !this._data.isFake && !this._data.isAlly;
        this.spottedIcon.visible = !this._data.isFake && !this._data.isAlly;
        this.baseCaptureIcon.visible = false;
        this.baseDefenceIcon.visible = false;
        this.baseNameTF.visible = false;
        this.playerName.userVO = new UserVO({
            "fullName": this._data.playerFullName,
            "userName": this._data.playerName,
            "clanAbbrev": this._data.playerClan,
            "region": this._data.playerRegion
        });
        var _loc1_:TextFormat = this.playerName.textField.getTextFormat();
        if (this._data.isFake) {
            _loc1_.align = "left";
            _loc1_.leftMargin = 15;
            this.playerName.textField.setTextFormat(_loc1_);
        }
        else {
            _loc1_.align = "right";
            _loc1_.leftMargin = 0;
            this.playerName.textField.setTextFormat(_loc1_);
            this.vehicleIcon.source = this._data.tankIcon;
            this.vehicleName.htmlText = this._data.vehicleName;
            this.damageIcon.enabled = false;
            this.critsIcon.enabled = false;
            this.evilIcon.enabled = false;
            this.spottedIcon.enabled = false;
            this.armorIcon.enabled = false;
            this.killIcon.enabled = false;
            this.killIcon.kind = !!this._data.isAlly ? BATTLE_EFFICIENCY_TYPES.TEAM_DESTRUCTION : BATTLE_EFFICIENCY_TYPES.DESTRUCTION;
            this.killIcon.enabled = this._data.killCount > 0;
            this.killIcon.value = this._data.killCount;
            if (this._data.deathReason > -1) {
                this.playerName.textColor = 6381391;
                this.vehicleName.textColor = 6381391;
                this.deadBg.visible = true;
                this.vehicleIcon.filters = [getVehIconFilter()];
            }
            else {
                this.vehicleIcon.filters = [];
            }
            if (this._data.damageDealt > 0) {
                this.damageIcon.enabled = true;
                this.damageIcon.value = this._data.piercings;
            }
            if (this._data.critsCount > 0) {
                this.critsIcon.enabled = true;
                this.critsIcon.value = this._data.critsCount;
            }
            if (this._data.armorTotalItems > 0) {
                this.armorIcon.enabled = true;
                this.armorIcon.value = this._data.armorTotalItems;
            }
            this.evilIcon.enabled = this._data.damageAssisted > 0;
            this.spottedIcon.enabled = this._data.spotted > 0;
        }
    }

    private function setBasesData():void {
        this.groupLabelTF.visible = false;
        this.vehicleIcon.visible = false;
        this.deadBg.visible = false;
        this.fakeBg.visible = false;
        this.vehicleName.visible = false;
        this.playerName.visible = false;
        this.baseNameTF.visible = true;
        this.baseNameTF.htmlText = this._data.baseLabel;
        this.hideIcons();
        this.baseCaptureIcon.visible = this._data.captureVals >= 0;
        this.baseDefenceIcon.visible = this._data.defenceVals >= 0;
        this.baseCaptureIcon.enabled = this._data.captureVals > 0;
        this.baseDefenceIcon.enabled = this._data.defenceVals > 0;
        this.baseDefenceIcon.x = !!this.baseCaptureIcon.visible ? Number(this._defenceIconX) : Number(this.baseCaptureIcon.x);
    }

    private function hideIcons():void {
        var _loc1_:EfficiencyIconRenderer = null;
        var _loc2_:int = 0;
        while (_loc2_ < this._iconsLength) {
            _loc1_ = this._icons[_loc2_];
            _loc1_.visible = false;
            _loc2_++;
        }
    }

    private function checkMouseOverOnScroll():void {
        var _loc2_:EfficiencyIconRenderer = null;
        var _loc1_:Point = new Point(mouseX, mouseY);
        _loc1_ = this.localToGlobal(_loc1_);
        var _loc3_:int = 0;
        while (_loc3_ < this._iconsLength) {
            _loc2_ = this._icons[_loc3_];
            if (_loc2_.hitTestPoint(_loc1_.x, _loc1_.y, true) && this._isMouseOver) {
                this._data.isDisabled = !_loc2_.enabled;
                this._data.hoveredKind = _loc2_.kind;
                dispatchEvent(new FinalStatisticEvent(FinalStatisticEvent.EFFICIENCY_ICON_ROLL_OVER, this._data));
            }
            _loc3_++;
        }
    }

    public function get owner():UIComponent {
        return this._owner;
    }

    public function set owner(param1:UIComponent):void {
        this._owner = param1;
    }

    public function get index():uint {
        return this._index;
    }

    public function set index(param1:uint):void {
        this._index = param1;
    }

    public function get selectable():Boolean {
        return this._selectable;
    }

    public function set selectable(param1:Boolean):void {
        this._selectable = param1;
    }

    public function get selected():Boolean {
        return this._selected;
    }

    public function set selected(param1:Boolean):void {
        if (this._selected == param1) {
            return;
        }
        this._selected = param1;
    }

    private function onIconRollHandler(param1:MouseEvent):void {
        if (param1.type == MouseEvent.ROLL_OVER) {
            this._data.isDisabled = !param1.target.enabled;
            this._data.hoveredKind = param1.target.kind;
            dispatchEvent(new FinalStatisticEvent(FinalStatisticEvent.EFFICIENCY_ICON_ROLL_OVER, this._data));
            this._isMouseOver = true;
        }
        else {
            dispatchEvent(new FinalStatisticEvent(FinalStatisticEvent.EFFICIENCY_ICON_ROLL_OUT));
            this._isMouseOver = false;
        }
    }
}
}
