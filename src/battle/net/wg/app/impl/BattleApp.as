package net.wg.app.impl {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.Sprite;

import net.wg.app.iml.base.AbstractApplication;
import net.wg.data.constants.AtlasConstants;
import net.wg.data.constants.ContainerTypes;
import net.wg.data.constants.generated.APP_CONTAINERS_NAMES;
import net.wg.gui.components.containers.CursorManagedContainer;
import net.wg.gui.components.containers.MainViewContainer;
import net.wg.gui.components.containers.ManagedContainer;
import net.wg.infrastructure.managers.GlobalVarsManager;
import net.wg.infrastructure.managers.IAtlasManager;
import net.wg.infrastructure.managers.ICacheManager;
import net.wg.infrastructure.managers.IColorSchemeManager;
import net.wg.infrastructure.managers.IContainerManager;
import net.wg.infrastructure.managers.IContextMenuManager;
import net.wg.infrastructure.managers.IEnvironmentManager;
import net.wg.infrastructure.managers.IEventLogManager;
import net.wg.infrastructure.managers.IGlobalVarsManager;
import net.wg.infrastructure.managers.IImageManager;
import net.wg.infrastructure.managers.ILoaderManager;
import net.wg.infrastructure.managers.IPopoverManager;
import net.wg.infrastructure.managers.ISoundManager;
import net.wg.infrastructure.managers.ITooltipMgr;
import net.wg.infrastructure.managers.ITutorialManager;
import net.wg.infrastructure.managers.IVoiceChatManager;
import net.wg.infrastructure.managers.impl.AtlasManager;
import net.wg.infrastructure.managers.impl.ClassManager;
import net.wg.infrastructure.managers.impl.ColorSchemeManagerBattle;
import net.wg.infrastructure.managers.impl.CommonsBattle;
import net.wg.infrastructure.managers.impl.ContainerManagerBattle;
import net.wg.infrastructure.managers.impl.ContextMenuManager;
import net.wg.infrastructure.managers.impl.EnvironmentManager;
import net.wg.infrastructure.managers.impl.LoaderManagerBase;
import net.wg.infrastructure.managers.impl.MockEventLogManager;
import net.wg.infrastructure.managers.impl.SoundManager;
import net.wg.infrastructure.managers.impl.TextManager;
import net.wg.infrastructure.managers.impl.ToolTipManagerBattle;
import net.wg.infrastructure.managers.impl.TutorialManagerBattle;
import net.wg.infrastructure.managers.impl.VoiceChatManagerBattle;
import net.wg.infrastructure.managers.pool.PoolManager;
import net.wg.infrastructure.managers.utils.impl.Asserter;
import net.wg.infrastructure.managers.utils.impl.ClassFactory;
import net.wg.infrastructure.managers.utils.impl.DataUtils;
import net.wg.infrastructure.managers.utils.impl.DateTimeBattle;
import net.wg.infrastructure.managers.utils.impl.EventCollector;
import net.wg.infrastructure.managers.utils.impl.FocusHandlerEx;
import net.wg.infrastructure.managers.utils.impl.IME;
import net.wg.infrastructure.managers.utils.impl.LocaleBase;
import net.wg.infrastructure.managers.utils.impl.PopupManager;
import net.wg.infrastructure.managers.utils.impl.Scheduler;
import net.wg.infrastructure.managers.utils.impl.StyleSheetManager;
import net.wg.infrastructure.managers.utils.impl.TweenManager;
import net.wg.infrastructure.managers.utils.impl.Utils;
import net.wg.infrastructure.managers.utils.impl.WGJSON;
import net.wg.utils.IGameInputManager;
import net.wg.utils.ITextManager;
import net.wg.utils.ITweenManager;
import net.wg.utils.IUtils;

import scaleform.clik.core.CLIK;
import scaleform.gfx.Extensions;

public final class BattleApp extends AbstractApplication {

    public static const BATTLE_REG_CMD:String = "registerBattleTest";

    private static const MAX_SWF_BATTLE_SIZE:Number = 600000;

    private var _libraries:MovieClip;

    private var _views:MainViewContainer;

    private var _windows:ManagedContainer;

    private var _dialogs:ManagedContainer;

    private var _toolTips:MovieClip;

    private var _systemMessages:Sprite;

    private var _cursorCtnr:ManagedContainer;

    public function BattleApp() {
        super();
        Extensions.enabled = true;
        Extensions.noInvisibleAdvance = true;
        CLIK.disableNullFocusMoves = true;
    }

    override protected function onBeforeAppConfiguring():void {
        super.onBeforeAppConfiguring();
        loaderMgr.initLibraries(this._libraries);
    }

    override protected function onPopUpManagerInit():void {
        super.onPopUpManagerInit();
        addChildAt(utils.popupMgr.popupCanvas, this.getTooltipsLayerIndex());
    }

    override protected function getNewUtils():IUtils {
        var _loc1_:IUtils = new Utils(new Asserter(), new Scheduler(), new LocaleBase(), new WGJSON(), null, new ClassFactory(), new PopupManager(), new CommonsBattle(), new FocusHandlerEx(), new EventCollector(), new IME(), null, null, new StyleSheetManager(), null, null, new DateTimeBattle(), new PoolManager(), new DataUtils());
        return _loc1_;
    }

    override protected function getMaxReleaseSize():Number {
        return MAX_SWF_BATTLE_SIZE;
    }

    override protected function getNewTweenManager():ITweenManager {
        return new TweenManager();
    }

    override protected function createContainers():void {
        this._libraries = new MovieClip();
        this._libraries.name = APP_CONTAINERS_NAMES.LIBRARIES;
        this._views = new MainViewContainer();
        this._views.type = ContainerTypes.VIEW;
        this._views.name = APP_CONTAINERS_NAMES.VIEWS;
        this._windows = new ManagedContainer();
        this._windows.type = ContainerTypes.WINDOW;
        this._windows.name = APP_CONTAINERS_NAMES.WINDOWS;
        this._systemMessages = new Sprite();
        this._systemMessages.name = APP_CONTAINERS_NAMES.SYSTEM_MESSAGES;
        this._dialogs = new ManagedContainer();
        this._dialogs.type = ContainerTypes.TOP_WINDOW;
        this._dialogs.name = APP_CONTAINERS_NAMES.DIALOGS;
        this._toolTips = new MovieClip();
        this._toolTips.name = APP_CONTAINERS_NAMES.TOOL_TIPS;
        this._cursorCtnr = new CursorManagedContainer();
        this._cursorCtnr.name = APP_CONTAINERS_NAMES.CURSOR;
        super.createContainers();
    }

    override protected function disposeContainers():void {
        super.disposeContainers();
        this._views.dispose();
        this._views = null;
        this._dialogs.dispose();
        this._dialogs = null;
        this._windows.dispose();
        this._windows = null;
        this._cursorCtnr.dispose();
        this._cursorCtnr = null;
        this._libraries = null;
        this._systemMessages = null;
        this._toolTips = null;
    }

    override protected function onDispose():void {
        super.onDispose();
    }

    override protected function getContainers():Vector.<DisplayObject> {
        var _loc1_:Vector.<DisplayObject> = new <DisplayObject>[this._libraries, this._views, this._windows, this._systemMessages, this._dialogs, this._toolTips, this._cursorCtnr];
        return _loc1_;
    }

    override protected function getRegCmdName():String {
        return BATTLE_REG_CMD;
    }

    override protected function getNewEnvironment():IEnvironmentManager {
        return EnvironmentManager.getInstance();
    }

    override protected function getNewSoundManager():ISoundManager {
        return new SoundManager();
    }

    override protected function getNewTooltipManager():ITooltipMgr {
        return new ToolTipManagerBattle(this._toolTips);
    }

    override protected function getNewContainerManager():IContainerManager {
        return new ContainerManagerBattle();
    }

    override protected function getNewColorSchemeManager():IColorSchemeManager {
        return new ColorSchemeManagerBattle();
    }

    override protected function getNewContextMenuManager():IContextMenuManager {
        return new ContextMenuManager();
    }

    override protected function getNewPopoverManager():IPopoverManager {
        return null;
    }

    override protected function getNewTutorialManager():ITutorialManager {
        return new TutorialManagerBattle();
    }

    override protected function getNewClassManager():Object {
        return new ClassManager();
    }

    override protected function getNewVoiceChatManager():IVoiceChatManager {
        return new VoiceChatManagerBattle();
    }

    override protected function getNewGameInputManager():IGameInputManager {
        return null;
    }

    override protected function getEventLogManager():IEventLogManager {
        return new MockEventLogManager();
    }

    override protected function getGlobalVarsManager():IGlobalVarsManager {
        return new GlobalVarsManager();
    }

    override protected function getNewLoaderManager():ILoaderManager {
        return new LoaderManagerBase();
    }

    override protected function getNewTextManager():ITextManager {
        return new TextManager();
    }

    override protected function getNewCacheManager():ICacheManager {
        return null;
    }

    override protected function getNewImageManagerManager():IImageManager {
        return null;
    }

    override protected function getNewAtlasManagerManager():IAtlasManager {
        return new AtlasManager();
    }

    override protected function initializeAtlasManager():void {
        App.atlasMgr.registerAtlas(AtlasConstants.BATTLE_ATLAS);
    }

    public function as_traceObject(param1:*):void {
        DebugUtils.LOG_DEBUG("traceObject", param1);
    }

    private function getTooltipsLayerIndex():Number {
        return getChildIndex(this._toolTips);
    }

    override public function get systemMessages():DisplayObjectContainer {
        return this._systemMessages;
    }

    override protected function onAfterAppConfiguring():void {
        DebugUtils.LOG_DEBUG("BattleApp configure finished");
        super.onAfterAppConfiguring();
    }
}
}
