package net.wg.gui.lobby.confirmModuleWindow {
import net.wg.gui.components.advanced.ExtraModuleIcon;
import net.wg.gui.lobby.window.ConfirmItemWindow;

public class ConfirmModuleWindow extends ConfirmItemWindow {

    public function ConfirmModuleWindow() {
        super();
    }

    override protected function onDispose():void {
        super.onDispose();
    }

    override protected function setData(param1:Object):void {
        data = new ModuleInfoVo(param1);
        invalidateData();
    }

    override protected function applyData():void {
        var _loc1_:ModuleInfoVo = ModuleInfoVo(data);
        var _loc2_:ExtraModuleIcon = App.utils.classFactory.getComponent(_loc1_.linkage, ExtraModuleIcon);
        _loc2_.setValueLabel(_loc1_.moduleLabel, _loc1_.level);
        _loc2_.extraIconSource = _loc1_.extraModuleInfo;
        content.setIcon(_loc2_);
        super.applyData();
    }
}
}
