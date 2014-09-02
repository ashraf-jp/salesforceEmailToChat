/**
 * 静的リソースのデータアクセスオブジェクト。
 * @author ashraf
 */
public with sharing class StaticResourceDao {
	
	/**
     * @param chatterResourceId ChatterリーソスＩｄ
     */
	public List<StaticResource> getStaticResourceList(String chatterResourceId) {
		
    	List<StaticResource> srList =
	        [
	            select
	                Body
	            from StaticResource
	            where Id =:chatterResourceId
	            limit 1
	        ];
	
        	return srList;
	}
}