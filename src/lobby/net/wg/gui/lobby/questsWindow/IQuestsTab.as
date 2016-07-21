package net.wg.gui.lobby.questsWindow {
import net.wg.gui.lobby.questsWindow.components.interfaces.IQuestsCurrentTabDAAPI;
import net.wg.infrastructure.interfaces.IDAAPIModule;
import net.wg.infrastructure.interfaces.IViewStackContent;

public interface IQuestsTab extends IViewStackContent, IQuestsCurrentTabDAAPI, IDAAPIModule {

    function get questContent():QuestContent;

    function set questContent(param1:QuestContent):void;
}
}
