package net.wg.gui.lobby.christmas.data {
import net.wg.gui.lobby.christmas.interfaces.IChristmasAnimationItemVO;
import net.wg.gui.lobby.christmas.interfaces.IChristmasAnimationVO;
import net.wg.gui.lobby.components.data.StoppableAnimationLoaderVO;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class ChristmasAwardAnimationLoaderVO extends StoppableAnimationLoaderVO implements IChristmasAnimationVO {

    private static const ITEMS_FIELD_NAME:String = "additionalItems";

    private static const MAIN_ITEM_FIELD_NAME:String = "mainItem";

    private var _mainItem:IChristmasAnimationItemVO;

    private var _additionalItems:Vector.<IChristmasAnimationItemVO>;

    public function ChristmasAwardAnimationLoaderVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == ITEMS_FIELD_NAME && param2 != null) {
            this._additionalItems = Vector.<IChristmasAnimationItemVO>(App.utils.data.convertVOArrayToVector(param1, param2, ChristmasAnimationItemVO));
            return false;
        }
        if (param1 == MAIN_ITEM_FIELD_NAME && param2 != null) {
            this._mainItem = new ChristmasAnimationItemVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        if (this._additionalItems != null) {
            for each(_loc1_ in this._additionalItems) {
                _loc1_.dispose();
            }
            this._additionalItems.fixed = false;
            this._additionalItems.splice(0, this._additionalItems.length);
            this._additionalItems = null;
        }
        if (this._mainItem != null) {
            this._mainItem.dispose();
            this._mainItem = null;
        }
        super.onDispose();
    }

    public function get additionalItems():Vector.<IChristmasAnimationItemVO> {
        return this._additionalItems;
    }

    public function get mainItem():IChristmasAnimationItemVO {
        return this._mainItem;
    }
}
}
