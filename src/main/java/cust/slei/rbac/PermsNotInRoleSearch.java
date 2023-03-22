package cust.slei.rbac;

import cust.slei.util.ListTemplate;
import cust.slei.util.search.Search;

public class PermsNotInRoleSearch extends Search {
	
	@Override
	protected String getTables(ListTemplate lt) {
		// TODO Auto-generated method stub
		return "(select a.* from permission a left outer join (select perm_id from role_to_perm where role_id=?) b on a.perm_id=b.c_perm_id where b.c_perm_id is null) c";
	}

}
