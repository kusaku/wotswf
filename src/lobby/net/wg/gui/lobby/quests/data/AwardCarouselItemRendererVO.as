package net.wg.gui.lobby.quests.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class AwardCarouselItemRendererVO extends DAAPIDataClass {

    public var imgSource:String = "";

    public var label:String = "";

    public var counter:String = "";

    public var tooltip:String = "";

    public var specialArgs:Array = null;

    public var specialAlias:String = "";

    public var isSpecial:Boolean = false;

    public var scaleImg:Number = 1;

    public function AwardCarouselItemRendererVO(param1:Object) {
        super(param1);
    }
}
}
