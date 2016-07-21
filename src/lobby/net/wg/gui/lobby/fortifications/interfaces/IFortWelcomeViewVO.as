package net.wg.gui.lobby.fortifications.interfaces {
public interface IFortWelcomeViewVO {

    function canCreateFort():Boolean;

    function get canRoleCreateFortRest():Boolean;

    function get canCreateFortLim():Boolean;

    function get joinClanAvailable():Boolean;

    function get clanSearchAvailable():Boolean;
}
}
