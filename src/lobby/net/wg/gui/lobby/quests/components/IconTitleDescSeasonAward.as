package net.wg.gui.lobby.quests.components {
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.quests.data.seasonAwards.IconTitleDescSeasonAwardVO;
import net.wg.infrastructure.base.UIComponentEx;

import org.idmedia.as3commons.util.StringUtils;

public class IconTitleDescSeasonAward extends UIComponentEx {

    public var iconLoader:UILoaderAlt;

    public var descriptionTf:TextField;

    public var titleTf:TextField;

    private var _tooltip:String;

    public function IconTitleDescSeasonAward() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.iconLoader.addEventListener(MouseEvent.ROLL_OVER, this.onIconRollOverHandler);
        this.iconLoader.addEventListener(MouseEvent.ROLL_OUT, this.onIconRollOutHandler);
    }

    override protected function onDispose():void {
        this.iconLoader.removeEventListener(MouseEvent.ROLL_OVER, this.onIconRollOverHandler);
        this.iconLoader.removeEventListener(MouseEvent.ROLL_OUT, this.onIconRollOutHandler);
        this.iconLoader.dispose();
        this.iconLoader = null;
        this.descriptionTf = null;
        this.titleTf = null;
        super.onDispose();
    }

    public function setData(param1:IconTitleDescSeasonAwardVO):void {
        this.iconLoader.source = param1.iconPath;
        this.descriptionTf.htmlText = param1.description;
        this.titleTf.htmlText = param1.title;
        this._tooltip = param1.tooltip;
    }

    private function onIconRollOverHandler(param1:MouseEvent):void {
        if (StringUtils.isNotEmpty(this._tooltip)) {
            App.toolTipMgr.showSpecial(this._tooltip, null);
        }
    }

    private function onIconRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }
}
}
