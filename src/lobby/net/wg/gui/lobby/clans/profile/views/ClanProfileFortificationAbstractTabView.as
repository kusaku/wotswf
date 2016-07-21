package net.wg.gui.lobby.clans.profile.views {
import flash.display.InteractiveObject;

import net.wg.data.constants.Errors;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileFortificationViewVO;
import net.wg.gui.lobby.clans.profile.interfaces.IClanProfileFortificationTabView;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.exceptions.AbstractException;
import net.wg.infrastructure.interfaces.IViewStackContent;

import scaleform.clik.constants.InvalidationType;

public class ClanProfileFortificationAbstractTabView extends UIComponentEx implements IClanProfileFortificationTabView, IViewStackContent {

    protected var _model:ClanProfileFortificationViewVO = null;

    public function ClanProfileFortificationAbstractTabView() {
        super();
    }

    override protected function onDispose():void {
        this._model = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            this.applyData();
        }
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return this;
    }

    public function isDataSet():Boolean {
        return this._model != null;
    }

    public function setData(param1:ClanProfileFortificationViewVO):void {
        this._model = param1;
        invalidateData();
    }

    public function update(param1:Object):void {
    }

    protected function applyData():void {
        throw new AbstractException("ClanProfileFortificationAbstractTabView.as_setData" + Errors.ABSTRACT_INVOKE);
    }
}
}
