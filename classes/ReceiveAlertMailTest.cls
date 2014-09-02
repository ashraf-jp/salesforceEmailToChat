/**
 * @author ashraf
 */
@isTest(seeAllData=false)
private class ReceiveAlertMailTest {

  static testMethod void testOK0001() {
  	Messaging.InboundEmail email = new Messaging.InboundEmail();
    Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
    email.plainTextBody = 'This should become a note';
    email.fromAddress ='test@test.com';
    String contactEmail = 'jsmith@salesforce.com';
    email.ccAddresses = new String[] {'Jon Smith <' + contactEmail + '>'};
    email.subject = 'Dummy Account Name 123';

	insertCustomSetting();

    CollaborationGroup cg = new CollaborationGroup();
    // 実際のグループ名と同じにならないようにする
    cg.Name = 'テスト用モニタ';
    cg.CollaborationType = 'Public';

    insert cg;

    Test.startTest();
    //AlertMailReceive edr = new AlertMailReceive();
    ReceiveAlertMail edr = new ReceiveAlertMail();
    Messaging.InboundEmailResult result = edr.handleInboundEmail(email, env);
    Test.stopTest();
    System.assert (result.success, 'InboundEmailResult returned a failure message');
    }

    /**
     * テスト用のカスタム設定を登録する。
     */
  private static void insertCustomSetting() {
    List<AlertImage__c> alertImageList = new List<AlertImage__c>();

    AlertImage__c alertImageSerious = AlertImage__c.getInstance();
    alertImageSerious.Name = 'Serious';
    //alertImageSerious.staticResourceName__c = 'AlertSerious';
    alertImageSerious.staticResourceId__c = '08110000000LCpH';
    alertImageSerious.fileName__c = 'alert.jpg';
    alertImageSerious.chatterGroupName__c = 'テスト用モニタ';
    alertImageSerious.SetupOwnerId = UserInfo.getOrganizationId();
    System.debug(alertImageSerious);

    alertImageList.add(alertImageSerious);

    AlertImage__c alertImageSlight = AlertImage__c.getInstance();
    alertImageSlight.Name = 'Slight';
    //alertImageSlight.staticResourceName__c = 'AlertSlight';
    alertImageSlight.staticResourceID__c = '08110000000LCpM';
    alertImageSlight.fileName__c = 'Slight.jpg';
    alertImageSlight.chatterGroupName__c = 'テスト用モニタ';
    alertImageSlight.SetupOwnerId = UserInfo.getOrganizationId();
    System.debug(alertImageSlight);

    alertImageList.add(alertImageSlight);

    AlertImage__c alertImageInfo = AlertImage__c.getInstance();
    alertImageInfo.Name = 'Info';
    //alertImageInfo.staticResourceName__c = 'AlertInfo';
    alertImageInfo.staticResourceId__c = '08110000000LCpR';
    alertImageInfo.fileName__c = 'Info.jpg';
    alertImageInfo.chatterGroupName__c = 'テスト用モニタ';
    alertImageInfo.SetupOwnerId = UserInfo.getOrganizationId();
    System.debug(alertImageInfo);

    alertImageList.add(alertImageInfo);

    AlertImage__c alertImageDefault = AlertImage__c.getInstance();
    alertImageDefault.Name = 'Default';
    //alertImageDefault.staticResourceName__c = 'AlertDefault';
    alertImageDefault.staticResourceId__c = '08110000000LCpC';
    alertImageDefault.fileName__c = 'Default.jpg';
    alertImageDefault.chatterGroupName__c = 'テスト用モニタ';
    alertImageDefault.SetupOwnerId = UserInfo.getOrganizationId();
    System.debug(alertImageDefault);

    alertImageList.add(alertImageDefault);

    insert alertImageList;
  }
}