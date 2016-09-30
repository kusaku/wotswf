package net.wg.infrastructure.tutorial.builders {
import flash.events.Event;

import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractView;
import net.wg.infrastructure.events.LifeCycleEvent;
import net.wg.infrastructure.events.TutorialHintEvent;
import net.wg.infrastructure.exceptions.AbstractException;
import net.wg.infrastructure.interfaces.ITutorialBuilder;
import net.wg.infrastructure.interfaces.IView;

public class TutorialBuilder implements ITutorialBuilder {

    private var _view:IView = null;

    private var _viewForHint:AbstractView = null;

    public function TutorialBuilder(param1:IView, param2:Object) {
        super();
        App.utils.asserter.assertNotNull(param1, "view for tutorial builder" + Errors.CANT_NULL);
        App.utils.asserter.assertNotNull(param2, "data for tutorial builder" + Errors.CANT_NULL);
        this._view = param1;
        this.getViewForHint();
        this._viewForHint.addEventListener(Event.RESIZE, this.onViewResizeHandler);
        this._viewForHint.addEventListener(LifeCycleEvent.ON_DISPOSE, this.onViewDisposeHandler);
        App.tutorialMgr.addEventListener(TutorialHintEvent.SETUP_HINT, this.onSetupHintHandler);
    }

    public final function dispose():void {
        this.onDispose();
    }

    protected function onDispose():void {
        this._viewForHint.removeEventListener(Event.RESIZE, this.onViewResizeHandler);
        this._viewForHint.removeEventListener(LifeCycleEvent.ON_DISPOSE, this.onViewDisposeHandler);
        App.tutorialMgr.removeEventListener(TutorialHintEvent.SETUP_HINT, this.onSetupHintHandler);
        this._view = null;
        this._viewForHint = null;
    }

    protected function getViewForHint():void {
        this._viewForHint = this.view as AbstractView;
        App.utils.asserter.assertNotNull(this._viewForHint, "_view as AbstractView" + Errors.CANT_NULL);
    }

    protected function onViewResize():void {
        var _loc1_:String = "onViewResize" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc1_);
        throw new AbstractException(_loc1_);
    }

    public function get view():IView {
        return this._view;
    }

    public function get viewForHint():AbstractView {
        return this._viewForHint;
    }

    protected function onSetupHint(param1:TutorialHintEvent):void {
        var _loc2_:String = "onViewResize" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    private function onViewResizeHandler(param1:Event):void {
        this.onViewResize();
    }

    private function onViewDisposeHandler(param1:LifeCycleEvent):void {
        this.dispose();
    }

    private function onSetupHintHandler(param1:TutorialHintEvent):void {
        this.onSetupHint(param1);
    }
}
}
