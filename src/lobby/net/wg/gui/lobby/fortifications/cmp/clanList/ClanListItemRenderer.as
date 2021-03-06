package net.wg.gui.lobby.fortifications.cmp.clanList {
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

import net.wg.data.constants.ColorSchemeNames;
import net.wg.gui.components.controls.TableRenderer;
import net.wg.gui.lobby.fortifications.data.ClanListRendererVO;
import net.wg.infrastructure.interfaces.IColorScheme;
import net.wg.infrastructure.interfaces.IUserProps;

import scaleform.clik.constants.InvalidationType;

public class ClanListItemRenderer extends TableRenderer {

    public var memeberNameTF:TextField;

    public var roleTF:TextField;

    public var weekMiningTF:TextField;

    public var totalMiningTF:TextField;

    private var _isMouseOver:Boolean = false;

    public function ClanListItemRenderer() {
        super();
        isPassive = false;
    }

    override public function setData(param1:Object):void {
        this.data = param1;
        invalidateData();
    }

    override protected function draw():void {
        var _loc1_:ClanListRendererVO = null;
        var _loc2_:IUserProps = null;
        var _loc3_:Point = null;
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            if (data) {
                _loc1_ = ClanListRendererVO(data);
                _loc2_ = App.utils.commons.getUserProps(_loc1_.userName);
                _loc2_.rgb = !!_loc1_.himself ? Number(IColorScheme(App.colorSchemeMgr.getScheme(ColorSchemeNames.TEAM_SELF)).rgb) : Number(15327935);
                App.utils.commons.formatPlayerName(this.memeberNameTF, _loc2_);
                this.roleTF.htmlText = _loc1_.playerRole;
                this.weekMiningTF.htmlText = _loc1_.thisWeek;
                this.totalMiningTF.htmlText = _loc1_.allTime;
                _loc3_ = new Point(mouseX, mouseY);
                _loc3_ = this.localToGlobal(_loc3_);
                if (this.hitTestPoint(_loc3_.x, _loc3_.y, true) && this._isMouseOver) {
                    App.toolTipMgr.show(_loc1_.fullName);
                }
            }
            else {
                this.memeberNameTF.htmlText = "";
                this.roleTF.htmlText = "";
                this.weekMiningTF.htmlText = "";
                this.totalMiningTF.htmlText = "";
            }
            this.updateButtonMode();
            updateDisable(_data && !enabled);
        }
    }

    override protected function updateButtonMode():void {
        var _loc1_:ClanListRendererVO = ClanListRendererVO(data);
        buttonMode = _loc1_ && !_loc1_.himself;
    }

    override protected function onDispose():void {
        this.memeberNameTF = null;
        this.roleTF = null;
        this.weekMiningTF = null;
        this.totalMiningTF = null;
        super.onDispose();
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        super.handleMouseRollOut(param1);
        this._isMouseOver = false;
        App.toolTipMgr.hide();
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        super.handleMouseRollOver(param1);
        this._isMouseOver = true;
        if (data && data.fullName) {
            App.toolTipMgr.show(ClanListRendererVO(data).fullName);
        }
    }
}
}
