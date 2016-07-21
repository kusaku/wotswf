package net.wg.gui.lobby.profile.components {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.Linkages;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.lobby.profile.ProfileOpenInfoEvent;
import net.wg.gui.lobby.profile.data.ProfileGroupBlockVO;

import scaleform.clik.events.ButtonEvent;

public class ProfileWindowFooter extends ProfileFooter {

    private static const LAYOUT_INVALID:String = "layInv";

    private static const HEIGHT:int = 181;

    private static const TOP_GAP:int = 25;

    private static const GROUPS_GAP:int = 120;

    private static const SIDES_GAP:uint = 10;

    public var registerDateTf:TextField = null;

    public var lastBattleTf:TextField = null;

    public var noGroupsTf:TextField = null;

    public var background:Sprite = null;

    public var noGroupsProxy:Sprite = null;

    private var _clanGroupBlock:ProfileGroupBlock = null;

    private var _clubGroupBlock:ProfileGroupBlock = null;

    private var _clan:ProfileGroupBlockVO = null;

    private var _club:ProfileGroupBlockVO = null;

    private var _clanEmblem:String = null;

    private var _clubEmblem:String = null;

    public function ProfileWindowFooter() {
        super();
    }

    private static function onClubGroupBlockEmblemRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    override protected function configUI():void {
        super.configUI();
        this.registerDateTf.autoSize = TextFieldAutoSize.LEFT;
        this.lastBattleTf.autoSize = TextFieldAutoSize.LEFT;
        this.registerDateTf.selectable = this.lastBattleTf.selectable = false;
        this.registerDateTf.x = SIDES_GAP;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(LAYOUT_INVALID)) {
            this.lastBattleTf.x = this.width - this.lastBattleTf.width - SIDES_GAP;
            this.noGroupsProxy.visible = this.noGroupsTf.visible = false;
            if (data) {
                if (this._clan && this._club) {
                    this._clanGroupBlock.y = this._clubGroupBlock.y = TOP_GAP;
                    this._clanGroupBlock.x = width - this._clanGroupBlock.width - this._clubGroupBlock.width - GROUPS_GAP >> 1;
                    this._clubGroupBlock.x = this._clanGroupBlock.x + this._clanGroupBlock.width + GROUPS_GAP >> 0;
                }
                else if (this._clan) {
                    this._clanGroupBlock.y = TOP_GAP;
                    this._clanGroupBlock.x = width - this._clanGroupBlock.width >> 1;
                }
                else if (this._club) {
                    this._clubGroupBlock.y = TOP_GAP;
                    this._clubGroupBlock.x = width - this._clubGroupBlock.width >> 1;
                }
                else {
                    this.noGroupsProxy.visible = this.noGroupsTf.visible = true;
                    this.noGroupsTf.text = PROFILE.PROFILE_SUMMARY_NOGROUPS;
                }
            }
        }
    }

    override protected function applyDataChanges():void {
        super.applyDataChanges();
        this.lastBattleTf.htmlText = data.lastBattleDate;
        this.registerDateTf.htmlText = data.registrationDate;
        this.updateClanBlock();
        this.updateClubBlock();
        invalidate(LAYOUT_INVALID);
    }

    override protected function onDispose():void {
        this.removeClanBlock();
        this.removeClubBlock();
        this.lastBattleTf = null;
        this.registerDateTf = null;
        this.background = null;
        this.noGroupsTf = null;
        this.noGroupsProxy = null;
        this._clan = null;
        this._club = null;
        super.onDispose();
    }

    public function setClanData(param1:ProfileGroupBlockVO):void {
        this._clan = param1;
        invalidateData();
    }

    public function setClanEmblem(param1:String):void {
        this._clanEmblem = param1;
        if (this._clanGroupBlock) {
            this._clanGroupBlock.setEmblem(param1);
        }
    }

    public function setClubData(param1:ProfileGroupBlockVO):void {
        this._club = param1;
        invalidateData();
    }

    public function setClubEmblem(param1:String):void {
        this._clubEmblem = param1;
        if (this._clubGroupBlock) {
            this._clubGroupBlock.setEmblem(param1);
        }
    }

    private function updateClubBlock():void {
        if (this._club) {
            if (this._clubGroupBlock == null) {
                this._clubGroupBlock = this.createGroupBlock();
                this._clubGroupBlock.actionBtn.addEventListener(MouseEvent.CLICK, this.onClubGroupBlockActionBtnClickHandler);
                this._clubGroupBlock.emblem.addEventListener(MouseEvent.ROLL_OVER, this.onClubGroupBlockEmblemRollOverHandler);
                this._clubGroupBlock.emblem.addEventListener(MouseEvent.ROLL_OUT, onClubGroupBlockEmblemRollOutHandler);
                App.utils.scheduler.scheduleOnNextFrame(this.updateClubData);
                invalidate(LAYOUT_INVALID);
            }
            else {
                this.updateClubData();
            }
        }
        else {
            this.removeClubBlock();
            invalidate(LAYOUT_INVALID);
        }
    }

    private function updateClubData():void {
        this._clubGroupBlock.setData(this._club);
        this._clubGroupBlock.setEmblem(this._clubEmblem);
        this._clubGroupBlock.visible = true;
    }

    private function createGroupBlock():ProfileGroupBlock {
        var _loc1_:ProfileGroupBlock = ProfileGroupBlock(App.utils.classFactory.getComponent(Linkages.PROFILE_GROUP_BLOCK, ProfileGroupBlock));
        this.addChild(_loc1_);
        _loc1_.visible = false;
        return _loc1_;
    }

    private function updateClanBlock():void {
        if (this._clan) {
            if (this._clanGroupBlock == null) {
                this._clanGroupBlock = this.createGroupBlock();
                this._clanGroupBlock.actionBtn.addEventListener(ButtonEvent.CLICK, this.onClanGroupBlockActionBtnClickHandler);
                App.utils.scheduler.scheduleOnNextFrame(this.updateClanData);
                invalidate(LAYOUT_INVALID);
            }
            else {
                this.updateClanData();
            }
        }
        else {
            this.removeClanBlock();
            invalidate(LAYOUT_INVALID);
        }
    }

    private function updateClanData():void {
        this._clanGroupBlock.setData(this._clan);
        this._clanGroupBlock.setEmblem(this._clanEmblem);
        this._clanGroupBlock.visible = true;
    }

    private function removeClanBlock():void {
        if (this._clanGroupBlock) {
            App.utils.scheduler.cancelTask(this.updateClanData);
            this._clanGroupBlock.actionBtn.removeEventListener(ButtonEvent.CLICK, this.onClanGroupBlockActionBtnClickHandler);
            removeChild(this._clanGroupBlock);
            this._clanGroupBlock.dispose();
            this._clanGroupBlock = null;
        }
    }

    private function removeClubBlock():void {
        if (this._clubGroupBlock) {
            App.utils.scheduler.cancelTask(this.updateClubData);
            this._clubGroupBlock.actionBtn.removeEventListener(MouseEvent.CLICK, this.onClubGroupBlockActionBtnClickHandler);
            this._clubGroupBlock.emblem.removeEventListener(MouseEvent.ROLL_OVER, this.onClubGroupBlockEmblemRollOverHandler);
            this._clubGroupBlock.emblem.removeEventListener(MouseEvent.ROLL_OUT, onClubGroupBlockEmblemRollOutHandler);
            removeChild(this._clubGroupBlock);
            this._clubGroupBlock.dispose();
            this._clubGroupBlock = null;
        }
    }

    override public function get height():Number {
        return HEIGHT;
    }

    private function onClubGroupBlockEmblemRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.LADDER, null, this._club.id);
    }

    private function onClubGroupBlockActionBtnClickHandler(param1:MouseEvent):void {
        var _loc2_:ProfileOpenInfoEvent = new ProfileOpenInfoEvent(ProfileOpenInfoEvent.CLUB);
        _loc2_.id = this._club.id;
        dispatchEvent(_loc2_);
    }

    private function onClanGroupBlockActionBtnClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new ProfileOpenInfoEvent(ProfileOpenInfoEvent.CLAN));
    }
}
}
