package net.wg.gui.lobby.fortifications.cmp.drctn {
import net.wg.gui.lobby.fortifications.data.DirectionVO;
import net.wg.infrastructure.interfaces.IUIComponentEx;

public interface IDirectionCmp extends IUIComponentEx {

    function setData(param1:DirectionVO):void;

    function showHideHowerState(param1:Boolean, param2:Boolean = false):void;

    function get labelVisible():Boolean;

    function set labelVisible(param1:Boolean):void;

    function get solidMode():Boolean;

    function set solidMode(param1:Boolean):void;

    function get layout():String;

    function set layout(param1:String):void;

    function get disableLowLevelBuildings():Boolean;

    function set disableLowLevelBuildings(param1:Boolean):void;

    function get hoverAnimation():String;

    function set hoverAnimation(param1:String):void;

    function get alwaysShowLevels():Boolean;

    function set alwaysShowLevels(param1:Boolean):void;

    function get showLevelsOnHover():Boolean;

    function set showLevelsOnHover(param1:Boolean):void;

    function get buildingRenderer():String;

    function set buildingRenderer(param1:String):void;
}
}
