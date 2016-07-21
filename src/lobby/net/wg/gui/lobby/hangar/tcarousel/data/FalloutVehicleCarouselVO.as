package net.wg.gui.lobby.hangar.tcarousel.data {
public class FalloutVehicleCarouselVO extends VehicleCarouselVO {

    public var falloutSelected:Boolean = false;

    public var falloutCanBeSelected:Boolean = false;

    public var falloutButtonDisabled:Boolean = false;

    public var selectButtonTooltip:String = "";

    public var selectButtonLabel:String = "";

    public function FalloutVehicleCarouselVO(param1:Object) {
        super(param1);
    }
}
}
