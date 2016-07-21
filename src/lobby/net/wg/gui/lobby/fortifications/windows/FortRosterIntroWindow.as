package net.wg.gui.lobby.fortifications.windows {
import flash.display.InteractiveObject;
import flash.text.TextField;

import net.wg.gui.components.common.SeparatorConstants;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.components.interfaces.ISeparatorAsset;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.fortifications.cmp.tankIcon.impl.FortTankIcon;
import net.wg.gui.lobby.fortifications.data.RosterIntroVO;
import net.wg.infrastructure.base.meta.IFortRosterIntroWindowMeta;
import net.wg.infrastructure.base.meta.impl.FortRosterIntroWindowMeta;

import scaleform.clik.events.ButtonEvent;
import scaleform.gfx.TextFieldEx;

public class FortRosterIntroWindow extends FortRosterIntroWindowMeta implements IFortRosterIntroWindowMeta {

    private static const TANK_ICON_GAP:int = 18;

    public var bgIcon:UILoaderAlt = null;

    public var header:TextField = null;

    public var defenceTitle:TextField = null;

    public var defenceIcon:UILoaderAlt = null;

    public var defenceDescription:TextField = null;

    public var defenceDivisionName:TextField = null;

    public var defenceDivisionIcon:FortTankIcon = null;

    public var separator:ISeparatorAsset = null;

    public var attackTitle:TextField = null;

    public var attackIcon:UILoaderAlt = null;

    public var championDivisionDescription:TextField = null;

    public var championDivisionName:TextField = null;

    public var championDivisionIcon:FortTankIcon = null;

    public var absoluteDivisionDescription:TextField = null;

    public var absoluteDivisionName:TextField = null;

    public var absoluteDivisionIcon:FortTankIcon = null;

    public var acceptBtn:ISoundButtonEx = null;

    public function FortRosterIntroWindow() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        TextFieldEx.setVerticalAlign(this.header, TextFieldEx.VALIGN_BOTTOM);
        this.separator.setType(SeparatorConstants.DOTTED_TYPE);
        this.separator.setMode(SeparatorConstants.TILE_MODE);
        this.acceptBtn.addEventListener(ButtonEvent.CLICK, this.onAcceptBtnClickHandler);
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.useBottomBtns = true;
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(InteractiveObject(this.acceptBtn));
    }

    override protected function setData(param1:RosterIntroVO):void {
        window.title = param1.windowTitle;
        this.bgIcon.source = param1.bgIcon;
        this.header.text = param1.header;
        this.defenceTitle.text = param1.defenceTitle;
        this.defenceIcon.source = param1.defenceIcon;
        this.defenceDescription.text = param1.defenceDescription;
        this.defenceDivisionName.text = param1.defenceDivisionName;
        this.defenceDivisionIcon.update(param1.defenceDivisionIcon);
        this.attackTitle.text = param1.attackTitle;
        this.attackIcon.source = param1.attackIcon;
        this.championDivisionDescription.text = param1.championDivisionDescription;
        this.championDivisionName.text = param1.championDivisionName;
        this.championDivisionIcon.update(param1.championDivisionIcon);
        this.absoluteDivisionDescription.text = param1.absoluteDivisionDescription;
        this.absoluteDivisionName.text = param1.absoluteDivisionName;
        this.absoluteDivisionIcon.update(param1.absoluteDivisionIcon);
        this.acceptBtn.label = param1.acceptBtnLabel;
        this.updateFortTankIconPosition();
    }

    override protected function onDispose():void {
        this.acceptBtn.removeEventListener(ButtonEvent.CLICK, this.onAcceptBtnClickHandler);
        this.bgIcon.dispose();
        this.bgIcon = null;
        this.header = null;
        this.defenceTitle = null;
        this.defenceIcon.dispose();
        this.defenceIcon = null;
        this.defenceDescription = null;
        this.defenceDivisionName = null;
        this.defenceDivisionIcon.dispose();
        this.defenceDivisionIcon = null;
        this.separator.dispose();
        this.separator = null;
        this.attackTitle = null;
        this.attackIcon.dispose();
        this.attackIcon = null;
        this.championDivisionDescription = null;
        this.championDivisionName = null;
        this.championDivisionIcon.dispose();
        this.championDivisionIcon = null;
        this.absoluteDivisionDescription = null;
        this.absoluteDivisionName = null;
        this.absoluteDivisionIcon.dispose();
        this.absoluteDivisionIcon = null;
        this.acceptBtn.dispose();
        this.acceptBtn = null;
        super.onDispose();
    }

    private function updateFortTankIconPosition():void {
        var _loc1_:* = Math.max(this.defenceDivisionName.textWidth, this.championDivisionName.textWidth, this.absoluteDivisionName.textWidth) >> 0;
        _loc1_ = int(_loc1_ + (this.defenceDivisionName.x + TANK_ICON_GAP >> 0));
        this.defenceDivisionIcon.x = _loc1_;
        this.championDivisionIcon.x = _loc1_;
        this.absoluteDivisionIcon.x = _loc1_;
    }

    private function onAcceptBtnClickHandler(param1:ButtonEvent):void {
        handleWindowClose();
    }
}
}
