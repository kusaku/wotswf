package net.wg.gui.lobby.vehicleCustomization.data.customizationPanel {
import net.wg.data.daapi.base.DAAPIDataClass;

public class CarouselDataVO extends DAAPIDataClass {

    private static const RENDERER_LIST_FIELD:String = "rendererList";

    public var rendererWidth:Number = 0;

    public var selectedIndex:int = -1;

    public var goToIndex:int = -1;

    public var filterCounter:String = "";

    public var messageVisible:Boolean = false;

    public var counterVisible:Boolean = false;

    private var _rendererList:Vector.<CarouselRendererVO> = null;

    public function CarouselDataVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Object = null;
        if (param1 == RENDERER_LIST_FIELD) {
            this._rendererList = new Vector.<CarouselRendererVO>();
            for each(_loc3_ in param2) {
                this._rendererList.push(new CarouselRendererVO(_loc3_));
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:CarouselRendererVO = null;
        for each(_loc1_ in this._rendererList) {
            _loc1_.dispose();
        }
        this._rendererList.splice(0, this._rendererList.length);
        this._rendererList = null;
        super.onDispose();
    }

    public function get renderersList():Vector.<CarouselRendererVO> {
        return this._rendererList;
    }
}
}
