package net.wg.gui.cyberSport.controls {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.Image;
import net.wg.gui.components.controls.TableRenderer;
import net.wg.gui.components.controls.helpers.UserInfoTextLoadingController;
import net.wg.gui.cyberSport.vo.CSCommandVO;
import net.wg.gui.rally.interfaces.IManualSearchRenderer;
import net.wg.infrastructure.interfaces.IUserProps;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;

public class ManualSearchRenderer extends TableRenderer implements IManualSearchRenderer {

    private static const ICONS_GAP:Number = 6;

    public var commander:TextField = null;

    public var commandDescr:TextField = null;

    public var commandSize:TextField = null;

    public var commandMaxSize:TextField = null;

    public var effency:TextField = null;

    public var freezeIcon:MovieClip;

    public var restrictionIcon:MovieClip;

    public var inBattleMC:MovieClip;

    public var ladderIcon:Image;

    private var _userInfoTextLoadingController:UserInfoTextLoadingController = null;

    private var _creatorName:String = null;

    private var _originalDescrWidth:Number;

    private var _originalDescrX:Number;

    private var _isHovered:Boolean;

    public function ManualSearchRenderer() {
        super();
        preventAutosizing = true;
        this._userInfoTextLoadingController = new UserInfoTextLoadingController();
    }

    override public function setData(param1:Object):void {
        this.data = param1;
        invalidateData();
    }

    override protected function configUI():void {
        super.configUI();
        this._originalDescrWidth = this.commandDescr.width;
        this._originalDescrX = this.commandDescr.x;
        this.commander.mouseEnabled = false;
        this.commandSize.mouseEnabled = false;
        this.commandMaxSize.mouseEnabled = false;
        this.effency.mouseEnabled = false;
        this.inBattleMC.mouseEnabled = false;
        this.freezeIcon.useHandCursor = this.freezeIcon.buttonMode = true;
        this.restrictionIcon.useHandCursor = this.restrictionIcon.buttonMode = true;
        this.freezeIcon.addEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
        this.freezeIcon.addEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.restrictionIcon.addEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
        this.restrictionIcon.addEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this._userInfoTextLoadingController.setControlledUserNameTextField(this.commander);
        this._userInfoTextLoadingController.setControlledUserRatingTextField(this.effency);
    }

    override protected function onDispose():void {
        this.freezeIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
        this.freezeIcon.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.restrictionIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
        this.restrictionIcon.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        this.ladderIcon.dispose();
        this.commander = null;
        this.commandDescr = null;
        this.commandSize = null;
        this.commandMaxSize = null;
        this.effency = null;
        this.ladderIcon = null;
        this.freezeIcon = null;
        this.restrictionIcon = null;
        this.inBattleMC = null;
        this._userInfoTextLoadingController.dispose();
        this._userInfoTextLoadingController = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:CSCommandVO = null;
        mouseEnabled = true;
        mouseChildren = true;
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            if (data) {
                _loc1_ = CSCommandVO(data);
                this.visible = true;
                this.populateUI(_loc1_);
                startSimulationDoubleClick();
            }
            else {
                this.visible = false;
                stopSimulationDoubleClick();
            }
            if (this._isHovered) {
                this.showToolTip();
            }
        }
    }

    public function update(param1:Object):void {
        this.data = param1;
        if (this.data) {
            this.populateUI(CSCommandVO(param1));
        }
    }

    protected function showToolTip():void {
        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CYBER_SPORT_TEAM, null, _data);
    }

    protected function populateUI(param1:CSCommandVO):void {
        var _loc2_:String = null;
        var _loc4_:IUserProps = null;
        if (param1.creator) {
            _loc4_ = App.utils.commons.getUserProps(param1.creator.userName, param1.creator.clanAbbrev, param1.creator.region, param1.creator.igrType);
            _loc4_.rgb = param1.creator.color;
            this._userInfoTextLoadingController.setUserNameFromProps(_loc4_);
            _loc2_ = this.commander.htmlText;
        }
        else {
            _loc2_ = "";
        }
        if (this._creatorName != _loc2_) {
            this._creatorName = _loc2_;
        }
        _loc2_ = param1.rating;
        if (_loc2_ != this.effency.text) {
            this._userInfoTextLoadingController.setUserRatingHtmlText(_loc2_);
        }
        _loc2_ = String(param1.playersCount);
        if (_loc2_ != this.commandSize.text) {
            this.commandSize.text = _loc2_;
        }
        _loc2_ = "/" + String(param1.commandSize);
        if (_loc2_ != this.commandMaxSize.text) {
            this.commandMaxSize.text = _loc2_;
        }
        if (this.ladderIcon.visible = StringUtils.isNotEmpty(param1.ladderIcon)) {
            this.ladderIcon.source = param1.ladderIcon;
        }
        var _loc3_:int = this.freezeIcon.x;
        this.freezeIcon.visible = param1.isFreezed;
        _loc3_ = _loc3_ + (!!this.freezeIcon.visible ? this.freezeIcon.width + ICONS_GAP : 0);
        this.restrictionIcon.visible = param1.isRestricted;
        this.restrictionIcon.x = _loc3_;
        _loc3_ = _loc3_ + (!!this.restrictionIcon.visible ? this.restrictionIcon.width + ICONS_GAP : 0);
        this.inBattleMC.visible = param1.inBattle;
        this.inBattleMC.x = _loc3_;
        _loc3_ = _loc3_ + (!!this.inBattleMC.visible ? this.inBattleMC.width + ICONS_GAP : 0);
        this.commandDescr.x = _loc3_;
        this.commandDescr.width = this._originalDescrWidth - (_loc3_ - this._originalDescrX);
        _loc4_ = App.utils.commons.getUserProps(param1.description, null, null, 0);
        App.utils.commons.formatPlayerName(this.commandDescr, _loc4_);
    }

    override public function set enabled(param1:Boolean):void {
        super.enabled = param1;
        mouseEnabled = true;
        mouseChildren = true;
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        this._isHovered = true;
        super.handleMouseRollOver(param1);
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        this._isHovered = false;
        App.toolTipMgr.hide();
        super.handleMouseRollOut(param1);
    }

    private function onControlRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(param1.currentTarget == this.freezeIcon ? TOOLTIPS.SETTINGSICON_FREEZED : TOOLTIPS.SETTINGSICON_CONDITIONS);
    }

    private function onControlRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
        if (this._isHovered) {
            this.showToolTip();
        }
    }
}
}
