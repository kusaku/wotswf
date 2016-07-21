package net.wg.gui.lobby.techtree.interfaces {
import net.wg.infrastructure.interfaces.IUIComponentEx;

public interface INodesContainer extends IUIComponentEx {

    function getNodeByID(param1:Number):IRenderer;

    function getRootNode():IRenderer;

    function isParentUnlocked(param1:Number, param2:Number):Boolean;

    function getNation():String;
}
}
