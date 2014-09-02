/**
 * コラボレーショングループのデータアクセスオブジェクト。
 * @author ashraf
 */
public with sharing class CollaborationGroupDao {

    /**
     * @param chatterGroupName Chatterグループ名
     */
	public List<CollaborationGroup> getCollaborationGroupList(String chatterGroupName) {

    	List<CollaborationGroup> cgList =
	        [
	            select
	                id,
	                name
	            from CollaborationGroup
	            where name =:chatterGroupName
	            limit 1
	        ];
	
        	return cgList;
	}
}