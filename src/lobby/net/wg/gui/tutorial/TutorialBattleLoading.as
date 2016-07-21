package net.wg.gui.tutorial {
import net.wg.gui.lobby.battleloading.BaseBattleLoading;
import net.wg.gui.lobby.battleloading.interfaces.ITipLoadingForm;
import net.wg.gui.lobby.battleloading.vo.TutorialInfoVO;

public class TutorialBattleLoading extends BaseBattleLoading {

    private static const FORM_HEIGHT:Number = 752;

    public var form:ITipLoadingForm;

    public function TutorialBattleLoading() {
        super();
    }

    override public function as_addVehicleInfo(param1:Object):void {
    }

    override public function as_setArenaInfo(param1:Object):void {
        var _loc2_:TutorialInfoVO = new TutorialInfoVO(param1);
        this.form.setBattleTypeName(_loc2_.battleTypeLocaleStr);
        this.form.updateMapName(_loc2_.mapName);
        this.form.updateTipTitle(_loc2_.tipTitle);
        this.form.updateTipBody(_loc2_.tipText);
        this.form.setBattleTypeFrameName(_loc2_.battleTypeFrameLabel);
        _loc2_.dispose();
    }

    override public function as_setMapIcon(param1:String):void {
    }

    override public function as_setPlayerData(param1:Number, param2:Number):void {
    }

    override public function as_setPlayerStatus(param1:Object):void {
    }

    override public function as_setProgress(param1:Number):void {
        this.form.updateProgress(param1);
    }

    override public function as_setTip(param1:String):void {
    }

    override public function as_setTipTitle(param1:String):void {
    }

    override public function as_setVehicleStatus(param1:Object):void {
    }

    override public function as_setVehiclesData(param1:Object):void {
    }

    override public function as_setVisualTipInfo(param1:Object):void {
    }

    override public function as_updateVehicleInfo(param1:Object):void {
    }

    override public function updateStage(param1:Number, param2:Number):void {
        this.form.x = param1 >> 1;
        this.form.y = param2 - FORM_HEIGHT >> 1;
    }

    override protected function configUI():void {
        super.configUI();
        App.contextMenuMgr.hide();
    }

    override protected function onDispose():void {
        this.form.dispose();
        this.form = null;
        super.onDispose();
    }
}
}
