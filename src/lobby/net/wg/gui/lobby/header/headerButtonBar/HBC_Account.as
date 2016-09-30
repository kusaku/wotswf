package net.wg.gui.lobby.header.headerButtonBar {
import net.wg.data.constants.ColorSchemeNames;
import net.wg.gui.components.advanced.ClanEmblem;
import net.wg.gui.components.advanced.interfaces.INewIndicator;
import net.wg.gui.components.controls.UserNameField;
import net.wg.gui.lobby.header.vo.HBC_AccountDataVo;

import org.idmedia.as3commons.util.StringUtils;

public class HBC_Account extends HeaderButtonContentItem {

    private static const CLAN_EMBLEM_MARGIN:int = 5;

    private static const MIN_SCREEN_PADDING_LEFT:int = 9;

    private static const MIN_SCREEN_PADDING_RIGHT:int = 12;

    private static const ADD_SCREEN_PADDING_LEFT:int = 0;

    private static const ADD_SCREEN_PADDING_RIGHT:int = 6;

    private static const MIN_WIDTH:Number = 100;

    private static const CLAN_EMBLEM_MAX_SCREEN_ALPHA:Number = 1;

    private static const CLAN_EMBLEM_NOT_MAX_SCREEN_ALPHA:Number = 0.6;

    private static const CLAN_EMBLEM_OFFSET:int = 7;

    public var userName:UserNameField = null;

    public var arrow:HBC_ArrowDown = null;

    public var clanEmblem:ClanEmblem = null;

    public var newIndicator:INewIndicator = null;

    private var _accountVo:HBC_AccountDataVo = null;

    private var _newWasAnimated:Boolean = false;

    private var _newWasHidden:Boolean = false;

    public function HBC_Account() {
        super();
        minScreenPadding.left = MIN_SCREEN_PADDING_LEFT;
        minScreenPadding.right = MIN_SCREEN_PADDING_RIGHT;
        additionalScreenPadding.left = ADD_SCREEN_PADDING_LEFT;
        additionalScreenPadding.right = ADD_SCREEN_PADDING_RIGHT;
        this.arrow.state = HBC_ArrowDown.STATE_NORMAL;
        this.newIndicator.visible = false;
    }

    override public function onPopoverClose():void {
        this.arrow.state = HBC_ArrowDown.STATE_NORMAL;
    }

    override public function onPopoverOpen():void {
        this.arrow.state = HBC_ArrowDown.STATE_UP;
    }

    override public function parentButtonClicked():void {
        if (!this._newWasHidden) {
            this._newWasHidden = true;
            this.newIndicator.hide();
        }
    }

    override protected function updateSize():void {
        bounds.width = this.arrow.x + this.arrow.width;
        if (bounds.width < MIN_WIDTH) {
            bounds.width = MIN_WIDTH;
        }
        super.updateSize();
    }

    override protected function updateData():void {
        var _loc1_:Number = NaN;
        var _loc2_:Number = NaN;
        var _loc3_:Number = NaN;
        var _loc4_:Number = NaN;
        if (data) {
            this.clanEmblem.visible = StringUtils.isNotEmpty(this._accountVo.clanEmblemId);
            this.userName.textColor = !!this._accountVo.isTeamKiller ? Number(App.colorSchemeMgr.getScheme(ColorSchemeNames.TEAMKILLER).rgb) : Number(UserNameField.DEF_USER_NAME_COLOR);
            _loc1_ = 0;
            if (this.clanEmblem.visible) {
                this.clanEmblem.setImage(this._accountVo.clanEmblemId);
                _loc1_ = this.clanEmblem.width >> 1;
            }
            _loc2_ = availableWidth - _loc1_ - ARROW_MARGIN - this.arrow.width;
            if (this._accountVo.userVO != null) {
                this.userName.width = _loc2_;
                this.userName.userVO = this._accountVo.userVO;
                this.userName.validateNow();
            }
            if (this.clanEmblem.visible) {
                if (this.clanEmblem.width + this.userName.textWidth + CLAN_EMBLEM_MARGIN < _loc2_) {
                    _loc1_ = this.clanEmblem.width + CLAN_EMBLEM_MARGIN;
                    this.clanEmblem.alpha = CLAN_EMBLEM_MAX_SCREEN_ALPHA;
                }
                else {
                    this.clanEmblem.alpha = CLAN_EMBLEM_NOT_MAX_SCREEN_ALPHA;
                }
            }
            _loc3_ = CLAN_EMBLEM_OFFSET;
            _loc4_ = _loc1_ + this.userName.textWidth + ARROW_MARGIN + this.arrow.width;
            if (_loc4_ < MIN_WIDTH) {
                _loc3_ = (availableWidth > MIN_WIDTH ? MIN_WIDTH : availableWidth) - _loc4_ >> 1;
            }
            this.clanEmblem.x = _loc3_;
            this.userName.x = _loc3_ + _loc1_;
            this.arrow.x = this.userName.x + this.userName.textWidth + ARROW_MARGIN ^ 0;
            if (this._accountVo.hasNew && !this._newWasAnimated) {
                this._newWasAnimated = true;
                this.newIndicator.visible = true;
                this.newIndicator.shine();
            }
        }
        super.updateData();
    }

    override protected function onDispose():void {
        this._accountVo = null;
        this.userName.dispose();
        this.userName = null;
        this.arrow.dispose();
        this.arrow = null;
        this.clanEmblem.dispose();
        this.clanEmblem = null;
        this.newIndicator.dispose();
        this.newIndicator = null;
        super.onDispose();
    }

    override public function set data(param1:Object):void {
        this._accountVo = HBC_AccountDataVo(param1);
        super.data = param1;
    }
}
}
