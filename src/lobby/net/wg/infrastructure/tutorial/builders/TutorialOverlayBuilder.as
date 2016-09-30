package net.wg.infrastructure.tutorial.builders {
import flash.events.Event;
import flash.events.MouseEvent;

import net.wg.data.constants.Errors;
import net.wg.data.constants.Linkages;
import net.wg.data.constants.Values;
import net.wg.gui.components.advanced.events.TutorialHelpBtnEvent;
import net.wg.gui.components.advanced.tutorial.TutorialContextOverlay;
import net.wg.gui.components.advanced.vo.TutorialContextOverlayVO;
import net.wg.infrastructure.events.TutorialHintEvent;
import net.wg.infrastructure.interfaces.IView;
import net.wg.infrastructure.tutorial.helpBtnControllers.interfaces.ITutorialHelpBtnController;

public class TutorialOverlayBuilder extends TutorialBuilder {

    private var _model:TutorialContextOverlayVO = null;

    private var _tutorialOverlay:TutorialContextOverlay = null;

    private var _viewTutorialId:String = "";

    private var _helpBtnController:ITutorialHelpBtnController = null;

    public function TutorialOverlayBuilder(param1:IView, param2:Object) {
        super(param1, param2);
        this._viewTutorialId = this.view.as_config.viewTutorialId;
        this._model = new TutorialContextOverlayVO(param2);
        this.createAndLayoutOverlay();
    }

    override protected function onDispose():void {
        App.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onStageClickHandler);
        App.utils.scheduler.cancelTask(this.createHelpBtnController);
        App.utils.scheduler.cancelTask(this.layoutOverlay);
        if (this._helpBtnController != null) {
            this._helpBtnController.removeEventListener(TutorialHelpBtnEvent.HELP_CLICK, this.onHelpBtnClickHandler);
            this._helpBtnController.dispose();
            this._helpBtnController = null;
        }
        this._tutorialOverlay.dispose();
        this._tutorialOverlay = null;
        if (this._model != null) {
            this._model.dispose();
            this._model = null;
        }
        super.onDispose();
    }

    override protected function onViewResize():void {
        this.layoutOverlay();
    }

    protected function layoutOverlay():void {
        this._tutorialOverlay.x = this._model.padding.left;
        this._tutorialOverlay.y = this._model.padding.top;
        this._tutorialOverlay.setSize(viewForHint.width - this._model.padding.left - this._model.padding.right, viewForHint.height - this._model.padding.top - this._model.padding.bottom);
    }

    private function createHelpBtnController():void {
        if (this._helpBtnController != null) {
            if (this._helpBtnController.model.btnControllerLnk == this._model.btnControllerVo.btnControllerLnk) {
                this._helpBtnController.model = this._model.btnControllerVo;
                this._helpBtnController.layoutHelpBtn();
                return;
            }
            this._helpBtnController.dispose();
            this._helpBtnController = null;
        }
        var _loc1_:String = this._model.btnControllerVo.btnControllerLnk != Values.EMPTY_STR ? this._model.btnControllerVo.btnControllerLnk : Linkages.DEFAULT_HELP_BTN_CONTROLLER_LNK;
        var _loc2_:Object = {
            "view": viewForHint,
            "model": this._model.btnControllerVo
        };
        this._helpBtnController = App.utils.classFactory.getObject(_loc1_, _loc2_) as ITutorialHelpBtnController;
        App.utils.asserter.assertNotNull(this._helpBtnController, "_helpBtnController" + Errors.CANT_NULL);
        this._helpBtnController.createHelpBtn();
        this._helpBtnController.addEventListener(TutorialHelpBtnEvent.HELP_CLICK, this.onHelpBtnClickHandler);
        _loc2_ = null;
    }

    private function showHideOverlay():void {
        if (!this._tutorialOverlay.visible) {
            viewForHint.setChildIndex(this._tutorialOverlay, viewForHint.numChildren - 1);
        }
        this._tutorialOverlay.visible = !this._tutorialOverlay.visible;
        if (this._tutorialOverlay.visible) {
            App.stage.addEventListener(MouseEvent.MOUSE_UP, this.onStageClickHandler);
        }
        else {
            App.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onStageClickHandler);
        }
    }

    private function createAndLayoutOverlay():void {
        this._tutorialOverlay = new TutorialContextOverlay();
        this._tutorialOverlay.setData(this._model);
        this._tutorialOverlay.visible = false;
        viewForHint.addChild(this._tutorialOverlay);
        App.utils.scheduler.scheduleOnNextFrame(this.createHelpBtnController);
        App.utils.scheduler.scheduleOnNextFrame(this.layoutOverlay);
    }

    public function get tutorialOverlay():TutorialContextOverlay {
        return this._tutorialOverlay;
    }

    public function get model():TutorialContextOverlayVO {
        return this._model;
    }

    override protected function onSetupHint(param1:TutorialHintEvent):void {
        if (param1.viewTutorialId == this._viewTutorialId && param1.component == null) {
            param1.handled = true;
            if (this._model != null && this._model.hintID != param1.data.hintID) {
                this._model.dispose();
                this._model = new TutorialContextOverlayVO(param1.data);
                this._tutorialOverlay.dispose();
                this._tutorialOverlay = null;
                this.createAndLayoutOverlay();
            }
        }
    }

    private function onStageClickHandler(param1:MouseEvent):void {
        if (this._helpBtnController.selected && param1.target != this._helpBtnController.helpBtn) {
            this._helpBtnController.selected = false;
            this.showHideOverlay();
        }
    }

    private function onHelpBtnClickHandler(param1:Event):void {
        this.showHideOverlay();
    }
}
}
