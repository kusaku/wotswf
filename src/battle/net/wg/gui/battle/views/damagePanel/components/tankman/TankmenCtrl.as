package net.wg.gui.battle.views.damagePanel.components.tankman {
import net.wg.data.constants.Linkages;
import net.wg.data.constants.RolesState;
import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelClickableItem;
import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelItemsCtrl;

public class TankmenCtrl implements IDamagePanelItemsCtrl {

    private static const PATTERN_SIMPLE_TANKMAN_NAME:RegExp = /[^\d]*/;

    private var identifiersByType:Object;

    private var items:TankmanDumper;

    public function TankmenCtrl(param1:Array) {
        var _loc4_:String = null;
        var _loc5_:Object = null;
        var _loc6_:String = null;
        var _loc7_:TankmanIdentifiers = null;
        super();
        this.identifiersByType = {};
        this.items = new TankmanDumper();
        this.identifiersByType[RolesState.COMANDER] = new TankmanIdentifiers(Linkages.TANKMAN_COMANDER, Linkages.TANKMAN_ORANGE_COMANDER);
        this.identifiersByType[RolesState.GUNNER] = new TankmanIdentifiers(Linkages.TANKMAN_GUNNER, Linkages.TANKMAN_ORANGE_GUNNER);
        this.identifiersByType[RolesState.DRIVER] = new TankmanIdentifiers(Linkages.TANKMAN_DRIVER, Linkages.TANKMAN_ORANGE_DRIVER);
        this.identifiersByType[RolesState.RADIOMAN] = new TankmanIdentifiers(Linkages.TANKMAN_RADIST, Linkages.TANKMAN_ORANGE_RADIOMAN);
        this.identifiersByType[RolesState.LOADER] = new TankmanIdentifiers(Linkages.TANKMAN_SHELLMAN, Linkages.TANKMAN_ORANGE_LOADER);
        var _loc2_:int = param1.length;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _loc4_ = param1[_loc3_];
            _loc5_ = PATTERN_SIMPLE_TANKMAN_NAME.exec(_loc4_);
            _loc6_ = _loc5_[0];
            App.utils.asserter.assert(_loc6_ != "", "Not valid tankmanName");
            _loc7_ = this.identifiersByType[_loc6_];
            this.items[_loc4_] = new TankmanAssets(_loc4_, _loc7_.normal, _loc7_.critical, _loc3_, _loc2_);
            _loc3_++;
        }
    }

    public function dispose():void {
        this.identifiersByType = App.utils.data.cleanupDynamicObject(this.identifiersByType);
        this.items.dispose();
        this.items = null;
    }

    public function getItemByName(param1:String):IDamagePanelClickableItem {
        var _loc2_:IDamagePanelClickableItem = this.items[param1];
        App.utils.asserter.assertNotNull(_loc2_, "Not item with name = " + param1);
        return _loc2_;
    }

    public function getItems():Vector.<IDamagePanelClickableItem> {
        return this.items.getItems();
    }

    public function reset():void {
        var _loc1_:Vector.<IDamagePanelClickableItem> = this.items.getItems();
        var _loc2_:int = _loc1_.length;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _loc1_[_loc3_].state = BATTLE_ITEM_STATES.NORMAL;
            _loc3_++;
        }
    }

    public function setState(param1:String, param2:String):void {
        var _loc3_:String = "Not such item with name = ";
        var _loc4_:IDamagePanelClickableItem = this.items[param1];
        App.utils.asserter.assertNotNull(_loc4_, _loc3_ + param1);
        _loc4_.state = param2;
    }

    public function showDestroyed():void {
        var _loc4_:IDamagePanelClickableItem = null;
        var _loc1_:Vector.<IDamagePanelClickableItem> = this.items.getItems();
        var _loc2_:int = _loc1_.length;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _loc4_ = _loc1_[_loc3_];
            _loc4_.showDestroyed();
            _loc3_++;
        }
    }
}
}
