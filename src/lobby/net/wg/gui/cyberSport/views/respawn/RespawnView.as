package net.wg.gui.cyberSport.views.respawn {
import flash.display.InteractiveObject;
import flash.events.Event;

import net.wg.data.Aliases;
import net.wg.data.constants.LobbyMetrics;
import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.cyberSport.interfaces.ICSAutoSearchMainView;
import net.wg.gui.cyberSport.interfaces.IChannelComponentHolder;
import net.wg.gui.cyberSport.vo.AutoSearchVO;
import net.wg.gui.events.UILoaderEvent;
import net.wg.infrastructure.base.meta.ICyberSportRespawnViewMeta;
import net.wg.infrastructure.base.meta.impl.CyberSportRespawnViewMeta;

public class RespawnView extends CyberSportRespawnViewMeta implements ICyberSportRespawnViewMeta {

    private static const BG_MAP_ALPHA:Number = 0.2;

    private static var INVALID_BG_IMG:String = "invalidBgImg";

    public var mapBG:UILoaderAlt = null;

    public var form:RespawnForm = null;

    public var autoSearch:ICSAutoSearchMainView = null;

    private var mapBgSource:String = "";

    private var _focusTo:InteractiveObject = null;

    public function RespawnView() {
        super();
        this.autoSearch.visible = false;
        this.form.unitTeamSection.addEventListener(Event.COMPLETE, this.onFormGetDataHandler);
        this._focusTo = this.form.unitTeamSection.btnFight;
        this.mapBG.alpha = BG_MAP_ALPHA;
    }

    override public function updateStage(param1:Number, param2:Number):void {
        this.form.x = param1 >> 1;
        this.form.y = App.appHeight - LobbyMetrics.MIN_STAGE_HEIGHT >> 2;
        this.mapBG.x = 0;
        this.mapBG.y = 0;
        var _loc3_:Number = 1920 / 1200;
        var _loc4_:Number = param1 / param2;
        if (_loc3_ > _loc4_) {
            this.mapBG.width = param2 * _loc3_;
            this.mapBG.height = param2;
        }
        else {
            this.mapBG.width = param1;
            this.mapBG.height = param1 * (1 / _loc3_);
        }
        this.mapBG.x = param1 - this.mapBG.width >> 1;
        this.mapBG.y = param2 - this.mapBG.height >> 1;
        this.autoSearch.x = 0;
        this.autoSearch.y = 0;
        this.autoSearch.setSize(param1, param2);
    }

    override protected function configUI():void {
        super.configUI();
    }

    override protected function onPopulate():void {
        super.onPopulate();
        registerFlashComponentS(this.form.minimap, Aliases.LOBBY_MINIMAP);
        registerFlashComponentS(this.form, CYBER_SPORT_ALIASES.CS_RESPAWN_FORM);
        var _loc1_:IChannelComponentHolder = this.form as IChannelComponentHolder;
        if (_loc1_ != null) {
            registerFlashComponentS(_loc1_.getChannelComponent(), Aliases.CHANNEL_COMPONENT);
        }
    }

    override protected function draw():void {
        if (isInvalid(INVALID_BG_IMG) && this.mapBG) {
            this.mapBG.source = this.mapBgSource;
        }
    }

    override protected function onDispose():void {
        this.autoSearch.dispose();
        this.autoSearch = null;
        this.mapBG.removeEventListener(UILoaderEvent.COMPLETE, this.onLoaderCompleteBGImageHandler);
        this.mapBG.removeEventListener(UILoaderEvent.IOERROR, this.onLoaderCompleteBGImageHandler);
        this.mapBG.dispose();
        this.mapBG = null;
        this._focusTo = null;
        if (this.form && this.form.unitTeamSection) {
            this.form.unitTeamSection.removeEventListener(Event.COMPLETE, this.onFormGetDataHandler);
        }
        this.form = null;
        super.onDispose();
    }

    override protected function onSetModalFocus(param1:InteractiveObject):void {
        super.onSetModalFocus(this._focusTo);
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(this._focusTo);
    }

    override protected function changeAutoSearchState(param1:AutoSearchVO):void {
        this.autoSearch.setData(param1);
        this.autoSearch.visible = true;
    }

    public function as_hideAutoSearch():void {
        this.autoSearch.stopTimer();
        this.autoSearch.visible = false;
    }

    public function as_setMapBG(param1:String):void {
        if (this.mapBgSource == param1) {
            return;
        }
        this.mapBgSource = param1;
        if (this.mapBG) {
            this.mapBG.addEventListener(UILoaderEvent.COMPLETE, this.onLoaderCompleteBGImageHandler);
            this.mapBG.addEventListener(UILoaderEvent.IOERROR, this.onLoaderCompleteBGImageHandler);
            this.mapBG.source = this.mapBgSource;
        }
        invalidate(INVALID_BG_IMG);
    }

    private function getElementForFocus():InteractiveObject {
        return this.form.unitTeamSection.getComponentForFocus();
    }

    private function onFormGetDataHandler(param1:Event):void {
        this.form.unitTeamSection.removeEventListener(Event.COMPLETE, this.onFormGetDataHandler);
        var _loc2_:InteractiveObject = this.getElementForFocus();
        if (_loc2_ != null) {
            this._focusTo = _loc2_;
        }
        setFocus(this._focusTo);
    }

    private function onLoaderCompleteBGImageHandler(param1:UILoaderEvent):void {
        this.mapBG.removeEventListener(UILoaderEvent.COMPLETE, this.onLoaderCompleteBGImageHandler);
        this.mapBG.removeEventListener(UILoaderEvent.IOERROR, this.onLoaderCompleteBGImageHandler);
    }
}
}
