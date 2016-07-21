package net.wg.gui.lobby.profile.pages.statistics.body {
import flash.display.InteractiveObject;
import flash.text.TextField;

import net.wg.gui.components.common.containers.EqualGapsHorizontalLayout;
import net.wg.gui.components.common.containers.Group;
import net.wg.gui.lobby.components.IResizableContent;
import net.wg.infrastructure.base.UIComponentEx;

public class ChartsStatisticsView extends UIComponentEx implements IResizableContent {

    public var label:TextField = null;

    public var group:ChartsStatisticsGroup = null;

    public function ChartsStatisticsView() {
        super();
        this.group.layout = new EqualGapsHorizontalLayout();
    }

    override protected function configUI():void {
        super.configUI();
        this.label.text = App.utils.locale.makeString(PROFILE.SECTION_STATISTICS_LABELS_BATTLESONTECH);
    }

    override protected function onDispose():void {
        this.label = null;
        this.group.dispose();
        this.group = null;
        super.onDispose();
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return null;
    }

    public function setViewSize(param1:Number, param2:Number):void {
        this.label.width = param1;
        EqualGapsHorizontalLayout(this.group.layout).availableSize = param1;
        this.group.invalidate(Group.LAYOUT_INVALID);
    }

    public function update(param1:Object):void {
        if (param1 is StatisticsChartsTabDataVO) {
            this.group.setDossierData(StatisticsChartsTabDataVO(param1).chartsData);
        }
    }

    public function get centerOffset():int {
        return 0;
    }

    public function set centerOffset(param1:int):void {
    }

    public function get active():Boolean {
        return false;
    }

    public function set active(param1:Boolean):void {
    }
}
}
