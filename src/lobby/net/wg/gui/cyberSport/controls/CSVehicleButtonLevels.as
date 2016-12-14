package net.wg.gui.cyberSport.controls {
import flash.display.MovieClip;

import net.wg.infrastructure.base.UIComponentEx;

public class CSVehicleButtonLevels extends UIComponentEx {

    private static const UPDATE_LEVELS:String = "updateLevels";

    public var vehicleLevelEff:MovieClip;

    public var vehicleLevel:MovieClip;

    private var state:String;

    private var levels:uint = 0;

    public function CSVehicleButtonLevels() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(UPDATE_LEVELS) && this.levels != 0) {
            this.vehicleLevel.gotoAndStop(this.levels);
            this.vehicleLevelEff.gotoAndStop(this.levels);
        }
    }

    public function setData(param1:uint):void {
        this.levels = param1;
        invalidate(UPDATE_LEVELS);
    }

    public function setState(param1:String):void {
        this.state = param1;
        gotoAndPlay(this.state);
    }
}
}
