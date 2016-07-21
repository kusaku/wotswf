package net.wg.gui.lobby.battleloading.interfaces {
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.infrastructure.interfaces.IUIComponentEx;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public interface IBaseLoadingForm extends IUIComponentEx, IDisposable {

    function updateProgress(param1:Number):void;

    function setBattleTypeName(param1:String):void;

    function updateWinText(param1:String):void;

    function updateMapName(param1:String):void;

    function setBattleTypeFrameName(param1:String):void;

    function setMapIcon(param1:String):void;

    function getMapIconComponent():UILoaderAlt;
}
}
