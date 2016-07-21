package net.wg.gui.lobby.fortifications.cmp.buildingProcess.impl {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.data.constants.SoundTypes;
import net.wg.gui.components.controls.TableRenderer;
import net.wg.gui.lobby.fortifications.data.buildingProcess.BuildingProcessListItemVO;
import net.wg.gui.lobby.fortifications.popovers.impl.PopoverBuildingTexture;

public class BuildingProcessItemRenderer extends TableRenderer {

    public var smallBuildingsIcon:PopoverBuildingTexture = null;

    public var buildingName:TextField = null;

    public var shortDescr:TextField = null;

    public var statusLbl:TextField = null;

    public var newItemIndicator:MovieClip;

    private var _model:BuildingProcessListItemVO = null;

    public function BuildingProcessItemRenderer() {
        super();
        soundType = SoundTypes.FORT_PROCESS_RENDERER;
        doubleClickEnabled = true;
        this.newItemIndicator.visible = false;
    }

    override public function setData(param1:Object):void {
        if (param1 == null) {
            return;
        }
        super.setData(param1);
        this._model = param1 as BuildingProcessListItemVO;
        this.smallBuildingsIcon.setState(this._model.buildingIcon);
        this.buildingName.htmlText = this._model.buildingName;
        this.shortDescr.htmlText = this._model.shortDescr;
        this.statusLbl.htmlText = this._model.statusLbl;
        this.newItemIndicator.visible = this._model.isNewItem;
        if (this._model.isNewItem) {
            this.newItemIndicator.gotoAndPlay("shine");
        }
    }

    override protected function onDispose():void {
        this.smallBuildingsIcon.dispose();
        this.smallBuildingsIcon = null;
        this.buildingName = null;
        this.shortDescr = null;
        this.statusLbl = null;
        this.newItemIndicator.stop();
        this.newItemIndicator = null;
        if (this._model) {
            this._model.dispose();
            this._model = null;
        }
        super.onDispose();
    }

    public function get model():BuildingProcessListItemVO {
        return this._model;
    }
}
}
