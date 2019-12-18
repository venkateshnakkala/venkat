public class testCallout {
    public static String callEchoString(String input) {
        WSCVSF.LAFSPort sample = new WSCVSF.LAFSPort();
        sample.endpoint_x = 'http://api.salesforce.com/foo/bar';
         
        // This invokes the EchoString method in the generated class
        String echo = sample.CVAPI_getData('test');
         
        return echo;
    }  
}