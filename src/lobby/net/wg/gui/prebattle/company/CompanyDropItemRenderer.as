package net.wg.gui.prebattle.company {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.data.constants.Values;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.ListItemRenderer;
import scaleform.clik.utils.Constraints;

public class CompanyDropItemRenderer extends ListItemRenderer {

    public var numberField:TextField;

    public var bg:MovieClip;

    private var isUpdated:Boolean = false;

    public function CompanyDropItemRenderer() {
        super();
        buttonMode = true;
        mouseEnabled = true;
    }

    override public function setData(param1:Object):void {
        if (param1 == null) {
            return;
        }
        if (this.data != null && param1 == this.data) {
            return;
        }
        super.setData(param1);
        invalidateData();
    }

    override protected function configUI():void {
        super.configUI();
        constraints.addElement(this.numberField.name, this.numberField, Constraints.LEFT);
        constraints.addElement(this.bg.name, this.bg, Constraints.ALL);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA) && !this.isUpdated) {
            this.isUpdated = true;
            this.afterSetData();
        }
    }

    override protected function updateText():void {
        if (data && data.userName) {
            App.utils.commons.formatPlayerName(textField, App.utils.commons.getUserProps(data.userName, data.clanAbbrev, data.region, data.igrType));
            if (data["color"] != null) {
                textField.textColor = data["color"];
            }
        }
        else {
            textField.text = Values.EMPTY_STR;
        }
    }

    private function afterSetData():void {
        this.numberField.text = String(index + 1);
        this.bg.visible = !Boolean(index % 2);
    }
}
}
