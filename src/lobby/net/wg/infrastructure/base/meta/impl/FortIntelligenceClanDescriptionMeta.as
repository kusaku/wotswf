package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.ClanDescriptionVO;
import net.wg.infrastructure.base.BaseDAAPIComponent;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortIntelligenceClanDescriptionMeta extends BaseDAAPIComponent {

    public var onOpenCalendar:Function;

    public var onOpenClanList:Function;

    public var onOpenClanStatistics:Function;

    public var onOpenClanCard:Function;

    public var onAddRemoveFavorite:Function;

    public var onAttackDirection:Function;

    public var onHoverDirection:Function;

    private var _clanDescriptionVO:ClanDescriptionVO;

    public function FortIntelligenceClanDescriptionMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._clanDescriptionVO) {
            this._clanDescriptionVO.dispose();
            this._clanDescriptionVO = null;
        }
        super.onDispose();
    }

    public function onOpenCalendarS():void {
        App.utils.asserter.assertNotNull(this.onOpenCalendar, "onOpenCalendar" + Errors.CANT_NULL);
        this.onOpenCalendar();
    }

    public function onOpenClanListS():void {
        App.utils.asserter.assertNotNull(this.onOpenClanList, "onOpenClanList" + Errors.CANT_NULL);
        this.onOpenClanList();
    }

    public function onOpenClanStatisticsS():void {
        App.utils.asserter.assertNotNull(this.onOpenClanStatistics, "onOpenClanStatistics" + Errors.CANT_NULL);
        this.onOpenClanStatistics();
    }

    public function onOpenClanCardS():void {
        App.utils.asserter.assertNotNull(this.onOpenClanCard, "onOpenClanCard" + Errors.CANT_NULL);
        this.onOpenClanCard();
    }

    public function onAddRemoveFavoriteS(param1:Boolean):void {
        App.utils.asserter.assertNotNull(this.onAddRemoveFavorite, "onAddRemoveFavorite" + Errors.CANT_NULL);
        this.onAddRemoveFavorite(param1);
    }

    public function onAttackDirectionS(param1:int):void {
        App.utils.asserter.assertNotNull(this.onAttackDirection, "onAttackDirection" + Errors.CANT_NULL);
        this.onAttackDirection(param1);
    }

    public function onHoverDirectionS():void {
        App.utils.asserter.assertNotNull(this.onHoverDirection, "onHoverDirection" + Errors.CANT_NULL);
        this.onHoverDirection();
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:ClanDescriptionVO = this._clanDescriptionVO;
        this._clanDescriptionVO = new ClanDescriptionVO(param1);
        this.setData(this._clanDescriptionVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:ClanDescriptionVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
