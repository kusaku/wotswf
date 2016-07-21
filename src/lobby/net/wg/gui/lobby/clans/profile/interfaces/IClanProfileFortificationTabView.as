package net.wg.gui.lobby.clans.profile.interfaces {
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileFortificationViewVO;

public interface IClanProfileFortificationTabView {

    function setData(param1:ClanProfileFortificationViewVO):void;

    function isDataSet():Boolean;
}
}
