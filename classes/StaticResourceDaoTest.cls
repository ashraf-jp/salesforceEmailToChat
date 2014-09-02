/**
 * @author ashraf
 */
@isTest
private class StaticResourceDaoTest {

    static testMethod void testNormal0001() {
    	StaticResourceDao dao = new StaticResourceDao();
    	System.assertNotEquals(null, dao);
    }

    static testMethod void testNormal0002() {
    	String expectedId = '08110000000LCpC';
    	    	
    	StaticResource sr1 = getStaticResource(expectedId);
    	
		Test.startTest();
    	StaticResourceDao dao = new StaticResourceDao();
    	List<StaticResource> srList = dao.getStaticResourceList(sr1.Id);
		Test.stopTest();

		// 1件取得できていること
		System.assert(!srList.isEmpty());
		System.assertEquals(1, srList.size());
		//System.assertEquals(expectedId, srList.get(0).Id);
    }

    static testMethod void testNormal0003() {

    	Test.startTest();
    	StaticResourceDao dao = new StaticResourceDao();
    	List<StaticResource> srList = dao.getStaticResourceList('norecord');
		Test.stopTest();

		// 1件取得できていないこと
		System.assert(srList.isEmpty());
    }

	private static StaticResource getStaticResource(String chatterResourceId) {
	    StaticResource sr = new StaticResource();
	    sr.Id = chatterResourceId;
	    return sr;
	}
}