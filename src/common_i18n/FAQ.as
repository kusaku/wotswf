package
{
   public class FAQ
   {
      
      public static const QUESTION_1:String = "#faq:question_1";
      
      public static const ANSWER_1:String = "#faq:answer_1";
      
      public static const QUESTION_2:String = "#faq:question_2";
      
      public static const ANSWER_2:String = "#faq:answer_2";
      
      public static const QUESTION_3:String = "#faq:question_3";
      
      public static const ANSWER_3:String = "#faq:answer_3";
      
      public static const QUESTION_4:String = "#faq:question_4";
      
      public static const ANSWER_4:String = "#faq:answer_4";
      
      public static const QUESTION_5:String = "#faq:question_5";
      
      public static const ANSWER_5:String = "#faq:answer_5";
      
      public static const QUESTION_6:String = "#faq:question_6";
      
      public static const ANSWER_6:String = "#faq:answer_6";
      
      public static const QUESTION_7:String = "#faq:question_7";
      
      public static const ANSWER_7:String = "#faq:answer_7";
      
      public static const QUESTION_8:String = "#faq:question_8";
      
      public static const ANSWER_8:String = "#faq:answer_8";
      
      public static const QUESTION_9:String = "#faq:question_9";
      
      public static const ANSWER_9:String = "#faq:answer_9";
      
      public static const QUESTION_10:String = "#faq:question_10";
      
      public static const ANSWER_10:String = "#faq:answer_10";
      
      public static const QUESTION_11:String = "#faq:question_11";
      
      public static const ANSWER_11:String = "#faq:answer_11";
      
      public static const QUESTION_12:String = "#faq:question_12";
      
      public static const ANSWER_12:String = "#faq:answer_12";
      
      public static const QUESTION_13:String = "#faq:question_13";
      
      public static const ANSWER_13:String = "#faq:answer_13";
      
      public static const QUESTION_14:String = "#faq:question_14";
      
      public static const ANSWER_14:String = "#faq:answer_14";
      
      public static const QUESTION_15:String = "#faq:question_15";
      
      public static const ANSWER_15:String = "#faq:answer_15";
      
      public static const QUESTION_16:String = "#faq:question_16";
      
      public static const ANSWER_16:String = "#faq:answer_16";
      
      public static const QUESTION_17:String = "#faq:question_17";
      
      public static const ANSWER_17_CONTAINS_LINKS:String = "#faq:answer_17/contains_links";
      
      public static const QUESTION_ENUM:Array = [QUESTION_1,QUESTION_2,QUESTION_3,QUESTION_4,QUESTION_5,QUESTION_6,QUESTION_7,QUESTION_8,QUESTION_9,QUESTION_10,QUESTION_11,QUESTION_12,QUESTION_13,QUESTION_14,QUESTION_15,QUESTION_16,QUESTION_17];
      
      public static const ANSWER_ENUM:Array = [ANSWER_1,ANSWER_2,ANSWER_3,ANSWER_4,ANSWER_5,ANSWER_6,ANSWER_7,ANSWER_8,ANSWER_9,ANSWER_10,ANSWER_11,ANSWER_12,ANSWER_13,ANSWER_14,ANSWER_15,ANSWER_16,ANSWER_17_CONTAINS_LINKS];
       
      
      public function FAQ()
      {
         super();
      }
      
      public static function question(param1:String) : String
      {
         var _loc2_:String = "#faq:question_" + param1;
         if(QUESTION_ENUM.indexOf(_loc2_) == -1)
         {
            DebugUtils.LOG_WARNING("[question]:locale key \"" + _loc2_ + "\" was not found");
            return null;
         }
         return _loc2_;
      }
      
      public static function answer(param1:String) : String
      {
         var _loc2_:String = "#faq:answer_" + param1;
         if(ANSWER_ENUM.indexOf(_loc2_) == -1)
         {
            DebugUtils.LOG_WARNING("[answer]:locale key \"" + _loc2_ + "\" was not found");
            return null;
         }
         return _loc2_;
      }
   }
}
