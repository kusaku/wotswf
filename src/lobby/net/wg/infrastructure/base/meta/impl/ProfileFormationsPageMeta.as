package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.profile.pages.ProfileSection;
import net.wg.infrastructure.exceptions.AbstractException;

public class ProfileFormationsPageMeta extends ProfileSection {

    public var showFort:Function;

    public var searchStaticTeams:Function;

    public var createFort:Function;

    public var showTeam:Function;

    public var onClanLinkNavigate:Function;

    private var _array:Array;

    public function ProfileFormationsPageMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._array) {
            this._array.splice(0, this._array.length);
            this._array = null;
        }
        super.onDispose();
    }

    public function showFortS():void {
        App.utils.asserter.assertNotNull(this.showFort, "showFort" + Errors.CANT_NULL);
        this.showFort();
    }

    public function searchStaticTeamsS():void {
        App.utils.asserter.assertNotNull(this.searchStaticTeams, "searchStaticTeams" + Errors.CANT_NULL);
        this.searchStaticTeams();
    }

    public function createFortS():void {
        App.utils.asserter.assertNotNull(this.createFort, "createFort" + Errors.CANT_NULL);
        this.createFort();
    }

    public function showTeamS(param1:int):void {
        App.utils.asserter.assertNotNull(this.showTeam, "showTeam" + Errors.CANT_NULL);
        this.showTeam(param1);
    }

    public function onClanLinkNavigateS(param1:String):void {
        App.utils.asserter.assertNotNull(this.onClanLinkNavigate, "onClanLinkNavigate" + Errors.CANT_NULL);
        this.onClanLinkNavigate(param1);
    }

    public final function as_setClubHistory(param1:Array):void {
        var _loc2_:Array = this._array;
        this._array = param1;
        this.setClubHistory(this._array);
        if (_loc2_) {
            _loc2_.splice(0, _loc2_.length);
        }
    }

    protected function setClubHistory(param1:Array):void {
        var _loc2_:String = "as_setClubHistory" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
