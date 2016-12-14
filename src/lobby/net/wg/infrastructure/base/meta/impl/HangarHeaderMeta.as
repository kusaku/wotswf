package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.hangar.data.HangarHeaderVO;
import net.wg.infrastructure.base.BaseDAAPIComponent;
import net.wg.infrastructure.exceptions.AbstractException;

public class HangarHeaderMeta extends BaseDAAPIComponent {

    public var showCommonQuests:Function;

    public var showPersonalQuests:Function;

    private var _hangarHeaderVO:HangarHeaderVO;

    public function HangarHeaderMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._hangarHeaderVO) {
            this._hangarHeaderVO.dispose();
            this._hangarHeaderVO = null;
        }
        super.onDispose();
    }

    public function showCommonQuestsS():void {
        App.utils.asserter.assertNotNull(this.showCommonQuests, "showCommonQuests" + Errors.CANT_NULL);
        this.showCommonQuests();
    }

    public function showPersonalQuestsS():void {
        App.utils.asserter.assertNotNull(this.showPersonalQuests, "showPersonalQuests" + Errors.CANT_NULL);
        this.showPersonalQuests();
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:HangarHeaderVO = this._hangarHeaderVO;
        this._hangarHeaderVO = new HangarHeaderVO(param1);
        this.setData(this._hangarHeaderVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:HangarHeaderVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
