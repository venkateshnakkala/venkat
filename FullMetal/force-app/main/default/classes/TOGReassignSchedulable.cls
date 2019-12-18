global class TOGReassignSchedulable implements Schedulable
{
    global void execute(SchedulableContext ctx)
    {
        TOGReassign t = new TOGReassign();
        Database.executebatch(t,10);
    }
}