package net.wg.gui.lobby.profile {
import net.wg.data.Aliases;
import net.wg.data.constants.Linkages;
import net.wg.gui.components.advanced.ButtonBarEx;
import net.wg.gui.events.ViewStackEvent;
import net.wg.gui.lobby.components.ResizableViewStack;
import net.wg.infrastructure.base.meta.IProfileTabNavigatorMeta;
import net.wg.infrastructure.base.meta.impl.ProfileTabNavigatorMeta;
import net.wg.infrastructure.interfaces.IDAAPIModule;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.IndexEvent;

public class ProfileTabNavigator extends ProfileTabNavigatorMeta implements IProfileTabNavigatorMeta {

    private static const OFFSET_INVALID:String = "layoutInv";

    private static const INIT_DATA_INV:String = "initDataInv";

    public var bar:ButtonBarEx = null;

    public var viewStack:ResizableViewStack = null;

    private var _data:ProfileMenuInfoVO = null;

    private var _sectionsDataUtil:LinkageUtils;

    private var _centerOffset:int = 0;

    public function ProfileTabNavigator() {
        this._sectionsDataUtil = new LinkageUtils();
        super();
        this._sectionsDataUtil.addEntity(Aliases.PROFILE_SUMMARY_PAGE, Linkages.PROFILE_SUMMARY_PAGE);
        this._sectionsDataUtil.addEntity(Aliases.PROFILE_SECTION, Linkages.PROFILE_TEST);
        this._sectionsDataUtil.addEntity(Aliases.PROFILE_SUMMARY_WINDOW, Linkages.PROFILE_SUMMARY_WINDOW);
        this._sectionsDataUtil.addEntity(Aliases.PROFILE_AWARDS, Linkages.PROFILE_AWARDS);
        this._sectionsDataUtil.addEntity(Aliases.PROFILE_STATISTICS, Linkages.PROFILE_STATISTICS);
        this._sectionsDataUtil.addEntity(Aliases.PROFILE_TECHNIQUE_WINDOW, Linkages.PROFILE_TECHNIQUE_WINDOW);
        this._sectionsDataUtil.addEntity(Aliases.PROFILE_TECHNIQUE_PAGE, Linkages.PROFILE_TECHNIQUE_PAGE);
        this._sectionsDataUtil.addEntity(Aliases.PROFILE_FORMATIONS_PAGE, Linkages.PROFILE_FORMATIONS);
    }

    override protected function configUI():void {
        super.configUI();
        this.viewStack.cache = true;
        this.bar.addEventListener(IndexEvent.INDEX_CHANGE, this.onTabBarIndexChanged, false, 0, true);
        this.viewStack.addEventListener(ViewStackEvent.NEED_UPDATE, this.onSectionViewShowed, false, 0, true);
    }

    override protected function draw():void {
        var _loc1_:Array = null;
        var _loc2_:uint = 0;
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        var _loc5_:int = 0;
        var _loc6_:String = null;
        var _loc7_:int = 0;
        var _loc8_:String = null;
        super.draw();
        if (isInvalid(INIT_DATA_INV) && this._data) {
            _loc1_ = this._data.sectionsData;
            _loc2_ = _loc1_.length;
            _loc3_ = [];
            _loc5_ = 0;
            _loc6_ = this._data.selectedAlias;
            _loc7_ = 0;
            while (_loc7_ < _loc2_) {
                _loc4_ = _loc1_[_loc7_];
                _loc8_ = _loc4_.alias;
                _loc3_.push(new SectionInfo(_loc8_, this._sectionsDataUtil.getLinkageByAlias(_loc8_), _loc4_.label, _loc4_.tooltip));
                if (_loc6_ == _loc8_) {
                    _loc5_ = _loc7_;
                }
                _loc7_++;
            }
            this.bar.dataProvider = new DataProvider(_loc3_);
            if (_loc3_.length > 0) {
                this.bar.selectedIndex = _loc5_;
            }
        }
        if (isInvalid(InvalidationType.SIZE)) {
            invalidate(OFFSET_INVALID);
        }
        if (isInvalid(OFFSET_INVALID)) {
            this.bar.x = (_width >> 1) - this._centerOffset >> 0;
            this.viewStack.centerOffset = this._centerOffset;
        }
    }

    override protected function onDispose():void {
        this._sectionsDataUtil.dispose();
        this._sectionsDataUtil = null;
        this.bar.removeEventListener(IndexEvent.INDEX_CHANGE, this.onTabBarIndexChanged, false);
        this.bar.dispose();
        this.bar = null;
        this.viewStack.removeEventListener(ViewStackEvent.NEED_UPDATE, this.onSectionViewShowed, false);
        this.viewStack.dispose();
        this.viewStack = null;
        this._data = null;
        super.onDispose();
    }

    override protected function setInitData(param1:ProfileMenuInfoVO):void {
        this._data = param1;
        invalidate(INIT_DATA_INV);
    }

    public function setAvailableSize(param1:Number, param2:Number):void {
        this.viewStack.setAvailableSize(param1, param2 - this.viewStack.y);
        setSize(param1, param2);
    }

    public function set centerOffset(param1:int):void {
        this._centerOffset = param1;
        invalidate(OFFSET_INVALID);
    }

    private function onSectionViewShowed(param1:ViewStackEvent):void {
        var _loc2_:String = this._sectionsDataUtil.getAliasByLinkage(param1.linkage);
        if (!isFlashComponentRegisteredS(_loc2_)) {
            registerFlashComponentS(IDAAPIModule(param1.view), _loc2_);
        }
    }

    private function onTabBarIndexChanged(param1:IndexEvent):void {
        if (param1.index != -1) {
            this.viewStack.show(this._sectionsDataUtil.getLinkageByAlias(SectionInfo(param1.data).alias));
        }
    }
}
}
