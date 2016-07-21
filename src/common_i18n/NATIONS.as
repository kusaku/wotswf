package
{
   public class NATIONS
   {
      
      public static const USSR:String = "#nations:ussr";
      
      public static const GERMANY:String = "#nations:germany";
      
      public static const USA:String = "#nations:usa";
      
      public static const FRANCE:String = "#nations:france";
      
      public static const UK:String = "#nations:uk";
      
      public static const JAPAN:String = "#nations:japan";
      
      public static const CZECH:String = "#nations:czech";
      
      public static const CHINA:String = "#nations:china";
      
      public static const SWEDEN:String = "#nations:sweden";
      
      public static const all_ENUM:Array = [USSR,GERMANY,USA,FRANCE,UK,JAPAN,CZECH,CHINA,SWEDEN];
       
      
      public function NATIONS()
      {
         super();
      }
      
      public static function all(param1:String) : String
      {
         var _loc2_:String = "#nations:" + param1;
         App.utils.asserter.assert(all_ENUM.indexOf(_loc2_) != -1,"locale key \"" + _loc2_ + "\" was not found");
         return _loc2_;
      }
   }
}
