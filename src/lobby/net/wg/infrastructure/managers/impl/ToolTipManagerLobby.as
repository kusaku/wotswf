package net.wg.infrastructure.managers.impl {
import flash.display.DisplayObjectContainer;

import net.wg.data.constants.Linkages;
import net.wg.data.constants.generated.BLOCKS_TOOLTIP_TYPES;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.data.managers.ITooltipProps;
import net.wg.data.managers.impl.TooltipProps;
import net.wg.gui.components.tooltips.Separator;
import net.wg.gui.components.tooltips.inblocks.TooltipInBlocks;
import net.wg.gui.components.tooltips.inblocks.interfaces.ITooltipBlock;
import net.wg.infrastructure.events.LibraryLoaderEvent;
import net.wg.infrastructure.interfaces.pool.IPoolManager;
import net.wg.infrastructure.managers.impl.TooltipMgr.ToolTipManagerBase;
import net.wg.infrastructure.managers.pool.ComponentsPool;

public class ToolTipManagerLobby extends ToolTipManagerBase {

    private static const TOOLTIPS_SWF_URL:String = "tooltips.swf";

    private static const NUM_TEXT_BLOCK_POOL_ITEMS:int = 20;

    private static const NUM_BUILD_UP_BLOCK_POOL_ITEMS:int = 10;

    private static const NUM_SEPARATOR_POOL_ITEMS:int = 20;

    private static const NUM_IMAGE_TEXT_BLOCK_POOL_ITEMS:int = 15;

    private static const NUM_TEXT_PARAMETER_BLOCK_POOL_ITEMS:int = 15;

    private static const NUM_TEXT_PARAMETER_BLOCK_WITH_ICON_POOL_ITEMS:int = 15;

    public function ToolTipManagerLobby(param1:DisplayObjectContainer) {
        super(param1);
        App.instance.loaderMgr.addEventListener(LibraryLoaderEvent.LOADED, this.onLoaderMangerLoadedHandler);
    }

    override public function getDefaultTooltipProps():ITooltipProps {
        return TooltipProps.DEFAULT;
    }

    override protected function onDispose():void {
        App.instance.loaderMgr.removeEventListener(LibraryLoaderEvent.LOADED, this.onLoaderMangerLoadedHandler);
        super.onDispose();
    }

    private function createPools():void {
        var _loc1_:IPoolManager = App.utils.poolManager;
        this.addTooltipBlocksPool(_loc1_, BLOCKS_TOOLTIP_TYPES.TOOLTIP_TEXT_BLOCK_LINKAGE, NUM_TEXT_BLOCK_POOL_ITEMS);
        this.addTooltipBlocksPool(_loc1_, BLOCKS_TOOLTIP_TYPES.TOOLTIP_BUILDUP_BLOCK_LINKAGE, NUM_BUILD_UP_BLOCK_POOL_ITEMS);
        this.addTooltipBlocksPool(_loc1_, BLOCKS_TOOLTIP_TYPES.TOOLTIP_IMAGETEXT_BLOCK_LINKAGE, NUM_IMAGE_TEXT_BLOCK_POOL_ITEMS);
        this.addTooltipBlocksPool(_loc1_, BLOCKS_TOOLTIP_TYPES.TOOLTIP_TEXT_PARAMETER_BLOCK_LINKAGE, NUM_TEXT_PARAMETER_BLOCK_POOL_ITEMS);
        this.addTooltipBlocksPool(_loc1_, BLOCKS_TOOLTIP_TYPES.TOOLTIP_TEXT_PARAMETER_WITH_ICON_BLOCK_LINKAGE, NUM_TEXT_PARAMETER_BLOCK_WITH_ICON_POOL_ITEMS);
        this.addTooltipBlocksPool(_loc1_, BLOCKS_TOOLTIP_TYPES.TOOLTIP_BUILDUP_BLOCK_WHITE_BG_LINKAGE, NUM_BUILD_UP_BLOCK_POOL_ITEMS);
        this.addTooltipBlocksPool(_loc1_, BLOCKS_TOOLTIP_TYPES.TOOLTIP_BUILDUP_BLOCK_NORMAL_VEHICLE_BG_LINKAGE, NUM_BUILD_UP_BLOCK_POOL_ITEMS);
        this.addTooltipBlocksPool(_loc1_, BLOCKS_TOOLTIP_TYPES.TOOLTIP_BUILDUP_BLOCK_ELITE_VEHICLE_BG_LINKAGE, NUM_BUILD_UP_BLOCK_POOL_ITEMS);
        _loc1_.addPool(Linkages.TOOLTIP_SEPARATOR_UI, new ComponentsPool(NUM_SEPARATOR_POOL_ITEMS, Linkages.TOOLTIP_SEPARATOR_UI, Separator));
    }

    private function addTooltipBlocksPool(param1:IPoolManager, param2:String, param3:uint):void {
        param1.addPool(param2, new ComponentsPool(param3, param2, ITooltipBlock));
    }

    private function onLoaderMangerLoadedHandler(param1:LibraryLoaderEvent):void {
        var _loc2_:String = null;
        if (param1.url.toLowerCase().indexOf(TOOLTIPS_SWF_URL) >= 0) {
            App.instance.loaderMgr.removeEventListener(LibraryLoaderEvent.LOADED, this.onLoaderMangerLoadedHandler);
            _loc2_ = TOOLTIPS_CONSTANTS.INBLOCKS_DEFAULT_UI;
            cacheComponent(_loc2_, App.utils.classFactory.getComponent(_loc2_, TooltipInBlocks));
            this.createPools();
        }
    }
}
}
