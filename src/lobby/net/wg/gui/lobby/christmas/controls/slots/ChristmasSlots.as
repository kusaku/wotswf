package net.wg.gui.lobby.christmas.controls.slots {
import flash.display.InteractiveObject;

import net.wg.data.constants.Errors;
import net.wg.gui.lobby.christmas.ChristmasDecorationsFilters;
import net.wg.gui.lobby.christmas.data.ChristmasFiltersVO;
import net.wg.gui.lobby.christmas.data.slots.SlotVO;
import net.wg.gui.lobby.christmas.data.slots.SlotsDataVO;
import net.wg.gui.lobby.christmas.data.slots.SlotsStaticDataVO;
import net.wg.gui.lobby.christmas.event.ChristmasCustomizationFilterEvent;
import net.wg.gui.lobby.christmas.event.ChristmasFilterEvent;
import net.wg.gui.lobby.christmas.interfaces.IChristmasDropActor;
import net.wg.gui.lobby.christmas.interfaces.IChristmasSlot;
import net.wg.gui.lobby.christmas.interfaces.IChristmasSlots;
import net.wg.infrastructure.base.UIComponentEx;

public class ChristmasSlots extends UIComponentEx implements IChristmasSlots {

    public var rankFilters:ChristmasDecorationsFilters = null;

    public var typeFilters:ChristmasDecorationsFilters = null;

    private var _slots:Vector.<IChristmasSlot> = null;

    private var _dropActors:Vector.<IChristmasDropActor> = null;

    public function ChristmasSlots() {
        super();
        this._slots = new Vector.<IChristmasSlot>(0);
        this._dropActors = new Vector.<IChristmasDropActor>(0);
    }

    override protected function configUI():void {
        super.configUI();
        this.rankFilters.addEventListener(ChristmasFilterEvent.CHANGE, this.onRankFilterChangeHandler);
        this.typeFilters.addEventListener(ChristmasFilterEvent.CHANGE, this.onTypeFilterChangeHandler);
    }

    override protected function onDispose():void {
        var _loc1_:IChristmasSlot = null;
        this.rankFilters.removeEventListener(ChristmasFilterEvent.CHANGE, this.onRankFilterChangeHandler);
        this.typeFilters.removeEventListener(ChristmasFilterEvent.CHANGE, this.onTypeFilterChangeHandler);
        for each(_loc1_ in this._slots) {
            _loc1_.dispose();
            this[_loc1_.name] = null;
        }
        this._slots.splice(0, this._slots.length);
        this._slots = null;
        this._dropActors.splice(0, this._dropActors.length);
        this._dropActors = null;
        this.rankFilters.dispose();
        this.rankFilters = null;
        this.typeFilters.dispose();
        this.typeFilters = null;
        super.onDispose();
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return this;
    }

    public function getDropActors():Vector.<IChristmasDropActor> {
        return this._dropActors;
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
        _loc1_ = _loc1_.concat(this.rankFilters.getFocusChain());
        _loc1_ = _loc1_.concat(this.typeFilters.getFocusChain());
        return _loc1_;
    }

    public function setData(param1:SlotsDataVO):void {
        var _loc2_:Vector.<SlotVO> = param1.slots;
        var _loc3_:int = Math.min(this._slots.length, _loc2_.length);
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            this._slots[_loc4_].setData(_loc2_[_loc4_]);
            _loc4_++;
        }
    }

    public function setFilters(param1:ChristmasFiltersVO, param2:ChristmasFiltersVO):void {
        this.rankFilters.setData(param1);
        this.typeFilters.setData(param2);
    }

    public function setStaticData(param1:SlotsStaticDataVO):void {
    }

    public function update(param1:Object):void {
    }

    public function updateSlot(param1:SlotVO):void {
        var _loc2_:IChristmasSlot = this.findSlot(param1.slotId);
        App.utils.asserter.assertNotNull(_loc2_, "ChristmasSlot by id:" + param1.slotId + Errors.WASNT_FOUND);
        _loc2_.setData(param1);
    }

    protected function addSlots(...rest):void {
        var _loc2_:IChristmasSlot = null;
        for each(_loc2_ in rest) {
            this._slots.push(_loc2_);
        }
    }

    protected function addDropActors(...rest):void {
        var _loc2_:IChristmasDropActor = null;
        for each(_loc2_ in rest) {
            this._dropActors.push(_loc2_);
        }
    }

    private function findSlot(param1:int):IChristmasSlot {
        var _loc2_:IChristmasSlot = null;
        for each(_loc2_ in this._slots) {
            if (_loc2_.slotId == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    private function onRankFilterChangeHandler(param1:ChristmasFilterEvent):void {
        dispatchEvent(new ChristmasCustomizationFilterEvent(ChristmasCustomizationFilterEvent.RANK_CHANGE, param1.index, true));
    }

    private function onTypeFilterChangeHandler(param1:ChristmasFilterEvent):void {
        dispatchEvent(new ChristmasCustomizationFilterEvent(ChristmasCustomizationFilterEvent.TYPE_CHANGE, param1.index, true));
    }
}
}
