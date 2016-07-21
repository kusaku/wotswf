package net.wg.gui.lobby.header.headerButtonBar {
import net.wg.data.constants.ColorSchemeNames;
import net.wg.gui.components.advanced.ClanEmblem;
import net.wg.gui.components.advanced.interfaces.INewIndicator;
import net.wg.gui.components.controls.UserNameField;
import net.wg.gui.lobby.header.LobbyHeader;
import net.wg.gui.lobby.header.vo.HBC_AccountDataVo;

public class HBC_Account extends HeaderButtonContentItem {

    private static const MAX_WIDTH_NARROW:int = 120;

    private static const MAX_WIDTH_WIDE:int = 60;

    private static const CLAN_EMBLEM_MARGIN:int = 5;

    private static const MIN_SCREEN_PADDING_LEFT:int = 9;

    private static const MIN_SCREEN_PADDING_RIGHT:int = 12;

    private static const ADD_SCREEN_PADDING_LEFT:int = 0;

    private static const ADD_SCREEN_PADDING_RIGHT:int = 6;

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

    override public function parentButtonClicked():void {
        if (!this._newWasHidden) {
            this._newWasHidden = true;
            this.newIndicator.hide();
        }
    }

    override public function onPopoverClose():void {
        this.arrow.state = HBC_ArrowDown.STATE_NORMAL;
    }

    override public function onPopoverOpen():void {
        this.arrow.state = HBC_ArrowDown.STATE_UP;
    }

    override protected function updateSize():void {
        bounds.width = this.arrow.x + this.arrow.width;
        super.updateSize();
    }

    override protected function updateData():void {
        var _loc1_:Number = NaN;
        if (data) {
            this.userName.textColor = !!this._accountVo.isTeamKiller ? Number(App.colorSchemeMgr.getScheme(ColorSchemeNames.TEAMKILLER).rgb) : Number(UserNameField.DEF_USER_NAME_COLOR);
            if (this._accountVo.clanEmblemId) {
                this.clanEmblem.setImage(this._accountVo.clanEmblemId);
                if (screen == LobbyHeader.MAX_SCREEN) {
                    this.userName.x = this.clanEmblem.x + this.clanEmblem.width + CLAN_EMBLEM_MARGIN;
                    this.clanEmblem.alpha = CLAN_EMBLEM_MAX_SCREEN_ALPHA;
                }
                else {
                    this.userName.x = this.clanEmblem.width >> 2;
                    this.clanEmblem.alpha = CLAN_EMBLEM_NOT_MAX_SCREEN_ALPHA;
                }
            }
            else {
                this.userName.x = this.clanEmblem.x + CLAN_EMBLEM_OFFSET;
            }
            this.clanEmblem.visible = Boolean(this._accountVo.clanEmblemId);
            if (this._accountVo.userVO) {
                _loc1_ = 0;
                if (availableWidth > 0) {
                    _loc1_ = availableWidth - (this.userName.x + ARROW_MARGIN + this.arrow.width);
                }
                else {
                    _loc1_ = screen == LobbyHeader.NARROW_SCREEN ? Number(MAX_WIDTH_NARROW) : Number(MAX_WIDTH_NARROW + wideScreenPrc * MAX_WIDTH_WIDE);
                }
                this.userName.width = _loc1_;
                this.userName.userVO = this._accountVo.userVO;
                this.userName.validateNow();
            }
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
