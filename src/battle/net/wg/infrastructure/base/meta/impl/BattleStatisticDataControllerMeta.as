package net.wg.infrastructure.base.meta.impl {
import flash.events.EventDispatcher;

import net.wg.data.constants.Errors;

public class BattleStatisticDataControllerMeta extends EventDispatcher {

    public var onRefreshComplete:Function;

    public function BattleStatisticDataControllerMeta() {
        super();
    }

    public function onRefreshCompleteS():void {
        App.utils.asserter.assertNotNull(this.onRefreshComplete, "onRefreshComplete" + Errors.CANT_NULL);
        this.onRefreshComplete();
    }
}
}
