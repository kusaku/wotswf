package net.wg.gui.lobby.christmas.interfaces {
import net.wg.gui.data.TabsVO;

public interface ICustomizationStaticDataVO extends ISlotsStaticDataMap {

    function get rulesLabelText():String;

    function get rulesLabelTooltip():String;

    function get btnConversionTooltip():String;

    function get tabsData():TabsVO;
}
}
