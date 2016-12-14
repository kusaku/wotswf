package net.wg.gui.crewOperations {
import flash.events.Event;

import net.wg.data.constants.Linkages;
import net.wg.gui.components.common.containers.IGroupEx;
import net.wg.gui.components.common.containers.VerticalGroupLayout;
import net.wg.gui.components.popovers.PopOver;
import net.wg.infrastructure.base.meta.ICrewOperationsPopOverMeta;
import net.wg.infrastructure.base.meta.impl.CrewOperationsPopOverMeta;
import net.wg.infrastructure.interfaces.IWrapper;

public class CrewOperationsPopOver extends CrewOperationsPopOverMeta implements ICrewOperationsPopOverMeta {

    public var group:IGroupEx;

    public function CrewOperationsPopOver() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.group.layout = new VerticalGroupLayout();
        this.group.itemRendererLinkage = Linkages.CREW_OPERATIONS_IR_UI;
        this.group.addEventListener(Event.RESIZE, this.onGroupResizeHandler, false, 0, true);
        this.group.addEventListener(CrewOperationEvent.OPERATION_CHANGED, this.onGroupOperationChangedHandler, false, 0, true);
    }

    override protected function onDispose():void {
        this.group.removeEventListener(Event.RESIZE, this.onGroupResizeHandler);
        this.group.removeEventListener(CrewOperationEvent.OPERATION_CHANGED, this.onGroupOperationChangedHandler);
        this.group.dispose();
        this.group = null;
        super.onDispose();
    }

    override protected function update(param1:CrewOperationsInitVO):void {
        this.group.dataProvider = param1.castedOperations;
    }

    override public function set wrapper(param1:IWrapper):void {
        super.wrapper = param1;
        PopOver(wrapper).title = CREW_OPERATIONS.WINDOW_TITLE;
    }

    private function onGroupOperationChangedHandler(param1:CrewOperationEvent):void {
        param1.stopImmediatePropagation();
        invokeOperationS(param1.operationName);
        App.popoverMgr.hide();
    }

    private function onGroupResizeHandler(param1:Event):void {
        setSize(this.group.width, this.group.height);
    }
}
}
