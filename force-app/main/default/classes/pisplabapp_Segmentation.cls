public with sharing class pisplabapp_Segmentation {
    /**
* Parse result from Segmentation List API call to see if it was successful. If it was then get Segmentation List ID for use later
* 
* Result example: {"@attributes":{"stat":"ok","version":1},"list":{"id":21943,"name":"Seg A","is_public":false,"is_dynamic":false,"title":"Seg A","description":"Seg A","is_crm_visible":false,"created_at":"2021-07-14 10:41:26","updated_at":"2021-07-14 10:41:26"}}
*/
    @InvocableMethod(label='ParseSegmentation Result')
    public static List<ParseSegmentationResult> ParseSegmentationResult(List<String> payloads) {
        
        List<pisplabapp_Segmentation.ParseSegmentationResult> resList = new List<pisplabapp_Segmentation.ParseSegmentationResult>();    
        
        //System.debug('pisplabapp_Segmentation payloads[0]=' + payloads[0]);
        Map<String, Object> m =  (Map<String, Object>) JSON.deserializeUntyped(payloads[0]);
        if(m.containsKey('list') && ((Map<String,Object>)m.get('list')).containsKey('id')){
            //System.debug('pisplabapp_Segmentation payloads[0] map=' + m);
            Map<String,Object> resultMap = (Map<String,Object>)m.get('list');
            System.debug(((Map<String,Object>)m.get('list')).get('id'));
            //System.debug('pisplabapp_Segmentation payloads[0] resultMap=' + resultMap);
            ParseSegmentationResult res = new ParseSegmentationResult();
            res.id= (String) String.valueOf(resultMap.get('id'));
            
            resList.add(res);
        }else{
            ParseSegmentationResult res = new ParseSegmentationResult();
            res.haserror = true;
            resList.add(res);
        }
        
        return resList;
    }
    /**
* Get Segmentation List from Pardot: https://developer.pardot.com/kb/api-version-4/lists/#list-query
*/
    public static pisplabapp_segmentationListJson getSegmentationLists(String businessUnitId){
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Pardot_Integration_NC/api/list/version/4/do/query?created_after%3Dthis_month%26fields%3Dname%2Cid');
        req.setMethod('GET');
        req.setHeader('Content-Type','application/json');
        //req.setHeader('Authorization', 'Bearer ' + getSessionId());
        req.setHeader('Pardot-Business-Unit-Id', businessUnitId);
        
        Http http = new Http();
        HTTPResponse res = http.send(req); 
        //System.debug(res.getBody());
        //Wrap <list> nodes with <lists> so that we can generate proper JSON
        String xml = res.getBody().replace('</total_results>','</total_results><lists>').replace('</result>','</lists></result>');
        
        String jsonContent = pisplabapp_XmlParser.xmlToJson(xml);
        
        
        jsonContent = jsonContent.replace('"lists": [{','"lists": {"list_x":[{').replace('}]','}]}');
        //Fix JSON for SINGLE lists to conver list tag into an array
        jsonContent = jsonContent.replace('"list": {','"list_x": [{').replace('}}},','}]}},');
        //System.debug(jsonContent);
        
        return pisplabapp_segmentationListJson.parse(jsonContent);
        

    }
    
    
    public class ParseSegmentationResult {
        @InvocableVariable(label='id' description='id' )
        public String id;
        @InvocableVariable(label='hasError' description='hasError' )
        public Boolean hasError=false;
        
    }
    
}