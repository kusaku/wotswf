package net.wg.gui.lobby.hangar {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.data.constants.Directions;
import net.wg.data.constants.IconsTypes;
import net.wg.gui.components.controls.IconText;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.tooltips.helpers.TankTypeIco;
import net.wg.infrastructure.base.meta.IResearchPanelMeta;
import net.wg.infrastructure.base.meta.impl.ResearchPanelMeta;
import net.wg.utils.helpLayout.HelpLayoutVO;
import net.wg.utils.helpLayout.IHelpLayoutComponent;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class ResearchPanel extends ResearchPanelMeta implements IResearchPanelMeta, IHelpLayoutComponent {

    private static const HELP_LAYOUT_W_CORRECTION:int = -1;

    private static const ELITE_VEHICLE_HORIZONTAL_OFFSET:int = -32;

    private static const REGULAR_VEHICLE_HORIZONTAL_OFFSET:int = -22;

    private static const ELITE_POSTFIX:String = "_elite";

    public var tankTypeIco:TankTypeIco = null;

    public var tankName:TextField = null;

    public var tankDescr:TextField = null;

    public var button:SoundButtonEx = null;

    public var xpText:IconText = null;

    public var premIGRBg:Sprite = null;

    public var bg:MovieClip = null;

    private var _vehicleName:String = null;

    private var _vehicleType:String = null;

    private var _vDescription:String = null;

    private var _earnedXP:Number = 0;

    private var _isElite:Boolean = false;

    private var _isPremIGR:Boolean;

    private var _helpLayoutId:String = null;

    private var _helpLayoutW:Number = 0;

    public function ResearchPanel() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.mouseEnabled = false;
        this.bg.mouseEnabled = false;
        this.bg.mouseChildren = false;
        this.premIGRBg.mouseEnabled = this.premIGRBg.mouseChildren = false;
        App.utils.helpLayout.registerComponent(this);
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.xpText.focusable = false;
        this.xpText.mouseChildren = false;
        this.button.addEventListener(ButtonEvent.CLICK, this.onButtonClickHandler);
        this.button.label = MENU.UNLOCKS_UNLOCKBUTTON;
        this.button.tooltip = TOOLTIPS.HANGAR_UNLOCKBUTTON;
    }

    override protected function onDispose():void {
        this.xpText.dispose();
        this.xpText = null;
        this.button.removeEventListener(ButtonEvent.CLICK, this.onButtonClickHandler);
        this.button.dispose();
        this.button = null;
        this._helpLayoutId = null;
        this.premIGRBg = null;
        this.tankTypeIco.dispose();
        this.tankTypeIco = null;
        this.tankName = null;
        this.tankDescr = null;
        this.bg = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            this.tankTypeIco.type = !!this._isElite ? this._vehicleType + ELITE_POSTFIX : this._vehicleType;
            this.tankTypeIco.x = !!this._isElite ? Number(ELITE_VEHICLE_HORIZONTAL_OFFSET) : Number(REGULAR_VEHICLE_HORIZONTAL_OFFSET);
            this.tankName.htmlText = this._vehicleName;
            this.tankDescr.htmlText = this._vDescription;
            this.xpText.text = App.utils != null ? App.utils.locale.integer(this._earnedXP) : this._earnedXP.toString();
            this.xpText.icon = !!this._isElite ? IconsTypes.ELITE_XP : IconsTypes.XP;
            this.premIGRBg.visible = this._isPremIGR;
        }
    }

    public function as_setEarnedXP(param1:Number):void {
        if (this._earnedXP == param1) {
            return;
        }
        this._earnedXP = param1;
        invalidateData();
    }

    public function as_setElite(param1:Boolean):void {
        if (this._isElite == param1) {
            return;
        }
        this._isElite = param1;
        invalidateData();
    }

    public function as_updateCurrentVehicle(param1:String, param2:String, param3:String, param4:Number, param5:Boolean, param6:Boolean):void {
        this._vehicleName = param1;
        this._vehicleType = param2;
        this._vDescription = param3;
        this._earnedXP = param4;
        this._isElite = param5;
        this._isPremIGR = param6;
        invalidateData();
    }

    public function getHelpLayoutWidth():Number {
        return this.bg.width + this.bg.x - (this.tankTypeIco.x - this.tankTypeIco.width);
    }

    public function getLayoutProperties():Vector.<HelpLayoutVO> {
        if (!this._helpLayoutId) {
            this._helpLayoutId = name + "_" + Math.random();
        }
        var _loc1_:HelpLayoutVO = new HelpLayoutVO();
        _loc1_.x = this.bg.x + this.bg.width - this._helpLayoutW;
        _loc1_.y = 0;
        _loc1_.width = this._helpLayoutW + HELP_LAYOUT_W_CORRECTION;
        _loc1_.height = this.bg.height;
        _loc1_.extensibilityDirection = Directions.RIGHT;
        _loc1_.message = LOBBY_HELP.HANGAR_VEHRESEARCHPANEL;
        _loc1_.id = this._helpLayoutId;
        _loc1_.scope = this;
        return new <HelpLayoutVO>[_loc1_];
    }

    public function showHelpLayoutEx(param1:Number, param2:Number):void {
        this._helpLayoutW = param2;
    }

    private function onButtonClickHandler(param1:ButtonEvent):void {
        goToResearchS();
    }
}
}
