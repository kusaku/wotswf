package net.wg.gui.messenger.windows {
import flash.display.DisplayObject;
import flash.display.Sprite;

import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.data.daapi.base.DAAPIDataProvider;
import net.wg.gui.components.controls.ScrollingListEx;
import net.wg.gui.events.ListEventEx;
import net.wg.gui.messenger.meta.ILobbyChannelWindowMeta;
import net.wg.gui.messenger.meta.impl.LobbyChannelWindowMeta;

import scaleform.clik.utils.Constraints;
import scaleform.clik.utils.Padding;
import scaleform.gfx.MouseEventEx;

public class LobbyChannelWindow extends LobbyChannelWindowMeta implements ILobbyChannelWindowMeta {

    private static const INVALID_LIST_VISIBILITY:String = "invalidListVisibility";

    private static const BACKGROUND:String = "background";

    private static const MEMBERS_LIST:String = "membersList";

    private static const MESSAGE_AREA:String = "messageArea";

    public var membersList:ScrollingListEx;

    public var background:Sprite;

    protected var _membersDP:DAAPIDataProvider;

    private var _needToHideList:Boolean = false;

    private const CONTENT_PADDING:Padding = new Padding(38, 10, 11, 10);

    private const SB_PADDING:Padding = new Padding(0, 0, 0, 0);

    public function LobbyChannelWindow() {
        super();
        this._membersDP = new DAAPIDataProvider();
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.contentPadding = this.CONTENT_PADDING;
    }

    override protected function configUI():void {
        super.configUI();
        constraints.addElement(BACKGROUND, this.background, Constraints.ALL);
        constraints.addElement(MEMBERS_LIST, this.membersList, Constraints.RIGHT | Constraints.TOP | Constraints.BOTTOM);
        this.membersList.sbPadding = this.SB_PADDING;
        this.membersList.addEventListener(ListEventEx.ITEM_CLICK, this.onMemberItemClickHandler);
        this.membersList.dataProvider = this._membersDP;
        this.membersList.smartScrollBar = true;
        window.titleUseHtml = true;
    }

    override protected function draw():void {
        var _loc1_:DisplayObject = null;
        var _loc2_:DisplayObject = null;
        if (isInvalid(INVALID_LIST_VISIBILITY) && this._needToHideList) {
            this._needToHideList = false;
            this.membersList.visible = false;
            _loc1_ = channelComponent.messageArea;
            _loc2_ = DisplayObject(channelComponent.sendButton);
            _loc1_.width = _loc2_.x + _loc2_.width - (_loc1_.x << 1);
            this.background.width = _loc2_.x + _loc2_.width;
            constraints.removeElement(BACKGROUND);
            constraints.removeElement(MESSAGE_AREA);
            constraints.addElement(BACKGROUND, this.background, Constraints.ALL);
            constraints.addElement(MESSAGE_AREA, channelComponent.messageArea, Constraints.ALL);
        }
        super.draw();
    }

    override protected function onDispose():void {
        this._membersDP.cleanUp();
        this._membersDP = null;
        this.membersList.removeEventListener(ListEventEx.ITEM_CLICK, this.onMemberItemClickHandler);
        this.membersList.dispose();
        this.membersList = null;
        this.background = null;
        super.onDispose();
    }

    public function as_getMembersDP():Object {
        return this._membersDP;
    }

    public function as_hideMembersList():void {
        this._needToHideList = true;
        invalidate(INVALID_LIST_VISIBILITY);
    }

    private function onMemberItemClickHandler(param1:ListEventEx):void {
        if (param1.buttonIdx == MouseEventEx.RIGHT_BUTTON) {
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.BASE_USER, this, param1.itemData);
        }
    }
}
}
