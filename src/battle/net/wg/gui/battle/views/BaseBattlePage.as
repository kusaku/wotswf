package net.wg.gui.battle.views {
import flash.geom.Point;

import net.wg.data.constants.Linkages;
import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
import net.wg.gui.battle.components.interfaces.IBattleDisplayable;
import net.wg.gui.battle.views.damagePanel.DamagePanel;
import net.wg.gui.battle.views.messages.MessageListDAAPI;
import net.wg.gui.battle.views.minimap.Minimap;
import net.wg.gui.battle.views.minimap.MinimapEntryController;
import net.wg.gui.battle.views.minimap.events.MinimapEvent;
import net.wg.gui.battle.views.postMortemTips.PostmortemTips;
import net.wg.gui.battle.views.prebattleTimer.PrebattleTimer;
import net.wg.gui.battle.views.ribbonsPanel.RibbonsPanel;
import net.wg.infrastructure.base.meta.IBattlePageMeta;
import net.wg.infrastructure.base.meta.impl.BattlePageMeta;
import net.wg.infrastructure.base.meta.impl.BattleTimerMeta;
import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
import net.wg.infrastructure.interfaces.IDAAPIModule;
import net.wg.infrastructure.interfaces.entity.IDisplayable;

public class BaseBattlePage extends BattlePageMeta implements IBattlePageMeta {

    protected static const VEHICLE_MESSAGES_LIST_OFFSET:Point = new Point(500, 90);

    protected static const VEHICLE_MESSAGES_LIST_POSTMORMEM_Y_OFFSET:int = 30;

    protected static const VEHICLE_ERORRS_LIST_OFFSET:Point = new Point(300, 30);

    protected static const PLAYER_MESSAGES_LIST_OFFSET:Point = new Point(350, -38);

    protected static const PREBATTLE_TIMER_Y_OFFSET:int = 120;

    protected static const MESSANGER_Y_OFFSET:int = 6;

    public var prebattleTimer:PrebattleTimer = null;

    public var damagePanel:DamagePanel = null;

    public var minimap:Minimap = null;

    public var battleTimer:BattleTimerMeta = null;

    public var ribbonsPanel:RibbonsPanel = null;

    protected var vehicleMessageList:MessageListDAAPI;

    protected var vehicleErrorMessageList:MessageListDAAPI;

    protected var playerMessageList:MessageListDAAPI;

    protected var battleStatisticDataController:BattleStatisticDataController;

    protected var postmortemTips:PostmortemTips = null;

    private var _componentsStorage:Object;

    public function BaseBattlePage() {
        this._componentsStorage = new Object();
        super();
        this.initializeStatisticsController();
        this.initializeMessageLists();
    }

    protected function initializeStatisticsController():void {
    }

    protected function initializeMessageLists():void {
        this.vehicleMessageList = new MessageListDAAPI(this);
        this.vehicleErrorMessageList = new MessageListDAAPI(this);
        this.playerMessageList = new MessageListDAAPI(this);
    }

    override protected function configUI():void {
        this.updateStage(App.appWidth, App.appHeight);
        this.minimap.addEventListener(MinimapEvent.SIZE_CHANGED, this.onMiniMapChangeHandler);
        this.minimap.addEventListener(MinimapEvent.VISIBILITY_CHANGED, this.onMiniMapChangeHandler);
        super.configUI();
    }

    override protected function onPopulate():void {
        this.registerComponent(this.minimap, BATTLE_VIEW_ALIASES.MINIMAP);
        this.registerComponent(this.prebattleTimer, BATTLE_VIEW_ALIASES.PREBATTLE_TIMER);
        this.registerComponent(this.damagePanel, BATTLE_VIEW_ALIASES.DAMAGE_PANEL);
        this.registerComponent(this.battleTimer, BATTLE_VIEW_ALIASES.BATTLE_TIMER);
        this.registerComponent(this.ribbonsPanel, BATTLE_VIEW_ALIASES.RIBBONS_PANEL);
        this.registerComponent(this.vehicleMessageList, BATTLE_VIEW_ALIASES.VEHICLE_MESSAGES);
        this.registerComponent(this.vehicleErrorMessageList, BATTLE_VIEW_ALIASES.VEHICLE_ERROR_MESSAGES);
        this.registerComponent(this.playerMessageList, BATTLE_VIEW_ALIASES.PLAYER_MESSAGES);
        this.onRegisterStatisticController();
        super.onPopulate();
    }

    protected function onRegisterStatisticController():void {
    }

    override protected function onDispose():void {
        this.prebattleTimer = null;
        this.damagePanel = null;
        this.battleTimer = null;
        this.ribbonsPanel = null;
        this.minimap.removeEventListener(MinimapEvent.SIZE_CHANGED, this.onMiniMapChangeHandler);
        this.minimap.removeEventListener(MinimapEvent.VISIBILITY_CHANGED, this.onMiniMapChangeHandler);
        this.minimap = null;
        MinimapEntryController.instance.dispose();
        this.vehicleMessageList = null;
        this.vehicleErrorMessageList = null;
        this.playerMessageList = null;
        this.battleStatisticDataController = null;
        if (this.postmortemTips) {
            this.postmortemTips.dispose();
            this.postmortemTips = null;
        }
        App.utils.data.cleanupDynamicObject(this._componentsStorage);
        this._componentsStorage = null;
        super.onDispose();
    }

    override public function updateStage(param1:Number, param2:Number):void {
        var _loc3_:Number = NaN;
        super.updateStage(param1, param2);
        _loc3_ = param1 >> 1;
        _originalWidth = param1;
        _originalHeight = param2;
        setSize(param1, param2);
        this.prebattleTimer.y = PREBATTLE_TIMER_Y_OFFSET;
        this.prebattleTimer.x = _loc3_;
        this.damagePanel.x = 0;
        this.damagePanel.y = param2 - this.damagePanel.initedHeight;
        this.battleTimer.x = param1 - this.battleTimer.initedWidth;
        this.battleTimer.y = 0;
        this.ribbonsPanel.x = _loc3_;
        this.minimap.x = param1 - this.minimap.initedWidth;
        this.minimap.y = param2 - this.minimap.initedHeight;
        if (this.postmortemTips) {
            this.updatePostmortemTipsPosition();
        }
        this.vehicleErrorMessageList.setLocation(param1 - VEHICLE_ERORRS_LIST_OFFSET.x >> 1, (param2 >> 2) + VEHICLE_ERORRS_LIST_OFFSET.y);
        this.playerMessageListPositionUpdate();
        this.vehicleMessageListPositionUpdate();
    }

    private function showComponent(param1:String, param2:Boolean):void {
        var _loc3_:IBattleDisplayable = null;
        _loc3_ = this._componentsStorage[param1];
        App.utils.asserter.assertNotNull(_loc3_, "can\'t find component " + param1 + " in Battle Page");
        _loc3_.setCompVisible(param2);
    }

    private function onMiniMapChangeHandler(param1:MinimapEvent):void {
        this.playerMessageListPositionUpdate();
    }

    protected function playerMessageListPositionUpdate():void {
        this.playerMessageList.setLocation(_originalWidth - PLAYER_MESSAGES_LIST_OFFSET.x | 0, _originalHeight - this.minimap.getMessageCoordinate() + PLAYER_MESSAGES_LIST_OFFSET.y);
    }

    public function as_checkDAAPI():void {
    }

    public function as_setPostmortemTipsVisible(param1:Boolean):void {
        if (this.postmortemTips == null) {
            this.postmortemTips = App.utils.classFactory.getComponent(Linkages.POSTMORTEN_TIPS, PostmortemTips);
            addChild(this.postmortemTips);
            this.updatePostmortemTipsPosition();
        }
        this.postmortemTips.visible = param1;
        this.vehicleMessageListPositionUpdate();
    }

    private function vehicleMessageListPositionUpdate():void {
        if (this.postmortemTips && this.postmortemTips.visible) {
            this.vehicleMessageList.setLocation(_originalWidth - VEHICLE_MESSAGES_LIST_OFFSET.x >> 1, this.postmortemTips.y - this.postmortemTips.height - VEHICLE_MESSAGES_LIST_POSTMORMEM_Y_OFFSET | 0);
        }
        else {
            this.vehicleMessageList.setLocation(_originalWidth - VEHICLE_MESSAGES_LIST_OFFSET.x >> 1, _originalHeight - VEHICLE_MESSAGES_LIST_OFFSET.y | 0);
        }
    }

    private function updatePostmortemTipsPosition():void {
        this.postmortemTips.x = width >> 1;
        this.postmortemTips.y = height;
    }

    protected function registerComponent(param1:IDAAPIModule, param2:String):void {
        this._componentsStorage[param2] = param1;
        registerFlashComponentS(param1, param2);
    }

    public function as_isComponentVisible(param1:String):Boolean {
        var _loc2_:IDisplayable = null;
        _loc2_ = this._componentsStorage[param1];
        App.utils.asserter.assertNotNull(_loc2_, "can\'t find component " + param1 + " in Battle Page");
        return _loc2_.visible;
    }

    public function as_setComponentsVisibility(param1:Array, param2:Array):void {
        var _loc3_:String = null;
        if (param1) {
            for each(_loc3_ in param1) {
                this.showComponent(_loc3_, true);
            }
        }
        if (param2) {
            for each(_loc3_ in param2) {
                this.showComponent(_loc3_, false);
            }
        }
    }

    public function as_getComponentsVisibility():Array {
        var _loc2_:* = null;
        var _loc3_:IDisplayable = null;
        var _loc1_:Array = [];
        for (_loc2_ in this._componentsStorage) {
            _loc3_ = this._componentsStorage[_loc2_];
            if (_loc3_.visible) {
                _loc1_.push(_loc2_);
            }
        }
        return _loc1_;
    }

    public function as_toggleCtrlPressFlag(param1:Boolean):void {
        App.toolTipMgr.hide();
    }
}
}
