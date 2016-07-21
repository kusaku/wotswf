package net.wg.gui.cyberSport.staticFormation.views.impl {
import flash.display.InteractiveObject;
import flash.events.Event;

import net.wg.gui.components.controls.ScrollBar;
import net.wg.gui.components.controls.ScrollPane;
import net.wg.gui.cyberSport.staticFormation.components.StaticFormationStatsContainer;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStatsVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStatsViewVO;
import net.wg.gui.cyberSport.staticFormation.events.StaticFormationStatsEvent;
import net.wg.gui.cyberSport.staticFormation.views.IStaticFormationStatsView;
import net.wg.infrastructure.base.meta.impl.StaticFormationStatsViewMeta;

public class StaticFormationStatsView extends StaticFormationStatsViewMeta implements IStaticFormationStatsView {

    public var scrollPane:ScrollPane = null;

    public var scrollBar:ScrollBar = null;

    private var _content:StaticFormationStatsContainer = null;

    public function StaticFormationStatsView() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.scrollPane.scrollBar = this.scrollBar;
        this._content = StaticFormationStatsContainer(this.scrollPane.target);
        this._content.addEventListener(StaticFormationStatsEvent.CHANGE_FILTER, this.onContentChangeFilterHandler);
        this._content.addEventListener(Event.RESIZE, this.onContentResizeHandler);
    }

    override protected function onDispose():void {
        this._content.removeEventListener(StaticFormationStatsEvent.CHANGE_FILTER, this.onContentChangeFilterHandler);
        this._content.removeEventListener(Event.RESIZE, this.onContentResizeHandler);
        this._content = null;
        this.scrollPane.dispose();
        this.scrollPane = null;
        this.scrollBar.dispose();
        this.scrollBar = null;
        super.onDispose();
    }

    override protected function setData(param1:StaticFormationStatsViewVO):void {
        this._content.setData(param1);
    }

    override protected function setStats(param1:StaticFormationStatsVO):void {
        this._content.setStats(param1);
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return this;
    }

    public function update(param1:Object):void {
    }

    private function onContentChangeFilterHandler(param1:StaticFormationStatsEvent):void {
        selectSeasonS(param1.filterIndex);
    }

    private function onContentResizeHandler(param1:Event):void {
        this.scrollPane.invalidateSize();
    }
}
}
