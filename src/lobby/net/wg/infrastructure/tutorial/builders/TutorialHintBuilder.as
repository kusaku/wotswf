package net.wg.infrastructure.tutorial.builders {
import flash.display.DisplayObject;
import flash.geom.Point;

import net.wg.data.constants.Errors;
import net.wg.data.constants.Linkages;
import net.wg.gui.components.advanced.tutorial.TutorialHint;
import net.wg.gui.components.advanced.vo.TutorialHintVO;
import net.wg.infrastructure.events.LifeCycleEvent;
import net.wg.infrastructure.events.TutorialHintEvent;
import net.wg.infrastructure.interfaces.IView;

public class TutorialHintBuilder extends TutorialBuilder {

    public static const HINT_GLOW_OFFSET:int = 13;

    private var _hint:TutorialHint = null;

    private var _component:DisplayObject = null;

    private var _model:TutorialHintVO = null;

    public function TutorialHintBuilder(param1:IView, param2:Object, param3:DisplayObject) {
        super(param1, param2);
        App.utils.asserter.assertNotNull(param3, "component for hint" + Errors.CANT_NULL);
        this._model = new TutorialHintVO(param2);
        this._component = param3;
        this._component.addEventListener(LifeCycleEvent.ON_DISPOSE, this.onComponentDisposeHandler);
        this.createAndLayoutHint();
        App.tutorialMgr.addEventListener(TutorialHintEvent.HIDE_HINT, this.onHideHintHandler);
    }

    override protected function onDispose():void {
        App.tutorialMgr.removeEventListener(TutorialHintEvent.HIDE_HINT, this.onHideHintHandler);
        if (this._component != null) {
            this._component.removeEventListener(LifeCycleEvent.ON_DISPOSE, this.onComponentDisposeHandler);
            this._component = null;
        }
        this.disposeHint();
        this.disposeModel();
        super.onDispose();
    }

    override protected function onViewResize():void {
        if (this._component != null) {
            this.layoutHint();
        }
    }

    protected function layoutHint():void {
        var _loc1_:Point = null;
        _loc1_ = this._component.localToGlobal(new Point(0, 0));
        _loc1_ = viewForHint.globalToLocal(_loc1_);
        this._hint.x = _loc1_.x - HINT_GLOW_OFFSET + this._model.padding.left ^ 0;
        this._hint.y = _loc1_.y - HINT_GLOW_OFFSET + this._model.padding.top ^ 0;
        this._hint.setSize(this._component.width - this._model.padding.left - this._model.padding.right, this._component.height - this._model.padding.top - this._model.padding.bottom);
    }

    private function disposeModel():void {
        if (this._model != null) {
            this._model.dispose();
            this._model = null;
        }
    }

    private function disposeHint():void {
        if (this._hint != null) {
            viewForHint.removeChild(this._hint);
            this._hint.dispose();
            this._hint = null;
        }
    }

    private function createAndLayoutHint():void {
        this.disposeHint();
        this._hint = App.utils.classFactory.getComponent(Linkages.TUTORIAL_HINT_UI, TutorialHint, {"model": this._model});
        App.utils.asserter.assertNotNull(this._hint, "_hint" + Errors.CANT_NULL);
        viewForHint.addChild(this._hint);
        this.layoutHint();
    }

    public function get component():DisplayObject {
        return this._component;
    }

    public function get model():TutorialHintVO {
        return this._model;
    }

    public function get hint():TutorialHint {
        return this._hint;
    }

    override protected function onSetupHint(param1:TutorialHintEvent):void {
        if (param1.component == this._component) {
            param1.handled = true;
            if (this._model != null && this._model.uniqueID != param1.data.uniqueID) {
                this.disposeModel();
                this._model = new TutorialHintVO(param1.data);
                this.createAndLayoutHint();
            }
            else {
                this._hint.show();
            }
        }
    }

    private function onHideHintHandler(param1:TutorialHintEvent):void {
        if (this._hint != null) {
            this._hint.hide();
        }
    }

    private function onComponentDisposeHandler(param1:LifeCycleEvent):void {
        this._component.removeEventListener(LifeCycleEvent.ON_DISPOSE, this.onComponentDisposeHandler);
        this._component = null;
        this.disposeHint();
    }
}
}
