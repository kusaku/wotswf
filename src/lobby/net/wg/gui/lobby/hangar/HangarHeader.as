package net.wg.gui.lobby.hangar {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.Directions;
import net.wg.gui.components.tooltips.helpers.TankTypeIco;
import net.wg.gui.interfaces.IButtonIconLoader;
import net.wg.gui.lobby.hangar.data.HangarHeaderVO;
import net.wg.infrastructure.base.meta.IHangarHeaderMeta;
import net.wg.infrastructure.base.meta.impl.HangarHeaderMeta;
import net.wg.infrastructure.managers.ITooltipMgr;
import net.wg.utils.helpLayout.HelpLayoutVO;
import net.wg.utils.helpLayout.IHelpLayoutComponent;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class HangarHeader extends HangarHeaderMeta implements IHangarHeaderMeta, IHelpLayoutComponent {

    private static const ICON_OFFSET_TOP:Number = -16;

    private static const ICON_OFFSET_LEFT:Number = 1;

    private static const SEPARATOR:String = "_";

    public var tankTypeIcon:TankTypeIco;

    public var txtTankInfo:TextField;

    public var btnCommonQuests:IButtonIconLoader;

    public var btnPersonalQuests:IButtonIconLoader;

    public var mcBackground:Sprite;

    public var premIGRBg:Sprite = null;

    private var _data:HangarHeaderVO;

    private var _tooltipMgr:ITooltipMgr;

    public function HangarHeader() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this._tooltipMgr = App.toolTipMgr;
        mouseEnabled = false;
        this.tankTypeIcon.mouseEnabled = this.tankTypeIcon.mouseChildren = false;
        this.mcBackground.mouseEnabled = this.mcBackground.mouseChildren = false;
        this.txtTankInfo.mouseEnabled = false;
        this.btnCommonQuests.iconOffsetTop = this.btnPersonalQuests.iconOffsetTop = ICON_OFFSET_TOP;
        this.btnCommonQuests.iconOffsetLeft = this.btnPersonalQuests.iconOffsetLeft = ICON_OFFSET_LEFT;
        this.btnCommonQuests.mouseEnabledOnDisabled = this.btnPersonalQuests.mouseEnabledOnDisabled = true;
        this.premIGRBg.mouseEnabled = this.premIGRBg.mouseChildren = false;
        App.utils.helpLayout.registerComponent(this);
        this.btnCommonQuests.addEventListener(ButtonEvent.CLICK, this.onBtnCommonQuestsClickHandler);
        this.btnCommonQuests.addEventListener(MouseEvent.ROLL_OVER, this.onBtnCommonQuestsRollOverHandler);
        this.btnCommonQuests.addEventListener(MouseEvent.ROLL_OUT, this.onBtnCommonQuestsRollOutHandler);
        this.btnPersonalQuests.addEventListener(ButtonEvent.CLICK, this.onBtnPersonalQuestsClickHandler);
        this.btnPersonalQuests.addEventListener(MouseEvent.ROLL_OVER, this.onBtnPersonalQuestsRollOverHandler);
        this.btnPersonalQuests.addEventListener(MouseEvent.ROLL_OUT, this.onBtnPersonalQuestsRollOutHandler);
    }

    override protected function onDispose():void {
        this.btnCommonQuests.removeEventListener(ButtonEvent.CLICK, this.onBtnCommonQuestsClickHandler);
        this.btnCommonQuests.removeEventListener(MouseEvent.ROLL_OVER, this.onBtnCommonQuestsRollOverHandler);
        this.btnCommonQuests.removeEventListener(MouseEvent.ROLL_OUT, this.onBtnCommonQuestsRollOutHandler);
        this.btnPersonalQuests.removeEventListener(MouseEvent.CLICK, this.onBtnPersonalQuestsClickHandler);
        this.btnPersonalQuests.removeEventListener(MouseEvent.ROLL_OVER, this.onBtnPersonalQuestsRollOverHandler);
        this.btnPersonalQuests.removeEventListener(MouseEvent.ROLL_OUT, this.onBtnPersonalQuestsRollOutHandler);
        this.btnCommonQuests.dispose();
        this.btnCommonQuests = null;
        this.btnPersonalQuests.dispose();
        this.btnPersonalQuests = null;
        this.tankTypeIcon.dispose();
        this.tankTypeIcon = null;
        this.premIGRBg = null;
        this.mcBackground = null;
        this.txtTankInfo = null;
        this._tooltipMgr = null;
        this._data = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            visible = this._data.isVisible;
            if (this._data.isVisible) {
                this.tankTypeIcon.type = this._data.tankType;
                this.txtTankInfo.htmlText = this._data.tankInfo;
                this.premIGRBg.visible = this._data.isPremIGR;
                this.btnCommonQuests.label = this._data.commonQuestsLabel;
                this.btnCommonQuests.iconSource = this._data.commonQuestsIcon;
                this.btnCommonQuests.enabled = this._data.commonQuestsEnable;
                this.btnPersonalQuests.label = this._data.personalQuestsLabel;
                this.btnPersonalQuests.iconSource = this._data.personalQuestsIcon;
                this.btnPersonalQuests.enabled = this._data.personalQuestsEnable;
            }
        }
    }

    override protected function setData(param1:HangarHeaderVO):void {
        this._data = param1;
        invalidateData();
    }

    public function getLayoutProperties():Vector.<HelpLayoutVO> {
        var _loc1_:HelpLayoutVO = new HelpLayoutVO();
        _loc1_.x = this.btnCommonQuests.x;
        _loc1_.y = this.btnCommonQuests.y;
        _loc1_.width = this.btnPersonalQuests.x + this.btnPersonalQuests.width - this.btnCommonQuests.x;
        _loc1_.height = this.btnCommonQuests.height;
        _loc1_.message = LOBBY_HELP.HANGAR_HEADER_QUESTS;
        _loc1_.extensibilityDirection = Directions.RIGHT;
        _loc1_.id = name + SEPARATOR + Math.random();
        _loc1_.scope = this;
        var _loc2_:HelpLayoutVO = new HelpLayoutVO();
        _loc2_.x = _loc1_.x + _loc1_.width;
        _loc2_.y = this.btnCommonQuests.y;
        _loc2_.width = this.txtTankInfo.x + this.txtTankInfo.textWidth - _loc2_.x;
        _loc2_.height = this.btnCommonQuests.height;
        _loc2_.message = LOBBY_HELP.HANGAR_HEADER_VEHICLE;
        _loc2_.extensibilityDirection = Directions.RIGHT;
        _loc2_.id = name + SEPARATOR + Math.random();
        _loc2_.scope = this;
        return new <HelpLayoutVO>[_loc1_, _loc2_];
    }

    private function onBtnCommonQuestsClickHandler(param1:Event):void {
        showCommonQuestsS();
    }

    private function onBtnPersonalQuestsClickHandler(param1:Event):void {
        showPersonalQuestsS();
    }

    private function onBtnCommonQuestsRollOverHandler(param1:MouseEvent):void {
        this._tooltipMgr.showComplex(this._data.commonQuestsTooltip);
    }

    private function onBtnPersonalQuestsRollOverHandler(param1:MouseEvent):void {
        this._tooltipMgr.showComplex(this._data.personalQuestsTooltip);
    }

    private function onBtnCommonQuestsRollOutHandler(param1:MouseEvent):void {
        this._tooltipMgr.hide();
    }

    private function onBtnPersonalQuestsRollOutHandler(param1:MouseEvent):void {
        this._tooltipMgr.hide();
    }
}
}
