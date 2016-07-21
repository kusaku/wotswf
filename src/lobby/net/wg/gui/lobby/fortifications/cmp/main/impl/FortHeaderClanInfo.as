package net.wg.gui.lobby.fortifications.cmp.main.impl {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.advanced.ClanEmblem;
import net.wg.gui.lobby.fortifications.cmp.main.IFortHeaderClanInfo;
import net.wg.gui.lobby.fortifications.data.FortificationVO;
import net.wg.infrastructure.base.UIComponentEx;

public class FortHeaderClanInfo extends UIComponentEx implements IFortHeaderClanInfo {

    public var levelText:TextField = null;

    public var clanName:TextField = null;

    public var clanEmblem:ClanEmblem = null;

    public var toolTipArea:MovieClip = null;

    public function FortHeaderClanInfo() {
        super();
        this.clanName.autoSize = TextFieldAutoSize.LEFT;
        this.toolTipArea.addEventListener(MouseEvent.ROLL_OVER, onRollOverHandler);
        this.toolTipArea.addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
    }

    private static function onRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CLAN_INFO, null, null);
    }

    private static function onRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    public function applyClanData(param1:FortificationVO):void {
        this.clanName.htmlText = param1.clanName;
        this.clanName.x = this.clanName.x ^ 0;
        this.levelText.text = param1.levelTitle;
    }

    public function setClanImage(param1:String):void {
        this.clanEmblem.setImage(param1);
    }

    override protected function onDispose():void {
        this.levelText = null;
        this.toolTipArea.removeEventListener(MouseEvent.ROLL_OVER, onRollOverHandler);
        this.toolTipArea.removeEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
        this.toolTipArea = null;
        this.clanName = null;
        this.clanEmblem.dispose();
        this.clanEmblem = null;
        super.onDispose();
    }
}
}
