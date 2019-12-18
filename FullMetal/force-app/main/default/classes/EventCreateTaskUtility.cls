public class EventCreateTaskUtility {
    private static Boolean alreadyLaunchedTrigger = false;
    public static Boolean hasAlreadyLaunchedTrigger()
    {
        return alreadyLaunchedTrigger;
    }
    
    public static void setAlreadyLaunchedTrigger()
    {
        alreadyLaunchedTrigger = true;
    }
    
    public static void resetAlreadyLaunchedTrigger()
    {
        alreadyLaunchedTrigger = false;
    }
}