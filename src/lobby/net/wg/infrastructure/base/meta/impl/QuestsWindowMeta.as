package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.questsWindow.data.TabsVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class QuestsWindowMeta extends AbstractWindowView {

    public var onTabSelected:Function;

    private var _tabsVO:TabsVO;

    public function QuestsWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._tabsVO) {
            this._tabsVO.dispose();
            this._tabsVO = null;
        }
        super.onDispose();
    }

    public function onTabSelectedS(param1:String):void {
        App.utils.asserter.assertNotNull(this.onTabSelected, "onTabSelected" + Errors.CANT_NULL);
        this.onTabSelected(param1);
    }

    public function as_init(param1:Object):void {
        if (this._tabsVO) {
            this._tabsVO.dispose();
        }
        this._tabsVO = new TabsVO(param1);
        this.init(this._tabsVO);
    }

    protected function init(param1:TabsVO):void {
        var _loc2_:String = "as_init" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
