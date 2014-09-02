/**
 * @author ashraf
 */
@isTest
private class CollaborationGroupDaoTest {

    static testMethod void testNormal0001() {
    	CollaborationGroupDao dao = new CollaborationGroupDao();
    	System.assertNotEquals(null, dao);
    }

    static testMethod void testNormal0002() {
    	String expectedName = 'テスト用モニタtestmethod1';
    	// コラボレーショングループ登録
    	CollaborationGroup cg1 = getCollaborationGroup(expectedName);
    	CollaborationGroup cg2 = getCollaborationGroup('テスト用モニタtestmethod2');
    	List<CollaborationGroup> insertCgList = new List<CollaborationGroup>();
    	insertCgList.add(cg1);
    	insertCgList.add(cg2);
    	insert insertCgList;

		Test.startTest();
    	CollaborationGroupDao dao = new CollaborationGroupDao();
    	List<CollaborationGroup> cgList = dao.getCollaborationGroupList(cg1.name);
		Test.stopTest();

		// 1件取得できていること
		System.assert(!cgList.isEmpty());
		System.assertEquals(1, cgList.size());
		System.assertEquals(expectedName, cgList.get(0).name);
    }

    static testMethod void testNormal0003() {

    	// コラボレーショングループ登録
    	CollaborationGroup cg1 = getCollaborationGroup('テスト用モニタtestmethod1');
    	CollaborationGroup cg2 = getCollaborationGroup('テスト用モニタtestmethod2');
    	List<CollaborationGroup> insertCgList = new List<CollaborationGroup>();
    	insertCgList.add(cg1);
    	insertCgList.add(cg2);
    	insert insertCgList;

		Test.startTest();
    	CollaborationGroupDao dao = new CollaborationGroupDao();
    	List<CollaborationGroup> cgList = dao.getCollaborationGroupList('norecord');
		Test.stopTest();

		// 1件取得できていないこと
		System.assert(cgList.isEmpty());
    }

	private static CollaborationGroup getCollaborationGroup(String chatterGroupName) {
	    CollaborationGroup cg = new CollaborationGroup();
	    // 実際のグループ名と同じにならないようにする
	    cg.Name = chatterGroupName;
	    cg.CollaborationType = 'Public';

		return cg;
	}
}