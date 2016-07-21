package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileFortificationViewInitVO;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileFortificationViewVO;
import net.wg.infrastructure.base.BaseDAAPIComponent;
import net.wg.infrastructure.exceptions.AbstractException;

public class ClanProfileFortificationInfoViewMeta extends BaseDAAPIComponent {

    private var _clanProfileFortificationViewVO:ClanProfileFortificationViewVO;

    private var _clanProfileFortificationViewInitVO:ClanProfileFortificationViewInitVO;

    public function ClanProfileFortificationInfoViewMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._clanProfileFortificationViewVO) {
            this._clanProfileFortificationViewVO.dispose();
            this._clanProfileFortificationViewVO = null;
        }
        if (this._clanProfileFortificationViewInitVO) {
            this._clanProfileFortificationViewInitVO.dispose();
            this._clanProfileFortificationViewInitVO = null;
        }
        super.onDispose();
    }

    public function as_setFortData(param1:Object):void {
        if (this._clanProfileFortificationViewVO) {
            this._clanProfileFortificationViewVO.dispose();
        }
        this._clanProfileFortificationViewVO = new ClanProfileFortificationViewVO(param1);
        this.setFortData(this._clanProfileFortificationViewVO);
    }

    public function as_setData(param1:Object):void {
        if (this._clanProfileFortificationViewInitVO) {
            this._clanProfileFortificationViewInitVO.dispose();
        }
        this._clanProfileFortificationViewInitVO = new ClanProfileFortificationViewInitVO(param1);
        this.setData(this._clanProfileFortificationViewInitVO);
    }

    protected function setFortData(param1:ClanProfileFortificationViewVO):void {
        var _loc2_:String = "as_setFortData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setData(param1:ClanProfileFortificationViewInitVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
