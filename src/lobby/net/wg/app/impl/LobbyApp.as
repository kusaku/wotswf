package net.wg.app.impl {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;

import net.wg.app.iml.base.AbstractApplication;
import net.wg.data.constants.ContainerTypes;
import net.wg.gui.components.containers.CursorManagedContainer;
import net.wg.gui.components.containers.MainViewContainer;
import net.wg.gui.components.containers.ManagedContainer;
import net.wg.gui.components.containers.WaitingManagedContainer;
import net.wg.infrastructure.interfaces.IManagedContainer;
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
import net.wg.infrastructure.managers.impl.CacheManager;
import net.wg.infrastructure.managers.impl.ClassManager;
import net.wg.infrastructure.managers.impl.ColorSchemeManagerLobby;
import net.wg.infrastructure.managers.impl.ContainerManagerLobby;
import net.wg.infrastructure.managers.impl.ContextMenuManager;
import net.wg.infrastructure.managers.impl.EnvironmentManager;
import net.wg.infrastructure.managers.impl.EventLogManager;
import net.wg.infrastructure.managers.impl.GameInputManager;
import net.wg.infrastructure.managers.impl.ImageManager;
import net.wg.infrastructure.managers.impl.LoaderManagerLobby;
import net.wg.infrastructure.managers.impl.PopoverManager;
import net.wg.infrastructure.managers.impl.SoundManager;
import net.wg.infrastructure.managers.impl.TextManager;
import net.wg.infrastructure.managers.impl.ToolTipManagerLobby;
import net.wg.infrastructure.managers.impl.TutorialManagerLobby;
import net.wg.infrastructure.managers.impl.VoiceChatManagerLobby;
import net.wg.infrastructure.managers.pool.PoolManager;
import net.wg.infrastructure.managers.utils.impl.AnimBuilder;
import net.wg.infrastructure.managers.utils.impl.Asserter;
import net.wg.infrastructure.managers.utils.impl.ClassFactory;
import net.wg.infrastructure.managers.utils.impl.CommonsLobby;
import net.wg.infrastructure.managers.utils.impl.DataUtils;
import net.wg.infrastructure.managers.utils.impl.DateTimeLobby;
import net.wg.infrastructure.managers.utils.impl.EventCollector;
import net.wg.infrastructure.managers.utils.impl.FocusHandlerEx;
import net.wg.infrastructure.managers.utils.impl.HelpLayoutManager;
import net.wg.infrastructure.managers.utils.impl.IME;
import net.wg.infrastructure.managers.utils.impl.Icons;
import net.wg.infrastructure.managers.utils.impl.LocaleLobby;
import net.wg.infrastructure.managers.utils.impl.Nations;
import net.wg.infrastructure.managers.utils.impl.PopupManager;
import net.wg.infrastructure.managers.utils.impl.Scheduler;
import net.wg.infrastructure.managers.utils.impl.StyleSheetManager;
import net.wg.infrastructure.managers.utils.impl.TweenAnimator;
import net.wg.infrastructure.managers.utils.impl.TweenManager;
import net.wg.infrastructure.managers.utils.impl.Utils;
import net.wg.infrastructure.managers.utils.impl.VOManager;
import net.wg.infrastructure.managers.utils.impl.WGJSON;
import net.wg.utils.IGameInputManager;
import net.wg.utils.ITextManager;
import net.wg.utils.ITweenManager;
import net.wg.utils.IUtils;

import scaleform.clik.core.CLIK;
import scaleform.gfx.Extensions;

public final class LobbyApp extends AbstractApplication {

    public static const APP_REG_CMD:String = "registerApplication";

    private static const TOOLTIP_CONTAINER_NAME:String = "ttContainer";

    private static const MAX_SWF_BATTLE_SIZE:Number = 5000000;

    public var browserBgClassValue:Class;

    public var altBrowserBgClassValue:Class;

    private var _libraries:MovieClip;

    private var _serviceLayout:ManagedContainer;

    private var _views:MainViewContainer;

    private var _windows:ManagedContainer;

    private var _browser:ManagedContainer;

    private var _dialogs:ManagedContainer;

    private var _toolTips:MovieClip;

    private var _cursorCtnr:ManagedContainer;

    private var _waitingCtnr:ManagedContainer;

    private var _systemMessages:Sprite;

    public function LobbyApp() {
        this.browserBgClassValue = LobbyApp_browserBgClassValue;
        this.altBrowserBgClassValue = LobbyApp_altBrowserBgClassValue;
        super();
        Extensions.enabled = true;
        Extensions.noInvisibleAdvance = true;
        CLIK.disableNullFocusMoves = true;
    }

    override public function getManagedContainer(param1:String):IManagedContainer {
        var _loc2_:ManagedContainer = new ManagedContainer();
        _loc2_.type = param1;
        return _loc2_;
    }

    override protected function getNewUtils():IUtils {
        var _loc1_:IUtils = new Utils(new Asserter(), new Scheduler(), new LocaleLobby(), new WGJSON(), new HelpLayoutManager(), new ClassFactory(), new PopupManager(), new CommonsLobby(), new FocusHandlerEx(), new EventCollector(), new IME(), new VOManager(), new Icons(), new StyleSheetManager(), new TweenAnimator(), new AnimBuilder(), new DateTimeLobby(), new PoolManager(), new DataUtils());
        _loc1_.setNations(new Nations(_loc1_));
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
        this._serviceLayout = new ManagedContainer();
        this._serviceLayout.type = ContainerTypes.SERVICE_LAYOUT;
        this._views = new MainViewContainer();
        this._views.type = ContainerTypes.VIEW;
        this._windows = new ManagedContainer();
        this._windows.type = ContainerTypes.WINDOW;
        this._systemMessages = new Sprite();
        this._browser = new ManagedContainer();
        this._browser.type = ContainerTypes.BROWSER;
        this._dialogs = new ManagedContainer();
        this._dialogs.type = ContainerTypes.TOP_WINDOW;
        this._toolTips = new MovieClip();
        this._toolTips.name = TOOLTIP_CONTAINER_NAME;
        this._cursorCtnr = new CursorManagedContainer();
        this._waitingCtnr = new WaitingManagedContainer();
        super.createContainers();
    }

    override protected function disposeContainers():void {
        super.disposeContainers();
        this._views.dispose();
        this._views = null;
        while (this._libraries.numChildren) {
            this._libraries.removeChildAt(this._libraries.numChildren - 1);
        }
        this._libraries = null;
        this._windows.dispose();
        this._windows = null;
        this._browser.dispose();
        this._browser = null;
        this._dialogs.dispose();
        this._dialogs = null;
        this._systemMessages = null;
        this._toolTips = null;
        this._serviceLayout.dispose();
        this._serviceLayout = null;
        this._cursorCtnr.dispose();
        this._cursorCtnr = null;
        this._waitingCtnr.dispose();
        this._waitingCtnr = null;
    }

    override protected function getContainers():Vector.<DisplayObject> {
        var _loc1_:Vector.<DisplayObject> = new <DisplayObject>[this._libraries, this._views, this._windows, this._systemMessages, this._browser, this._dialogs, utils.IME.getContainer(), this._toolTips, this._serviceLayout, this._cursorCtnr, this._waitingCtnr];
        return _loc1_;
    }

    override protected function getNewEnvironment():IEnvironmentManager {
        return EnvironmentManager.getInstance();
    }

    override protected function getNewSoundManager():ISoundManager {
        return new SoundManager();
    }

    override protected function getNewTooltipManager():ITooltipMgr {
        return new ToolTipManagerLobby(this._toolTips);
    }

    override protected function getNewContainerManager():IContainerManager {
        return new ContainerManagerLobby();
    }

    override protected function getNewColorSchemeManager():IColorSchemeManager {
        return new ColorSchemeManagerLobby();
    }

    override protected function getNewContextMenuManager():IContextMenuManager {
        return new ContextMenuManager();
    }

    override protected function getNewPopoverManager():IPopoverManager {
        return new PopoverManager(stage);
    }

    override protected function getNewClassManager():Object {
        return new ClassManager();
    }

    override protected function getNewVoiceChatManager():IVoiceChatManager {
        return new VoiceChatManagerLobby();
    }

    override protected function getNewGameInputManager():IGameInputManager {
        return new GameInputManager();
    }

    override protected function getEventLogManager():IEventLogManager {
        return new EventLogManager();
    }

    override protected function getGlobalVarsManager():IGlobalVarsManager {
        return new GlobalVarsManager();
    }

    override protected function getNewLoaderManager():ILoaderManager {
        return new LoaderManagerLobby();
    }

    override protected function getNewTextManager():ITextManager {
        return new TextManager();
    }

    override protected function getNewCacheManager():ICacheManager {
        return new CacheManager();
    }

    override protected function getNewTutorialManager():ITutorialManager {
        return new TutorialManagerLobby();
    }

    override protected function getNewAtlasManagerManager():IAtlasManager {
        return null;
    }

    override protected function getNewImageManagerManager():IImageManager {
        return new ImageManager();
    }

    override protected function onBeforeAppConfiguring():void {
        super.onBeforeAppConfiguring();
        loaderMgr.initLibraries(this._libraries);
    }

    override protected function onPopUpManagerInit():void {
        super.onPopUpManagerInit();
        addChildAt(utils.popupMgr.popupCanvas, this.getTooltipsLayerIndex());
    }

    override protected function getRegCmdName():String {
        return APP_REG_CMD;
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

    override public function get browserBgClass():Class {
        return this.browserBgClassValue;
    }

    override public function get altBrowserBgClass():Class {
        return this.altBrowserBgClassValue;
    }

    override protected function initStage(param1:Event = null):void {
        if (gameInputMgr) {
            gameInputMgr.initStage(this.stage);
        }
        super.initStage(param1);
    }
}
}
