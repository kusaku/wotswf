package net.wg.gui.lobby.clans.profile.interfaces {
import scaleform.clik.data.DataProvider;

public interface IClanProfileFortificationTabbedView {

    function setTabsProvider(param1:DataProvider):void;

    function selectTabIndex(param1:int):void;

    function addTabIndexChangedEventListener(param1:Function):void;

    function removeTabIndexChangedEventListener(param1:Function):void;
}
}
