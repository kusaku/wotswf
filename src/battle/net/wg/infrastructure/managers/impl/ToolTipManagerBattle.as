package net.wg.infrastructure.managers.impl {
import flash.display.DisplayObjectContainer;

import net.wg.data.managers.IToolTipParams;
import net.wg.data.managers.ITooltipProps;
import net.wg.data.managers.impl.TooltipProps;
import net.wg.infrastructure.managers.impl.TooltipMgr.ToolTipManagerBase;

public class ToolTipManagerBattle extends ToolTipManagerBase {

    public function ToolTipManagerBattle(param1:DisplayObjectContainer) {
        super(param1);
    }

    override public function getDefaultTooltipProps():ITooltipProps {
        return TooltipProps.DEFAULT;
    }

    override public function showLocal(param1:String, param2:Object, param3:ITooltipProps = null):void {
        if (!App.cursor.visible) {
            return;
        }
        super.showLocal(param1, param2, param3);
    }

    override public function showSpecial(param1:String, param2:ITooltipProps, ...rest):void {
        if (!App.cursor.visible) {
            return;
        }
        super.showSpecial.apply(null, [param1, param2].concat(rest));
    }

    override public function showComplex(param1:String, param2:ITooltipProps = null):void {
        if (!App.cursor.visible) {
            return;
        }
        super.showComplex(param1, param2);
    }

    override public function showComplexWithParams(param1:String, param2:IToolTipParams, param3:ITooltipProps = null):void {
        if (!App.cursor.visible) {
            return;
        }
        super.showComplexWithParams(param1, param2, param3);
    }

    override public function show(param1:String, param2:ITooltipProps = null):void {
        if (!App.cursor.visible) {
            return;
        }
        super.show(param1, param2);
    }
}
}
