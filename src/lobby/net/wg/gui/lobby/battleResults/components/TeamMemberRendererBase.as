package net.wg.gui.lobby.battleResults.components {
import flash.events.MouseEvent;

import net.wg.data.constants.Errors;
import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.gui.components.controls.SoundListItemRenderer;
import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
import net.wg.infrastructure.exceptions.AbstractException;

import scaleform.clik.constants.InvalidationType;

public class TeamMemberRendererBase extends SoundListItemRenderer {

    protected static const DEFAULT_TEAM_KILLER_COLOR:int = 65535;

    private var _bonusType:int = -1;

    private var _vo:TeamMemberItemVO = null;

    private var _commonStatsVO:CommonStatsVO = null;

    public function TeamMemberRendererBase() {
        super();
    }

    override public function setData(param1:Object):void {
        super.setData(param1);
        this._vo = TeamMemberItemVO(param1);
        invalidateData();
    }

    override protected function onDispose():void {
        this._commonStatsVO = null;
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

    public function get bonusType():int {
        return this._bonusType;
    }

    private function get wasInBattle():Boolean {
        return !!this._commonStatsVO ? Boolean(this._commonStatsVO.wasInBattle) : false;
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
                "vehicleCD": this._vo.vehicleCD,
                "clientArenaIdx": this._commonStatsVO.clientArenaIdx
            };
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.BATTLE_RESULTS_USER, this, _loc2_);
        }
        super.handleMouseRelease(param1);
    }

    public function setCommonStatsVO(param1:CommonStatsVO):void {
        this._commonStatsVO = param1;
        this._bonusType = this._commonStatsVO.bonusType;
    }
}
}
