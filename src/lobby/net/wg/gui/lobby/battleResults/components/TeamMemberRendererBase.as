package net.wg.gui.lobby.battleResults.components {
import flash.events.MouseEvent;

import net.wg.data.constants.Errors;
import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.gui.components.controls.SoundListItemRenderer;
import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
import net.wg.infrastructure.exceptions.AbstractException;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.core.UIComponent;

public class TeamMemberRendererBase extends SoundListItemRenderer {

    protected static const DEFAULT_TEAM_KILLER_COLOR:int = 65535;

    private var _bonusType:int = -1;

    private var _teamStatsListOwner:TeamStatsList = null;

    private var _vo:TeamMemberItemVO = null;

    public function TeamMemberRendererBase() {
        super();
    }

    override public function setData(param1:Object):void {
        super.setData(param1);
        this._vo = TeamMemberItemVO(param1);
        invalidateData();
    }

    override protected function onDispose():void {
        this._teamStatsListOwner = null;
        this._vo = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            if (this._vo) {
                this.visible = true;
                this.showData(this._vo);
            }
            else {
                this.visible = false;
                this.selectable = false;
            }
        }
    }

    protected function showData(param1:TeamMemberItemVO):void {
        throw new AbstractException("TeamMemberRendererBase::showData() " + Errors.ABSTRACT_INVOKE);
    }

    protected function getColorForAlias(param1:String, param2:Number):Number {
        var result:Number = NaN;
        var alias:String = param1;
        var defaultColor:Number = param2;
        try {
            result = App.colorSchemeMgr.getRGB(alias);
            if (!result) {
                result = defaultColor;
            }
        }
        catch (e:Error) {
            result = defaultColor;
        }
        return result;
    }

    override public function set owner(param1:UIComponent):void {
        super.owner = param1;
        this._teamStatsListOwner = TeamStatsList(param1);
    }

    public function get bonusType():int {
        return this._bonusType;
    }

    public function set bonusType(param1:int):void {
        this._bonusType = param1;
    }

    private function get wasInBattle():Boolean {
        return !!this._teamStatsListOwner ? Boolean(this._teamStatsListOwner.wasInBattle) : false;
    }

    override protected function handleMouseRelease(param1:MouseEvent):void {
        var _loc2_:Object = null;
        if (App.utils.commons.isRightButton(param1) && this._vo) {
            _loc2_ = {
                "dbID": this._vo.playerId,
                "userName": this._vo.userName,
                "himself": this._vo.isSelf,
                "wasInBattle": this.wasInBattle,
                "showClanProfile": true,
                "clanAbbrev": this._vo.userVO.clanAbbrev,
                "vehicleCD": this._vo.vehicleCD
            };
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.APPEAL_USER, this, _loc2_);
        }
        super.handleMouseRelease(param1);
    }
}
}
