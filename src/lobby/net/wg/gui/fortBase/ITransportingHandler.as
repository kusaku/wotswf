package net.wg.gui.fortBase {
public interface ITransportingHandler {

    function onTransportingSuccess(param1:IFortBuilding, param2:IFortBuilding):void;

    function onStartImporting():void;

    function onStartExporting():void;
}
}
