/**
 * メールを受信してChatterへ投稿するクラス。
 * @author ashraf
 */
global class ReceiveAlertMail implements Messaging.InboundEmailHandler {
	  
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        
        FeedItem newFeedItemData = new FeedItem();

        //フィード内容
        newFeedItemData.Body = email.plainTextBody;
        Map<String, AlertImage__c>alertImageMap = AlertImage__c.getAll();
		
		List<String> customObjects = new List<String>();
        customObjects.addAll(alertImageMap.keySet());
		String cls = null;
		for (String customObject : customObjects) {
        	AlertImage__c alertImageMaps = alertImageMap.get(customObject);
           	System.debug(alertImageMaps.Name);
           	
           	if (newFeedItemData.Body.contains(alertImageMaps.Name)){
          		cls = alertImageMaps.Name;
        	} 
		}
			if (cls == null){
          		newFeedItemData.Body = '制御系システムの監視アラートが企業向けSNSに投稿される。';
          	  	cls = 'Default';
        	}
		
        //フィード投稿画像のファイル名
        AlertImage__c alertimage = AlertImage__c.getinstance(cls);
        newFeedItemData.ContentFileName = alertimage.fileName__c;

        //フィード投稿先
		List <CollaborationGroup> cgList = new CollaborationGroupDao().getCollaborationGroupList(alertimage.chatterGroupName__c);
    	
        if(!cgList.isEmpty()){
            newFeedItemData.ParentId = cgList[0].Id;
        }

        //フィード投稿画像参照先
		List <StaticResource> srList = new StaticResourceDao().getStaticResourceList(alertimage.staticResourceId__c);
        newFeedItemData.ContentData = srList[0].Body;
		                
        insert newFeedItemData;
	    return result;
    }
}