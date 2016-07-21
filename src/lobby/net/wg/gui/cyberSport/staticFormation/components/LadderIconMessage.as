package net.wg.gui.cyberSport.staticFormation.components {
import flash.text.TextField;

import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.cyberSport.staticFormation.data.LadderIconMessageVO;
import net.wg.infrastructure.base.UIComponentEx;

public class LadderIconMessage extends UIComponentEx {

    public var icon:UILoaderAlt;

    public var titleTF:TextField;

    public var messageTF:TextField;

    public function LadderIconMessage() {
        super();
    }

    public function setData(param1:LadderIconMessageVO):void {
        this.icon.source = param1.iconPath;
        this.titleTF.htmlText = param1.title;
        this.messageTF.htmlText = param1.message;
        App.utils.commons.updateTextFieldSize(this.titleTF);
        App.utils.commons.updateTextFieldSize(this.messageTF);
        this.width = this.actualWidth;
    }

    override protected function onDispose():void {
        this.icon.dispose();
        this.icon = null;
        this.titleTF = null;
        this.messageTF = null;
        super.onDispose();
    }
}
}
