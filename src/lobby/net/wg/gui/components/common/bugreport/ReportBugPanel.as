package net.wg.gui.components.common.bugreport {
import flash.events.TextEvent;
import flash.text.TextField;

import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.infrastructure.base.meta.IReportBugPanelMeta;
import net.wg.infrastructure.base.meta.impl.ReportBugPanelMeta;

public class ReportBugPanel extends ReportBugPanelMeta implements IReportBugPanelMeta {

    public var reportBugLink:TextField;

    public var background:UILoaderAlt;

    public function ReportBugPanel() {
        super();
        visible = false;
        tabEnabled = false;
        tabChildren = false;
    }

    override protected function configUI():void {
        super.configUI();
        this.background.source = RES_ICONS.MAPS_ICONS_LOBBY_REPORT_BUG_BACKGROUND;
        App.utils.styleSheetManager.setLinkStyle(this.reportBugLink);
        this.reportBugLink.addEventListener(TextEvent.LINK, this.onReportBugLinkClick);
    }

    override protected function onDispose():void {
        this.reportBugLink.removeEventListener(TextEvent.LINK, this.onReportBugLinkClick);
        this.reportBugLink.styleSheet = null;
        this.reportBugLink = null;
        this.background.dispose();
        this.background = null;
        super.onDispose();
    }

    public function as_setHyperLink(param1:String):void {
        this.reportBugLink.htmlText = param1;
        visible = true;
    }

    private function onReportBugLinkClick(param1:TextEvent):void {
        reportBugS();
    }
}
}
